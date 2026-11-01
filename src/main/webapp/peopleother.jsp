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
<!-- check session -->
<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>
<c:if test="${param.peopleID > 0}">
	<sql:query var="sets">
		Select * From People Where PeopleID = ?
		<sql:param value="${param.peopleID}"/>
	</sql:query>
	<c:forEach items="${sets.rows}" var="zcup" end="0">
		<c:set var="cup" value="${zcup}" />
	</c:forEach>
</c:if>
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
					<table align="center">
						<tr>
							<td align="center">
							<c:if test="${flag == null}">
								<p>
<script type="text/javascript"><!--
google_ad_client = "pub-3538041140037139";
google_ad_width = 468;
google_ad_height = 60;
google_ad_format = "468x60_as";
google_ad_type = "image";
//2007-02-22: investment club
google_ad_channel = "3833421812";
google_color_border = "FFFFFF";
google_color_bg = "FFFFFF";
google_color_link = "0000FF";
google_color_text = "000000";
google_color_url = "008000";
//--></script>
<script type="text/javascript"
  src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
								</p>
							</c:if>
							</td>
						</tr>
					</table>
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
								<tr><td align="center"> <input type="password" name="password" size="20"></td></tr>
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
								<form action="control/doLanguage.jsp" method="post" name="changeLanguage">
									<select name="language" onChange="changeLanguage.submit()">
										<c:forEach items="${languageBean.list}" var="it">
											<c:choose>
											<c:when test="${languageBean.language == it.Cle0}">
												<option value="${it.Cle0}" selected="selected">${it.Cle1}</option>
											</c:when>
											<c:otherwise>
												<option value="${it.Cle0}">${it.Cle1}</option>
											</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
									<input type="hidden" name="theURL" value="${theURL}">
								</form>
							</td></tr>
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
			  	<p style="font-style:italic; font-size:12px"> <a href="index.jsp">Home</a> > <a href="<c:out value="${searchUrl}"/>">Back to Other Trees</a> > ${param.name}</p>
			  	
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
								<c:param name="otheraccountID" value="${item.AccountID}" />
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
				</div>
				
