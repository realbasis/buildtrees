<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>


<c:if test="${param.status == 'Public'}">

<!-- update account parameters -->
<sql:update var="result">
    Update Trees Set
        Status = ? 
    Where TreeID = ?
        <sql:param value="Private" />
        <sql:param value="${param.treeID}" />
</sql:update>

<c:redirect url="/mytree.jsp">
    <c:param name="name" value="${param.name}" />
    <c:param name="treeID" value="${param.treeID}" />
    <c:param name="ref" value="1" />
</c:redirect>

</c:if>

<c:if test="${param.status == 'Private'}">

<!-- update account parameters -->
<sql:update var="result">
    Update Trees Set
        Status = ?,
        Grouppass = ?
    Where TreeID = ?
        <sql:param value="Public" />
        <sql:param value="none" />
        <sql:param value="${param.treeID}" />
</sql:update>

<c:redirect url="/mytree.jsp">
    <c:param name="name" value="${param.name}" />
    <c:param name="treeID" value="${param.treeID}" />
    <c:param name="ref" value="1" />
</c:redirect>

</c:if>