<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="java.util.LinkedList,java.util.SortedMap,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@include file="/control/stdTags.jspf" %>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Family Tree Builder..Mankind Connected</title>
<style type="text/css">
body {
	font-family: "Times New Roman", Times, serif;
	font-size: 12px;
	background-color:#99FF99;
}

td {
	font-family: "Times New Roman", Times, serif;
	font-size: 12px;
}

th {
	font-family: "Times New Roman", Times, serif;
	font-size: 12px;
}

input, button {
	color:blue;
	font-size:16px;
}

.bodystyle {
	font-family: "Times New Roman", Times, serif;
	font-size: 12px;
}
.style1 
{
	color: #FF0000;
	font-size:12px;
}
.small {
	font-family: "Times New Roman", Times, serif;
	font-size: 9px;
}

.medium {
	font-family: "Times New Roman", Times, serif;
	font-size: 12px;
}

.big {
	font-family: "Times New Roman", Times, serif;
	font-size: 16px;
}

.xbig {
	font-family: "Times New Roman", Times, serif;
	font-size: 24px;
}

.expanded {
	font-family: "Times New Roman", Times, serif;
	font-size: 12px;
	line-height: 16px;
	letter-spacing: 2px;
}

.justified {
	font-family: "Times New Roman", Times, serif;
	text-align: justify;
}

.footer {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 9px;
	color: #999999;
}

.box1 {
	padding: 3px;
	border-width: thin;
	border-style: solid;
	border-color: #CCCCCC #666666 #666666 #CCCCCC;
}

.box2 {
	font-style: italic;
	word-spacing: 2pt;
	padding: 3px;
	border-width: thin;
	border-style: solid;
}
div#menu
{
	font-size:14px;
	margin-bottom:20px;
	background-color:#006600;
	color:white;
}
div#menu a
{
	font-size:16px;
	text-decoration:underline;
	color:white;

}
div#menu a:hover
{
	text-decoration:underline;
	color:white;
}
div#menu3a
{
	font-size:14px;
}
div#menuRight input
{
	font-size:12px;
}
div#menuRight
{
	font-size:16px;
}

div#content
{
	margin-left:30px;
	margin-top:15px;
/*	border-left:solid 1px white; */
}
.odd {

}
.even {

}
.menuFont {
	font-size:16px;
}
</style>
<style>
.AutoCompleteBackground
{
	background-color:white;
}
.AutoCompleteHighlight
{
	background-color:lime;
}
div#content table td
{
	font-size:16px;
}
</style>
<style>
.AutoCompleteBackground
{
	background-color:white;
}
.AutoCompleteHighlight
{
	background-color:lime;
}
</style>
<script type="text/javascript" src="js/util-functions.js"></script>
<script type="text/javascript" src="js/clear-default-text.js"></script>
</head>

<body onload="document.getElementById('theText').focus(); createAutoComplete();">

<div id="menu">
<table width="100%">
	<tr>
    	<td align="left">
        	<div id="menuLeft">
            	<a href="index.jsp" class="menuFont">Home</a> | <a href="aboutus.jsp" class="menuFont">About Us</a>
            </div>
        </td>
        <td align="right">
        <c:if test="${accountID == null}">
        	<div id="menuRight">
            	<table>
                	<tr>
                        <td>
                        	<div style="margin-left:20px;font-style:italic; font-size:10px">
                        		Real Basis LLC copyright @ 2011
                        	</div>
                        </td>
                    </tr>
                </table>
			</div>
        </c:if>
        </td>
    </tr>
</table>
</div>

<div id="menu2">
	<table style="width:700px">
    	<tr>
            <td valign="middle" style="width:280px;">
               	<div id="menuLeftb">
	   				<a href="index.jsp"><img style="border:none; text-decoration:none" src="images/buildtrees_logo2.png"></a>
		        </div>
            </td>
			<td valign="middle" align="left">
				<h3 style="text-transform:uppercase">
                	Login to modify people's profiles
                </h3>
			</td>
        </tr>
        <tr>
        	<td colspan="2"><div style="margin-bottom:0px"></div></td>
        </tr>
        <tr>
            <td valign="top" colspan="2" align="left">
            	<div id="content">
                 	<form action="control/authenticate.jsp" method="post">
                    	<table>
                        	<tr>
                            	<td colspan="3" align="center" class="style1">
                                	${fn:escapeXml(param.errors)}
                                </td>
                        	<tr>
		                    	<td>
        		                	<input type="text" name="email" value="Email" class="cleardefault" style="color:#666666" />
                		        </td>
                        		<td>
		                        	<input type="password" name="password" value="Password" class="cleardefault" style="color:#666666" />
        		                </td>
                                <td align="right">
	        	                	<input type="submit" name="Login" value="Login" />
    		                        <input type="hidden" name="goodBrowser" value="true">
            		            </td>
                        	</tr>
                            <tr>
                            	<td class="menuFont" colspan="3">
                        			<a href="signup.jsp">Sign Up</a> | 
                                    <a href="index.jsp">Home</a>
		                        </td>
                        	</tr>
                        </table>
					</form>
				</div>
            </td>
        </tr>
	</table>
</div>

</body>

</html>
