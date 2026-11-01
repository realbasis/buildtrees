<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html><!-- InstanceBegin template="/Templates/publicLinked.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<!-- InstanceBeginEditable name="doctitle" -->
<title>Family Tree Builder..Mankind Connected</title>
<!-- InstanceEndEditable -->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/linked.css" rel="stylesheet" type="text/css">
<%@include file="/control/stdTags.jspf" %>
<c:set var="theURI" value="${pageContext.request.requestURI}" />
<c:set var="theURL" value="${pageContext.request.requestURL}" />
<c:if test="${languageBean == null}">
	<jsp:useBean id="languageBean" class="value.LanguageBean" scope="session" />
</c:if>
<c:if test="${param.in != null}">
	<c:if test="${param.in == 'admin'}">
		<c:set var="paswd" value="${param.password}"/>
	</c:if>
</c:if>
<!-- InstanceBeginEditable name="head" -->
<script src="js/calendarDateInput.js" type="text/javascript"></script>
<style type="text/css">
div#man
{
	margin-bottom:5px;
}
div#man div#manphoto
{
	border:1px solid #000;
	width:170px;
	height:170px;
	background-color:#CCCCCC;
}
div#man img
{
	width:170px;
	height:170px;
}
div#man div#mandata
{
	border:1px solid #000;
	width:200px;
	height:170px;
}
.smallbox
{
	width:40px;
	height:40px;
}
</style>
<script type='text/javascript' language='JavaScript'>
function submitID(thisForm) {
    thisForm.country.value=countryForm.country.options[countryForm.country.selectedIndex].value;
    thisForm.submit();
}
</script>
<jsp:useBean id="checkFamilyBean" class="utility.CheckFamilyBean" />
<!-- InstanceEndEditable -->
</head>

<body>