<!--------------- ref = 0, add people to tree -->
				<c:if test="${param.ref == 0}">
					<hr>
					<form action="control/doNewPeople.jsp" method="post" name="addPeopleForm">
					<table class="noborder">
						<tr>
							<th colspan="2">Add New Person</th>
						</tr>
						<tr><td colspan="2" class="style1"><p style="text-align:center">${fn:escapeXml(param.errors)}</p></td></tr>
						<tr>
							<td class="style1" colspan="2" align="center">Please carefully specify person's GENDER!</td>
						</tr>
						<tr>
							<td class="style1" colspan="2" align="center">This parameter may not be modified once saved.</td>
						</tr>
						<tr>
							<td>Gender<span class="style1">*</span></td>
							<td>
								<select name="gender">
								<c:choose>
									<c:when test="${param.gender == 'Male'}">
										<option selected="selected">Male</option>
									</c:when>
									<c:otherwise>
										<option>Male</option>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${param.gender == 'Female'}">
										<option selected="selected">Female</option>
									</c:when>
									<c:otherwise>
										<option>Female</option>
									</c:otherwise>
								</c:choose>
								</select>
							</td>
						</tr>
						<tr>
							<td>First Name(s)<span class="style1">*</span></td>
							<td>Last Name<span class="style1">*</span></td>
						</tr>
						<tr>
							<td><input type="text" name="firstName" value="${param.firstName}"></td>
							<td><input type="text" name="lastName" value="${param.lastName}"></td>
						</tr>
						<tr>
							<td>Email::</td>
							<td>Telephone::</td>
						</tr>
						<tr>
							<td><input type="text" name="pemail" value="${param.pemail}"></td>
							<td><input type="text" name="tel" value="${param.tel}"></td>
						</tr>
						<tr>
							<td colspan="2" align="center">Web Site::</td>
						</tr>
						<tr>
							<td colspan="2" align="center"><input type="text" name="web" value="${param.web}" size="40"></td>
						</tr>
					</table>
					<table class="noborder">
						<tr>
							<td colspan="3" style="font-style:italic">Dates are recorded only if boxes below are checked!</td>
						</tr>
						<tr>
						<c:choose>
							<c:when test="${param.gotBirthdate == 'on'}">
							<td><input type="checkbox" name="gotBirthdate" value="${param.gotBirthdate}" checked="checked"></td>
							</c:when>
							<c:otherwise>
							<td><input type="checkbox" name="gotBirthdate"></td>
							</c:otherwise>
						</c:choose>
							<td>Born on</td>
						<c:choose>
							<c:when test="${param.birthdate == '' || param.birthdate == null}">
							<td><script>DateInput('birthdate', true, 'MON-DD-YYYY')</script></td>
							</c:when>
							<c:otherwise>
							<td><script>DateInput('birthdate', true, 'MON-DD-YYYY', '${param.birthdate}')</script></td>
							</c:otherwise>
						</c:choose>
						</tr>
						<tr>
						<c:choose>
							<c:when test="${param.isDeceased == 'on'}">
							<td><input type="checkbox" name="isDeceased" checked="checked"></td>
							</c:when>
							<c:otherwise>
							<td><input type="checkbox" name="isDeceased"></td>
							</c:otherwise>
						</c:choose>
							<td>Deceased on</td>
						<c:choose>
							<c:when test="${param.deceased == '' || param.deceased == null}">
							<td><script>DateInput('deceased', true, 'MON-DD-YYYY')</script></td>
							</c:when>
							<c:otherwise>
							<td><script>DateInput('deceased', true, 'MON-DD-YYYY', '${param.deceased}')</script></td>
							</c:otherwise>
						</c:choose>
						</tr>
						<tr>
							<td colspan="3" align="center"><input type="button" value="Save Record" name="addPeople" onClick="addPeopleForm.addPeople.value='Processing...';addPeopleForm.submit()"></td>
						</tr>
						<input type="hidden" name="name" value="${param.name}">
						<input type="hidden" name="treeID" value="${param.treeID}">
						<input type="hidden" name="other" value="true">
					</form>
					</table>
						
					<c:if test="${param.peopleID == null || param.peopleID == ''}">
						<c:url var="viewpeopleUrl" value="/trees.jsp">
							<c:param name="treeID" value="${param.treeID}" />
							<c:param name="ref" value="1" />
						</c:url>
					</c:if>
					<c:if test="${param.peopleID > 0}">
						<c:url var="viewpeopleUrl" value="/peopleother.jsp">
							<c:param name="treeID" value="${param.treeID}" />
							<c:param name="name" value="${param.name}" />
							<c:param name="peopleID" value="${param.peopleID}" />
							<c:param name="ref" value="1" />
						</c:url>
					</c:if>
					<div><p><a href="<c:out value="${viewpeopleUrl}"/>">Cancel transaction</a></p></div>
				</c:if>
				
<!-------------- view profile ref = 1 --------->				
				<c:if test="${param.ref == 1}">
					
					<c:choose>
					<c:when test="${sets.rowCount == 1}">
					<c:forEach items="${sets.rows}" end="0" var="line">
					
						<p style="font-size:16px; text-align:center"><span style="font-weight:bold">Profile of  ${fn:escapeXml(line.FirstName)} ${fn:escapeXml(line.LastName)} and Family</span>
						<c:if test="${line.AccountID == accountID}">
							<br><span class="style1" style="font-size:18px">^</span> <span class="style1" style="color:gray">means profile can be modified by only you or tree owner</span>
						</c:if>
						</p>
						<c:if test="${param.updateStatus != null && param.updateStatus != ''}">
							<p class="style1">${fn:escapeXml(param.updateStatus)} updates</p>
						</c:if>
									
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
									
									<c:if test="${line.AccountID == accountID}">
										<c:url var="delpersonUrl" value="/peopleother.jsp">
											<c:param name="ref" value="1" />
											<c:param name="pos" value="2" />
											<c:param name="name" value="${param.name}" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${param.peopleID}" />
										</c:url>
										<c:url var="editpersonUrl" value="/peopleother.jsp">
											<c:param name="ref" value="1" />
											<c:param name="pos" value="3" />
											<c:param name="name" value="${param.name}" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${param.peopleID}" />
										</c:url>
										<c:url var="loadimgUrl" value="/peopleother.jsp">
											<c:param name="ref" value="1" />
											<c:param name="pos" value="4" />
											<c:param name="name" value="${param.name}" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${param.peopleID}" />
										</c:url>
										<li style="list-style:none; text-align:center; margin-top:10px">[<a href="<c:out value="${loadimgUrl}" />">Load Image</a>] - [<a href="<c:out value="${editpersonUrl}" />">Edit</a>] - [<a href="<c:out value="${delpersonUrl}" />">Delete</a>]</li>
									</c:if>
									</ul>
								</div>
							</td>
						</tr></table>
					</div>
					</c:forEach>
