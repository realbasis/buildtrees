<%-- Replacement for the O'Reilly <ora:fileWrite fileName="log"> tag: the body is written to the server log. --%>
<%@ tag body-content="scriptless" pageEncoding="UTF-8" %>
<%@ attribute name="fileName" %>
<jsp:doBody var="logText" />
<%
    String text = String.valueOf(jspContext.getAttribute("logText")).trim();
    ((javax.servlet.jsp.PageContext) jspContext).getServletContext().log("[buildtrees] " + text);
%>
