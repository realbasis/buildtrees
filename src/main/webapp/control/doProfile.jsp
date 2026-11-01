<%@page contentType="text/html" errorPage="../error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<c:if test="${param.ref == 1}">
	<c:if test="${param.retour == 'cancel'}">
		<c:redirect url="/profile.jsp" />
	</c:if>
    <c:if test="${param.name == ''}">
        <c:redirect url="/profile.jsp">
            <c:param name="errors" value="Name is a required field!" />
            <c:param name="ref" value="1" />
        </c:redirect>
    </c:if>
    
    <!-- update account parameters -->
    <sql:update var="result">
        Update Accounts Set Name = ? Where AccountID = ?
        <sql:param value="${param.name}" />
        <sql:param value="${accountID}" />
    </sql:update>
    
    <c:set var="myname" value="${param.name}" scope="session" />
</c:if>

<c:if test="${param.ref == 2}">

<%
    String pass1 = request.getParameter("pass1");
    if(pass1.length() < 6)
        {
%>
        <c:redirect url="/profile.jsp">
            <c:param name="errors" value="password must at least 6 letters long!" />
            <c:param name="ref" value="2" />
        </c:redirect>
<%
        }
%>
    
    <c:if test="${param.pass1 != param.pass2}">
        <c:redirect url="/profile.jsp">
            <c:param name="errors" value="Please confirm password!" />
            <c:param name="ref" value="2" />
        </c:redirect>
    </c:if>
    
    <!-- update account parameters -->
    <sql:update>
        Update Accounts Set Password = ? Where AccountID = ?
        <sql:param value="${param.pass1}" />
        <sql:param value="${accountID}" />
    </sql:update>
    
    <c:set var="errors" value="password has been changed successfully"/>
   
</c:if>

<c:if test="${param.ref == 3}">
    <c:if test="${param.notify == 'yes'}">
        <c:set var="notify" value="no" />
    </c:if>
    <c:if test="${param.notify == 'no'}">
        <c:set var="notify" value="yes" />
    </c:if>
    <!-- update account parameters -->
    <sql:update var="result">
        Update Accounts Set Notify = ? Where AccountID = ?
        <sql:param value="${notify}" />
        <sql:param value="${accountID}" />
    </sql:update>
</c:if>

<!-- back to profile -->
<c:redirect url="/profile.jsp">
    <c:param name="errors" value="${errors}" />
</c:redirect>