<table align="center" class="noborder"><tr><td>
<div id="main">
	<div id="banner" align="center">
		<table align="center" width="100%">
			<tr>
				<td align="left">
					<c:choose>
						<c:when test="${flag == 7}">
							<a href="main.jsp"><img style="border:none; text-decoration:none" src="images/buildtrees_logo2.png"></a>
						</c:when>
						<c:otherwise>
							<a href="index.jsp"><img style="border:none; text-decoration:none" src="images/buildtrees_logo2.png"></a>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
				</td>
			</tr>
		</table>
	</div>
	<!--
	<div id="menu">
	</div>
	-->
	<div id="content">
		<table align="center" width="100%"><tr>
			<td valign="top" align="left">
				<div id="vmenu">
					<table class="noborder" align="center">
						<c:if test="${flag == null}">
						<c:choose>
							<c:when test="${(fn:endsWith(theURI, 'index.jsp')) || (fn:endsWith(theURI, 'Linked/'))}">
								<tr><td><li> > ${languageBean.home}</li></td></tr>
							</c:when>
							<c:otherwise>
								<tr><td><li> <a href="index.jsp">${languageBean.home}</a></li></td></tr>
							</c:otherwise>
						</c:choose>
						</c:if>
						<c:if test="${flag == 7}">
							<tr><td>
								<p style="text-align:center; color:green; font-style:italic; padding:5px 0 5px 0">
									"${myname}"
									<br>
									You're logged in
								</p>
							</td></tr>
						</c:if>
						<c:if test="${flag == null}">
						<c:choose>
							<c:when test="${fn:endsWith(theURI, 'contactus.jsp')}">
								<tr><td><li> > ${languageBean.contactUs}</li></td></tr>
							</c:when>
							<c:otherwise>
								<tr><td><li> <a href="contactus.jsp">${languageBean.contactUs}</a></li></td></tr>
							</c:otherwise>
						</c:choose>
						</c:if>
						<c:if test="${flag != 7}">
							<c:if test="${fn:endsWith(theURI, 'signup.jsp')}">
								<tr><td><li> > ${languageBean.signup}</li></td></tr>
							</c:if>
						</c:if>
						<c:if test="${flag == 7}">
							<tr><td><li> <a href="control/logout.jsp">Logout</a></li></td></tr>
							<tr><td align="center" style="color:green">
								<br>
								need help? email us at
								<br>
								<a href="mailto:buildtrees@realbasis.com">buildtrees@realbasis.com</a>
								<br>
								<br>
							</td></tr>
						</c:if>
					</table>
					
					<c:if test="${fn:endsWith(theURI, 'signup.jsp') == false && fn:endsWith(theURI, 'forgotPassword.jsp') == false}">
						<c:if test="${flag != 7}">
						<table class="noborder" align="center" style="margin-top:20px;">
							<form action="control/authenticate.jsp" name="loginForm" method="post">
								<tr><td align="center"><div class="style1">${fn:escapeXml(param.errors)}</div></td></tr>
								<tr><td align="center"  style="color:green"> ${languageBean.email}</td></tr>
								<tr><td align="center"> <input type="text" name="email" size="20" value="${param.email}"></td></tr>
								<tr><td align="center"  style="color:green">  ${languageBean.password}</td></tr>
								<tr><td align="center"> <input type="password" name="password" size="20" value="${paswd}"></td></tr>
								<tr><td align="center">
									<input type="submit" name="login" value="${languageBean.login}" onClick="loginForm.login.value='Login...'" style="margin-top:10px; margin-bottom:10px">
								</td></tr>
								<tr><td align="center"> <a href="forgotPassword.jsp">${languageBean.forgotPassword}</a></td></tr>
								<input type="hidden" name="goodBrowser" value="true">
							</form>
						<c:choose>
							<c:when test="${fn:endsWith(theURI, 'signup.jsp')}">
								<tr><td align="center">${languageBean.signup}</td></tr>
							</c:when>
							<c:otherwise>
								<tr><td align="center"><a href="signup.jsp">${languageBean.signup}</a></td></tr>
							</c:otherwise>
						</c:choose>
						</table>
						</c:if>
					</c:if>
						<table class="noborder" align="center" style="margin-top:20px;">
							<tr><td align="center">
								<form action="https://www.paypal.com/cgi-bin/webscr" method="post">
									<input type="hidden" name="cmd" value="_s-xclick">
									<input type="hidden" name="hosted_button_id" value="4323081">
									<input type="image" src="https://www.paypal.com/en_US/i/btn/btn_donateCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
									<img alt="" border="0" src="https://www.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
								</form>
							</td></tr>
						</table>
				</div>
			</td>
			<td valign="top" align="center">
				<div id="crt">
			  <!-- InstanceBeginEditable name="EditRegion3" -->
			  <div style="margin:5px 0px 5px 10px">
				<c:url var="searchUrl" value="/treesother.jsp" />
			  	<p style="font-style:italic; font-size:12px"> <a href="index.jsp">Home</a> > <a href="<c:out value="${searchUrl}"/>">Back to Trees</a> > ${param.name}</p>
			  	
				<div>
					<sql:query var="result">
						Select People.*, Trees.Name From People, Trees 
						Where (People.TreeID = ? And People.TreeID = Trees.TreeID) Order By LastName
						<sql:param value="${param.treeID}"/>
					</sql:query>
					<c:forEach items="${result.rows}" var="row" end="0">
						<c:set var="item" value="${row}" />
					</c:forEach>
					
					<c:if test="${param.ref == null || param.ref == ''}">
						<c:if test="${result.rowCount > 0}">
							<c:redirect url="/peopleother.jsp">
							    <c:param name="name" value="${item.Name}" />
								<c:param name="peopleID" value="${item.PeopleID}" />
							    <c:param name="treeID" value="${param.treeID}" />
							    <c:param name="ref" value="1" />
							</c:redirect>
						</c:if>
					
						<c:if test="${result.rowCount == 0}">
							<p class="style1" style="text-align:center">This tree is empty</p>
							<p style="text-align:center">
								<form method="post" action="treesother.jsp">
									<input type="submit" value="Back to other trees">
								</form>
							</p>
						</c:if>
					</c:if>
					
					<p style="text-align:center">
					<table class="noborder">
						<c:if test="${result.rowCount > 0}">
						<form action="peopleotherx.jsp" method="post" name="viewForm">
						<tr>
							<td colspan="2" style="text-align:center">
								<p style="font-style:italic">family has ${result.rowCount} members</p>
							</td>
						</tr>
						<tr>
							<td style="font-style:italic">* Change selection to view profile</td>
							<td align="center">
								<select name="peopleID" onChange="viewForm.submit()">
								<c:forEach items="${result.rows}" var="row">
									<sql:query var="crowd">
										Select * From Links Where PeopleID = ?
										<sql:param value="${row.PeopleID}"/>
									</sql:query>
									
									<c:choose>
										<c:when test="${param.peopleID == row.PeopleID}">
											<option value="${row.PeopleID}" selected="selected">${row.LastName}, ${row.FirstName}... ${crowd.rowCount} members</option>
										</c:when>
										<c:otherwise>
											<option value="${row.PeopleID}">${row.LastName}, ${row.FirstName}... ${crowd.rowCount} members</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								</select>
							</td>
								<input type="hidden" name="treeID" value="${param.treeID}">
								<input type="hidden" name="name" value="${param.name}">
								<input type="hidden" name="ref" value="1">
						</tr>
						</form>
						</c:if>
					</table>
					</p>
				</div>
				