<hr>
					<c:if test="${param.pos == null || param.pos == ''}">
					
						<c:if test="${cup.AccountID == accountID}">
						<table class="noborder">
							<tr>
								<td colspan="5" style="font-size:12; font-style:italic">* Click <img src="images/del.png"> to delete link to family member</td>
							</tr>
							<tr>
								<td valign="top" width="100">
									<c:url var="addTypeUrl" value="/peopleother.jsp">
										<c:param name="ref" value="1" />
										<c:param name="pos" value="0" />
										<c:param name="treeID" value="${param.treeID}" />
										<c:param name="peopleID" value="${param.peopleID}" />
										<c:param name="name" value="${param.name}" />
										<c:param name="type" value="parent" />
									</c:url>
									<p style="text-decoration:underline; text-align:center">[<a href="<c:out value="${addTypeUrl}"/>">add Parent</a>]</p>
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
										</c:url>
										<c:url var="dellinkUrl" value="/control/doDelLink.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${param.peopleID}" />
											<c:param name="familyID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="other" value="true" />
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>${phrase.Title} <a href="<c:out value="${dellinkUrl}"/>"><img src="images/del.png" style="border:none"></a> <br><a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a></p>
											<c:if test="${phrase.ImageName != 'none'}">
												<a href="<c:out value="${tomanUrl}" />"><img class="smallbox" src='<c:out value="control/doGetImg.jsp?id=${phrase.FamilyID}" />'></a>
											</c:if>
										</div>
									</c:forEach>	
								</td>
								<td valign="top" width="100">
								<c:if test="${gender == 'Male'}">
									<c:url var="addTypeUrl" value="/peopleother.jsp">
										<c:param name="ref" value="1" />
										<c:param name="pos" value="1" />
										<c:param name="treeID" value="${param.treeID}" />
										<c:param name="peopleID" value="${param.peopleID}" />
										<c:param name="name" value="${param.name}" />
										<c:param name="type" value="spouse" />
										<c:param name="title" value="Wife" />
									</c:url>
								</c:if>
								<c:if test="${gender == 'Female'}">
									<c:url var="addTypeUrl" value="/peopleother.jsp">
										<c:param name="ref" value="1" />
										<c:param name="pos" value="1" />
										<c:param name="treeID" value="${param.treeID}" />
										<c:param name="peopleID" value="${param.peopleID}" />
										<c:param name="name" value="${param.name}" />
										<c:param name="type" value="spouse" />
										<c:param name="title" value="Husband" />
									</c:url>
								</c:if>
									<p style="text-decoration:underline; text-align:center">[<a href="<c:out value="${addTypeUrl}"/>">add Spouse</a>]</p>
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
										</c:url>
										<c:url var="dellinkUrl" value="/control/doDelLink.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${param.peopleID}" />
											<c:param name="familyID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="other" value="true" />
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>${phrase.Title} <a href="<c:out value="${dellinkUrl}"/>"><img src="images/del.png" style="border:none"></a> <br><a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a></p>
											<c:if test="${phrase.ImageName != 'none'}">
												<a href="<c:out value="${tomanUrl}" />"><img class="smallbox" src='<c:out value="control/doGetImg.jsp?id=${phrase.FamilyID}" />'></a>
											</c:if>
										</div>
									</c:forEach>	
								</td>
								<td valign="top" width="100">
									<c:url var="addTypeUrl" value="/peopleother.jsp">
										<c:param name="ref" value="1" />
										<c:param name="pos" value="0" />
										<c:param name="treeID" value="${param.treeID}" />
										<c:param name="peopleID" value="${param.peopleID}" />
										<c:param name="name" value="${param.name}" />
										<c:param name="type" value="child" />
									</c:url>
									<p style="text-decoration:underline; text-align:center">[<a href="<c:out value="${addTypeUrl}"/>">add Child</a>]</p>
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
										</c:url>
										<c:url var="dellinkUrl" value="/control/doDelLink.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${param.peopleID}" />
											<c:param name="familyID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="other" value="true" />
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>${phrase.Title} <a href="<c:out value="${dellinkUrl}"/>"><img src="images/del.png" style="border:none"></a> <br><a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a></p>
											<c:if test="${phrase.ImageName != 'none'}">
												<a href="<c:out value="${tomanUrl}" />"><img class="smallbox" src='<c:out value="control/doGetImg.jsp?id=${phrase.FamilyID}" />'></a>
											</c:if>
										</div>
									</c:forEach>
								</td>
								<td valign="top" width="100">
									<c:url var="addTypeUrl" value="/peopleother.jsp">
										<c:param name="ref" value="1" />
										<c:param name="pos" value="0" />
										<c:param name="treeID" value="${param.treeID}" />
										<c:param name="peopleID" value="${param.peopleID}" />
										<c:param name="name" value="${param.name}" />
										<c:param name="type" value="sibling" />
									</c:url>
									<p style="text-decoration:underline; text-align:center">[<a href="<c:out value="${addTypeUrl}"/>">add Sibling</a>]</p>
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
										</c:url>
										<c:url var="dellinkUrl" value="/control/doDelLink.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${param.peopleID}" />
											<c:param name="familyID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="other" value="true" />
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>${phrase.Title} <a href="<c:out value="${dellinkUrl}"/>"><img src="images/del.png" style="border:none"></a> <br><a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a></p>
											<c:if test="${phrase.ImageName != 'none'}">
												<a href="<c:out value="${tomanUrl}" />"><img class="smallbox" src='<c:out value="control/doGetImg.jsp?id=${phrase.FamilyID}" />'></a>
											</c:if>
										</div>
									</c:forEach>
								</td>
								<td valign="top" width="100">
									<c:url var="addTypeUrl" value="/peopleother.jsp">
										<c:param name="ref" value="1" />
										<c:param name="pos" value="0" />
										<c:param name="treeID" value="${param.treeID}" />
										<c:param name="peopleID" value="${param.peopleID}" />
										<c:param name="name" value="${param.name}" />
										<c:param name="type" value="other" />
									</c:url>
									<p style="text-decoration:underline; text-align:center">[<a href="<c:out value="${addTypeUrl}"/>">add Other</a>]</p>
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
										</c:url>
										<c:url var="dellinkUrl" value="/control/doDelLink.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${param.peopleID}" />
											<c:param name="familyID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="other" value="true" />
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>${phrase.Title} <a href="<c:out value="${dellinkUrl}"/>"><img src="images/del.png" style="border:none"></a> <br><a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a></p>
											<c:if test="${phrase.ImageName != 'none'}">
												<a href="<c:out value="${tomanUrl}" />"><img class="smallbox" src='<c:out value="control/doGetImg.jsp?id=${phrase.FamilyID}" />'></a>
											</c:if>
										</div>
									</c:forEach>
								</td>
							</tr>
						</table>
						</c:if>
						
						<c:if test="${cup.AccountID != accountID}">
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

					</c:if> 

