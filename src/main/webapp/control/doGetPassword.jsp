<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

    <c:if test="${param.email == ''}">
        <c:redirect url="/index.jsp">
            <c:param name="errors" value="email is required!" />
            <c:param name="newuser" value="other" />
        </c:redirect>
    </c:if>
	
<!-- check if param.spam is a number or not -->
<%
	try {
		Integer.valueOf(request.getParameter("spam"));
		} 
	catch (NumberFormatException e) {    
%>
		<c:redirect url="/index.jsp">
            <c:param name="errors" value="invalid code!" />
            <c:param name="email" value="${param.email}" />
            <c:param name="newuser" value="other" />
        </c:redirect>
<%
	}
%>
	<c:if test="${(param.spam1 + param.spam2) != param.spam}">
		<c:redirect url="/index.jsp">
            <c:param name="errors" value="invalid code!" />
            <c:param name="email" value="${param.email}" />
            <c:param name="newuser" value="other" />
        </c:redirect>
	</c:if>
    
	<sql:query var="result">
        Select * from Accounts Where Email = ?
            <sql:param value="${param.email}" />
    </sql:query>
    
    <c:if test="${result.rowCount == 0}">
        <c:redirect url="/index.jsp">
            <c:param name="errors" value="user does not exist!" />
            <c:param name="email" value="${param.email}" />
            <c:param name="newuser" value="other" />
        </c:redirect>
    </c:if>
    
    <c:if test="${result.rowCount > 1}">
<%
try {
%>
    <mt:mail from="buildtrees@realbasis.com" to="buildtrees@realbasis.com" 
	server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456" 
        subject="Error in recovery password - multiple accounts">

	- Email: ${param.email}
	- Password Hint: ${param.petName}
	
   To BuildTrees Staff.

    </mt:mail>
<%
}
catch (Exception e){

}
%>
    
        <c:redirect url="/index.jsp">
            <c:param name="errors" value="user does not exist!" />
            <c:param name="email" value="${param.email}" />
        </c:redirect>
    </c:if>
    
    <c:forEach items="${result.rows}" var="row">
<%
try {
%>
    <mt:mail from="buildtrees@realbasis.com" to="${row.Email}" bcc="buildtrees@realbasis.com" 
            server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456" 
			subject="Account Password Recovered!">

 Dear ${row.Name},
	
 The password of your BuildTrees account is ${row.Password}.
 Please keep this information confidential.
   
   Thanks,
   BuildTrees Staff.

    </mt:mail>
<%
}
catch (Exception e){
    %>
        <c:redirect url="/index.jsp">
			<c:param name="email" value="${param.email}" />
            <c:param name="errors" value="server down." />
            <c:param name="newuser" value="other" />
        </c:redirect>
    <%
}
%>
    </c:forEach>
    
    <c:redirect url="/index.jsp">
        <c:param name="errors" value="password has been emailed!" />
        <c:param name="email" value="${param.email}" />
        <c:param name="newuser" value="no" />
    </c:redirect>
