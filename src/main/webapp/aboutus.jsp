<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="java.util.LinkedList,java.util.SortedMap,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@include file="/control/stdTags.jspf" %>
<jsp:useBean id="spamBean" class="utility.SpamBean" />

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
.AutoCompleteBackground
{
	background-color:white;
}
.AutoCompleteHighlight
{
	background-color:lime;
}
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
                    	<form action="control/authenticate.jsp" method="post">
                    	<td>
                        	<input type="text" name="email" value="Email" class="cleardefault" style="color:#666666" />
                        </td>
                        <td>
                        	<input type="password" name="password" value="Password" class="cleardefault" style="color:#666666" />
                        </td>
                        <td>
                        	<input type="submit" name="Login" value="Login" />
                            <input type="hidden" name="goodBrowser" value="true">
                        </td>
                        </form>
                        <td class="menuFont">
                        	<a href="signup.jsp">Sign In</a>
                        </td>
                        <td>
                        	<div style="margin-left:20px;font-style:italic; font-size:10px">
                        		Real Basis LLC copyright @ 2011
                        	</div>
                        </td>
                    </tr>
                </table>
			</div>
        </c:if>
        <c:if test="${accountID != null}">
        	<div id="menuRight">
            	<table>
                	<tr>
                        <th class="menuFont">Welcome to ${myname} | </th>
                        <td class="menuFont">
                        	<a href="control/logout.jsp">Logout</a>
                        </td>
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
				<h3 style="text-transform:uppercase">BuildTrees&#8482; is about Family</h3>
			</td>
        </tr>
        <tr>
        	<td colspan="2"><div style="margin-bottom:0px"></div></td>
        </tr>
        <tr>
            <td valign="top" colspan="2" align="left">
            	<div id="content">
					<p style="text-align:justify; font-size:14px; padding-left:15px; padding-right:15px">BuildTrees&#8482; is an online license-free utilty designed to help people link their family members over the internet.  This is much more than a traditional family tree builder as users can share and contribute on the same tree within a few clicks regardless of their location.  BuildTrees&#8482; goal is to, eventually, connect every human being in this universe. Join us in this amazing journey.</p>
					<div align="center"><img src="images/family2.jpg"></div>
					<p style="text-align:justify; font-style:italic; font-size:14px; padding-left:15px; padding-right:15px">"What greater thing is there for human souls than to feel that they are joined for life - to be with each other in silent unspeakable memories." ~ George Eliot</p>
                    <h2 style="text-align:center;">
	                    email :: <a href="mailto:buildtrees@realbasis.com">buildtrees@realbasis.com</a>
                    </h2>
                </div>
            </td>
        </tr>
	</table>
</div>

</body>

</html>
