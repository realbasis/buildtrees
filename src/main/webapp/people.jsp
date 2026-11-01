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
<jsp:useBean id="checkFamilyBean" class="utility.CheckFamilyBean" scope="request" />
<!-- check session -->
<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>
<c:if test="${param.peopleID > 0}">
	<sql:query var="sets" scope="request">
		Select * From People Where PeopleID = ?
		<sql:param value="${param.peopleID}"/>
	</sql:query>
</c:if>
<!-- InstanceEndEditable -->
<%@ include file="/WEB-INF/jspf/head.jspf" %>
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
			  <div style="margin:20px 0px 5px 10px">

			  	<c:url var="viewtreeUrl" value="/mytree.jsp">
					<c:param name="ref" value="1" />
					<c:param name="treeID" value="${param.treeID}" />
					<c:param name="other" value="${param.other}" />
					<c:param name="accountOwner" value="${param.accountOwner}" />
					<c:param name="emailo" value="${param.emailo}" />
				</c:url>
				<c:url var="viewpeopleUrl" value="/people.jsp">
					<c:param name="treeID" value="${param.treeID}" />
					<c:param name="name" value="${param.name}" />
					<c:param name="other" value="${param.other}" />
				</c:url>

				<!--
				<c:if test="${param.ref == null}">
				  	<p style="font-style:italic; font-size:12px"> <a href="trees.jsp">Trees</a> > <a href="<c:out value="${viewtreeUrl}"/>">My tree</a> > Members</p>
				</c:if>
				<c:if test="${param.ref >= 0}">
				  	<p style="font-style:italic; font-size:12px"> <a href="trees.jsp">Trees</a> > <a href="<c:out value="${viewtreeUrl}"/>">My tree</a> > Members</p>
				</c:if>
				-->

<!--------------- ref = null, list people in tree -->				
				<c:if test="${param.ref == null}">
					<jsp:include page="fragListPeople.jsp"/>
				</c:if>
				
<!--------------- ref = 0, add people to tree -->
				<c:if test="${param.ref == 0}">
					<jsp:include page="fragAddPeople.jsp"/>
				</c:if>
				
<!-------------- view profile ref = 1 --------->				
				<c:if test="${param.ref == 1}">
					
<c:choose>
	<c:when test="${sets.rowCount == 1}">
	
<!----------------- display of member profile -->
		<jsp:include page="fragProfile.jsp"/>
		<hr>
					<c:if test="${param.pos == null || param.pos == ''}">
<!----------------- display of family & friends -->
						<jsp:include page="fragLinks.jsp">
							<jsp:param name="gender" value="${gender}" />
						</jsp:include>
					</c:if> 

					<c:if test="${param.pos == 0}">
<!----------------- checks for pos / select relationship -->
						<jsp:include page="fragSelectRel.jsp"/>
					</c:if>

					<c:if test="${param.pos == 1}">
<!----------------- checks for pos / add link to person -->
						<jsp:include page="fragAddLink.jsp"/>
					</c:if>

					<c:if test="${param.pos == 2}">
<!----------------- checks for pos / delete person -->
						<jsp:include page="fragDelPerson.jsp"/>
					</c:if>
					
					<c:if test="${param.pos == 3}">
<!----------------- checks for pos / edit person profile -->
						<jsp:include page="fragEditPerson.jsp"/>
					</c:if>
					
					<c:if test="${param.pos == 4}">
<!----------------- checks for pos / load person image -->
						<jsp:include page="fragImgPerson.jsp"/>
					</c:if>

					<c:if test="${param.pos == 5}">
<!----------------- checks for pos / extended family -->
						<jsp:include page="fragOtherFamily.jsp"/>
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

</body>
<!-- InstanceEnd --></html>
