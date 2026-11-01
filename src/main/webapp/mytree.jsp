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
	font-size:10px;
}
</style>
<script LANGUAGE="JavaScript" type="text/javascript" >
function verify(thisform)
{
	var ans = confirm('do you want to delete guest permanently?');
	if(ans)
		{
		thisform.submit();
		}
}
</script>
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
			  
				<div style="margin:0px 10px 10px 10px; padding:5px 5px 5px 5px">
					<sql:query var="result3">
						Select * From Trees Where TreeID = ?
						<sql:param value="${param.treeID}"/>
					</sql:query>
					<sql:query var="result4">
						Select * From People Where TreeID = ?
						<sql:param value="${param.treeID}"/>
					</sql:query>
					<sql:query var="guests">
				    	SELECT Trees.Name, Accounts.Name As 'AccountName', Accounts.Email, Viewers.Status, Viewers.ViewerID, Viewers.AccountIDg  
						FROM Trees, Viewers, Accounts 
						Where 
							Trees.TreeID = Viewers.TreeID And 
							Viewers.AccountIDg = Accounts.AccountID And 
							Viewers.TreeID = ? 
							Order By Viewers.Status Desc
						<sql:param value="${param.treeID}" />
					</sql:query>
					<c:forEach items="${result3.rows}" var="ans" end="0">

<!--					
<c:if test="${param.other != true}">
						<c:if test="${result4.rowCount > 0}">
							<c:url var="viewpeopleUrl" value="/people.jsp">
								<c:param name="treeID" value="${param.treeID}" />
								<c:param name="name" value="${ans.Name}" />
							</c:url>
							<c:set var="label" value="Members" />
						</c:if>
						<c:if test="${result4.rowCount == 0}">
								<c:url var="viewpeopleUrl" value="/people.jsp">
									<c:param name="ref" value="0" />
									<c:param name="treeID" value="${param.treeID}" />
									<c:param name="name" value="${ans.Name}" />
								</c:url>
						</c:if>
								<c:url var="edittreeUrl" value="/mytree.jsp">
									<c:param name="ref" value="2" />
									<c:param name="treeID" value="${param.treeID}" />
									<c:param name="name" value="${ans.Name}" />
									<c:param name="description" value="${ans.Description}" />
								</c:url>
								<c:url var="deltreeUrl" value="/mytree.jsp">
									<c:param name="ref" value="3" />
									<c:param name="treeID" value="${param.treeID}" />
									<c:param name="name" value="${ans.Name}" />
								</c:url>
								<c:url var="statustreeUrl" value="/mytree.jsp">
									<c:param name="ref" value="4" />
									<c:param name="treeID" value="${param.treeID}" />
									<c:param name="name" value="${ans.Name}" />
									<c:param name="status" value="${ans.Status}" />
								</c:url>
							
								<c:url var="inviteUrl" value="/invite.jsp">
									<c:param name="ref" value="5" />
									<c:param name="treeID" value="${param.treeID}" />
									<c:param name="name" value="${ans.Name}" />
								</c:url>
							<p style="text-align:center; font-size:12px">
[<a href="trees.jsp">All Trees</a>] [<a href="<c:out value="${edittreeUrl}" />">Edit</a>] [<a href="<c:out value="${statustreeUrl}" />">Change Status</a>] [<a href="<c:out value="${viewpeopleUrl}" />">${fn:escapeXml(label)}</a>] [<a href="<c:out value="${deltreeUrl}" />">Delete</a>] [<a href="<c:out value="${inviteUrl}" />">Invite Guest</a>]
							</p>
</c:if>
-->

<!--
<c:if test="${param.other == true}">
						<c:if test="${result4.rowCount > 0}">
							<c:url var="viewpeopleUrl" value="/people.jsp">
								<c:param name="treeID" value="${param.treeID}" />
								<c:param name="name" value="${ans.Name}" />
								<c:param name="other" value="true" />
							</c:url>
							<c:set var="label" value="View Members" />
						</c:if>
						<c:if test="${result4.rowCount == 0}">
								<c:url var="viewpeopleUrl" value="/people.jsp">
									<c:param name="ref" value="0" />
									<c:param name="treeID" value="${param.treeID}" />
									<c:param name="name" value="${ans.Name}" />
									<c:param name="other" value="true" />
								</c:url>
							<c:set var="label" value="Add Members" />
						</c:if>
						<c:url var="inviteUrl" value="/mytree.jsp">
							<c:param name="ref" value="5" />
							<c:param name="treeID" value="${param.treeID}" />
							<c:param name="name" value="${ans.Name}" />
							<c:param name="other" value="true" />
						</c:url>
							<p style="text-align:center; font-size:12px">
