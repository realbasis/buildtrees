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
<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>
<style type="text/css">
th
{
	font-size:16px;
}
input
{
	font-size:12px;
}
.notifyme
{
	border:solid 1px;
	width:150px;
	padding:2px 2px 2px 2px;
	text-align:center;
}
</style>
<jsp:useBean id="postBean" class="utility.PostBean" />
<jsp:useBean id="now" class="java.util.Date" />
<sql:query var="result">
	Select * From Trees Where TreeID = ?
	<sql:param value="${param.treeID}"/>
</sql:query>
<c:forEach items="${result.rows}" var="row">
	<c:set var="notifyme" value="${row.Notifyme}" />
</c:forEach>
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
		  		<div style="margin:0px 10px 10px 10px; padding:5px 5px 5px 5px" align="center">
					<sql:query var="result">
						Select * From Trees Where TreeID = ?
						<sql:param value="${param.treeID}"/>
					</sql:query>
					<sql:query var="result1">
						Select * From People Where TreeID = ? And GotBirthdate = ? Order By Birthdate
						<sql:param value="${param.treeID}"/>
						<sql:param value="on"/>
					</sql:query>
					<sql:query var="result2">
						Select * From People Where TreeID = ? And IsDeceased = ? Order By Deceased
						<sql:param value="${param.treeID}"/>
						<sql:param value="on"/>
					</sql:query>
					
					<jsp:setProperty name="postBean" property="birthdateMap" value="${result1.rows}" />
					<jsp:setProperty name="postBean" property="deceasedMap" value="${result2.rows}" />

						<table>
							<tr>
								<th align="center">
									<h3>Family Tree ${param.name}</h3>
								</th>
							</tr>

							<tr>
								<fmt:formatDate var="rightNow" value="${now}" pattern="MMM dd yyyy" />
								<th align="center">
									<h5>
										Upcoming Events
										<br>
										as of ${rightNow}
									</h5>
									<table>
										<!-- temp comment
										<tr>
											<td>
												<c:if test="${notifyme == true}">
													<div class="notifyme" style="color:blue; border-color:blue">notify me by email</div>
												</c:if>
												<c:if test="${notifyme == false}">
													<div class="notifyme" style="color:red; border-color:red">do not notify me by email</div>
												</c:if>
											</td>
											<td>
												<form action="control/doEmails.jsp" method="post">
													<input type="submit" value="switch">
													<input type="hidden" name="notifyme" value="${notifyme}">
													<input type="hidden" name="treeID" value="${param.treeID}">
													<input type="hidden" name="name" value="${param.name}">
													<input type="hidden" name="peopleID" value="${param.peopleID}">
													<input type="hidden" name="ref" value="1">
													<input type="hidden" name="other" value="${param.other}">
													<input type="hidden" name="accountOwner" value="${param.accountOwner}">
													<input type="hidden" name="emailo" value="${param.emailo}">
												</form>
											</td>
										</tr>
										--------->
									</table>
								</th>
								<!--
								<td align="left">
									<form action="people.jsp" method="post">
										<input type="submit" value="add event" style="font-size:9px" />
										<input type="hidden" name="ref" value="0" />
										<input type="hidden" name="treeID" value="${param.treeID}" />
										<input type="hidden" name="name" value="${param.name}" />
										<input type="hidden" name="other" value="${param.other}" />
										<input type="hidden" name="accountOwner" value="${param.accountOwner}" />
										<input type="hidden" name="emailo" value="${param.emailo}" />
									</form>
								</td>
								-->
							</tr>

						</table>
						<table>
							<tr>
								<td><hr></td>
							</tr>
							<tr>
								<td style="color:green" align="center">* * *</td>
							</tr>
						<c:forEach items="${postBean.list}" var="row">
							<tr>
								<td>
									<c:url var="seeMemberUrl" value="/people.jsp">
										<c:param name="ref" value="1" />
										<c:param name="treeID" value="${param.treeID}" />
										<c:param name="peopleID" value="${row.PeopleID}" />
										<c:param name="name" value="${param.name}" />
										<c:param name="other" value="${param.other}" />
										<c:param name="accountOwner" value="${param.accountOwner}" />
										<c:param name="emailo" value="${param.emailo}" />
									</c:url>
									<p>
								<c:if test="${row.Days == 0}">
									<span style="color:red; font-weight:bold">TODAY reminder: </span>
									<br>
								</c:if>
								<c:if test="${row.Days > 0 && row.Days <= 32}">
									<span style="color:orange; font-weight:bold">In ${row.Days} days: </span>
									<br>
								</c:if>
								<c:if test="${row.Days > 32 && row.Days <= 91}">
									<span style="color:green; font-weight:bold">In ${row.Days} days: </span>
									<br>
								</c:if>
								<c:if test="${row.Type == 'Birthdate'}">
									<fmt:formatDate var="birthdate" value="${row.DateStamp}" pattern="MMM dd yyyy" />
									
<a href="<c:out value="${seeMemberUrl}" />">${row.FirstName} ${row.LastName}</a> was born on <span style="font-weight:bold">${birthdate}</span> and will turn <span style="font-weight:bold">${row.Age}</span>.
								</c:if>
								<c:if test="${row.Type == 'Birthdate2'}">
									<fmt:formatDate var="birthdate" value="${row.DateStamp}" pattern="MMM dd yyyy" />
<a href="<c:out value="${seeMemberUrl}" />">${row.FirstName} ${row.LastName}</a>, rest in peace, was born on <span style="font-weight:bold">${birthdate}</span>.
								</c:if>
								<c:if test="${row.Type == 'Deceased'}">
									<fmt:formatDate var="deceased" value="${row.DateStamp}" pattern="MMM dd yyyy" />
<a href="<c:out value="${seeMemberUrl}" />">${row.FirstName} ${row.LastName}</a> was deceased on <span style="font-weight:bold">${deceased}</span>, which will be <span style="font-weight:bold">${row.Age}</span> years ago. 
								</c:if>
									</p>
								</td>
							</tr>
							<tr>
								<td style="color:green" align="center">* * *</td>
							</tr>
						</c:forEach>
						<c:if test="${postBean.listSize == 0}">
							<tr>
								<td><h6>No upcoming events in the next month</h6></td>
							</tr>
						</c:if>
							<c:url var="cancelUrl" value="/mytree.jsp">
								<c:param name="ref" value="1" />
								<c:param name="name" value="${param.name}" />
								<c:param name="treeID" value="${param.treeID}" />
								<c:param name="peopleID" value="${param.peopleID}" />
								<c:param name="other" value="${param.other}" />
								<c:param name="accountOwner" value="${param.accountOwner}" />
								<c:param name="emailo" value="${param.emailo}" />
							</c:url>
							<tr>
								<td align="center">
									<br />
									<a href="<c:out value="${cancelUrl}" />">Back to Tree</a>
								</td>
							</tr>
						</table>
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

</body>
<!-- InstanceEnd --></html>
