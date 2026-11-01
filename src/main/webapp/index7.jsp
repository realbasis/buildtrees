<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@include file="/control/stdTags.jspf" %>
<c:if test="${baobabBean == null}">
	<sql:query var="ans">
		Select * from Zpeople
	</sql:query>
    <jsp:useBean id="baobabBean" class="value.BaobabBean" scope="application" />
    <jsp:setProperty name="baobabBean" property="peopleMaps" value="${ans.rows}" />
    <jsp:setProperty name="baobabBean" property="peopleSize" value="${ans.rowCount}" />
</c:if>
<c:if test="${treeBean == null}">
	<jsp:useBean id="treeBean" class="value.TreeBean" scope="session" />
</c:if>

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
div#content
{
	margin-left:30px;
	margin-top:15px;
/*	border-left:solid 1px white; */
}
.odd {
	font-size:20px;

}
.event {

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
</head>

<body onload="document.getElementById('theText').focus(); createAutoComplete();">

<div id="menu">
<table width="100%">
	<tr>
    	<td align="left">
        	<div id="menuLeft">
            	<a href="aboutus.jsp">About Us</a> | <a href="contactus.jsp">Contact Us</a>
            </div>
        </td>
        <td align="right">
        	<div id="menuRight">
            	<a href="signup.jsp">Sign In</a> @ 2011
			</div>
        </td>
    </tr>
</table>
</div>

<div id="menu2">
	<table style="width:700px">
    	<tr>
		   	<form name=fred action="control/doBuildTree.jsp" method="post">
               	<td valign="middle">
                   	<div id="menuLeftb">
	   					<a href="index.jsp"><img style="border:none; text-decoration:none" src="images/buildtrees_logo2.png"></a>
		            </div>
                </td>
				<td valign="middle" align="left">
					<div style="position:relative;overflow:visible">
						<input name="theText" value="${param.theText}" style="width:300px;" id="theText" type="text" autocomplete="off">
						<div id="theDiv" style="position:absolute;left:0px;top:25px;visibility:hidden;border:solid green 2px;background-color:white;z-index:1; width:300px"></div>
                	</div>
				</td>
				<td align="left" valign="middle">
            		<input type="submit" value="Search People" />
				</td>
	    	</form>
        </tr>
        <tr>
        	<td><div style="margin-bottom:0px"></div></td>
        </tr>
        <tr>
            <td valign="top" colspan="3" align="left">
            	<div id="content">
                	<ui:pager total="${fn:length(treeBean.list)}" pageSize="10" render="false" />
                	<table class="list" cellspacing="0" cellpadding="2">
                	<c:forEach items="${treeBean.list}" var="row" begin="${pageBegin}" end="${pageEnd}">
                    	<tr><td align="left">
                        	<p style="width:500px;">
	                        	<a href=""><c:out value="${row.Name}" /></a>
    	                        <c:if test="${!(row.BirthPlace == null || row.BirthPlace == '')}">
        	                    	, born in <c:out value="${row.BirthPlace}" /> 
            	                </c:if>
                	            <c:if test="${row.GotBirthdate == 'on'}">
                    	        	, born on <fmt:formatDate value="${row.Birthdate}" pattern="MM/dd/yyyy" />
                        	    </c:if>
                            	<c:if test="${row.IsDeceased == 'on'}">
	                            	, deceased on <fmt:formatDate value="${row.Deceased}" pattern="MM/dd/yyyy" />
    	                        </c:if>
        	                    <div style="margin-bottom:20px"></div>
                        	</p>
                        </td></tr>
                    </c:forEach>
                	</table>
                	<ui:pager total="${fn:length(treeBean.list)}" pageSize="10" render="true" />
                </div>
            </td>
        </tr>
	</table>
</div>

</body>

</html>