[<a href="trees.jsp">Back to Trees</a>] [<a href="<c:out value="${viewpeopleUrl}" />">Calendar</a>] [<a href="<c:out value="${inviteUrl}" />">Invite Guest</a>]
							</p>
</c:if>
-->
<!--
								<c:url var="inviteUrl" value="/invite.jsp">
									<c:param name="ref" value="5" />
									<c:param name="treeID" value="${param.treeID}" />
									<c:param name="name" value="${ans.Name}" />
									<c:param name="other" value="${param.other}" />
									<c:param name="accountOwner" value="${param.accountOwner}" />
									<c:param name="emailo" value="${param.emailo}" />
								</c:url>
								<c:url var="calendarUrl" value="/calendar.jsp">
									<c:param name="ref" value="1" />
									<c:param name="treeID" value="${param.treeID}" />
									<c:param name="name" value="${ans.Name}" />
									<c:param name="other" value="${param.other}" />
									<c:param name="accountOwner" value="${param.accountOwner}" />
									<c:param name="emailo" value="${param.emailo}" />
								</c:url>
							<p style="text-align:center; font-size:12px">
[<a href="trees.jsp">Back to Trees</a>] [<a href="<c:out value="${calendarUrl}" />">Calendar</a>] [<a href="<c:out value="${inviteUrl}" />">Invite Guest</a>]
							</p>
-->
<c:if test="${param.other != true}">
					<table style="font-size:18px">
						<tr><td colspan="2" class="style1"><p style="text-align:center">${fn:escapeXml(param.errors)}</p></td></tr>
						
						<c:if test="${param.ref == 1}">
						<tr>
							<td style="font-size:18px; font-weight:bold">Family Tree ${fn:escapeXml(ans.Name)}</td>
							<td>
								<form action="mytree.jsp" method="post">
									<input type="submit" value="edit" style="font-size:9px">
									<input type="hidden" name="description" value="${ans.Description}">
									<input type="hidden" name="ref" value="2">
									<input type="hidden" name="treeID" value="${param.treeID}">
									<input type="hidden" name="name" value="${ans.Name}">
									<input type="hidden" name="status" value="${ans.Status}">
								</form>
							</td>
						</tr>
						</c:if>
						<c:if test="${param.ref == 2}">
						<tr>
						<form action="control/doTree.jsp" method="post">
							<td><input type="text" name="name" value="${param.name}" maxlength="25"></td>
							<td><input type="submit" value="save" style="font-size:9px"></td>
							<input type="hidden" name="description" value="${ans.Description}">
							<input type="hidden" name="ref" value="2">
							<input type="hidden" name="treeID" value="${param.treeID}">
							<input type="hidden" name="name" value="${ans.Name}">
							<input type="hidden" name="status" value="${ans.Status}">
							</td>
						</form>
						</tr>
						</c:if>
					</table>
					
					<table>
						<tr>
							<c:if test="${ans.Status == 'Public'}">
								<td style="font-size:14px; font-weight:bold">Status: <span style="color:green">${fn:escapeXml(ans.Status)}</span></td>
							</c:if>
							<c:if test="${ans.Status == 'Private'}">
								<td style="font-size:14px; font-weight:bold">Status: <span style="color:orange">${fn:escapeXml(ans.Status)}</span></td>
							</c:if>
							<td>
								<form action="control/doStatusTrees.jsp" method="post">
									<input type="submit" value="switch" style="font-size:9px" title="make tree viewable only by your guests">
									<input type="hidden" name="description" value="${ans.Description}">
									<input type="hidden" name="ref" value="4">
									<input type="hidden" name="treeID" value="${param.treeID}">
									<input type="hidden" name="name" value="${ans.Name}">
									<input type="hidden" name="status" value="${ans.Status}">
								</form>
							</td>
						</tr>
					</table>
</c:if>

<!-- separation between tree profile local and other -->
<c:if test="${param.other == true}">
					<table align="center">
						<tr><td class="style1" align="center"><p style="text-align:center">${fn:escapeXml(param.errors)}</p></td></tr>
						<tr>
							<td style="font-weight:bold; font-size:18px" align="center">${fn:escapeXml(ans.Name)}</td>
						</tr>
						<tr>
							<td style="font-weight:bold; font-size:14px" align="center">
								Created by ${fn:escapeXml(param.accountOwner)}
								<br>
								<a href="mailto:${fn:escapeXml(param.emailo)}">${fn:escapeXml(param.emailo)}</a>
							</td>
						</tr>
					</table>
