<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html><!-- InstanceBegin template="/Templates/publicLinked.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<!-- InstanceBeginEditable name="doctitle" -->
<title>Mankind Connected</title>
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
<!-- check session -->
<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>
<style type="text/css">
div#crt th
{
	font-size:16px;
	padding-bottom:10px;
}
div#crt td
{
	padding-bottom:10px;
}
input
{
	font-size:10px;
}
.ligne
{
	margin-bottom:10px;
}
</style>
<sql:query var="result">
	Select * From Accounts Where AccountID = ?
	<sql:param value="${accountID}"/>
</sql:query>
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
			  		<div style="margin:20px 5px 5px 10px; text-align:left">

						<h3 style="text-decoration:underline">My Profile</h3>
						<c:if test="${param.errors != null}">
							<p class="style1">${fn:escapeXml(param.errors)}</p>
						</c:if>
							
						<c:forEach items="${result.rows}" end="0" var="row">

							<c:if test="${param.ref != 1}">
								<div class="ligne">
									<table>
										<form action="profile.jsp" method="post">
										<tr>
											<th style="font-size:14px">
												Name: ${fn:escapeXml(row.Name)}
											</th>
											<td>
													<input type="submit" value="edit">
													<input type="hidden" name="ref" value="1">
											</td>
										</tr>
										</form>
									</table>
								</div>
							</c:if>
							<c:if test="${param.ref == 1}">
								<div class="ligne">
									<table>
										<form action="control/doProfile.jsp" method="post">
										<tr>
											<th>
												Name: <input type="text" name="name" value="${row.Name}" maxlength="20">
											</th>
											<td>
												<input type="submit" value="save"> <input type="submit" name="retour" value="cancel">
												<input type="hidden" name="ref" value="1">
											</td>
										</tr>
										</form>
									</table>
								</div>
							</c:if>

							<div class="ligne">
								<table>
									<tr>
										<th>Email: <span style="color:green">${fn:escapeXml(row.Email)}</span></th>
									</tr>
								</table>
							</div>
							
							<div class="ligne">
								<table>
									<form action="control/doProfile.jsp" method="post">
										<tr>
											<th align="left">
												Email reminders of birthdays and memories? <span style="color:green">${fn:escapeXml(row.Notify)}</span>
											</th>
											<td>
												<input type="submit" value="change"> 
												<input type="hidden" name="ref" value="3">
												<input type="hidden" name="notify" value="${row.Notify}">
											</td>
										</tr>
									</form>
								</table>
							</div>

							<c:if test="${param.ref != 2}">
								<div class="ligne">
								<table>
									<form action="profile.jsp" method="post">
										<tr>
											<td width="300" align="center">
												<input type="submit" value="change my password">
												<input type="hidden" name="ref" value="2">
											</td>
										</tr>
									</form>
								</table>
								</div>
							</c:if>
							
							<c:if test="${param.ref == 2}">
								<div class="ligne">
								<table>
									<form action="control/doProfile.jsp" method="post">
									<tr>
										<td align="center" colspan="3" style="font-style:italic; color:orange">
											<hr  style="color:green">
										</td>
									</tr>
									<tr>
										<td style="font-weight:bold">
											New Password
											<br>
											<input type="password" name="pass1">
										</td>
										<td style="font-weight:bold">
											Confirm Password
											<br>
											<input type="password" name="pass2">
										</td>
										<td>
											<br>
											<input type="submit" value="save">
										</td>
									</tr>
									<input type="hidden" name="ref" value="2">
									</form>
								</table>
							</c:if>


								
						</c:forEach>

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