<!----------------- checks for pos / select relationship -->
					<c:if test="${param.pos == 0}">
					<div>
						<table class="noborder" align="center">
						<form action="peopleother.jsp" method="post" name="addLinkForm">
							<input type="hidden" name="type" value="${param.type}">
							<input type="hidden" name="treeID" value="${param.treeID}">
							<input type="hidden" name="name" value="${param.name}">
							<input type="hidden" name="peopleID" value="${param.peopleID}">
							<input type="hidden" name="ref" value="1">
							<input type="hidden" name="pos" value="1">
							<tr>
								<td>Select a relationship type</td>
								<td>
									<select name="title">
										<c:if test="${param.type == 'parent'}">
											<option>Mother</option>
											<option>Father</option>
										</c:if>
										<c:if test="${param.type == 'spouse'}">
											<option>Husband</option>
											<option>Wife</option>
										</c:if>
										<c:if test="${param.type == 'sibling'}">
											<option>Sister</option>
											<option>Brother</option>
										</c:if>
										<c:if test="${param.type == 'child'}">
											<option>Son</option>
											<option>Daughter</option>
										</c:if>
										<c:if test="${param.type == 'other'}">
											<option>Friend</option>
											<option>Girlfriend</option>
											<option>Boyfriend</option>
											<option>Other</option>
										</c:if>
									</select>
								</td>
								<td>
									<input type="submit" value="Continue">
								</td>
							</tr>
						</form>
							<c:url var="cancelUrl" value="/peopleother.jsp">
								<c:param name="ref" value="1" />
								<c:param name="name" value="${param.name}" />
								<c:param name="treeID" value="${param.treeID}" />
								<c:param name="peopleID" value="${param.peopleID}" />
							</c:url>
							<tr>
								<td colspan="3" align="left"><a href="<c:out value="${cancelUrl}" />">Cancel transaction</a></td>
							</tr>
						</table>
					</div>
					</c:if>


