<%@ page import="com.temesoft.security.Base64Coder"%>
<%@ page import="com.temesoft.security.Encrypter"%>
<%@ page import="com.temesoft.security.Config"%>
<%@ page import="java.awt.*"%>
<%@page contentType="text/html" errorPage="../error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@include file="stdTags.jspf" %>
<jsp:useBean id="now" class="java.util.Date" />

<c:if test="${param.submitNo == 'I Do Not Agree'}">
	<c:redirect url="/" />
</c:if>

<%
    /*** temp
    String passline = request.getParameter("passline");
    String passlineEncoded = request.getParameter("passline_enc");
    Encrypter stringEncrypter = new Encrypter();
    String errorMsg = null;

    if ((passline!=null) || (passlineEncoded !=null)) {

        String passlineDecoded = Base64Coder.decode(passlineEncoded);
        String passlineCheck = stringEncrypter.decrypt(passlineDecoded);
        String passlineString = passlineCheck;
        
        
        String sessionId = passlineString.substring(
                passlineString.indexOf(".")+1, passlineString.length());
        
        if (!sessionId.equals(request.getSession().getId())) {
            errorMsg = new String("Encripted session is incorrect!");
        }

        passlineCheck = passlineCheck.substring(0, Config.getPropertyInt(Config.MAX_NUMBER));
        if (!passline.toUpperCase().equals(passlineCheck.toUpperCase())) {
            errorMsg = new String("Security code is incorrect!");
        }

    }
    else
        response.sendRedirect("../signup.jsp?errors=Encripted session is incorrect!");
    
    if(errorMsg != null) {
     ***/
%>

<c:redirect url="/signup.jsp">
    <c:param name="errors" value="<%= errorMsg %>" />
    <c:param name="name" value="${param.name}" />
    <c:param name="email" value="${param.email}" />
    <c:param name="petName" value="${param.petName}" />
    <c:param name="user" value="${param.user}" />
</c:redirect>

<%        
    }


%>


    <c:if test="${param.name == ''}">
        <c:redirect url="/signup.jsp">
            <c:param name="errors" value="Name is a required field!" />
            <c:param name="email" value="${param.email}" />
            <c:param name="petName" value="${param.petName}" />
            <c:param name="user" value="${param.user}" />
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
        </c:redirect>
    </c:if>
    
    <c:if test="${param.user == '' || param.user == ''}">
        <c:redirect url="/signup.jsp">
            <c:param name="errors" value="Please enter username!" />
            <c:param name="name" value="${param.name}" />
            <c:param name="email" value="${param.email}" />
            <c:param name="petName" value="${param.petName}" />
            <c:param name="user" value="${param.user}" />
        </c:redirect>
    </c:if>
    
<%
    String user = request.getParameter("user");
    if(user.length() < 6)
        {
%>
        <c:redirect url="/signup.jsp">
            <c:param name="errors" value="Your username is too short!" />
            <c:param name="name" value="${param.name}" />
            <c:param name="email" value="${param.email}" />
            <c:param name="petName" value="${param.petName}" />
            <c:param name="user" value="${param.user}" />
        </c:redirect>
<%
        }
%>
    
    <!-- verify that email does not already exists -->
    <sql:query var="result">
        SELECT * FROM Accounts WHERE User = ?
        <sql:param value="${param.user}" />
    </sql:query>
    <c:if test="${result.rowCount != 0}">
        <c:redirect url="/signup.jsp">
            <c:param name="errors" value="Username is already in use!" />
            <c:param name="email" value="${param.email}" />
            <c:param name="name" value="${param.name}" />
            <c:param name="petName" value="${param.petName}" />
            <c:param name="user" value="${param.user}" />
        </c:redirect>
    </c:if>
    
    
    <c:if test="${param.pass1 == '' || param.pass2 == ''}">
        <c:redirect url="/signup.jsp">
            <c:param name="errors" value="Please enter password!" />
            <c:param name="name" value="${param.name}" />
            <c:param name="email" value="${param.email}" />
            <c:param name="petName" value="${param.petName}" />
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
        </c:redirect>
    </c:if>
    
    <c:if test="${param.petName == ''}">
        <c:redirect url="/signup.jsp">
            <c:param name="errors" value="Pet Name is a required field!" />
            <c:param name="name" value="${param.name}" />
            <c:param name="email" value="${param.email}" />
            <c:param name="user" value="${param.user}" />
        </c:redirect>
    </c:if>
    
    <!-- create account -->
    <sql:update var="result">
        Insert Into Accounts (Name, Email, User, Password, PetName, CreationDate) Values (?,?,?,?,?,?)
        <sql:param value="${param.name}" />
        <sql:param value="${param.email}" />
        <sql:param value="${param.user}" />
        <sql:param value="${param.pass1}" />
        <sql:param value="${param.petName}" />
        <sql:dateParam value="${now}" />
    </sql:update>
    
<c:if test="${configBean.serverEmail != 'none'}" >

<%
try {
%>
        <mt:mail from="buildtrees@realbasis.com" subject="New account created on buildtrees" 
            to="support@realbasis.com" 
			server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456">

    ${now}
    Email notification for new buildtrees account!
    
         -- name: ${fn:escapeXml(param.name)}
         -- user: ${fn:escapeXml(param.user)}
         -- email: ${fn:escapeXml(param.email)}

        </mt:mail>

<%
}
catch (Exception e){
    %>
        <mt:mail from="buildtrees@realbasis.com" subject="Email Failure" 
            to="support@realbasis.com" 
			server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456">

    ${now}
    -- Email forwarded to ${param.email} has failed 
             Email notification for new buildtrees account failed!
             
             name: ${fn:escapeXml(param.name)}
             user: ${fn:escapeXml(param.user)}

        </mt:mail>
    <%
}
%>
</c:if>
    
    <!-- login -->
    <c:redirect url="/control/authenticate.jsp">
        <c:param name="user" value="${param.user}" />
        <c:param name="password" value="${param.pass1}" />
    </c:redirect>

