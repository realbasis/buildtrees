package appconfig;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 * Single place to obtain JDBC connections.
 *
 * Uses the container-managed pool {@code jdbc/LinkedDB} (META-INF/context.xml)
 * when it is available, otherwise falls back to DriverManager with the
 * settings from {@link AppConfig}. Callers must close the connection.
 */
public final class Db {

    private static final Logger LOG = Logger.getLogger(Db.class.getName());

    private static volatile DataSource dataSource;
    private static volatile boolean jndiTried;

    private Db() {
    }

    public static DataSource dataSource() {
        if (!jndiTried) {
            synchronized (Db.class) {
                if (!jndiTried) {
                    try {
                        dataSource = (DataSource) new InitialContext().lookup(AppConfig.dbJndiName());
                    } catch (NamingException | RuntimeException e) {
                        LOG.log(Level.INFO, "JNDI DataSource {0} not available, using DriverManager",
                                AppConfig.dbJndiName());
                    }
                    jndiTried = true;
                }
            }
        }
        return dataSource;
    }

    public static Connection getConnection() throws SQLException {
        DataSource ds = dataSource();
        if (ds != null) {
            return ds.getConnection();
        }
        try {
            Class.forName(AppConfig.dbDriver());
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC driver not found: " + AppConfig.dbDriver(), e);
        }
        return DriverManager.getConnection(AppConfig.dbUrl(), AppConfig.dbUser(), AppConfig.dbPassword());
    }
}
