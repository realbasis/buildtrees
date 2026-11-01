<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="java.util.LinkedList,java.util.*,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>
<!DOCTYPE html>
<html lang="en">

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
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>BuildTrees – find your relatives</title>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Atkinson+Hyperlegible:wght@400;700&family=Literata:opsz,wght@7..72,500;7..72,700&display=swap" rel="stylesheet" />
<style>
/*
  BuildTrees home / search page.
  Palette is built around the logo, whose mint background (#99FF99) is part of the image.
*/
:root {
	--mint: #99ff99;        /* logo background, masthead band */
	--leaf: #0f6b2f;        /* links, primary actions */
	--leaf-dark: #0a4f22;
	--sap: #6fcf7f;         /* branch lines */
	--bark: #74552f;        /* relationship names, dates */
	--ink: #1f2a24;         /* text */
	--ground: #f1f6f2;      /* page background */
	--paper: #ffffff;
	--line: #d5e3d8;

	--serif: "Literata", Georgia, "Times New Roman", serif;
	--sans: "Atkinson Hyperlegible", "Segoe UI", Arial, sans-serif;
}

* { box-sizing: border-box; }

html { -webkit-text-size-adjust: 100%; }

body {
	margin: 0;
	background: var(--ground);
	color: var(--ink);
	font: 1rem/1.55 var(--sans);
}

a { color: var(--leaf); text-underline-offset: 2px; }
a:hover { color: var(--leaf-dark); }

:focus-visible {
	outline: 3px solid var(--leaf);
	outline-offset: 2px;
}

.wrap {
	width: 100%;
	max-width: 52rem;
	margin: 0 auto;
	padding: 0 1.25rem;
}

/* ---------- Masthead: the logo sits on its own mint ---------- */
.masthead {
	background: var(--mint);
	border-bottom: 1px solid #7fe38a;
}
.masthead .wrap {
	max-width: 72rem;
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	justify-content: space-between;
	gap: .75rem 1.5rem;
	padding-top: .5rem;
	padding-bottom: .5rem;
}
.brand { display: block; line-height: 0; }
.brand img { width: 250px; height: 60px; border: 0; }

.topnav {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap: .5rem 1.25rem;
	font-size: .95rem;
}
.topnav a { color: var(--leaf-dark); font-weight: 700; text-decoration: none; }
.topnav a:hover { text-decoration: underline; }

.login {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap: .4rem;
}
.login input[type=email],
.login input[type=password] {
	width: 11rem;
	padding: .4rem .55rem;
	border: 1px solid #5fbf6d;
	border-radius: 4px;
	background: #f7fff7;
	font: inherit;
	font-size: .9rem;
	color: var(--ink);
}
.login button {
	padding: .42rem .9rem;
	border: 0;
	border-radius: 4px;
	background: var(--leaf);
	color: #fff;
	font: inherit;
	font-size: .9rem;
	font-weight: 700;
	cursor: pointer;
}
.login button:hover { background: var(--leaf-dark); }
.greeting { color: var(--ink); }
.greeting strong { font-weight: 700; }

/* ---------- Search ---------- */
.search {
	padding: 3rem 0 2rem;
}
.search h1 {
	margin: 0 0 .35rem;
	font: 700 clamp(2rem, 5vw, 3rem)/1.1 var(--serif);
	letter-spacing: -.01em;
}
.search .lede {
	margin: 0 0 1.5rem;
	max-width: 36rem;
	font-size: 1.05rem;
}
.search label {
	display: block;
	margin-bottom: .35rem;
	font-weight: 700;
}
.field-row {
	display: flex;
	flex-wrap: wrap;
	gap: .6rem;
}
.name-box {
	position: relative;
	flex: 1 1 18rem;
}
#theText {
	width: 100%;
	padding: .8rem 1rem;
	border: 2px solid var(--leaf);
	border-radius: 6px;
	background: var(--paper);
	font: 500 1.25rem/1.2 var(--serif);
	color: var(--ink);
}
#theText::placeholder { color: #7b8a80; font-family: var(--sans); font-size: 1.05rem; }