</c:if>
					<c:set var="treeName" value="${ans.Name}" />
				</c:forEach>
			</div>
			
				<hr style="color:green">
					<div style="margin:0px 10px 10px 10px" align="center">
						<table>
							<tr>
								<td style="font-weight:bold; font-size:16px" align="right">Guests</td>
								<td align="left">
									<form action="invite.jsp" method="post">
										<input type="submit" value="invite">
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
						</table>
						
						<table width="400px">
						<c:if test="${guests.rowCount > 0}">
							<tr>
								<td style="text-decoration:underline" >Name</td>
								<td style="text-decoration:underline" >Email</td>
								<td style="text-decoration:underline" >Access</td>
								<c:if test="${param.other != true}">
									<td style="text-decoration:underline" >Action</td>
								</c:if>
								<c:if test="${param.other == true}">
									<td></td>
								</c:if>
								<td></td>
							</tr>
							<c:forEach items="${guests.rows}" var="guest">
								<tr>
									<td>${guest.AccountName}</td>
									<td><a href="mailto:${guest.Email}">${guest.Email}</a></td>
								<c:if test="${param.other != true}">
									<c:if test="${guest.Status == 'Pending'}">
										<td style="color:red">Pending</td>
										<form action="control/doChangeRequest.jsp" method="post">
											<td><input type="submit" value="allow"></td>
											<input type="hidden" name="viewerID" value="${guest.ViewerID}">
											<input type="hidden" name="accountName" value="${guest.AccountName}">
											<input type="hidden" name="accountIDg" value="${guest.AccountIDg}">
											<input type="hidden" name="treeID" value="${param.treeID}">
											<input type="hidden" name="guestEmail" value="${guest.Email}">
											<input type="hidden" name="treeName" value="${treeName}">
											<input type="hidden" name="ref" value="1">
											<input type="hidden" name="status" value="Accepted">
										</form>
									</c:if>
									<c:if test="${guest.Status == 'Accepted'}">
										<td style="color:green">Allowed</td>
										<form action="control/doChangeRequest.jsp" method="post">
											<td><input type="submit" value="block" style="font-size:10px"></td>
											<input type="hidden" name="viewerID" value="${guest.ViewerID}">
											<input type="hidden" name="treeID" value="${param.treeID}">
											<input type="hidden" name="status" value="Blocked">
										</form>
									</c:if>
									<c:if test="${guest.Status == 'Blocked'}">
										<td style="color:orange">Blocked</td>
										<form action="control/doChangeRequest.jsp" method="post">
											<td><input type="submit" value="allow"></td>
											<input type="hidden" name="viewerID" value="${guest.ViewerID}">
											<input type="hidden" name="treeID" value="${param.treeID}">
											<input type="hidden" name="status" value="Accepted">
										</form>
									</c:if>
									<form action="control/doDelRequest.jsp" name="delForm" method="post">
										<td><input type="button" value="delete" onClick="verify(this.form)"></td>
										<input type="hidden" name="viewerID" value="${guest.ViewerID}">
										<input type="hidden" name="treeID" value="${param.treeID}">
										<input type="hidden" name="guestEmail" value="${guest.Email}">
										<input type="hidden" name="treeName" value="${treeName}">
										<input type="hidden" name="ref" value="1">
										<input type="hidden" name="accountIDg" value="${guest.AccountIDg}">
									</form>
								</c:if>
								<c:if test="${param.other == true}">
									<c:if test="${guest.Status == 'Pending'}">
										<td>PENDING</td>
									</c:if>
									<c:if test="${guest.Status == 'Accepted'}">
										<td style="color:orange">WRITE</td>
									</c:if>
									<c:if test="${guest.Status == 'Blocked'}">
										<td style="color:green">READ</td>
									</c:if>
									<td></td>
									<td></td>
								</c:if>
								</tr>
							</c:forEach>
						</c:if>
						</table>
					</div>
				<hr style="color:green">

				<jsp:include page="fragListPeople.jsp"/>

				<div style="margin-bottom:10px"><p><a href="<c:out value="trees.jsp"/>">Back to Trees</a></p></div>
			
			<c:if test="${param.ref == 3}">
				<jsp:include page="fragDelTree.jsp" />
			</c:if>
			
			<c:if test="${param.ref == 5}">
				<jsp:include page="fragInviteTree.jsp" />
			</c:if>
			
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
