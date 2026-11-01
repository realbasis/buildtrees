<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

    <c:if test="${param.name == ''}">
        <c:redirect url="/mytree.jsp">
            <c:param name="errors" value="Name is a required field!" />
            <c:param name="description" value="${param.description}" />
            <c:param name="ref" value="2" />
            <c:param name="treeID" value="${param.treeID}" />
        </c:redirect>
    </c:if>
    
    <!-- verify that name is not already being used -->
    <sql:query var="result">
        Select * from Trees Where TreeID = ?
        <sql:param value="${param.treeID}" />
    </sql:query>
    <c:forEach items="${result.rows}" end="0" var="row">
        <c:if test="${param.name != row.Name}">
            <!-- at this point, we know that name has been changed -->
            <sql:query var="ans">
                Select * from Trees Where Name = ?
                <sql:param value="${param.name}" />
            </sql:query>
            <c:if test="${ans.rowCount > 0}">
                <c:redirect url="/mytree.jsp">
                    <c:param name="errors" value="Name is already used!" />
                    <c:param name="name" value="${param.name}" />
                    <c:param name="description" value="${param.description}" />
                    <c:param name="treeID" value="${param.treeID}" />
                    <c:param name="ref" value="2" />
                </c:redirect>
            </c:if>
        </c:if>
    </c:forEach>
    
    <!-- update account parameters -->
    <sql:update var="result">
        Update Trees Set
            Name = ?,
            Description = ?
        Where TreeID = ?
        <sql:param value="${param.name}" />
        <sql:param value="${param.description}" />
        <sql:param value="${param.treeID}" />
    </sql:update>
  
    <!-- login -->
    <c:redirect url="/mytree.jsp">
        <c:param name="ref" value="1" />
        <c:param name="treeID" value="${param.treeID}" />
    </c:redirect>
