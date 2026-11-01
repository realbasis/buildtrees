package appconfig;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Logger;

/**
 * Plain-text e-mail sender built on Jakarta Mail.
 *
 * Replaces Apache commons-email (PeopleSql) and the Jakarta mailer2 taglib
 * ({@code <mt:mail>}). SMTP settings from {@link AppConfig} take precedence;
 * the per-call server/port/user/password (as still written in older JSPs)
 * are only used when nothing is configured.
 */
public final class Mailer {

    private static final Logger LOG = Logger.getLogger(Mailer.class.getName());

    private Mailer() {
    }

    public static void send(String from, String[] to, String[] cc, String[] bcc,
                            String subject, String body) throws MessagingException {
        send(from, to, cc, bcc, subject, body, null, 0, null, null);
    }

    public static void send(String from, String[] to, String[] cc, String[] bcc,
                            String subject, String body,
                            String fallbackHost, int fallbackPort,
                            String fallbackUser, String fallbackPassword) throws MessagingException {

        String host = AppConfig.smtpHost();
        int port = AppConfig.smtpPort();
        String user = AppConfig.smtpUser();
        String password = AppConfig.smtpPassword();
        if (host == null) {
            host = fallbackHost;
            port = fallbackPort > 0 ? fallbackPort : 25;
            user = fallbackUser;
            password = fallbackPassword;
        }

        List<InternetAddress> toList = parse(to);
        if (toList.isEmpty()) {
            throw new MessagingException("No recipient");
        }
        if (from == null || from.isBlank()) {
            from = AppConfig.mailFrom();
        }

        if (!AppConfig.mailEnabled() || host == null || host.isBlank()) {
            LOG.info("[mail disabled] to=" + toList + " subject=" + subject);
            return;
        }

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", String.valueOf(port));
        props.put("mail.smtp.connectiontimeout", "10000");
        props.put("mail.smtp.timeout", "10000");
        if (AppConfig.smtpStartTls()) {
            props.put("mail.smtp.starttls.enable", "true");
        }
        Authenticator auth = null;
        if (user != null && !user.isBlank()) {
            props.put("mail.smtp.auth", "true");
            final String u = user;
            final String p = password == null ? "" : password;
            auth = new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(u, p);
                }
            };
        }

        Session session = Session.getInstance(props, auth);
        MimeMessage msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(from));
        msg.setRecipients(Message.RecipientType.TO, toList.toArray(new InternetAddress[0]));
        List<InternetAddress> ccList = parse(cc);
        if (!ccList.isEmpty()) {
            msg.setRecipients(Message.RecipientType.CC, ccList.toArray(new InternetAddress[0]));
        }
        List<InternetAddress> bccList = parse(bcc);
        if (!bccList.isEmpty()) {
            msg.setRecipients(Message.RecipientType.BCC, bccList.toArray(new InternetAddress[0]));
        }
        msg.setSubject(subject == null ? "" : subject, StandardCharsets.UTF_8.name());
        msg.setText(body == null ? "" : body, StandardCharsets.UTF_8.name());
        Transport.send(msg);
    }

    /** Accepts arrays whose entries may themselves be comma/semicolon separated lists. */
    private static List<InternetAddress> parse(String[] addresses) throws MessagingException {
        List<InternetAddress> out = new ArrayList<>();
        if (addresses == null) {
            return out;
        }
        for (String a : addresses) {
            if (a == null) {
                continue;
            }
            for (String part : a.split("[,;]")) {
                String s = part.trim();
                if (!s.isEmpty()) {
                    out.add(new InternetAddress(s));
                }
            }
        }
        return out;
    }

    public static boolean isValidAddress(String address) {
        if (address == null || address.isBlank() || !address.contains("@")) {
            return false;
        }
        try {
            InternetAddress ia = new InternetAddress(address.trim(), true);
            String a = ia.getAddress();
            int at = a.indexOf('@');
            return at > 0 && a.indexOf('.', at) > at + 1 && !a.endsWith(".");
        } catch (MessagingException e) {
            return false;
        }
    }
}
