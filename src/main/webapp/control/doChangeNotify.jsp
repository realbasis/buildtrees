<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>

<%@include file="stdTags.jspf" %>

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<!-- create notification -->
<sql:update>
    Update Accounts Set Notify = ? Where AccountID = ?
    <sql:param value="${param.notify}" />
    <sql:param value="${accountID}" />
</sql:update>

<c:remove var="notifyMe" scope="session" />
<c:set var="notifyMe" value="${param.notify}" scope="session"/>

<c:redirect url="/settings.jsp" />

