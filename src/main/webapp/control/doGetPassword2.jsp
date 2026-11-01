<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

    <c:if test="${param.email == ''}">
        <c:redirect url="/forgotPassword.jsp">
            <c:param name="errors" value="Email is a required field!" />
        </c:redirect>
    </c:if>
	
<!-- check if param.spam is a number or not -->
<%
	try {
		Integer.valueOf(request.getParameter("spam"));
		} 
	catch (NumberFormatException e) {    
%>
		<c:redirect url="/forgotPassword.jsp">
            <c:param name="errors" value="invalid anti-spam code!" />
        </c:redirect>
<%
	}
%>
	<c:if test="${(param.spam1 + param.spam2) != param.spam}">
		<c:redirect url="/forgotPassword.jsp">
            <c:param name="errors" value="invalid anti-spam code!" />
        </c:redirect>
	</c:if>
    
	<!--
    <c:if test="${param.petName == ''}">
        <c:redirect url="/forgotPassword.jsp">
            <c:param name="errors" value="Password Hint is a required field!" />
            <c:param name="email" value="${param.email}" />
        </c:redirect>
    </c:if>
    -->
<!-- verify parameters -->
    <!--
    <sql:query var="result">
        Select * from Accounts Where Email = ? And PetName = ?
            <sql:param value="${param.email}" />
            <sql:param value="${param.petName}" />
    </sql:query>
	-->
	<sql:query var="result">
        Select * from Accounts Where Email = ?
            <sql:param value="${param.email}" />
    </sql:query>
    
    <c:if test="${result.rowCount == 0}">
        <c:redirect url="/forgotPassword.jsp">
            <c:param name="errors" value="We could not find your account!" />
            <c:param name="email" value="${param.email}" />
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
    
        <c:redirect url="/forgotPassword.jsp">
            <c:param name="errors" value="We could not find your account!" />
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
        <c:redirect url="/forgotPassword.jsp">
			<c:param name="email" value="${param.email}" />
            <c:param name="errors" value="Email server is temporarily down." />
        </c:redirect>
    <%
}
%>
    </c:forEach>
    
    <c:redirect url="/forgotPassword.jsp">
        <c:param name="errors" value="Your password has been emailed to your address!" />
        <c:param name="email" value="${param.email}" />
    </c:redirect>
