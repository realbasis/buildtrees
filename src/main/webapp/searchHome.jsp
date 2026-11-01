<%--
    Document   : searchHome (simple search landing page from the 2015 "buildtrees" rewrite)
    Created on : May 3, 2015, 6:08:47 AM
    Author     : ThiernoLamine
    Wired to the home page search (index.jsp?theText=...).
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>BuildTrees - search people</title>
        <%@include file="control/stdTags.jspf" %>
        <link href="css/default.css" rel="stylesheet" type="text/css">
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
    <body>
        <div class="search">
            <form action="index.jsp" method="get">
                <b>search people by name</b>
                <br>
                <input type="text" name="theText" class="searchText" value="<c:out value='${param.theText}'/>" autofocus>
                <input type="submit" value="BUILDTREES" class="searchButton">
            </form>
            <p><a href="index.jsp">Home</a></p>
        </div>
    </body>
</html>
