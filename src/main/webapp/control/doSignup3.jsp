<%@ page import="java.awt.*"%>
<%@page contentType="text/html" errorPage=""%>
<%@page pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@include file="stdTags.jspf" %>
<jsp:useBean id="now" class="java.util.Date" />
<jsp:useBean id="mailerBean" class="value.MailerBean" />

<!-- check if param.spam is a number or not -->
<%
	try {
		Integer.valueOf(request.getParameter("spam"));
		} 
	catch (NumberFormatException e) {    
%>
		<c:redirect url="/signup.jsp">
            <c:param name="errors" value="invalid anti-spam code!" />
			<c:param name="email" value="${param.email}" />
            <c:param name="petName" value="${param.petName}" />
            <c:param name="user" value="${param.user}" />
            <c:param name="gender" value="${param.gender}" />
            <c:param name="name" value="${param.name}" />
        </c:redirect>
<%
	}
%>
	<c:if test="${(param.spam1 + param.spam2) != param.spam}">
		<c:redirect url="/signup.jsp">
            <c:param name="errors" value="invalid anti-spam code!" />
			<c:param name="email" value="${param.email}" />
            <c:param name="petName" value="${param.petName}" />
            <c:param name="user" value="${param.user}" />
            <c:param name="gender" value="${param.gender}" />
            <c:param name="name" value="${param.name}" />
        </c:redirect>
	</c:if>

    <c:if test="${param.name == ''}">
        <c:redirect url="/signup.jsp">
            <c:param name="errors" value="Name is a required field!" />
            <c:param name="email" value="${param.email}" />
            <c:param name="petName" value="${param.petName}" />
            <c:param name="user" value="${param.user}" />
            <c:param name="gender" value="${param.gender}" />
        </c:redirect>
    </c:if>
    
    <c:if test="${param.email == ''}">
        <c:redirect url="/signup.jsp">
            <c:param name="errors" value="Please enter email!" />
            <c:param name="name" value="${param.name}" />
            <c:param name="email" value="${param.email}" />
            <c:param name="petName" value="${param.petName}" />
            <c:param name="user" value="${param.user}" />
            <c:param name="gender" value="${param.gender}" />
        </c:redirect>
    </c:if>
    
    <ora:ifValidEmailAddr value="${param.email}" var="isValid" />
    <c:if test="${!isValid}">
        <c:redirect url="/signup.jsp">
            <c:param name="errors" value="Please enter valid Email!" />
            <c:param name="email" value="${param.email}" />
            <c:param name="name" value="${param.name}" />
            <c:param name="petName" value="${param.petName}" />
            <c:param name="user" value="${param.user}" />
            <c:param name="gender" value="${param.gender}" />
        </c:redirect>
    </c:if>
    
    <c:if test="${param.gender == 'SELECT'}">
        <c:redirect url="/signup.jsp">
            <c:param name="errors" value="Please enter gender!" />
            <c:param name="name" value="${param.name}" />
            <c:param name="email" value="${param.email}" />
            <c:param name="petName" value="${param.petName}" />
            <c:param name="user" value="${param.user}" />
            <c:param name="gender" value="${param.gender}" />
        </c:redirect>
    </c:if>
    
    <!-- verify that email does not already exists -->
    <sql:query var="result">
        SELECT * FROM Accounts WHERE Email = ?
        <sql:param value="${param.email}" />
    </sql:query>
    <c:if test="${result.rowCount != 0}">
        <c:redirect url="/signup.jsp">
            <c:param name="errors" value="Email is already in use!" />
            <c:param name="email" value="${param.email}" />
            <c:param name="name" value="${param.name}" />
            <c:param name="petName" value="${param.petName}" />
            <c:param name="user" value="${param.user}" />
            <c:param name="gender" value="${param.gender}" />
        </c:redirect>
    </c:if>
    
    <c:if test="${param.petName == ''}">
        <c:redirect url="/signup.jsp">
            <c:param name="errors" value="Password hint is a required field!" />
            <c:param name="name" value="${param.name}" />
            <c:param name="email" value="${param.email}" />
            <c:param name="user" value="${param.user}" />
            <c:param name="gender" value="${param.gender}" />
        </c:redirect>
    </c:if>
    
    <c:if test="${param.pass1 == '' || param.pass2 == ''}">
        <c:redirect url="/signup.jsp">
            <c:param name="errors" value="Please enter password!" />
            <c:param name="name" value="${param.name}" />
            <c:param name="email" value="${param.email}" />
            <c:param name="petName" value="${param.petName}" />
            <c:param name="gender" value="${param.gender}" />
        </c:redirect>
    </c:if>
    
