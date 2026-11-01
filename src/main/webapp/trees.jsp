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
th
{
	font-size:16px;
}
</style>
<script LANGUAGE="JavaScript" type="text/javascript" >
function verify(thisform)
{
	var ans = confirm('delete all associations to tree permanently?');
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
			  <div style="margin:0px 0px 5px 10px; padding:5px 5px 5px 5px">
			  	<c:if test="${result.rowCount < 3}">
					<p>create you own tree</p>
				</c:if>
			  	<c:if test="${param.ref != 0}">
				<div>
					<h4>My Family Tree</h4>
					<sql:query var="result">
						Select * From Trees Where AccountID = ?
						<sql:param value="${accountID}"/>
					</sql:query>
					<c:set var="treeCount" value="${result.rowCount}" />
						<table class="noborder">
							<tr>
								<td width="120" style="text-decoration:underline">Tree Name</td>
								<td style="text-decoration:underline" align="center" width="70">Members</td>
								<td style="text-decoration:underline" align="center" width="70">Active Guests</td>
								<td style="text-decoration:underline" align="center" width="70">Pending Guests</td>
								<td style="text-decoration:underline" align="center" width="70">Status</td>
								<td style="text-decoration:underline" align="center" width="70">View</td>
							</tr>
							<tr>
								<td colspan="6"><hr></td>
							</tr>
							<c:forEach items="${result.rows}" var="row">
								<sql:query var="result2">
									Select * From People Where TreeID = ?
									<sql:param value="${row.TreeID}"/>
								</sql:query>
								<sql:query var="guests">
							    	SELECT * FROM Viewers Where TreeID = ? And Status != ?
									<sql:param value="${row.TreeID}" />
									<sql:param value="Pending" />
								</sql:query>
								<sql:query var="noguests">
							    	SELECT * FROM Viewers Where TreeID = ? And Status = ?
									<sql:param value="${row.TreeID}" />
									<sql:param value="Pending" />
								</sql:query>
								<c:url var="mytreeUrl" value="/mytree.jsp">
									<c:param name="ref" value="1" />
									<c:param name="treeID" value="${row.TreeID}" />
									<c:param name="name" value="${row.Name}" />
								</c:url>
								<tr>
									<td width="120"><a href="<c:out value="${mytreeUrl}"/>">${row.Name}</a></td>
									<td align="center" width="70">${fn:escapeXml(result2.rowCount)}</td>
									<td align="center" width="70">${fn:escapeXml(guests.rowCount)}</td>
									<c:if test="${noguests.rowCount == 0}">
										<td align="center" width="70">${fn:escapeXml(noguests.rowCount)}</td>
									</c:if>
									<c:if test="${noguests.rowCount > 0}">
										<td align="center" width="70" style="color:red">${fn:escapeXml(noguests.rowCount)}</td>
									</c:if>
								<c:if test="${row.Status == 'Public'}">
									<td align="center" style="font-weight:bold; color:green" width="70">${fn:escapeXml(row.Status)}</td>
								</c:if>
								<c:if test="${row.Status == 'Private'}">
									<td align="center" style="font-weight:bold; color:orange" width="70">${fn:escapeXml(row.Status)}</td>
								</c:if>
								<td align="center" width="70">
									<form action="mytree.jsp" method="post">
										<input type="submit" value="VIEW" style="font-size:8px">
										<input type="hidden" name="ref" value="1">
										<input type="hidden" name="treeID" value="${row.TreeID}">
										<input type="hidden" name="name" value="${row.Name}">
									</form>
								</td>
							</tr>
							<tr>
								<td colspan="6"><hr></td>
							</tr>
							</c:forEach>
						</table>
						<br>
					<sql:query var="result2">
				    	SELECT Trees.Name, Trees.TreeID, Accounts.Name As 'AccountName', Accounts.Email, Viewers.Status, Viewers.ViewerID  
						FROM Trees, Viewers, Accounts 
						Where 
							Trees.TreeID = Viewers.TreeID And 
							Viewers.AccountIDo = Accounts.AccountID And 
							Viewers.AccountIDg = ? And 
							(Viewers.Status = ? Or Viewers.Status = ? Or Viewers.Status = ?) 
						Order By Viewers.Status Desc
						<sql:param value="${accountID}" />
						<sql:param value="Accepted" />
						<sql:param value="Blocked" />
						<sql:param value="Pending" />
					</sql:query>
					<c:if test="${result2.rowCount > 0}">
						<h4>Trees I Joined</h4>
						<table class="noborder">
							<tr>
								<td width="120" style="text-decoration:underline">Tree Name</td>
								<td style="text-decoration:underline" align="center" width="70">Members</td>
								<td style="text-decoration:underline" align="center" width="70">Owner</td>
								<td style="text-decoration:underline" align="center" width="70">Access</td>
								<td style="text-decoration:underline" align="center" width="70">View</td>
								<td style="text-decoration:underline" align="center" width="70">Delete</td>
							</tr>
							<tr>
								<td colspan="6"><hr></td>
							</tr>
							<c:forEach items="${result2.rows}" var="row2">
								<sql:query var="resultx">
									Select * From People Where TreeID = ?
									<sql:param value="${row2.TreeID}"/>
								</sql:query>
								<c:url var="mytreeUrl" value="/mytree.jsp">
									<c:param name="ref" value="1" />
									<c:param name="treeID" value="${row2.TreeID}" />
									<c:param name="other" value="true" />
									<c:param name="accountOwner" value="${row2.AccountName}" />
									<c:param name="emailo" value="${row2.Email}" />
									<c:param name="name" value="${row2.Name}" />
									<c:param name="access" value="${row2.Status}"/>
								</c:url>
								
								<tr>
										<td width="120"><a href="<c:out value="${mytreeUrl}"/>">${row2.Name}</a></td>
										<td align="center" width="70">${fn:escapeXml(resultx.rowCount)}</td>
										<td align="center" width="70">${fn:escapeXml(row2.AccountName)}</td>
										<c:if test="${row2.Status == 'Accepted'}">
											<td align="center" style="color:orange" width="70">WRITE</td>
											<c:set var="access" value="WRITE" scope="session"/>
										</c:if>
										<c:if test="${row2.Status != 'Accepted'}">
											<td align="center" style="color:green" width="70">READ</td>
											<c:set var="access" value="READ" scope="session"/>
										</c:if>
										<td align="center" width="70">
											<form action="mytree.jsp" method="post">
												<input type="submit" value="VIEW" style="font-size:8px">
												<input type="hidden" name="ref" value="1">
												<input type="hidden" name="treeID" value="${row2.TreeID}">
												<input type="hidden" name="other" value="true">
												<input type="hidden" name="accountOwner" value="row2.AccountName">
												<input type="hidden" name="emailo" value="${row2.Email}">
												<input type="hidden" name="name" value="${row2.Name}">
												<input type="hidden" name="access" value="${row2.Status}">
											</form>
										</td>
										<td align="center" width="70">
											<form action="control/doDelOtherTree.jsp" name="delForm1" method="post">
												<input type="button" value="X" style="font-style:italic; color:red; font-size:10px" onClick="verify(this.form)">
												<input type="hidden" name="viewerID" value="${row2.ViewerID}">
												<input type="hidden" name="treeID" value="${row2.TreeID}">
												<input type="hidden" name="accountIDg" value="${accountID}">
											</form>
										</td>
								</tr>
							</c:forEach>
							<tr>
								<td colspan="6"><hr></td>
							</tr>
							
						</table>
					</c:if>
						<table>
							<tr>
								<td align="center">
									<form action="search.jsp" method="post">
										<input type="submit" value="join other trees">
									</form>
								</td>
							</tr>
						</table>
				</div>
				
				<!-- temp commented
				<c:if test="${treeCount < 3}">
					<div>
						<form action="trees.jsp">
							<input type="hidden" name="ref" value="0">
							<input type="submit" value="create a new tree">
						</form>
						<p style="font-size:12px; color:green; font-style:italic"> you can create up to 3 trees</p>
					</div>
				</c:if>
				-->
				
				</c:if>
				
				<c:if test="${param.ref == 0}">
					<h4>Create a new family tree</h4>
					<div style="margin:10px 0px 0px 20px">
					<form action="control/doNewTree.jsp" method="post">
					<table class="noborder">
						<tr><td colspan="3" class="style1"><p style="text-align:center">${fn:escapeXml(param.errors)}</p></td></tr>
						<tr>
							<td style="font-weight:bold">Name::</td>
							<td><input type="text" name="name" value="${param.name}" maxlength="25"></td>
							<td><input type="submit" value="Save Profile"></td>
						</tr>
						<tr>
							<td style="font-weight:bold">Status::</td>
							<td>Public</td>
							<td class="style1" width="150">A newly created tree is always public. You can modify the status of the tree once profile has been saved.</td>
						</tr>
						<tr>
							<td style="font-weight:bold" colspan="3">Description</td>
						</tr>
						<tr>
							<td colspan="3"><textarea name="description" rows="10" cols="40">${param.description}</textarea></td>
						</tr>
					</table>
					</form>
					</div>
					<div><p><a href="trees.jsp">Go Back</a></p></div>
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
