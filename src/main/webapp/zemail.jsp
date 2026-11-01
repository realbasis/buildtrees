<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/privateLinked.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- InstanceBeginEditable name="doctitle" -->
<title>Family Tree Builder..Mankind Connected</title>
<!-- InstanceEndEditable -->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/linked.css" rel="stylesheet" type="text/css">
<%@include file="/control/stdTags.jspf" %>
<c:set var="theURI" value="${pageContext.request.requestURI}" />
<c:if test="${languageBean == null}">
	<jsp:useBean id="languageBean" class="value.LanguageBean" scope="session" />
</c:if>
<!-- InstanceBeginEditable name="head" -->
<style type="text/css">
.tableau
{
	width:700px;
	font-size:24px;
}

.ligne
{
	width:700px;
	margin-bottom:5px;
}
.cell
{
	width:200px;
/*	background-color:#CCCCCC; */
	background-color:white;
	border:solid 1px blue;
	text-align:center;
	height:60px;
	padding-top:20px;
	margin-bottom:5px;
}
.zhead
{
	width:200px;
	text-align:center;
}
.image
{
	background-color:#CCCCCC;
	width:100px;
	height:100px;
}
a img
{
	border:none;
}
</style>
<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<c:set var="email" value="${param.email}" />
<c:set var="name" value="${param.name}" />

<!-- InstanceEndEditable -->
</head>

<body onload="document.getElementById('theText').focus(); createAutoComplete();">

<table align="left" class="noborder"><tr><td>
<div id="zmain">
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
                          <c:choose>
							<c:when test="${flag == null}">                                
							    <!-- InstanceBeginEditable name="EditRegionTop" -->
                                
								<!-- InstanceEndEditable -->
                          </c:when>
						  <c:when test="${flag == 7}">
							    <!-- InstanceBeginEditable name="EditMenu" -->
								<div id="parents" style="margin-top:15px;">
									<table width="100%">
										<tr>
											<td align="right" valign="top" colspan="2">
												<p style="font-size:16px; font-weight:bold">
													Send Email | <a href="zmain.jsp">My Tree</a> | <a href="settings.jsp">Settings</a> | <a href="control/logout.jsp">Logout</a>
												</p>
											</td>
										</tr>
									</table>
								</div>
								<!-- InstanceEndEditable -->
							</c:when>
                            <c:otherwise></c:otherwise>
                            </c:choose>						
						  </td>
					  </tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
	
    <!-- InstanceBeginEditable name="content" -->
	<div class="ligne" id="parents" style="height:400px;; margin-left:50px; margin-top:30px">
	<c:if test="${param.done == null}">
		<form action="control/doZemail.jsp" method="post">
			<table style="margin-top:20px; margin-left:40px">
				<c:if test="${param.errors != null}">
				<tr>
					<td style="font-size:14px; font-style:italic;color:red; text-align:center; font-weight:bold">
						${param.errors}
						<br />
					</td>
				</tr>
				</c:if>
				<tr>
					<th align="center">
						<h3>Send email to ${name} - ${email}</h3>
					</th>
				</tr>
				<tr>
					<td align="center" style="font-style:italic; color:orange">
						<hr  style="color:green">
					</td>
				</tr>
				<tr>
					<th style="font-weight:bold" align="left">
						<span style="color:red">*</span>SUBJECT: <input type="text" name="subject" size="40">
					</th>
				</tr>
				<tr>
					<td style="font-weight:bold" align="left">
						<textarea name="body" cols="40" rows="10">Note...</textarea>
					</td>
				</tr>
				<tr>
					<td align="right">
						<input type="submit" name="retour" value="CANCEL"> <input type="submit" value="SEND">
						<input type="hidden" name="name" value="${name}" />
						<input type="hidden" name="email" value="${email}" />
						<input type="hidden" name="isProfile" value="${param.isProfile}" />
					</td>
				</tr>
			</table>
		</form>
	</c:if>
	<c:if test="${param.done == true}">
		<table style="margin-top:20px; margin-left:40px">
			<tr>
				<td valign="top" style="font-size:18px; font-style:italic; text-align:center; font-weight:bold">
					THE EMAIL HAS BEEN SENT TO ${name}
					<br />
				</td>
				<td valign="top">
					<form method="post" action="zmain.jsp">
						<input type="submit" value="OK" />
					</form>
				</td>
			</tr>
		</table>
	</c:if>
	</div>
	<!-- InstanceEndEditable -->
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
