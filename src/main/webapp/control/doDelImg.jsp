<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<jsp:useBean id="nodeBean" class="utility.NodeBean" />
<jsp:setProperty name="nodeBean" property="treeBean" value="${treeBean}" />

<c:if test="${nodeBean.imgDeleted == false}">
    <c:redirect url="/control/logout.jsp" >
        <c:param name="errors" value="${nodeBean.errors}" />
    </c:redirect>
</c:if>

<!-- update image in treeBean -->
<jsp:setProperty name="treeBean" property="it" value="${nodeBean.treeBean.it}" />

<c:redirect url="/zprofile.jsp" />

<!-- old version -->
<!-- update account parameters -->
<sql:update>
    Update People Set ImageName = ? Where PeopleID = ?
    <sql:param value="none" />
    <sql:param value="${param.peopleID}" />
</sql:update>

<c:redirect url="/people.jsp">
    <c:param name="treeID" value="${param.treeID}" />
    <c:param name="name" value="${param.name}" />
    <c:param name="peopleID" value="${param.peopleID}" />
    <c:param name="ref" value="${param.ref}" />
    <c:param name="pos" value="4" />
    <c:param name="other" value="${param.other}" />
    <c:param name="accountOwner" value="${param.accountOwner}" />
    <c:param name="emailo" value="${param.emailo}" />
</c:redirect>