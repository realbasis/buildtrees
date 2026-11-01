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
	width:120px;
	height:120px;
}
</style>
<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<!--
<c:if test="${peopleID == null}">
	<sql:query var="sets" scope="session">
		Select * From Zpeople Where AccountID = ? Order By Name
		<sql:param value="${accountID}"/>
	</sql:query>
	
	<c:forEach items="${sets.rows}" var="row">
		<c:if test="${row.Title == 'owner' && row.Email == myemail}">
			<c:set var="peopleID" value="${profile.peopleID}" />
			<c:set var="profile" value="${row}" />
		</c:if>
	</c:forEach>
</c:if>
-->

<!--
<c:if test="${peopleID != null}">
	<c:forEach items="${sets.rows}" var="row">
		<c:if test="${row.PeopleID == peopleID}">
			<c:set var="profile" value="${row}" />
		</c:if>
	</c:forEach>
	
	<c:if test="${links != null}">
		<c:remove var="links" scope="session" />
	</c:if>
	<sql:query var="links" scope="session">
		Select * From Zlinks Where SelfID = ?
		<sql:param value="${peopleID}"/>
	</sql:query>
</c:if>
-->

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
								<div id="parents" style="margin-top:15px">
									<table width="100%">
										<tr>
											<td width="100">
												<form method="" action="">
													<select name="">
														<c:forEach items="${sets.rows}" var="row">
															<c:if test="${row.PeopleID == profile.peopleID}">
																<option selected="selected">${row.Name}</option>
															</c:if>
															<c:if test="${row.PeopleID != profile.peopleID}">
																<option>${row.Name}</option>
															</c:if>
														</c:forEach>
													</select>
												</form>
											</td>
											<td align="right" valign="top">
												<p style="font-size:16px; font-weight:bold">
													Dashboard | <a href="">Settings</a> | <a href="">Sync</a> | <a href="">Reminders</a> | <a href="">Help</a> | <a href="control/logout.jsp">Logout</a>
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
	<div class="ligne" id="parents">
		<table width="100%">
			<tr>
				<td align="right" valign="middle">
					<div class="cell">
						<c:if test="${father != 0}">
							<form action="control/doAddFather.jsp" method="post">
								<input type="submit" value="Add Father" />
							</form>	
						</c:if>
						<c:if test="${father == 0}">
							<a href="">Add Mother</a>
						</c:if>
					</div>
				</td>
				<td align="left">
					<div class="cell">
						<c:if test="${mother != 0}">
							<form action="" method="">
								<input type="submit" value="Add Mother" />
							</form>	
						</c:if>
						<c:if test="${father == 0}">
							mother
						</c:if>
					</div>
				</td>
			</tr>
		</table>
	</div>

	<div class="ligne" id="me">
		<table width="100%">
			<tr>
				<td align="center" valign="top">
					<c:if test="${profile.Gender == 'Male'}">
						<form action="" method="">
							<input type="submit" value="Add Wife or Partner" />
						</form>	
					</c:if>
					<c:if test="${profile.Gender == 'Female'}">
						<form action="" method="">
							<input type="submit" value="Add Husband or Partner" />
						</form>	
					</c:if>
					<div class="cell">
						<c:if test="${profile.Gender == 'Male'}">
							<a href="">Add Wife/Partner</a>
						</c:if>
						<c:if test="${profile.Gender == 'Female'}">
							<a href="">Add Husband/Partner</a>
						</c:if>
						<c:if test="${gender == 0}">
							husband/wife
						</c:if>
					</div>
				</td>
				<td align="center">
					<div class="cell" style="height:200px; padding:5px 5px 5px 5px">
						<c:if test="${profile.ImageName == 'none'}">
							<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;">
								<br /><br />
								NO
								<br /><br />
								PHOTO
							</div>
						</c:if>
						<c:if test="${profile.ImageName != 'none'}">
							<div class="image">
								<img src='<c:out value="control/doGetImg.jsp?id=${profile.peopleID}" />'>
							</div>
						</c:if>
						<div>
							<span style="font-weight:bold; font-size:14px">${profile.Name}</span>
							<br />
							<a href="mailto:${profile.Email}">${profile.Email}</a>
							<br />
							<c:if test="${profile.GotBirthdate == 'on'}">
								Born on <fmt:formatDate value="${profile.Birthdate}" pattern="MM/dd/yy" />
							</c:if>
							<c:if test="${profile.IsDeceased == 'on'}">
								<br />
								Passed on <fmt:formatDate value="${profile.Deceased}" pattern="MM/dd/yy" />
							</c:if>
							<form method="post" action="">
								<input type="submit" value="Edit" />
							</form>
						</div>
					</div>
				</td>
				<td align="center" valign="top">
					<table style="width:200px">
						<tr>
							<td>
								<form method="post" action="">
									<input type="submit" value="Add Son" />
								</form>
							</td>
							<td>
								<form method="post" action="">
									<input type="submit" value="Add Daughter" />
								</form>
							</td>
						</tr>
					</table>
					<div class="cell">
						<a href="">Add Son</a>  |  <a href="">Add Daughter</a>
					</div>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="ligne">
		<table width="100%">
			<tr>
				<td align="center"></td>
				<td align="center">
					<table style="width:200px" align="center">
						<tr>
							<td align="center">
								<form method="post" action="">
									<input type="submit" value="Add Brother" />
								</form>
							</td>
							<td align="center">
								<form method="post" action="">
									<input type="submit" value="Add Sister" />
								</form>
							</td>
						</tr>
					</table>
					<div class="cell">
						<a href="">Add Brother</a>  |  <a href="">Add Sister</a>
					</div>
					<div class="cell">
						Jessica Simpson
					</div>
					<div class="cell">
						Alex
					</div>
				</td>
				<td align="center"></td>
			</tr>
		</table>
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
