<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Mankind Connected</title>
<%@ page isErrorPage="true" %>
<%@include file="/control/stdTags.jspf" %>
<c:set var="theURI" value="${pageContext.request.requestURI}" />
<jsp:useBean id="now" class="java.util.Date" />
<jsp:useBean id="mailerBean" class="value.MailerBean" />
<c:if test="${configBean.serverEmail != 'none'}" >
<%
try {
%>
	<mt:mail from="buildtrees@realbasis.com" subject="Software Error on Buildtrees" 
			to="support@realbasis.com" server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456"> 
	${now}
    Dear Real Basis staff, Your customer has experienced a software error. See 
    below... 
	
		Path: ${pageContext.request.requestURL} 
		Error in: ${pageContext.errorData.requestURI} 
	    Exception: ${pageContext.exception} 
		Error message: ${pageContext.errorData.throwable.message} 
		AccountID: ${accountID}
    
	See logs for more details! 
	</mt:mail>
<%
}
catch (Exception e){
}
%>
</c:if>
<c:if test="${flag != null && flag !=''}">
<%
	session.invalidate();
%>
</c:if>
<%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>

<body>
			<div style="text-align:left; font-size:14px; margin:40px 25px 20px 45px">
				<p>We're sorry but the request could not be processed.</p>
			    <p>Detailed information about the error has been logged so we will analyze it and correct whatever is causing it as soon as possible.</p>
			    <p>Please try again, or contact <a href="mailto:support@realbasis.com">technical support</a> to report the problem if it persists.</p>
			    <p style="text-align:center">[<a href="http://www.buildtrees.com">Back to BuildTrees.Com</a>]
				<p>
					<ora:fileWrite fileName="log"> Error in: ${pageContext.errorData.requestURI} </ora:fileWrite> 
					<ora:fileWrite fileName="log"> Error message: ${pageContext.errorData.throwable.message} </ora:fileWrite> 
					<ora:debug type="params" /> 
				</p>
			</div>
</body>
</html>
