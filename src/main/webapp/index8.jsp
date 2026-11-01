<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="java.util.LinkedList,java.util.*,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@include file="/control/stdTags.jspf" %>

<c:if test="${baobabBean == null}">
    <jsp:useBean id="baobabBean" class="value.BaobabBean" scope="application" />
<%
	boolean success = true;
	int size = 0;

	ConnBean connBean = null;
    ArrayList values = null;
	SortedMap maps[] = null;
	SortedMap map = null;
	TreeMap tMaps = null;
	TreeMap tMap = null;
	LinkedList imgList = null;
	TreeLogicBean treeLogicBean = new TreeLogicBean();

	connBean = new ConnBean();
	success = connBean.isStarted();

	BaobabBean baobab = (BaobabBean) application.getAttribute("baobabBean");
	
	// create accounts maps
	success = treeLogicBean.createAccounts();
        maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
        baobab.setAccountsMaps(maps);

	// create people maps
	success = treeLogicBean.createFamily(null);
	maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
	// update maps with Blob image
        values = new ArrayList();
	imgList = connBean.selectImg(treeLogicBean.getMsg(),values);
        int imgListSize = 0;
        imgListSize = imgList.size();
        size = maps.length;
        if(size == imgListSize) {
            for(int i=0; i<size; i++) {
                
                TreeMap imgMap = (TreeMap) imgList.get(i);
                Blob blob = (Blob) imgMap.get("Image");
                //Integer imgId = (Integer) imgMap.get("PeopleID");
                if(blob != null) {
                    tMap = (TreeMap) maps[i];
                    tMap.put("Image",blob);
                    maps[i] = (SortedMap) tMap;
                }
                
            }
        }
	baobab.setPeopleMaps(maps);
	
	
    baobab.setPeopleSize(maps.length);

	success = treeLogicBean.createLinks(null,null);
	maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
	baobab.setLinksMaps(maps);
    baobab.setLinksSize(maps.length);
        
    // create a map of people indexed by peopleID
    baobab.setFamilyMap(treeLogicBean.famByPeopleID(baobab.getPeopleMaps()));
      
    // update link of family links in familyMap
    baobab.setFamilyMap(treeLogicBean.createBaobabLinks(baobab.getFamilyMap(),baobab.getLinksMaps()));

	success = connBean.isClosed();
%>
</c:if>

<c:if test="${treeBean == null}">
	<jsp:useBean id="treeBean" class="value.TreeBean" scope="session" />
    <fmt:setLocale value="en_US" scope="session"/>
	<fmt:setTimeZone value="US/Eastern" scope="session"/>
</c:if>
<c:if test="${param.theText != null}">
	<jsp:setProperty name="treeBean" property="theText" value="${param.theText}" />
</c:if>

<c:if test="${accountID == null && isCookie == null}">
<%
	// check if cookie is set, if yes - automatically login user
	/***
	String cookieName = new String("buildtreesCookie");
    String loginString[];
	Cookie[] mesCookies = request.getCookies();
	boolean isCookie = false;
	int size = 0; 
	
	if (mesCookies!=null) {
		size = mesCookies.length;
		for (int i=0; i<mesCookies.length; i++) {
			if (mesCookies[i].getName().equals(cookieName)) {
                            loginString = mesCookies[i].getValue().split(":");
                            if(loginString.length == 2) {
                                isCookie = true;
                                request.setAttribute("loginEmail",loginString[0]);
                                request.setAttribute("loginPassword",loginString[1]);
                                break;
                            }
			}
		}
	}
        if(isCookie)
            request.setAttribute("isCookie","yes");
        else
            request.setAttribute("isCookie","no");
	***/