<!-------------- view profile ref = 1 --------->				
				<c:if test="${param.ref == 1}">
					<sql:query var="sets">
						Select * From People Where PeopleID = ?
						<sql:param value="${param.peopleID}"/>
					</sql:query>
					<c:choose>
					<c:when test="${sets.rowCount == 1}">
					<c:forEach items="${sets.rows}" end="0" var="line">
						<p style="font-size:16px; text-align:center; text-decoration:underline">Profile of <span style="font-weight:bold">${fn:escapeXml(line.FirstName)} ${fn:escapeXml(line.LastName)}</span></p>
						<c:set var="memo" value="${line}" />
					<hr>
					<div id="man">
						<table class="noborder" align="center"><tr>
							<c:set var="gender" value="${line.Gender}" />
							<td>
								<c:choose>
								<c:when test="${line.ImageName == 'none'}">
								<div id="manphoto" style="text-align:center; padding-top:40px">
									<p>NO</p>
									<p>PICTURE</p>
								</div>
								</c:when>
								<c:otherwise>
									<img src='<c:out value="control/doGetImg.jsp?id=${param.peopleID}" />'>
								</c:otherwise>
								</c:choose>
								
							</td>
							<td>
								<div id="mandata">
									<ul>
										<li style="text-decoration:underline; margin-top:4px">${fn:escapeXml(line.LastName)}, ${fn:escapeXml(line.FirstName)}</li>
									<c:if test="${line.GotBirthdate == 'on'}">
										<fmt:formatDate var="birthdate" value="${line.Birthdate}" pattern="MMM-dd-yyyy" />
										<li style="list-style:none">Born on ${fn:escapeXml(birthdate)}</li>
									</c:if>
									<c:if test="${line.isDeceased == 'on'}">
										<fmt:formatDate var="deceased" value="${line.Deceased}" pattern="MMM-dd-yyyy" />
										<li style="list-style:none">Departed on ${fn:escapeXml(deceased)}</li>
									</c:if>
										<li style="list-style:none">${fn:escapeXml(line.Gender)}</li>
										<li style="margin-top:6px">Contacts:</li>
									<c:if test="${line.Email != ''}">
										<li style="list-style:none"><a href="mailto:<c:out value="${line.Email}"/>">${fn:escapeXml(line.Email)}</a></li>
									</c:if>
									<c:if test="${line.Tel != ''}">
										<li style="list-style:none">${fn:escapeXml(line.Tel)}</li>
									</c:if>
									<c:if test="${line.Web != ''}">
										<li style="list-style:none"><a href="<c:out value="${fn:escapeXml(line.Web)}" />" target="_blank">${fn:escapeXml(line.Web)}</a></li>
									</c:if>
									</ul>
								</div>
							</td>
						</tr></table>
					</div>
					</c:forEach>
