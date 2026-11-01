<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>


<!-- update account parameters -->
<sql:update>
    Update People Set Locker = ? Where PeopleID = ?
        <sql:param value="${param.lock}" />
        <sql:param value="${param.peopleID}" />
</sql:update>

<c:redirect url="/people.jsp">
    <c:param name="treeID" value="${param.treeID}" />
    <c:param name="name" value="${param.name}" />
    <c:param name="peopleID" value="${param.peopleID}" />
    <c:param name="ref" value="1" />
    <c:param name="other" value="${param.other}" />
    <c:param name="accountOwner" value="${param.accountOwner}" />
    <c:param name="emailo" value="${param.emailo}" />
</c:redirect>