%>
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
	<c:if test="${baobabBean.peopleSize >= 2}">
            <c:forEach items="${baobabBean.peopleMaps}" var="row" end="${baobabBean.peopleSize-2}">
		"${row.Name}",
            </c:forEach>
	</c:if>
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
                        	<a href="signup.jsp">Sign Up</a>
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
                	<form name="searchTextForm" action="control/doBuildTree.jsp" method=post>
                    <div>
                    	<table>
                        	<tr><td>
		                    	<div style="position:relative;overflow:visible">
									<input name="theText" value="${treeBean.theText}" style="width:300px;" id="theText" type="text" autocomplete="off">
									<div id="theDiv" style="position:absolute;left:0px;top:25px;visibility:hidden;border:solid green 2px;background-color:white;z-index:1; width:300px"></div>
			                	</div>
                            </td></tr>
                        	<tr><td>
		                    	<input type="text" value="name of one parent (optional)" class="cleardefault" style="color:gray; width:300px" />
                            </td></tr>
                            <tr><td>
		                        <input type="text" value="name of one child (optional)" class="cleardefault" style="color:gray; width:300px" />
                            </td></tr>
                    	</table>
                    </div>
                    </form>
				</td>
				<td align="left" valign="middle">
                    <div>
                    	<table>
                        	<tr><td>
		                    	<input type="button" value="Search People" onclick="searchTextForm.action='control/doBuildTree.jsp';searchTextForm.submit()" style="width:150px" />
                            </td></tr>
                        	<tr><td>
                            	<input type="button" value="Create a Family" onclick="searchTextForm.action='newfamily.jsp';searchTextForm.submit()" style="width:150px" />
                            </td></tr>
                    	</table>
                    </div>
				</td>
        </tr>
        <tr>
        	<td><div style="margin-bottom:0px"></div></td>
        </tr>
        <tr>
            <td valign="top" colspan="3" align="left">
            	<div id="content">
                	<display:table name="${treeBean.list}" uid="row" pagesize="10" >
                    	<display:column title="" align="left" style="font-size:14px" >
                        	<p style="width:500px;">
                            	<c:url var="mainUrl" value="/control/doBuildTree.jsp">
									<c:param name="theText" value="${row.Name}" />
								</c:url>
	                        	<a href="<c:out value="${mainUrl}"/>"><c:out value="${row.Name}" /></a> 
    	                        <c:if test="${!(row.BirthPlace == null || row.BirthPlace == '')}">
        	                    	, born in <c:out value="${row.BirthPlace}" /> 
            	                </c:if>
                	            <c:if test="${row.GotBirthdate == 'on'}">
                    	        	, born on <fmt:formatDate value="${row.Birthdate}" pattern="MMM-dd-yyyy" />
                        	    </c:if>
                            	<c:if test="${row.IsDeceased == 'on'}">
	                            	, deceased on <fmt:formatDate value="${row.Deceased}" pattern="MMM-dd-yyyy" />
    	                        </c:if> 
                                <c:if test="${accountID != null}">
	                                <c:url var="mainProfileUrl" value="/details.jsp">
										<c:param name="peopleID" value="${row.PeopleID}" />
									</c:url>
                                </c:if>
                                <c:if test="${accountID == null}">
	                                <c:url var="mainProfileUrl" value="/login.jsp" />
                                </c:if>
                                [<a href="<c:out value="${mainProfileUrl}"/>">more</a>]
                                <ul>
                                	<jsp:setProperty name="baobabBean" property="peopleID" value="${row.PeopleID}" />
                                	<c:forEach items="${baobabBean.peopleMap.LinksList}" var="line">
                                    	<jsp:setProperty name="baobabBean" property="peopleID" value="${line.ElseID}" />
                                    	<li>
                                        	<c:out value="${line.Title}" />: 
                                            <c:url var="subUrl" value="/control/doBuildTree.jsp">
												<c:param name="theText" value="${baobabBean.peopleMap.Name}" />
											</c:url>
                                            <a href="<c:out value="${subUrl}"/>">
                                            	<c:out value="${baobabBean.peopleMap.Name}" />
                                            </a>
                                            <c:if test="${!(baobabBean.peopleMap.BirthPlace == null || baobabBean.peopleMap.BirthPlace == '')}">
			        	                    	, born in <c:out value="${baobabBean.peopleMap.BirthPlace}" /> 
			            	                </c:if>
			                	            <c:if test="${baobabBean.peopleMap.GotBirthdate == 'on'}">
			                    	        	, born on <fmt:formatDate value="${baobabBean.peopleMap.Birthdate}" pattern="MMM-dd-yyyy" />
			                        	    </c:if>
			                            	<c:if test="${baobabBean.peopleMap.IsDeceased == 'on'}">
				                            	, deceased on <fmt:formatDate value="${baobabBean.peopleMap.Deceased}" pattern="MMM-dd-yyyy" />
			    	                        </c:if> 
                                            <c:if test="${accountID != null}">
				                                <c:url var="subProfileUrl" value="/details.jsp">
													<c:param name="peopleID" value="${baobabBean.peopleMap.PeopleID}" />
												</c:url>
			                                </c:if>
            			                    <c:if test="${accountID == null}">
	                    			            <c:url var="subProfileUrl" value="/login.jsp" />
			                                </c:if>
            			                    [<a href="<c:out value="${subProfileUrl}"/>">more</a>]
                                        </li>
                                    </c:forEach>
                                </ul>
                        	</p>
                            <div style="margin-bottom:10px"></div>
                        </display:column>
                    </display:table>
                </div>
            </td>
        </tr>
	</table>
</div>

</body>

</html>
