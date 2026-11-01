<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<c:if test="${param.notifyme == true}">
    <c:set var="notifyme" value="false"/>
</c:if>
<c:if test="${param.notifyme == false}">
    <c:set var="notifyme" value="true"/>
</c:if>

 <!-- update account parameters -->
    <sql:update>
        Update Trees Set Notifyme = ? Where TreeID = ?
        <sql:param value="${notifyme}" />
        <sql:param value="${param.treeID}" />
    </sql:update>
    
    <c:redirect url="/calendar.jsp">
        <c:param name="ref" value="1" />
        <c:param name="treeID" value="${param.treeID}" />
	<c:param name="peopleID" value="${row.PeopleID}" />
	<c:param name="name" value="${param.name}" />
	<c:param name="other" value="${param.other}" />
	<c:param name="accountOwner" value="${param.accountOwner}" />
	<c:param name="emailo" value="${param.emailo}" />
	<c:param name="peopleID" value="${param.peopleID}" />
    </c:redirect>
