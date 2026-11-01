<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<!-- delete link from POI to Family member -->
<sql:update>
    Delete From Viewers Where ViewerID = ?
    <sql:param value="${param.viewerID}" />
</sql:update>

<c:redirect url="/treesother.jsp" />
