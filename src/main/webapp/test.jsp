<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="utility.*,value.*" %>

<%@include file="control/stdTags.jspf" %>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Mankind Connected</title><a href="test.jsp">Mankind Connected</a>
<script type="text/javascript" src="js/ajaxjs2.js"></script>
</head>
<body>

<div id="test">
	<h2>Click to let AJAX change this text</h2>
</div>
<button type="button" onclick="loadXMLDoc('test1.txt')">Click Me</button>
<button type="button" onclick="loadXMLDoc('test2.txt')">Click Me</button>

<br /><br />

<div>
	<form>
    	First Name: <input tabindex="text" id="txt1" onkeyup="showHint(this.value)" />
    </form>
    <p>Suggestions: <span id="txtHint"></span></p>
</div>
</body>
</html>
