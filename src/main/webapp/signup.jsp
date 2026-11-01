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
<script language=javascript>

function AutoCompleteDB()
{
	// set the initial values.
	this.bEnd = false;
	this.nCount = 0;
	this.aStr = new Object;
}

AutoCompleteDB.prototype.add = function(str)
{
	// increment the count value.
	this.nCount++;

	// if at the end of the string, flag this node as an end point.
	if ( str == "" )
		this.bEnd = true;
	else
	{
		// otherwise, pull the first letter off the string
		var letter = str.substring(0,1);
		var rest = str.substring(1,str.length);
		
		// and either create a child node for it or reuse an old one.
		if ( !this.aStr[letter] ) this.aStr[letter] = new AutoCompleteDB();
		this.aStr[letter].add(rest);
	}
}

AutoCompleteDB.prototype.getCount = function(str, bExact)
{
	// if end of search string, return number
	if ( str == "" )
		if ( this.bEnd && bExact && (this.nCount == 1) ) return 0;
		else return this.nCount;
	
	// otherwise, pull the first letter off the string
	var letter = str.substring(0,1);
	var rest = str.substring(1,str.length);
	
	// and look for case-insensitive matches
	var nCount = 0;
	var lLetter = letter.toLowerCase();
	if ( this.aStr[lLetter] )
		nCount += this.aStr[lLetter].getCount(rest, bExact && (letter == lLetter));
	
	var uLetter = letter.toUpperCase();
	if ( this.aStr[uLetter] )
		nCount += this.aStr[uLetter].getCount(rest, bExact && (letter == uLetter));
	
	return nCount;	
}

AutoCompleteDB.prototype.getStrings = function(str1, str2, outStr)
{
	if ( str1 == "" )
	{
		// add matching strings to the array
		if ( this.bEnd ) 
			outStr.push(str2);

		// get strings for each child node
		for ( var i in this.aStr )
			this.aStr[i].getStrings(str1, str2 + i, outStr);
	}
	else
	{
		// pull the first letter off the string
		var letter = str1.substring(0,1);
		var rest = str1.substring(1,str1.length);
		
		// and get the case-insensitive matches.
		var lLetter = letter.toLowerCase();
		if ( this.aStr[lLetter] )
			this.aStr[lLetter].getStrings(rest, str2 + lLetter, outStr);

		var uLetter = letter.toUpperCase();
		if ( this.aStr[uLetter] )
			this.aStr[uLetter].getStrings(rest, str2 + uLetter, outStr);
	}
}


function AutoComplete(aStr, oText, oDiv, nMaxSize)
{
	// initialize member variables
	this.oText = oText;
	this.oDiv = oDiv;
	this.nMaxSize = nMaxSize;
	
	// preprocess the texts for fast access
	this.db = new AutoCompleteDB();
	var i, n = aStr.length;
	for ( i = 0; i < n; i++ )
	{
		this.db.add(aStr[i]);
	}
			
	// attach handlers to the text-box
	oText.AutoComplete = this;
	oText.onkeyup = AutoComplete.prototype.onTextChange;
	oText.onblur = AutoComplete.prototype.onTextBlur;
}

AutoComplete.prototype.onTextBlur = function()
{
	this.AutoComplete.onblur();
}

AutoComplete.prototype.onblur = function()
{
	this.oDiv.style.visibility = "hidden";
}

AutoComplete.prototype.onTextChange = function()
{
	this.AutoComplete.onchange();
}

AutoComplete.prototype.onDivMouseDown = function()
{
	this.AutoComplete.oText.value = this.innerHTML;
}

AutoComplete.prototype.onDivMouseOver = function()
{
	this.className = "AutoCompleteHighlight";
}

AutoComplete.prototype.onDivMouseOut = function()
{
	this.className = "AutoCompleteBackground";
}

