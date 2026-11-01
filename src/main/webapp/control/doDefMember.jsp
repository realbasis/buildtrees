<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<!-- update account parameters -->
    <sql:update>
        Update People Set
            AccountID = ?
        Where PeopleID = ?
        <sql:param value="${param.accountIDg}" />
        <sql:param value="${param.peopleID}" />
    </sql:update>
    
    <c:redirect url="/mytree.jsp">
        <c:param name="ref" value="1" />
        <c:param name="treeID" value="${param.treeID}" />
        <c:param name="accountOwner" value="${param.accountOwner}" />
	<c:param name="emailo" value="${param.emailo}" />
    </c:redirect>