<%
    String pass1 = request.getParameter("pass1");
    if(pass1.length() < 6)
        {
%>
        <c:redirect url="/signup.jsp">
            <c:param name="errors" value="Your password is too short!" />
            <c:param name="name" value="${param.name}" />
            <c:param name="email" value="${param.email}" />
            <c:param name="petName" value="${param.petName}" />
            <c:param name="user" value="${param.user}" />
            <c:param name="gender" value="${param.gender}" />
        </c:redirect>
<%
        }
%>
    
    <c:if test="${param.pass1 != param.pass2}">
        <c:redirect url="/signup.jsp">
            <c:param name="errors" value="Please confirm password!" />
            <c:param name="name" value="${param.name}" />
            <c:param name="email" value="${param.email}" />
            <c:param name="petName" value="${param.petName}" />
            <c:param name="user" value="${param.user}" />
            <c:param name="gender" value="${param.gender}" />
        </c:redirect>
    </c:if>
    
    <!-- create account -->
    <sql:update>
        Insert Into Accounts (Name, Email, User, Password, PetName, CreationDate) Values (?,?,?,?,?,?)
        <sql:param value="${param.name}" />
        <sql:param value="${param.email}" />
        <sql:param value="" />
        <sql:param value="${param.pass1}" />
        <sql:param value="${param.petName}" />
        <sql:dateParam value="${now}" />
    </sql:update>
    
    <!-- get account ID -->
    <sql:query var="result">
        Select MAX(AccountID) from Accounts
    </sql:query>
    <c:forEach items="${result.rowsByIndex}" var="ans" end="0">
        <c:set var="accountID" value="${ans[0]}" />
    </c:forEach>
    
    <!-- create owner as member -->
    <sql:update>
        Insert Into Zpeople (Name, Email, Gender, Title, AccountID) Values (?,?,?,?,?)
        <sql:param value="${param.name}" />
        <sql:param value="${param.email}" />
        <sql:param value="${param.gender}" />
        <sql:param value="owner" />
        <sql:param value="${accountID}" />
    </sql:update>
    
    <!-- check if you got invitations -->
    <sql:query var="result">
        Select * from Sollicitations Where Email = ? And Status = ?
        <sql:param value="${param.email}" />
        <sql:param value="1" />
    </sql:query>
    <c:forEach items="${result.rows}" var="ans">
        <sql:update>
	        Insert Into Sharers (AccountID, MyAccountID, Status) Values (?,?,?)
    	    <sql:param value="${accountID}" />
            <sql:param value="${ans.FromAID}" />
    	    <sql:param value="1" />
	    </sql:update>
        <sql:update>
	        Insert Into Sharers (AccountID, MyAccountID, Status) Values (?,?,?)
    	    <sql:param value="${ans.FromAID}" />
            <sql:param value="${accountID}" />
    	    <sql:param value="0" />
	    </sql:update>
    </c:forEach>
    
    <sql:update>
		Delete From Sollicitations Where Email = ? And Status = ?
	    <sql:param value="${param.email}" />
        <sql:param value="1" />
    </sql:update>

<c:if test="${configBean.serverEmail != 'none'}" >

<%
try {
%>
        <mt:mail from="buildtrees@realbasis.com" subject="New account created on buildtrees" 
            to="support@realbasis.com" server="${mailerBean.smtp}" port="${mailerBean.port}" 
			username="${mailerBean.username}" password="${mailerBean.password}">

    ${now}
    Email notification for new buildtrees account!
    
         -- name: ${fn:escapeXml(param.name)}
         -- email: ${fn:escapeXml(param.email)}

        </mt:mail>

<%
}
catch (Exception e){
    %>
        <mt:mail from="buildtrees@realbasis.com" subject="Email Failure" 
            to="support@realbasis.com" server="${mailerBean.smtp}" port="${mailerBean.port}" 
			username="${mailerBean.username}" password="${mailerBean.password}">

    ${now}
    -- Email forwarded to ${param.email} has failed 
             Email notification for new buildtrees account failed!
             
             -- name: ${fn:escapeXml(param.name)}
             -- email: ${fn:escapeXml(param.email)}

        </mt:mail>
    <%
}
%>
</c:if>
    
    <!-- login -->
    <c:redirect url="/control/authenticate.jsp">
        <c:param name="email" value="${param.email}" />
        <c:param name="password" value="${param.pass1}" />
		<c:param name="goodBrowser" value="true" />
    </c:redirect>

