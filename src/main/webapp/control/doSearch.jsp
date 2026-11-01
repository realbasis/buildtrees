<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<!-- split string -->
<c:set var="nameArray" value="${fn:split(param.name, ' ')}" />

<c:forEach items="nameArray" var="item">
    
</c:forEach>

<sql:query var="result">
    Select * from Trees
    <sql:param value="${param.peopleID}" />
</sql:query>

<!-- create link -->
<sql:update>
    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
    <sql:param value="${param.type}" />
    <sql:param value="${param.title}" />
    <sql:param value="${param.peopleID}" />
    <sql:param value="${param.familyID}" />
</sql:update>