.btn {
	padding: .8rem 1.25rem;
	border-radius: 6px;
	font: 700 1rem/1.2 var(--sans);
	cursor: pointer;
}
.btn-primary {
	border: 2px solid var(--leaf);
	background: var(--leaf);
	color: #fff;
}
.btn-primary:hover { background: var(--leaf-dark); border-color: var(--leaf-dark); }
.btn-secondary {
	border: 2px solid var(--leaf);
	background: transparent;
	color: var(--leaf);
}
.btn-secondary:hover { background: #e2f3e5; }

.hint {
	margin: .6rem 0 0;
	font-size: .9rem;
	color: #4c5c52;
}

/* autocomplete list (classes used by the script below) */
#theDiv {
	position: absolute;
	left: 0;
	right: 0;
	top: calc(100% + 4px);
	z-index: 10;
	visibility: hidden;
	max-height: 18rem;
	overflow-y: auto;
	border: 1px solid var(--line);
	border-radius: 6px;
	background: var(--paper);
	box-shadow: 0 6px 18px rgba(15, 107, 47, .15);
}
#theDiv div {
	padding: .45rem 1rem;
	font-family: var(--serif);
	cursor: pointer;
}
.AutoCompleteBackground { background: var(--paper); }
.AutoCompleteHighlight { background: #dff7e3; }

/* ---------- Results: each person drawn as a small branch ---------- */
.results { padding-bottom: 3rem; }
.results-head {
	margin: 0 0 1rem;
	padding-bottom: .5rem;
	border-bottom: 1px solid var(--line);
	font-size: .95rem;
	color: #4c5c52;
}
.people { list-style: none; margin: 0; padding: 0; }

.person {
	display: grid;
	grid-template-columns: 4rem 1fr;
	gap: 0 1rem;
	padding: 1.25rem 0;
	border-bottom: 1px solid var(--line);
}
.person:last-child { border-bottom: 0; }

.photo {
	width: 4rem;
	height: 4rem;
	border-radius: 50%;
	object-fit: cover;
	background: #e2efe5;
	border: 2px solid var(--sap);
}

.person h2 {
	margin: 0;
	font: 700 1.4rem/1.25 var(--serif);
}
.person h2 a { color: var(--ink); text-decoration: none; }
.person h2 a:hover { color: var(--leaf); text-decoration: underline; }

.facts {
	margin: .15rem 0 0;
	color: #46564c;
}
.facts .date { color: var(--bark); }
.more { margin-left: .35rem; font-size: .9rem; white-space: nowrap; }

/* relatives hang off a vertical branch line */
.branch {
	list-style: none;
	margin: .75rem 0 0;
	padding: 0 0 0 1.1rem;
	border-left: 2px solid var(--sap);
}
.branch li {
	position: relative;
	padding: .2rem 0 .2rem .4rem;
}
.branch li::before {
	content: "";
	position: absolute;
	left: -1.1rem;
	top: 1rem;
	width: .9rem;
	border-top: 2px solid var(--sap);
}
.branch li:last-child::after {
	/* stop the vertical line at the last relative */
	content: "";
	position: absolute;
	left: calc(-1.1rem - 2px);
	top: calc(1rem + 2px);
	bottom: 0;
	border-left: 2px solid var(--ground);
}
.relation {
	display: inline-block;
	min-width: 5.5rem;
	color: var(--bark);
	font-weight: 700;
}
.relative { font-family: var(--serif); font-weight: 500; }
.relative-facts { color: #46564c; font-size: .95rem; }

.empty {
	padding: 2rem 0 3rem;
	max-width: 36rem;
}
.empty h2 { margin: 0 0 .4rem; font: 700 1.4rem/1.3 var(--serif); }
.empty p { margin: 0; }

/* pager links printed by the ui:pager tag */
.pagelinks {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap: .35rem;
	margin: 1.5rem 0 0 !important;
	font-size: .95rem !important;
}
.pagelinks a, .pagelinks strong {
	display: inline-block;
	min-width: 2.2rem;
	padding: .3rem .55rem;
	border-radius: 4px;
	text-align: center;
}
.pagelinks a { border: 1px solid var(--line); background: var(--paper); text-decoration: none; }
.pagelinks a:hover { border-color: var(--leaf); }
.pagelinks strong { background: var(--leaf); color: #fff; }

/* ---------- Footer ---------- */
.footer {
	border-top: 1px solid var(--line);
	padding: 1.25rem 0 2rem;
	font-size: .85rem;
	color: #5b6b61;
}
.footer .wrap { max-width: 72rem; display: flex; flex-wrap: wrap; justify-content: space-between; gap: .5rem; }

.sr-only {
	position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px;
	overflow: hidden; clip: rect(0 0 0 0); white-space: nowrap; border: 0;
}

@media (max-width: 40rem) {
	.masthead .wrap { justify-content: center; }
	.topnav { width: 100%; justify-content: center; }
	.login { order: 3; width: 100%; flex-wrap: nowrap; }
	.login input[type=email], .login input[type=password] { width: auto; min-width: 0; flex: 1 1 0; }
	.search { padding-top: 2rem; }
	.field-row .btn { flex: 1 1 auto; }
	.person { grid-template-columns: 3rem 1fr; }
	.photo { width: 3rem; height: 3rem; }
	.relation { display: block; min-width: 0; }
}
</style>
<script type="text/javascript" src="js/util-functions.js"></script>
<script type="text/javascript">

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
	this.AutoComplete.oText.value = this.textContent;
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
			oDiv.textContent = aStr[i];
			oDiv.className = "AutoCompleteBackground";
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
	// names of everyone in the database (escaped for a JavaScript string)
	var aNames =
	[
	<c:forEach items="${baobabBean.peopleMaps}" var="row" varStatus="st">"${fn:replace(fn:replace(fn:replace(row.Name, '\\', '\\\\'), '"', '\\"'), '<', '\\u003c')}"<c:if test="${!st.last}">,</c:if>
	</c:forEach>
	];

	new AutoComplete(
		aNames,
		document.getElementById('theText'),
		document.getElementById('theDiv'),
		25
	);
}
</script>
</head>

<jsp:useBean id="now" class="java.util.Date" />

<body onload="document.getElementById('theText').focus(); createAutoComplete();">

<header class="masthead">
	<div class="wrap">
		<a class="brand" href="index.jsp"><img src="images/buildtrees_logo2.png" width="250" height="60" alt="BuildTrees home" /></a>

		<nav class="topnav" aria-label="Main">
			<a href="index.jsp">Home</a>
			<a href="aboutus.jsp">About us</a>

			<c:if test="${accountID == null}">
				<form class="login" action="control/authenticate.jsp" method="post">
					<label class="sr-only" for="loginEmail">Email</label>
					<input id="loginEmail" type="email" name="email" placeholder="Email" autocomplete="username" required />
					<label class="sr-only" for="loginPassword">Password</label>
					<input id="loginPassword" type="password" name="password" placeholder="Password" autocomplete="current-password" required />
					<input type="hidden" name="goodBrowser" value="true" />
					<button type="submit" name="Login" value="Login">Log in</button>
				</form>
				<a href="signup.jsp">Sign up</a>
			</c:if>

			<c:if test="${accountID != null}">
				<span class="greeting">Welcome, <strong><c:out value="${myname}" /></strong></span>
				<a href="control/logout.jsp">Log out</a>
			</c:if>
		</nav>
	</div>
</header>

<main>
	<section class="search">
		<div class="wrap">
			<h1>Find a relative</h1>
			<p class="lede">Type someone's name to see where they were born and how they connect to the rest of the family.</p>

			<form name="searchTextForm" action="control/doBuildTree.jsp" method="post" role="search">
				<label for="theText">Person's name</label>
				<div class="field-row">
					<div class="name-box">
						<input name="theText" value="<c:out value='${treeBean.theText}'/>" id="theText" type="text"
						       autocomplete="off" placeholder="e.g. Fatou Diallo" />
						<div id="theDiv" role="listbox" aria-label="Matching names"></div>
					</div>
					<button class="btn btn-primary" type="submit">Search people</button>
					<button class="btn btn-secondary" type="submit" formaction="newfamily.jsp"
					        onclick="searchTextForm.action='newfamily.jsp';">Create a family</button>
				</div>
				<p class="hint">Can't find them? Create a family and add them yourself.</p>
			</form>
		</div>
	</section>

	<section class="results" aria-live="polite">
		<div class="wrap">
			<c:choose>
				<c:when test="${fn:length(treeBean.list) > 0}">
					<p class="results-head">
						<c:choose>
							<c:when test="${not empty treeBean.theText}">Closest names to <strong><c:out value="${treeBean.theText}" /></strong> first,</c:when>
							<c:otherwise>Showing</c:otherwise>
						</c:choose>
						<c:out value="${fn:length(treeBean.list)}" />
						<c:choose><c:when test="${fn:length(treeBean.list) == 1}">person</c:when><c:otherwise>people</c:otherwise></c:choose>
					</p>

					<ui:pager total="${fn:length(treeBean.list)}" pageSize="10" render="false" />
					<ol class="people">
					<c:forEach items="${treeBean.list}" var="row" begin="${pageBegin}" end="${pageEnd}">
						<c:url var="mainUrl" value="/control/doBuildTree.jsp">
							<c:param name="theText" value="${row.Name}" />
						</c:url>
						<c:choose>
							<c:when test="${accountID != null}">
								<c:url var="mainProfileUrl" value="/details.jsp">
									<c:param name="peopleID" value="${row.PeopleID}" />
								</c:url>
							</c:when>
							<c:otherwise>
								<c:url var="mainProfileUrl" value="/login.jsp" />
							</c:otherwise>
						</c:choose>

						<li class="person">
							<img class="photo" src="control/doGetImg.jsp?id=${row.PeopleID}" alt="" loading="lazy" width="64" height="64" />
							<div>
								<h2><a href="<c:out value='${mainUrl}'/>"><c:out value="${row.Name}" /></a></h2>
								<p class="facts">
									<c:if test="${!(row.BirthPlace == null || row.BirthPlace == '')}">
										Born in <c:out value="${row.BirthPlace}" /><c:if test="${row.GotBirthdate == 'on'}"> on</c:if>
									</c:if>
									<c:if test="${row.GotBirthdate == 'on'}">
										<c:if test="${row.BirthPlace == null || row.BirthPlace == ''}">Born on</c:if>
										<span class="date"><fmt:formatDate value="${row.Birthdate}" pattern="d MMM yyyy" /></span>.
									</c:if>
									<c:if test="${row.IsDeceased == 'on'}">
										Died on <span class="date"><fmt:formatDate value="${row.Deceased}" pattern="d MMM yyyy" /></span>.
									</c:if>
									<a class="more" href="<c:out value='${mainProfileUrl}'/>">View profile</a>
								</p>

								<jsp:setProperty name="baobabBean" property="peopleID" value="${row.PeopleID}" />
								<c:if test="${not empty baobabBean.peopleMap.LinksList}">
								<ul class="branch" aria-label="Relatives of ${fn:escapeXml(row.Name)}">
									<c:forEach items="${baobabBean.peopleMap.LinksList}" var="line">
										<jsp:setProperty name="baobabBean" property="peopleID" value="${line.ElseID}" />
										<c:url var="subUrl" value="/control/doBuildTree.jsp">
											<c:param name="theText" value="${baobabBean.peopleMap.Name}" />
										</c:url>
										<c:choose>
											<c:when test="${accountID != null}">
												<c:url var="subProfileUrl" value="/details.jsp">
													<c:param name="peopleID" value="${baobabBean.peopleMap.PeopleID}" />
												</c:url>
											</c:when>
											<c:otherwise>
												<c:url var="subProfileUrl" value="/login.jsp" />
											</c:otherwise>
										</c:choose>
										<li>
											<span class="relation"><c:out value="${line.Title}" /></span>
											<%-- kept on one line so no space appears before the commas --%>
											<a class="relative" href="<c:out value='${subUrl}'/>"><c:out value="${baobabBean.peopleMap.Name}" /></a><span class="relative-facts"><c:if test="${!(baobabBean.peopleMap.BirthPlace == null || baobabBean.peopleMap.BirthPlace == '')}">, born in <c:out value="${baobabBean.peopleMap.BirthPlace}" /></c:if><c:if test="${baobabBean.peopleMap.GotBirthdate == 'on'}"><c:choose><c:when test="${!(baobabBean.peopleMap.BirthPlace == null || baobabBean.peopleMap.BirthPlace == '')}"> on </c:when><c:otherwise>, born </c:otherwise></c:choose><fmt:formatDate value="${baobabBean.peopleMap.Birthdate}" pattern="d MMM yyyy" /></c:if><c:if test="${baobabBean.peopleMap.IsDeceased == 'on'}">, died <fmt:formatDate value="${baobabBean.peopleMap.Deceased}" pattern="d MMM yyyy" /></c:if></span>
											<a class="more" href="<c:out value='${subProfileUrl}'/>">View profile</a>
										</li>
									</c:forEach>
								</ul>
								</c:if>
							</div>
						</li>
					</c:forEach>
					</ol>
					<ui:pager total="${fn:length(treeBean.list)}" pageSize="10" render="true" />
				</c:when>

				<c:when test="${not empty treeBean.theText}">
					<div class="empty">
						<h2>No one named <c:out value="${treeBean.theText}" /> yet</h2>
						<p>Check the spelling or try just a first or last name. If they're not in BuildTrees yet, <a href="newfamily.jsp">create a family</a> and add them.</p>
					</div>
				</c:when>

				<c:otherwise>
					<div class="empty">
						<p>${baobabBean.peopleSize} people are already in BuildTrees. Start typing a name above and pick one from the list.</p>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</section>
</main>

<footer class="footer">
	<div class="wrap">
		<span>&copy; <fmt:formatDate value="${now}" pattern="yyyy" /> Real Basis LLC</span>
		<span><a href="aboutus.jsp">About BuildTrees</a></span>
	</div>
</footer>

</body>

</html>
