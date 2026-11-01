<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Facebook Document</title>
<%@include file="control/stdTags.jspf" %>
</head>

<body>

<%
	String API_KEY="";
	String SECRET="";
	
	FacebookRestClient client= new FacebookRestClient(API_KEY, SECRET);
//	client.setIsDesktop(true);
	
	try {
	
	String url="http://www.facebook.com/login.php?api_key="+API_KEY+"&v=1.0"+
		"&auth_token="+SECRET;
		
	String sessionKey = request.getParameter(FacebookParam.SESSION_KEY.toString());
	FacebookXmlRestClient client = new FacebookXmlRestClient(apiKey, secretKey, sessionKey);
	Long uid = client.users_getLoggedInUser();
	
	

	
	} catch (FacebookException e) {
	
	} catch (IOException ioe) {
	
	
	}


%>

</body>
</html>
