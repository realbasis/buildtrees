<%@ page contentType="text/html; charset=iso-8859-1" language="java" 
	import="java.sql.*,java.util.TreeMap" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Facebook Document</title>
<%@include file="control/stdTags.jspf" %>

</head>

<body>

<%
	TinyFBClient fb = new TinyFBClient("62372666001","c005aba09797b1e902feafe6d45b227c");
	TreeMap tm = new TreeMap();
    tm.put("uid", "");
	//String friendList = fb.call("friends.get", tm);
%>

<p>
	<h4>list of friends</h4>
	<%=friendList%>
</p>

</body>
</html>
