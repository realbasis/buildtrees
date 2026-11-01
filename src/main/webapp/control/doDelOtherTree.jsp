<%@page contentType="text/html" errorPage="../error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<!-- delete all notifications -->
    <sql:update>
        Delete From Viewers Where ViewerID = ?
        <sql:param value="${param.viewerID}" />
    </sql:update>
    
    <!-- update peoople -->
    <sql:query var="result">
        Select * From People Where TreeID = ? And AccountID = ?
        <sql:param value="${param.treeID}"/>
        <sql:param value="${param.accountIDg}"/>
    </sql:query>
    
    <c:forEach items="${result.rows}" var="row">
        <!-- update people parameters -->
        <sql:update>
            Update People 
            Set
                AccountID = ?
            Where PeopleID = ?
            <sql:param value="-1" />
            <sql:param value="${row.PeopleID}" />
        </sql:update>
    </c:forEach>

<!-- return -->
<c:redirect url="/trees.jsp" />
