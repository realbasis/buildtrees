<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@include file="/control/stdTags.jspf" %>

<c:remove var="logged" scope="session" />

<%
		session.invalidate();
%>

<c:choose>
<c:when test="${param.errors == null || param.errors == ''}">
    <c:redirect url="/auth.jsp" >
        <c:param name="errors" value="Logged out!" />
    </c:redirect>
</c:when>
<c:otherwise>
    <c:redirect url="/auth.jsp" >
        <c:param name="errors" value="${param.errors}" />
    </c:redirect>
</c:otherwise>
</c:choose>