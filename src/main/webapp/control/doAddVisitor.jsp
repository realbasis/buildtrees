<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<!-- update account parameters -->
<sql:update var="result">
    Update Viewers Set
        Status = ? 
    Where ViewerID = ?
        <sql:param value="Accepted" />
        <sql:param value="${param.viewerID}" />
</sql:update>

<c:redirect url="/visitors.jsp" />