<!----------------- checks for pos / add link to person -->
					<c:if test="${param.pos == '1'}">
					
					<!-- segregate selection per gender -->
					<c:choose>
						<c:when test="${param.title == 'Other' || param.title == 'Friend'}">
							<sql:query var="maps">
								Select * From People Where (PeopleID != ? And TreeID = ?)
								<sql:param value="${param.peopleID}"/>
								<sql:param value="${param.treeID}"/>
							</sql:query>
						</c:when>
						<c:when test="${param.title == 'Father' || param.title == 'Stepfather' || param.title == 'Brother' || param.title == 'Half brother' || param.title == 'Son' || param.title == 'Stepson' || param.title == 'Boyfriend' || param.title == 'Husband'}">
							<sql:query var="maps">
								Select * From People Where (PeopleID != ? And TreeID = ? And Gender = ?)
								<sql:param value="${param.peopleID}"/>
								<sql:param value="${param.treeID}"/>
								<sql:param value="Male"/>
							</sql:query>
						</c:when>
						<c:otherwise>
							<sql:query var="maps">
								Select * From People Where (PeopleID != ? And TreeID = ? And Gender = ?)
								<sql:param value="${param.peopleID}"/>
								<sql:param value="${param.treeID}"/>
								<sql:param value="Female"/>
							</sql:query>
						</c:otherwise>
					</c:choose>
					
					<!-- get selection of family members -->
					<sql:query var="submaps">
						Select * From Links Where PeopleID = ?
						<sql:param value="${param.peopleID}"/>
					</sql:query>
					
					<!-- ultimage list -->
					<jsp:setProperty name="checkFamilyBean" property="familyMap" value="${maps.rows}" />
					<jsp:setProperty name="checkFamilyBean" property="subfamilyMap" value="${submaps.rows}" />
					<c:set var="familyList" value="${checkFamilyBean.list}"/>
					<div>
						<table class="noborder" align="center">
						<form action="control/doNode.jsp" method="post" name="addLinkForm">
							<input type="hidden" name="type" value="${param.type}">
							<input type="hidden" name="title" value="${param.title}">
							<input type="hidden" name="treeID" value="${param.treeID}">
							<input type="hidden" name="name" value="${param.name}">
							<input type="hidden" name="peopleID" value="${param.peopleID}">
							<input type="hidden" name="ref" value="${param.ref}">
							<input type="hidden" name="other" value="true">
							<tr>
								<td colspan="2" align="center">add <span style="font-weight:bold">${param.title}</span></td>
							</tr>
							<tr>
								<td colspan="2" align="center">and update related members of family tree</td>
							</tr>
							<tr>
								<td align="center" colspan="2">
									<select name="familyID">
										<c:forEach items="${familyList}" var="play">
										<c:choose>
										<c:when test="${param.familyID == play.PeopleID}">
											<option value="${play.PeopleID}" selected="selected">${play.LastName}, ${play.FirstName}</option>
										</c:when>
										<c:otherwise>
											<option value="${play.PeopleID}">${play.LastName}, ${play.FirstName}</option>
										</c:otherwise>
										</c:choose>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td align="center" colspan="2">
									<input type="button" value="Save" name="addLink" onClick="addLinkForm.addLink.value='Processing...';addLinkForm.submit()">
								</td>
							</tr>
						</form>
							<tr>
							<c:url var="cancelUrl" value="/peopleother.jsp">
								<c:param name="ref" value="1" />
								<c:param name="name" value="${param.name}" />
								<c:param name="treeID" value="${param.treeID}" />
								<c:param name="peopleID" value="${param.peopleID}" />
							</c:url>
							<tr>
								<td colspan="2" align="left"><a href="<c:out value="${cancelUrl}" />">Cancel transaction</a></td>
							</tr>
						</table>
					</div>
					</c:if>
					
