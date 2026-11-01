<%--
  Drop-in replacement for the Jakarta "mailer2" <mt:mail> tag.
  The tag body is the plain-text message. SMTP settings configured in
  buildtrees.properties (mail.smtp.*) take precedence over the server/port/
  username/password attributes still present in older pages.
  On failure a JspException is thrown, as the original tag did, so the
  try/catch blocks around it in the pages keep working.
--%>
<%@ tag body-content="scriptless" pageEncoding="UTF-8" %>
<%@ attribute name="from" %>
<%@ attribute name="to" required="true" %>
<%@ attribute name="cc" %>
<%@ attribute name="bcc" %>
<%@ attribute name="subject" %>
<%@ attribute name="server" %>
<%@ attribute name="port" %>
<%@ attribute name="username" %>
<%@ attribute name="password" %>
<jsp:doBody var="mailBody" />
<%
    String body = (String) jspContext.getAttribute("mailBody");
    // drop the indentation/blank lines that come from JSP source formatting
    body = body == null ? "" : body.replaceAll("(?m)^[ \\t]+", "").trim() + "\n";
    String cc = (String) jspContext.getAttribute("cc");
    String bcc = (String) jspContext.getAttribute("bcc");
    int port = 0;
    try { port = Integer.parseInt(String.valueOf(jspContext.getAttribute("port")).trim()); } catch (NumberFormatException ignored) { }
    try {
        appconfig.Mailer.send(
            (String) jspContext.getAttribute("from"),
            new String[] { (String) jspContext.getAttribute("to") },
            cc == null ? null : new String[] { cc },
            bcc == null ? null : new String[] { bcc },
            (String) jspContext.getAttribute("subject"),
            body,
            (String) jspContext.getAttribute("server"), port,
            (String) jspContext.getAttribute("username"),
            (String) jspContext.getAttribute("password"));
    } catch (jakarta.mail.MessagingException e) {
        throw new javax.servlet.jsp.JspException("Mail could not be sent: " + e.getMessage(), e);
    }
%>
