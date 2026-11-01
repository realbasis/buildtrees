<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<!-- delete all links -->
<sql:update>
    Delete From Links Where PeopleID = ?
    <sql:param value="${param.peopleID}" />
</sql:update>

<sql:update>
    Delete From Links Where FamilyID = ?
    <sql:param value="${param.peopleID}" />
</sql:update>

<!-- delete person -->
<sql:update>
    Delete From People Where PeopleID = ?
    <sql:param value="${param.peopleID}" />
</sql:update>

<sql:query var="ans">
    Select * From People Where TreeID = ?
    <sql:param value="${param.treeID}"/>
</sql:query>
<c:forEach items="${ans.rows}" var="line" end="0">
    <c:set var="peopleID" value="${line.PeopleID}" />
</c:forEach>

<c:if test="${ans.rowCount > 0}">
    <c:redirect url="/mytree.jsp">
        <c:param name="treeID" value="${param.treeID}" />
        <c:param name="name" value="${param.name}" />
        <c:param name="other" value="${param.other}" />
        <c:param name="accountOwner" value="${param.accountOwner}" />
	<c:param name="emailo" value="${param.emailo}" />
	<c:param name="ref" value="1" />
    </c:redirect>
</c:if>
<c:if test="${ans.rowCount == 0}">
    <c:redirect url="/mytree.jsp">
        <c:param name="treeID" value="${param.treeID}" />
        <c:param name="ref" value="1" />
        <c:param name="other" value="${param.other}" />
        <c:param name="accountOwner" value="${param.accountOwner}" />
	<c:param name="emailo" value="${param.emailo}" />
    </c:redirect>
</c:if>