<!----------------- checks for pos / delete person -->
					<c:if test="${param.pos == 2}">
						<table class="noborder" align="center">
							<tr>
								<td colspan="2" align="center">
									<p style="text-align:center; font-size:14px">You are about to <span style="font-weight:bold">delete</span> this person and all its associations to the tree!</p>
									<p class="style1" style="text-align:center; font-size:22px">Would you like to continue?</p>
								</td>
							</tr>
							<tr>
								<td align="center">
									<form action="control/doDelNode.jsp" method="post" name="delNodeForm">
										<input type="hidden" name="treeID" value="${param.treeID}">
										<input type="hidden" name="name" value="${param.name}">
										<input type="hidden" name="peopleID" value="${param.peopleID}">
										<input type="hidden" name="ref" value="1">
										<input type="hidden" name="other" value="true">
										<input type="button" value="Yes" name="delNode" onClick="delNodeForm.delNode.value='Processing...';delNodeForm.submit()">
									</form>
								</td>
								<td align="center">
									<form action="peopleother.jsp" method="post">
										<input type="hidden" name="treeID" value="${param.treeID}">
										<input type="hidden" name="name" value="${param.name}">
										<input type="hidden" name="peopleID" value="${param.peopleID}">										<input type="hidden" name="ref" value="1">
										<input type="submit" value="No">
									</form>
								</td>
							</tr>
						</table>
					</c:if>
					
