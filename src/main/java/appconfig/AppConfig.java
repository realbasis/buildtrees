package appconfig;

import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Locale;
import java.util.Properties;

/**
 * Central configuration for BuildTrees.
 *
 * Replaces the database and SMTP credentials that were hard-coded in
 * ConnBean, PeopleSql, MailerBean, UploadImg and the JSP mail tags.
 *
 * Lookup order for a key such as {@code db.url} (first hit wins):
 * <ol>
 *   <li>JVM system property {@code buildtrees.db.url} (e.g. in Tomcat's setenv.sh)</li>
 *   <li>Environment variable {@code BUILDTREES_DB_URL}</li>
 *   <li>External file given by {@code -Dbuildtrees.config=/path/file.properties}
 *       or {@code $BUILDTREES_CONFIG}, else {@code ~/.buildtrees/buildtrees.properties}
 *       (Windows: {@code %USERPROFILE%\.buildtrees\buildtrees.properties})</li>
 *   <li>{@code buildtrees.properties} on the classpath (defaults bundled in the WAR)</li>
 * </ol>
 */
public final class AppConfig {

    private static final Properties PROPS = load();

    private AppConfig() {
    }

    private static Properties load() {
        Properties p = new Properties();
        try (InputStream in = AppConfig.class.getResourceAsStream("/buildtrees.properties")) {
            if (in != null) {
                p.load(in);
            }
        } catch (IOException ignored) {
            // defaults only
        }
        String external = System.getProperty("buildtrees.config", System.getenv("BUILDTREES_CONFIG"));
        Path path = external != null && !external.isBlank()
                ? Paths.get(external)
                : Paths.get(System.getProperty("user.home", "."), ".buildtrees", "buildtrees.properties");
        if (Files.isReadable(path)) {
            try (Reader r = Files.newBufferedReader(path, StandardCharsets.UTF_8)) {
                Properties ext = new Properties();
                ext.load(r);
                // keys may be written with or without the "buildtrees." prefix
                for (String k : ext.stringPropertyNames()) {
                    String key = k.startsWith("buildtrees.") ? k.substring("buildtrees.".length()) : k;
                    p.setProperty(key, ext.getProperty(k));
                }
            } catch (IOException ignored) {
                // keep bundled defaults
            }
        }
        return p;
    }

    public static String get(String key) {
        return get(key, null);
    }

    public static String get(String key, String def) {
        String v = System.getProperty("buildtrees." + key);
        if (v == null) {
            v = System.getenv("BUILDTREES_" + key.toUpperCase(Locale.ROOT).replace('.', '_'));
        }
        if (v == null) {
            v = PROPS.getProperty(key);
        }
        return (v == null || v.isBlank()) ? def : v.trim();
    }

    public static int getInt(String key, int def) {
        try {
            return Integer.parseInt(get(key, String.valueOf(def)));
        } catch (NumberFormatException e) {
            return def;
        }
    }

    public static boolean getBoolean(String key, boolean def) {
        return Boolean.parseBoolean(get(key, String.valueOf(def)));
    }

    // ---- Convenience accessors -------------------------------------------------

    public static String dbJndiName() {
        return get("db.jndi", "java:comp/env/jdbc/LinkedDB");
    }

    public static String dbDriver() {
        return get("db.driver", "com.mysql.cj.jdbc.Driver");
    }

    public static String dbUrl() {
        return get("db.url", "jdbc:mysql://localhost:3306/connected");
    }

    public static String dbUser() {
        return get("db.user", "buildtrees");
    }

    public static String dbPassword() {
        return get("db.password", "");
    }

    public static String smtpHost() {
        return get("mail.smtp.host");
    }

    public static int smtpPort() {
        return getInt("mail.smtp.port", 587);
    }

    public static String smtpUser() {
        return get("mail.smtp.user");
    }

    public static String smtpPassword() {
        return get("mail.smtp.password");
    }

    public static boolean smtpStartTls() {
        return getBoolean("mail.smtp.starttls", true);
    }

    /** When false, outgoing mail is logged instead of sent (useful for local dev). */
    public static boolean mailEnabled() {
        return getBoolean("mail.enabled", true);
    }

    public static String mailFrom() {
        return get("mail.from", "buildtrees@realbasis.com");
    }

    public static String mailAdmin() {
        return get("mail.admin", "buildtrees@realbasis.com");
    }
}