AutoComplete.prototype.onchange = function()
{
	var txt = this.oText.value;
	
	// count the number of strings that match the text-box value
	var nCount = this.db.getCount(txt, true);
	
	// if a suitable number then show the popup-div
	if ( (this.nMaxSize == -1 ) || ((nCount < this.nMaxSize) && (nCount > 0)) )
	{
		// clear the popup-div.
		while ( this.oDiv.hasChildNodes() )
			this.oDiv.removeChild(this.oDiv.firstChild);
			
		// get all the matching strings from the AutoCompleteDB
		var aStr = new Array();
		this.db.getStrings(txt, "", aStr);
		
		// add each string to the popup-div
		var i, n = aStr.length;
		for ( i = 0; i < n; i++ )
		{
			var oDiv = document.createElement('div');
			this.oDiv.appendChild(oDiv);
			oDiv.innerHTML = aStr[i];
			oDiv.onmousedown = AutoComplete.prototype.onDivMouseDown;
			oDiv.onmouseover = AutoComplete.prototype.onDivMouseOver;
			oDiv.onmouseout = AutoComplete.prototype.onDivMouseOut;
			oDiv.AutoComplete = this;			
		}
		this.oDiv.style.visibility = "visible";
	}
	else // hide the popup-div
	{
		this.oDiv.innerHTML = "";
		this.oDiv.style.visibility = "hidden";
	}
}

function createAutoComplete()
{
	var aNames = 
	[
	<c:forEach items="${baobabBean.peopleMaps}" var="row" end="${baobabBean.peopleSize-2}">
		"${row.Name}",
	</c:forEach>
	"${baobabBean.peopleMaps[baobabBean.peopleSize-1].Name}"
	]

	new AutoComplete(
		aNames, 
		document.getElementById('theText'), 
		document.getElementById('theDiv'), 
		25
	);
}
</script>
<%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>

<body onload="document.getElementById('theText').focus(); createAutoComplete();">

<%@ include file="/WEB-INF/jspf/masthead.jspf" %>

<div id="menu2">
	<table style="width:700px">
    	<tr>
			<td valign="middle" align="left">
				<h3 style="text-transform:uppercase">Create an account to build your family tree</h3>
			</td>
        </tr>
        <tr>
        	<td colspan="2"><div style="margin-bottom:0px"></div></td>
        </tr>
        <tr>
            <td valign="top" colspan="2" align="left">
            	<div id="content">
					<form action="control/doSignup.jsp" method="post" name="signupForm">
		                <table>
						  <tr>
                		    <td colspan="2">
								<div align="center" class="style1">${fn:escapeXml(param.errors)}</div>
							</td>
		                  </tr>
						  <tr align="left">
                		    <td>Your Name<span class="style1">*</span>::</td>
		                    <td><input type="text" name="name" value="${param.name}"></td>
        		          </tr>
                		  <tr align="left">
		                    <td>Your Email<span class="style1">*</span>::</td>
        		            <td><input type="text" name="email" value="${param.email}"></td>
                		  </tr>
						  <tr align="left">
		                    <td>Your Gender<span class="style1">*</span>::</td>
        		            <td>
								<select name="gender">
									<option>SELECT</option>
									<c:if test="${param.gender == 'Male'}">
										<option selected="selected">Male</option>
									</c:if>
									<c:if test="${param.gender != 'Male'}">
										<option>Male</option>
									</c:if>
									<c:if test="${param.gender == 'Female'}">
										<option selected="selected">Female</option>
									</c:if>
									<c:if test="${param.gender != 'Female'}">
										<option>Female</option>
									</c:if>
								</select>
							</td>
                		  </tr>
						  <tr align="left">
		                    <td>Password (at least 6 chars)<span class="style1">*</span>::</td>
        		            <td><input type="password" name="pass1" value="${param.pass1}"></td>
                		  </tr>
						  <tr align="left">
		                    <td>Confirm password<span class="style1">*</span>::</td>
        		            <td><input type="password" name="pass2" value="${param.pass2}"></td>
                		  </tr>
						  <tr>
		                    <th align="right">
								<span style="color:red">anti-spam code:</span>  ${spamBean.spam1} + ${spamBean.spam2} = 
								<input type="hidden" name="spam1" value="${spamBean.spam1}">
								<input type="hidden" name="spam2" value="${spamBean.spam2}">
							</th>
        		            <td align="left">
								<input type="text" name="spam" size="2" maxlength="2"> <input type="submit" name="signupB" value="Sign Up" onClick="signupForm.signupB.value='Processing...'">
							</td>
                            <input type="hidden" name="petName" value="12345678">
                		  </tr>
				      </table>
				  </form>
                </div>
            </td>
        </tr>
	</table>
</div>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>

</html>
