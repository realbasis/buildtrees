<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%
    /*** Preventin<c:setg Caching of Pages ***/
    response.addHeader("Pragma", "no-cache");
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.addHeader("Cache-Control", "pre-check=0, post-check=0");
    response.setDateHeader("Expires", 0);
%>

<%@include file="/control/stdTags.jspf" %>

<jsp:useBean id="authBean" class="utility.AuthBean" />

<c:if test="${param.flag == null || param.flag != 7}">
    <c:redirect url="/auth.jsp">
        <c:param name="errors" value="Login failed" />
    </c:redirect>
</c:if>

<c:choose>
    <c:when test="${authBean.passwordOwner == param.password}">
        <%-- Set Session Span --%>
        <%
            session.setMaxInactiveInterval(1800); 
        %>
        <c:set var="logged" value="true" scope="session" />
        <c:redirect url="/admin.jsp"/>
    </c:when>
    <c:otherwise>
        <c:redirect url="/auth.jsp">
            <c:param name="errors" value="Login failed" />
        </c:redirect>
    </c:otherwise>
</c:choose>

<c:redirect url="/auth.jsp">
    <c:param name="errors" value="Login failed" />
</c:redirect>