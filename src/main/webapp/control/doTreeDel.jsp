<%@page contentType="text/html" errorPage="../error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

    <!-- delete all people parameters -->
    <sql:update>
        Delete From People Where TreeID = ?
        <sql:param value="${param.treeID}" />
    </sql:update>
    
    <!-- delete all notifications -->
    <sql:update>
        Delete From Viewers Where TreeID = ?
        <sql:param value="${param.treeID}" />
    </sql:update>
    
    <!-- delete tree parameters -->
    <sql:update var="result">
        Delete From Trees Where TreeID = ?
        <sql:param value="${param.treeID}" />
    </sql:update>
  
    <!-- login -->
    <c:redirect url="/trees.jsp" />