<hr>
					<c:if test="${param.pos == null || param.pos == ''}">
					
						<p style="font-size:16px; text-align:center; text-decoration:underline">Display of ${fn:escapeXml(memo.FirstName)} ${fn:escapeXml(memo.LastName)} Family</p>
						
						<table class="noborder">
							<tr>
								<td valign="top" width="100">
									<p style="text-decoration:underline; text-align:center">[add Parent]</p>
									<sql:query var="parentRes">
										Select Links.*, People.FirstName, People.LastName, People.Birthdate, People.ImageName 
										From Links, People 
										Where (Links.PeopleID = ? And Links.FamilyID = People.PeopleID And Links.Type = ?)
										<sql:param value="${param.peopleID}"/>
										<sql:param value="parent"/>
									</sql:query>
									<c:forEach items="${parentRes.rows}" var="phrase">
										<c:url var="tomanUrl" value="/peopleother.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="nameSearch" value="${param.nameSearch}" />
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>${phrase.Title}<br><a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a></p>
											<c:if test="${phrase.ImageName != 'none'}">
												<a href="<c:out value="${tomanUrl}" />"><img class="smallbox" src='<c:out value="control/doGetImg.jsp?id=${phrase.FamilyID}" />'></a>
											</c:if>
										</div>
									</c:forEach>	
								</td>
								<td valign="top" width="100">
									<p style="text-decoration:underline; text-align:center">[add Spouse]</p>
									<sql:query var="spouseRes">
										Select Links.*, People.FirstName, People.LastName, People.Birthdate, People.ImageName 
										From Links, People 
										Where (Links.PeopleID = ? And Links.FamilyID = People.PeopleID And Links.Type = ?)
										<sql:param value="${param.peopleID}"/>
										<sql:param value="spouse"/>
									</sql:query>
									<c:forEach items="${spouseRes.rows}" var="phrase">
										<c:url var="tomanUrl" value="/peopleother.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="nameSearch" value="${param.nameSearch}" />
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>${phrase.Title}<br><a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a></p>
											<c:if test="${phrase.ImageName != 'none'}">
												<a href="<c:out value="${tomanUrl}" />"><img class="smallbox" src='<c:out value="control/doGetImg.jsp?id=${phrase.FamilyID}" />'></a>
											</c:if>
										</div>
									</c:forEach>	
								</td>
								<td valign="top" width="100">
									<p style="text-decoration:underline; text-align:center">[add Child]</p>
									<sql:query var="childRes">
										Select Links.*, People.FirstName, People.LastName, People.Birthdate, People.ImageName 
										From Links, People 
										Where (Links.PeopleID = ? And Links.FamilyID = People.PeopleID And Links.Type = ?) 
										Order By Birthdate
										<sql:param value="${param.peopleID}"/>
										<sql:param value="child"/>
									</sql:query>
									<c:forEach items="${childRes.rows}" var="phrase">
										<c:url var="tomanUrl" value="/peopleother.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="nameSearch" value="${param.nameSearch}" />
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>${phrase.Title}<br><a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a></p>
											<c:if test="${phrase.ImageName != 'none'}">
												<a href="<c:out value="${tomanUrl}" />"><img class="smallbox" src='<c:out value="control/doGetImg.jsp?id=${phrase.FamilyID}" />'></a>
											</c:if>
										</div>
									</c:forEach>
								</td>
								<td valign="top" width="100">
									<p style="text-decoration:underline; text-align:center">[add Sibling]</p>
									<sql:query var="siblingRes">
										Select Links.*, People.FirstName, People.LastName, People.Birthdate, People.ImageName 
										From Links, People 
										Where (Links.PeopleID = ? And Links.FamilyID = People.PeopleID And Links.Type = ?) 
										Order By Birthdate
										<sql:param value="${param.peopleID}"/>
										<sql:param value="sibling"/>
									</sql:query>
									<c:forEach items="${siblingRes.rows}" var="phrase">
										<c:url var="tomanUrl" value="/peopleother.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="nameSearch" value="${param.nameSearch}" />
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>${phrase.Title}<br><a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a></p>
											<c:if test="${phrase.ImageName != 'none'}">
												<a href="<c:out value="${tomanUrl}" />"><img class="smallbox" src='<c:out value="control/doGetImg.jsp?id=${phrase.FamilyID}" />'></a>
											</c:if>
										</div>
									</c:forEach>
								</td>
								<td valign="top" width="100">
									<p style="text-decoration:underline; text-align:center">[add Other]</p>
									<sql:query var="otherRes">
										Select Links.*, People.FirstName, People.LastName, People.Birthdate, People.ImageName 
										From Links, People 
										Where (Links.PeopleID = ? And Links.FamilyID = People.PeopleID And Links.Type = ?)
										<sql:param value="${param.peopleID}"/>
										<sql:param value="other"/>
									</sql:query>
									<c:forEach items="${otherRes.rows}" var="phrase">
										<c:url var="tomanUrl" value="/peopleother.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="nameSearch" value="${param.nameSearch}" /> 
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>${phrase.Title}<br><a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a></p>
											<c:if test="${phrase.ImageName != 'none'}">
												<a href="<c:out value="${tomanUrl}" />"><img class="smallbox" src='<c:out value="control/doGetImg.jsp?id=${phrase.FamilyID}" />'></a>
											</c:if>
										</div>
									</c:forEach>
								</td>
							</tr>
						</table>

					</c:if> 
					
					</c:when>
					<c:otherwise>
						<!-- we have an error -->
						<p>Individual was not found.  Please try again.</p>
						<p>If this problem persists, contact us at <a href="mailto:support@realbasis.com">support@realbasis.com</a></p>
					</c:otherwise>
					</c:choose>
				</c:if>
			  </div>
			  <!-- InstanceEndEditable -->
			  	</div>
			 </td>
			<td valign="top" align="right">
				<div id="rvmenu">
					<c:if test="${flag == null}">
					</c:if>
				</div>
			</td>
		</tr></table>
	</div>
	<div id="footnotes">
		<p style="font-size:10px">Powered by Real Basis LLC - Copyright 2003-2010.  <a href="policy.jsp">Privacy Policy</a>.</p>
	</div>
</div>
</td></tr></table>

<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-544679-2";
urchinTracker();
</script>

</body>
<!-- InstanceEnd --></html>