<!----------------- checks for pos / edit person profile -->
					<c:if test="${param.pos == 3}">
						<c:forEach items="${sets.rows}" end="0" var="line">
						<form action="control/doSavePeople.jsp" method="post" name="savePeopleForm">
							<table class="noborder">
								<tr><td colspan="2" class="style1">
									<p style="text-align:center">${fn:escapeXml(param.errors)}</p>
								</td></tr>
								<tr>
									<td><span class="style1">*</span>First Name(s)</td>
									<td><span class="style1">*</span>Last Name</td>
								</tr>
								<tr>
									<td><input type="text" name="firstName" value="${line.FirstName}"></td>
									<td><input type="text" name="lastName" value="${line.LastName}"></td>
								</tr>
								<tr>
									<td>Email::</td>
									<td>Telephone::</td>
								</tr>
								<tr>
									<td><input type="text" name="pemail" value="${line.Email}"></td>
									<td><input type="text" name="tel" value="${line.Tel}"></td>
								</tr>
								<tr>
									<td colspan="2" align="center">Web Site::</td>
								</tr>
								<tr>
									<td colspan="2" align="center">
										<input type="text" name="web" value="${line.Web}" size="40">
									</td>
								</tr>
							</table>
							<table class="noborder">
								<tr>
									<td colspan="3" style="font-style:italic">Dates are recorded only if boxes below are checked!</td>
								</tr>
								<tr>
								<c:choose>
									<c:when test="${line.GotBirthdate == 'on'}">
									<td><input type="checkbox" name="gotBirthdate" checked="checked"></td>
									<td>Born on</td>
									<td>
										<fmt:formatDate var="birthdate" value="${line.Birthdate}" pattern="MMM-dd-yyyy" />
										<script>DateInput('birthdate', true, 'MON-DD-YYYY', '${birthdate}')</script>
									</td>
									</c:when>
									<c:otherwise>
									<td>
										<input type="checkbox" name="gotBirthdate">
									</td>
									<td>Born on</td>
									<td><script>DateInput('birthdate', true, 'MON-DD-YYYY')</script></td>
									</c:otherwise>
								</c:choose>
								</tr>
								<tr>
								<c:choose>
									<c:when test="${line.IsDeceased == 'on'}">
									<td><input type="checkbox" name="isDeceased" checked="checked"></td>
									<td>Deceased on</td>
									<td>
										<fmt:formatDate var="deceased" value="${line.Deceased}" pattern="MMM-dd-yyyy" />
										<script>DateInput('deceased', true, 'MON-DD-YYYY', '${deceased}')</script>
									</td>
									</c:when>
									<c:otherwise>
									<td><input type="checkbox" name="isDeceased"></td>
									<td>Deceased on</td>
									<td><script>DateInput('deceased', true, 'MON-DD-YYYY')</script></td>
									</c:otherwise>
								</c:choose>
								</tr>
								<!--
								<tr>
									<td></td>
									<td>Gender</td>
									<td>
										<select name="gender">
										<c:choose>
											<c:when test="${line.Gender == 'Male'}">
												<option selected="selected">Male</option>
											</c:when>
											<c:otherwise>
												<option>Male</option>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${line.Gender == 'Female'}">
												<option selected="selected">Female</option>
											</c:when>
											<c:otherwise>
												<option>Female</option>
											</c:otherwise>
										</c:choose>
										</select>
									</td>
								</tr>
								-->
								<tr>
									<td colspan="3" align="center"><input type="button" value="Save Record" name="savePeople" onClick="savePeopleForm.savePeople.value='Processing...';savePeopleForm.submit()"></td>
								</tr>
							</table>
								<input type="hidden" name="name" value="${param.name}">
								<input type="hidden" name="treeID" value="${param.treeID}">
								<input type="hidden" name="peopleID" value="${param.peopleID}">
								<input type="hidden" name="gender" value="${line.Gender}">
								<input type="hidden" name="ref" value="1">
								<input type="hidden" name="other" value="true">
							</form>
							</c:forEach>
							<c:url var="viewpeopleUrl" value="/peopleother.jsp">
								<c:param name="ref" value="1" />
								<c:param name="treeID" value="${param.treeID}" />
								<c:param name="name" value="${param.name}" />
								<c:param name="peopleID" value="${param.peopleID}" />
							</c:url>
							<div><p><a href="<c:out value="${viewpeopleUrl}"/>">Cancel transaction</a></p></div>
					
					</c:if>
					
<!----------------- checks for pos / load person image -->
					<c:if test="${param.pos == 4}">
					
						<table class="noborder" align="center">
							<tr>
								<td align="center">
									<p style="text-align:center; font-size:14px; font-weight:bold">Upload a photo of the person here</p>
									<p style="text-align:center; font-size:12px; font-style:italic">Size: less than <span style="font-weight:bold">250 KB</span> - Dim: 170px by 170px - Format: only <span style="font-weight:bold">JPEG</span></p>
								</td>
							</tr>
							<tr>
						      <td align="center" class="style1">${fn:escapeXml(param.errors)}</td>
						    </tr>
							<tr>
								<td align="center">
									<form name="uploadForm" action="control/doDbUpload.jsp" enctype="multipart/form-data" method="post">
										<input type="file" name="uploadfile"/>
										<input TYPE=Button name='Upload' Value='Upload' onClick="uploadForm.Upload.value='Uploading...';uploadForm.submit()">
										<input type="hidden" name="treeID" value="${param.treeID}">
										<input type="hidden" name="name" value="${param.name}">
										<input type="hidden" name="peopleID" value="${param.peopleID}">
										<input type="hidden" name="ref" value="${param.ref}">
										<input type="hidden" name="pos" value="${param.pos}">
										<input type="hidden" name="other" value="true">
									</form>
								</td>
							</tr>
							<tr>
								<td align="center">
									<form action="control/doDelImg.jsp" method="post" name="delImgForm">
										<input type="button" name="delImg" value="Erase Current Photo" onClick="delImgForm.delImg.value='Deleting...';delImgForm.submit()">
										<input type="hidden" name="treeID" value="${param.treeID}">
										<input type="hidden" name="name" value="${param.name}">
										<input type="hidden" name="peopleID" value="${param.peopleID}">
										<input type="hidden" name="ref" value="${param.ref}">
										<input type="hidden" name="other" value="true">
									</form>
								</td>
							</tr>
						</table>
							<c:url var="viewpeopleUrl" value="/peopleother.jsp">
								<c:param name="ref" value="1" />
								<c:param name="treeID" value="${param.treeID}" />
								<c:param name="name" value="${param.name}" />
								<c:param name="peopleID" value="${param.peopleID}" />
							</c:url>
							<div><p><a href="<c:out value="${viewpeopleUrl}"/>">Cancel transaction</a></p></div>
					
					</c:if>

