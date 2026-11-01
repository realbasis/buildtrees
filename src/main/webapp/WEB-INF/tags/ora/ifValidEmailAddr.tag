<%-- Replacement for the O'Reilly <ora:ifValidEmailAddr value="..." var="..."/> tag. --%>
<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ attribute name="value" required="true" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="result" variable-class="java.lang.Boolean" scope="AT_END" %>
<%
    jspContext.setAttribute("result",
        Boolean.valueOf(appconfig.Mailer.isValidAddress((String) jspContext.getAttribute("value"))));
%>
