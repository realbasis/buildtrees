<%@page contentType="text/html" errorPage="../error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

    <c:if test="${param.name == ''}">
        <c:redirect url="/trees.jsp">
            <c:param name="errors" value="Name is a required field!" />
            <c:param name="description" value="${param.description}" />
            <c:param name="ref" value="0" />
        </c:redirect>
    </c:if>
    
    <!-- verify that family name does not already exists -->
    <sql:query var="result">
        Select * from Trees Where Name = ?
        <sql:param value="${param.name}" />
    </sql:query>
    <c:if test="${result.rowCount > 0}">
        <c:redirect url="/trees.jsp">
            <c:param name="errors" value="Name is already used!" />
            <c:param name="name" value="${param.name}" />
            <c:param name="description" value="${param.description}" />
            <c:param name="ref" value="0" />
        </c:redirect>
    </c:if>
    
    <!-- update account parameters -->
    <sql:update var="result">
        Insert Into Trees (Name, Description, AccountID) Values (?,?,?)
        <sql:param value="${param.name}" />
        <sql:param value="${param.description}" />
        <sql:param value="${accountID}" />
    </sql:update>
    
    <!-- login -->
    <c:redirect url="/trees.jsp" />