<!----------------- checks for pos / extended family -->
					<c:if test="${param.pos == 5}">
						<!-- look for extended family - got p1p2Type, p1p2Title -->
						<sql:query var="otrafamilyMap">
						    Select Links.Type, Links.Title, Links.PeopleID, Links.FamilyID, People.FirstName, People.LastName 
							From Links, People 
							Where (Links.PeopleID = ? And People.PeopleID = Links.FamilyID And Links.FamilyID != ?)
						    <sql:param value="${param.p2ID}" />
							<sql:param value="${param.peopleID}" />
						</sql:query>
						
						<!-- verify that extended family does not already exist -->
						<sql:query var="mifamilyMap">
						    Select Links.Type, Links.Title, Links.PeopleID, Links.FamilyID, People.FirstName, People.LastName 
							From Links, People 
							Where (Links.PeopleID = ? And People.PeopleID = Links.FamilyID And Links.FamilyID != ?)
						    <sql:param value="${param.peopleID}" />
							<sql:param value="${param.p2ID}" />
						</sql:query>
						
						<jsp:setProperty name="checkFamilyBean" property="familyMap" value="${otrafamilyMap.rows}" />
						<jsp:setProperty name="checkFamilyBean" property="subfamilyMap" value="${mifamilyMap.rows}" />
						<jsp:setProperty name="checkFamilyBean" property="peopleID" value="${param.peopleID}" />
						<jsp:setProperty name="checkFamilyBean" property="familyID" value="${param.p2ID}" />
						<jsp:setProperty name="checkFamilyBean" property="p1p2Title" value="${param.p1p2Title}" />
						<c:set var="familyList2" value="${checkFamilyBean.list2}"/>
						<c:set var="familySize" value="${checkFamilyBean.list2Size}"/>
						<p class="style1">Type - Title - PeopleID - FamilyID - Name</p>
						<c:forEach items="${familyList2}" var="person">
							<p>${person.Type} - ${person.Title} - ${person.PeopleID} - ${person.FamilyID} - ${person.FirstName} ${person.LastName}</p>
							<!-- create secondary links -->
							<sql:update>
							    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
							    <sql:param value="${person.Type}" />
							    <sql:param value="${person.Title}" />
							    <sql:param value="${person.PeopleID}" />
							    <sql:param value="${person.FamilyID}" />
							</sql:update>
						</c:forEach>
						<div>
						<p class="style1">Family tree has been updated.</p>
						<p>
							<form action="peopleother.jsp" method="post">
								<input type="hidden" name="treeID" value="${param.treeID}">
								<input type="hidden" name="name" value="${param.name}">
								<input type="hidden" name="peopleID" value="${param.peopleID}">
								<input type="hidden" name="ref" value="${param.ref}">
								<input type="submit" value="Continue">
							</form>
						</p>
						</div>
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
<script type="text/javascript"><!--
google_ad_client = "pub-3538041140037139";
google_ad_width = 120;
google_ad_height = 600;
google_ad_format = "120x600_as";
google_ad_type = "image";
//2007-03-01: investment club
google_ad_channel = "3833421812";
google_color_border = "FFFFFF";
google_color_bg = "FFFFFF";
google_color_link = "0000FF";
google_color_text = "000000";
google_color_url = "008000";
//--></script>
<script type="text/javascript"
  src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
					</c:if>
				</div>
			</td>
		</tr></table>
	</div>
	<div id="footnotes">
		<p style="font-size:10px">Powered by Real Basis LLC - Copyright 2003-2009.  <a href="Templates/policy.jsp">Privacy Policy</a>.</p>
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
