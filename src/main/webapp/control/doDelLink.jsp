<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<!-- delete link from POI to Family member -->
<sql:update>
    Delete From Links Where (PeopleID = ? And FamilyID = ?)
    <sql:param value="${param.peopleID}" />
    <sql:param value="${param.familyID}" />
</sql:update>

<!-- delete link from Family member to POI -->
<sql:update>
    Delete From Links Where (PeopleID = ? And FamilyID = ?)
    <sql:param value="${param.familyID}" />
    <sql:param value="${param.peopleID}" />
</sql:update>

<!-- otherwise -->
<c:redirect url="/people.jsp">
    <c:param name="treeID" value="${param.treeID}" />
    <c:param name="name" value="${param.name}" />
    <c:param name="peopleID" value="${param.peopleID}" />
    <c:param name="ref" value="${param.ref}" />
    <c:param name="other" value="${param.other}" />
    <c:param name="accountOwner" value="${param.accountOwner}" />
    <c:param name="emailo" value="${param.emailo}" />
</c:redirect>