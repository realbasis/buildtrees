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
a
{
	text-decoration:none;
}

</style>
<script type="text/javascript">
<!--
function confirmation() {
	ans = confirm("ERASING PROFILE: ARE YOU SURE?");
	if (ans){
		return true;
	}
	return false;
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>

<jsp:useBean id="partnerBean" class="utility.PartnerMgtBean" />
<jsp:setProperty name="partnerBean" property="treeBean" value="${treeBean}" />

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<!-- InstanceEndEditable -->
</head>

<body onload="document.getElementById('theText').focus(); createAutoComplete();MM_preloadImages('images/trash2.png','images/forward-arrow-dark.jpg','images/unlink2.png')">

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
							    <!-- InstanceBeginEditable name="EditMenu" --><body onload="MM_preloadImages('images/forward-arrow-dark.jpg')">
								<jsp:include flush="true" page="${languageBean.zmainHeadFrag}"/>
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
	
	<div class="ligne" id="me" align="center">
		<table width="90%" style="margin:10px 0 10px 0">
			<tr>
				<td align="center" valign="middle" width="20%">
					<div style="font-family:Geneva, Arial, Helvetica, sans-serif; font-style:italic; font-weight:bold; font-size:14px; width:140px; height:50px; padding-top:12px; vertical-align:middle; background-color:#00FF00; text-align:center;">
						${languageBean.familyAnniv}	
					</div>
				</td>
				<td align="left" valign="middle">
					<jsp:include flush="true" page="${languageBean.zmainHelpFrag}"/>
				</td>
			</tr>
			<tr><td colspan="2">
				<iframe src ="${languageBean.zmainEventsFrag}" width="100%" height="100px">
				  <p>Your browser does not support iframes. Click here for <a href="events.jsp">family events</a></p>
				</iframe>

			</td></tr>
		</table>
	</div>
	
	<div class="ligne" id="parents">
		<table width="100%">
			<tr>
				<td align="right" valign="middle">
						<c:if test="${treeBean.father == null}">
							<div class="screen2" align="center">
								<table>
									<tr>
										<td valign="top">
											<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
												<br />
												NO
												<br /><br />
												PHOTO
											</div>
										</td>
										<td valign="top">
											<div style="background-color:white;">
												<form action="control/doAddZnode.jsp" method="post">
													<input type="submit" value="${languageBean.zmainAddFather}" style="font-size:12px" />
													<input type="hidden" name="relationship" value="Father" />
												</form>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</c:if>
						<c:if test="${treeBean.father.AccountID == accountID}">
							<c:set var="scrn" value="screen2"/>
						</c:if>
						<c:if test="${treeBean.father.AccountID != accountID}">
							<c:set var="scrn" value="screen3"/>
						</c:if>
						<c:if test="${treeBean.father != null}">
							<div class="${scrn}" align="center">
								<table>
									<tr>
										<td valign="top">
											<c:if test="${treeBean.father.ImageName == 'none'}">
												<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
													<br />
													NO
													<br /><br />
													PHOTO
												</div>
											</c:if>
											<c:if test="${treeBean.father.ImageName != 'none'}">
												<div align="center">
													<img class="image" src='<c:out value="control/doGetImg.jsp?id=${treeBean.father.PeopleID}" />'>
												</div>
											</c:if>
										</td>
										<td valign="top">
										  <div class="textZone">
												<span style="font-size:14px; font-weight:bold">
													* ${languageBean.zmainFather} *
													<br />
													<c:if test="${fn:length(treeBean.father.Name) > 15}">
														<span title="${treeBean.father.Name}">${fn:substring(treeBean.father.Name, 0, 13)}...</span>
													</c:if>
													<c:if test="${fn:length(treeBean.father.Name) <= 15}">
														${treeBean.father.Name}
													</c:if>
												</span>
												<c:if test="${treeBean.father.GotBirthdate == 'on'}">
													<br />
													${languageBean.zmainBornOn} <fmt:formatDate value="${treeBean.father.Birthdate}" pattern="MM/dd/yy" />
												</c:if>	
												<c:if test="${treeBean.father.IsDeceased == 'on'}">
													<br />
													${languageBean.zmainPassedOn} <fmt:formatDate value="${treeBean.father.Deceased}" pattern="MM/dd/yy" />
												</c:if>
												<br /><br />
												<c:url var="changeDadUrl" value="control/doChangeProfile.jsp">
												    <c:param name="id" value="${treeBean.father.PeopleID}" />
											  </c:url>
											  <a href="<c:out value="${changeDadUrl}"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('NavigateDad','','images/forward-arrow-dark.jpg',1)"><img src="images/forward-arrow-light.jpg" alt="Navigate to this profile" name="NavigateDad" width="33" height="33" border="0" id="NavigateDad" /></a>
											
										  <c:url var="unlinkUrl" value="control/doUnlink.jsp">
											    <c:param name="peopleID" value="${treeBean.father.PeopleID}" />
										</c:url>
									    <a href="<c:out value="${unlinkUrl}"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('unlink','','images/unlink2.png',1)"><img src="images/unlink.png" alt="Unlink profile from tree" name="unlink" width="32" height="32" border="0" id="unlink" /></a>

								    	  </div>
										</td>
									</tr>
								</table>
							</div>
						</c:if>
				</td>
				<td align="left" valign="middle">
					
						<c:if test="${treeBean.mother == null}">
							<div class="screen2" align="center">
								<table>
									<tr>
										<td valign="top">
											<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
												<br />
												NO
												<br /><br />
												PHOTO
											</div>
										</td>
										<td valign="top">
											<div style="background-color:white;">
												<form action="control/doAddZnode.jsp" method="post">
													<input type="submit" value="${languageBean.zmainAddMother}" style="font-size:12px" />
													<input type="hidden" name="relationship" value="Mother" />
												</form>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</c:if>
						<c:if test="${treeBean.mother != null}">
							<c:if test="${treeBean.mother.AccountID == accountID}">
								<c:set var="scrn" value="screen2"/>
							</c:if>
							<c:if test="${treeBean.mother.AccountID != accountID}">
								<c:set var="scrn" value="screen3"/>
							</c:if>
							<div class="${scrn}" align="center">
								<table>
									<tr>
										<td valign="top">
											<c:if test="${treeBean.mother.ImageName == 'none'}">
												<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
													<br />
													NO
													<br /><br />
													PHOTO
												</div>
											</c:if>
											<c:if test="${treeBean.mother.ImageName != 'none'}">
												<div align="center">
													<img class="image" src='<c:out value="control/doGetImg.jsp?id=${treeBean.mother.PeopleID}" />'>
												</div>
											</c:if>
										</td>
										<td valign="top">
											<div class="textZone">
												<span style="font-size:14px; font-weight:bold">
													* ${languageBean.zmainMother} *
													<br />
													<c:if test="${fn:length(treeBean.mother.Name) > 15}">
														<span title="${treeBean.mother.Name}">${fn:substring(treeBean.mother.Name, 0, 13)}...</span>
													</c:if>
													<c:if test="${fn:length(treeBean.mother.Name) <= 15}">
														${treeBean.mother.Name}
													</c:if>
												</span>
												<c:if test="${treeBean.mother.GotBirthdate == 'on'}">
													<br />
													${languageBean.zmainBornOn} <fmt:formatDate value="${treeBean.mother.Birthdate}" pattern="MM/dd/yy" />
												</c:if>
												<c:if test="${treeBean.mother.IsDeceased == 'on'}">
													<br />
													${languageBean.zmainPassedOn} <fmt:formatDate value="${treeBean.mother.Deceased}" pattern="MM/dd/yy" />
												</c:if>
												<br /><br />
											<c:url var="changeMomUrl" value="control/doChangeProfile.jsp">
												    <c:param name="id" value="${treeBean.mother.PeopleID}" />
										  </c:url>
										  <a href="<c:out value="${changeMomUrl}"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('NavigMom','','images/forward-arrow-dark.jpg',1)"><img src="images/forward-arrow-light.jpg" alt="Navigate to this profile" name="NavigMom" width="33" height="33" border="0" id="NavigMom" /></a>
											  
										  <c:url var="unlinkMomUrl" value="control/doUnlink.jsp">
												    <c:param name="peopleID" value="${treeBean.mother.PeopleID}" />
										  </c:url>
										  <a href="<c:out value="${unlinkMomUrl}"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('UnlinkMom','','images/unlink2.png',1)"><img src="images/unlink.png" alt="Unlink profile from tree" name="UnlinkMom" width="32" height="32" border="0" id="UnlinkMom" /></a>

											</div>
										</td>
									</tr>
								</table>
							</div>
						</c:if>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="ligne" id="me" align="center">
		<table width="100%">
			<tr>
				<td align="center" valign="top" width="33.33%">
					<table style="width:200px" align="center">
						<tr>
						</tr>
					</table>
				</td>
				<td align="center" valign="top">
					<c:if test="${treeBean.me.AccountID == accountID}">
						<c:set var="scrn" value="screen2"/>
					</c:if>
					<c:if test="${treeBean.me.AccountID != accountID}">
						<c:set var="scrn" value="screen3"/>
					</c:if>
					<div>
					<table><tr>
						<td>
						<table style="border-color:blue; border-width:thick" class="${scrn}">
							<tr>
								<td colspan="2" align="center">
									<form method="post" action="control/doChangeProfile.jsp" name="changeForm">
													<select name="id" onChange="changeForm.submit()">
														<c:forEach items="${treeBean.familyAll}" var="row">
															<c:if test="${row.PeopleID == treeBean.me.peopleID}">
																<c:choose>
																<c:when test="${row.Title == 'owner'}">
																	<option value="${row.PeopleID}" selected="selected" style="background-color:#99FF99">${fn:substring(row.Name, 0, 30)}</option>
																</c:when>
																<c:when test="${row.Title == 'other'}">
																	<option value="${row.PeopleID}" selected="selected">*${fn:substring(row.Name, 0, 30)}</option>
																</c:when>
																<c:otherwise>
																	<option value="${row.PeopleID}" selected="selected">${fn:substring(row.Name, 0, 30)}</option>
																</c:otherwise>
																</c:choose>
															</c:if>
															<c:if test="${row.PeopleID != treeBean.me.peopleID}">
																<c:choose>
																<c:when test="${row.Title == 'owner'}">
																	<option value="${row.PeopleID}" style="background-color:#99FF99">${fn:substring(row.Name, 0, 30)}</option>
																</c:when>
																<c:when test="${row.Title == 'other'}">
																	<option value="${row.PeopleID}">*${fn:substring(row.Name, 0, 30)}</option>
																</c:when>
																<c:otherwise>
																	<option value="${row.PeopleID}">${fn:substring(row.Name, 0, 30)}</option>
																</c:otherwise>
																</c:choose>
															</c:if>
														</c:forEach>
													</select>
												</form>
								</td>
							</tr>
							<tr>
								<td valign="top">
								<c:if test="${treeBean.me.ImageName == 'none'}">
									<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
										<br />
										NO
										<br /><br />
										PHOTO
									</div>
								</c:if>
								<c:if test="${treeBean.me.ImageName != 'none'}">
									<div align="center">
										<img class="image" src='<c:out value="control/doGetImg.jsp?id=${treeBean.me.PeopleID}" />'>
									</div>
								</c:if>
								</td>
								<td valign="top">
								  <div class="textZone">
										<span style="font-weight:bold; font-size:14px">
											<c:if test="${fn:length(treeBean.me.Name) > 17}">
												<span title="${treeBean.me.Name}">${fn:substring(treeBean.me.Name, 0, 15)}...</span>
											</c:if>
											<c:if test="${fn:length(treeBean.me.Name) <= 20}">
												${treeBean.me.Name}
											</c:if>
										</span>
										<br />
										<c:if test="${treeBean.me.GotBirthdate == 'on'}">
											${languageBean.zmainBornOn} <fmt:formatDate value="${treeBean.me.Birthdate}" pattern="MM/dd/yyyy" />
										</c:if>
										<c:if test="${treeBean.me.IsDeceased == 'on'}">
											<br />
											${languageBean.zmainPassedOn} <fmt:formatDate value="${treeBean.me.Deceased}" pattern="MM/dd/yyyy" />
										</c:if>
										<br /><br />
										<c:url var="openMeUrl" value="control/doOpenZprofile.jsp">
											<c:param name="peopleID" value="${treeBean.me.PeopleID}"/>
										</c:url>
										<c:if test="${treeBean.me.IsProfile == 'no'}">
											<a href="<c:out value="${openMeUrl}"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('OpenMe','','images/open2.png',1)"><img src="images/open.png" alt="View Details" name="OpenMe" width="32" height="32" border="0" id="OpenMe" /></a>
										</c:if>
										<c:if test="${treeBean.me.IsProfile == 'yes'}">
											<a href="<c:out value="${openMeUrl}"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('OpenMe','','images/open2.png',1)"><img src="images/open0.png" alt="View Details - Profile is a Buildtrees subscriber" name="OpenMe" width="32" height="32" border="0" id="OpenMe" /></a>
										</c:if>
									<c:if test="${treeBean.me.Email != null && treeBean.me.Email != ''}">
										<c:if test="${treeBean.me.Title != 'owner'}">
											<c:url var="emailMeUrl" value="zemail.jsp">
												<c:param name="email" value="${treeBean.me.Email}" />
												<c:param name="name" value="${treeBean.me.Name}" />
												<c:param name="isProfile" value="${treeBean.me.IsProfile}" />
											</c:url>
											<a href="<c:out value="${emailMeUrl}"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('EmailMe','','images/sentMail-dark.png',1)"><img src="images/sentMail2.png" alt="Email ${treeBean.me.Email}" name="EmailMe" width="32" height="32" border="0" id="EmailMe" /></a>										
										</c:if>
									</c:if>
									<c:if test="${treeBean.me.Title != 'owner'}">
										<a href="control/doDelZnode.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Trash','','images/trash2.png',1)"><img src="images/trash.png" alt="Delete profile" name="Trash" width="32" height="32" border="0" id="Trash" /></a>
									</c:if>
								  </div>
								</td>
							</tr>
						</table>
						</td>
						<td>
							<table>
								<tr>
									<td>
										<form method="post" action="control/doChangeProfile.jsp" name="changeForm">
													<select name="id" onChange="changeForm.submit()">
														<c:forEach items="${treeBean.familyAll}" var="row">
															<c:if test="${row.PeopleID == treeBean.me.peopleID}">
																<c:choose>
																<c:when test="${row.Title == 'owner'}">
																	<option value="${row.PeopleID}" selected="selected" style="background-color:#99FF99">${fn:substring(row.Name, 0, 30)}</option>
																</c:when>
																<c:when test="${row.Title == 'other'}">
																	<option value="${row.PeopleID}" selected="selected">*${fn:substring(row.Name, 0, 30)}</option>
																</c:when>
																<c:otherwise>
																	<option value="${row.PeopleID}" selected="selected">${fn:substring(row.Name, 0, 30)}</option>
																</c:otherwise>
																</c:choose>
															</c:if>
															<c:if test="${row.PeopleID != treeBean.me.peopleID}">
																<c:choose>
																<c:when test="${row.Title == 'owner'}">
																	<option value="${row.PeopleID}" style="background-color:#99FF99">${fn:substring(row.Name, 0, 30)}</option>
																</c:when>
																<c:when test="${row.Title == 'other'}">
																	<option value="${row.PeopleID}">*${fn:substring(row.Name, 0, 30)}</option>
																</c:when>
																<c:otherwise>
																	<option value="${row.PeopleID}">${fn:substring(row.Name, 0, 30)}</option>
																</c:otherwise>
																</c:choose>
															</c:if>
														</c:forEach>
													</select>
												</form>
										</td>
									</tr>
									<tr><td style="font-size:12px; font-weight:bold">
										Create New Profile
									</td></tr>
									<tr><td>
										<form action="" method="post">
											<input type="submit" value="+Profile" />
										</form>
									</td></tr>
								</table>
						</td>
					</tr></table>
					</div>
				</td>
				<td align="center" valign="top" width="33.33%">
					<table style="width:200px" align="center">
						<tr>

						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>

	<div class="ligne" id="me">
		<table width="100%">
			<tr>
				<td align="center" valign="top">
					<c:if test="${partnerBean.size == 0}">
						<div class="screen2" align="center">
							<table>
									<tr>
										<td valign="top">
											<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
												<br />
												NO
												<br /><br />
												PHOTO
											</div>
										</td>
										<td valign="top">
											<div style="background-color:white;">
												<form action="control/doAddZnode.jsp" method="post">
													<c:if test="${treeBean.me.Gender == 'Male'}">
														<input type="submit" value="${languageBean.zmainAddWife}" style="font-size:10px;" />
														<input type="hidden" name="relationship" value="Wife_Partner" />
													</c:if>
													<c:if test="${treeBean.me.Gender == 'Female'}">
														<input type="submit" value="${languageBean.zmainAddHusband}" style="font-size:10px" />
														<input type="hidden" name="relationship" value="Husband_Partner" />
													</c:if>
												</form>	
											</div>
										</td>
									</tr>
								</table>
						</div>
					</c:if>
					<c:if test="${partnerBean.size > 0}">
					<table style="width:200px" align="center">
						<tr>
							<td align="center" colspan="2">
								<form action="control/doAddZnode.jsp" method="post">
								<c:if test="${treeBean.me.Gender == 'Male'}">
										<input type="submit" value="${languageBean.zmainAddWife}" />
										<input type="hidden" name="relationship" value="Wife_Partner" />
								</c:if>
								<c:if test="${treeBean.me.Gender == 'Female'}">
										<input type="submit" value="${languageBean.zmainAddHusband}" />
										<input type="hidden" name="relationship" value="Husband_Partner" />
								</c:if>
								</form>	
							</td>
						</tr>
						<c:forEach items="${treeBean.partners}" var="partner">
							<tr>
								<td colspan="2">
									<c:if test="${partner.AccountID == accountID}">
										<c:set var="scrn" value="screen2"/>
									</c:if>
									<c:if test="${partner.AccountID != accountID}">
										<c:set var="scrn" value="screen3"/>
									</c:if>
									<div class="${scrn}" align="center">
										<table>
											<tr>
												<td valign="top">
													<c:if test="${partner.ImageName == 'none'}">
														<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
															<br />
															NO
															<br /><br />
															PHOTO
														</div>

													</c:if>
													<c:if test="${partner.ImageName != 'none'}">
														<div align="center">
															<img class="image" src='<c:out value="control/doGetImg.jsp?id=${partner.PeopleID}" />'>
														</div>
													</c:if>
												</td>
												<td valign="top">
													<div class="textZone">
														<span style="font-size:14px; font-weight:bold">
															<c:if test="${treeBean.me.Gender == 'Male'}">
																* ${languageBean.zmainWife} *
															</c:if>
															<c:if test="${treeBean.me.Gender == 'Female'}">
																* ${languageBean.zmainHusband} *
															</c:if>
															<br />
															<c:if test="${fn:length(partner.Name) > 15}">
																<span title="${partner.Name}">${fn:substring(partner.Name, 0, 13)}...</span>
															</c:if>
															<c:if test="${fn:length(partner.Name) <= 15}">
																${partner.Name}
															</c:if>
														</span>
														<c:if test="${partner.GotBirthdate == 'on'}">
															<br />
															${languageBean.zmainBornOn} <fmt:formatDate value="${partner.Birthdate}" pattern="MM/dd/yy" />
														</c:if>
														<c:if test="${partner.IsDeceased == 'on'}">
															<br />
															${languageBean.zmainPassedOn} <fmt:formatDate value="${partner.Deceased}" pattern="MM/dd/yy" />
														</c:if>
														<br /><br />
													<c:url var="changePartnerUrl" value="control/doChangeProfile.jsp">
													    <c:param name="id" value="${partner.PeopleID}" />
													</c:url>
													<a href="${changePartnerUrl}" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Navig1','','images/forward-arrow-dark.jpg',1)"><img src="images/forward-arrow-light.jpg" alt="Navigate" name="Navig1" width="33" height="33" border="0" id="Navig1" /></a> 
													
													<c:url var="unlinkUrl" value="control/doUnlink.jsp">
													  	<c:param name="peopleID" value="${partner.PeopleID}" />
													</c:url>
												    <a href="${unlinkUrl}" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Unlink11','','images/unlink2.png',1)"><img src="images/unlink.png" alt="Unlink profile from tree" name="Unlink11" width="32" height="32" border="0" id="Unlink11" /></a>
													</div>
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
						</c:forEach>
					</table>
					</c:if>
					
				<!-- man and woman -->
				<c:if test="${false}">
					<table style="width:200px" align="center">
						<tr>
							<td><hr style="color:#006600; height:5px;" /></td>
						</tr>
					</table>
					
					<!-- handle friends -->
					<table style="width:200px" align="center">
						<tr>
							<td colspan="2">
								<form method="post" action="control/doAddZnode.jsp">
									<input type="submit" value="${languageBean.zmainAddMan}" />
									<input type="hidden" name="relationship" value="Boyfriend" />
								</form>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<form method="post" action="control/doAddZnode.jsp">
									<input type="submit" value="${languageBean.zmainAddWoman}" />
									<input type="hidden" name="relationship" value="Girlfriend" />
								</form>
							</td>
						</tr>
						<c:forEach items="${treeBean.friends}" var="friend">
							<tr>
								<td colspan="2">
									<c:if test="${friend.AccountID == accountID}">
										<c:set var="scrn" value="screen2"/>
									</c:if>
									<c:if test="${friend.AccountID != accountID}">
										<c:set var="scrn" value="screen3"/>
									</c:if>
									<div class="${scrn}" align="center">
										<table>
											<tr>
												<td valign="top">
													<c:if test="${friend.ImageName == 'none'}">
														<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
															<br />
															NO
															<br /><br />
															PHOTO
														</div>

													</c:if>
													<c:if test="${friend.ImageName != 'none'}">
														<div align="center">
															<img class="image" src='<c:out value="control/doGetImg.jsp?id=${friend.PeopleID}" />'>
														</div>
													</c:if>
												</td>
												<td valign="top">
													<div class="textZone">
														<span style="font-size:14px; font-weight:bold">
															* ${languageBean.zmainFriend} *
															<br />
															<c:if test="${fn:length(friend.Name) > 15}">
																<span title="${friend.Name}">${fn:substring(friend.Name, 0, 13)}...</span>
															</c:if>
															<c:if test="${fn:length(friend.Name) <= 15}">
																${friend.Name}
															</c:if>
														</span>
														<c:if test="${friend.GotBirthdate == 'on'}">
															<br />
															${languageBean.zmainBornOn} <fmt:formatDate value="${friend.Birthdate}" pattern="MM/dd/yy" />
														</c:if>
														<c:if test="${friend.IsDeceased == 'on'}">
															<br />
															${languageBean.zmainPassedOn} <fmt:formatDate value="${friend.Deceased}" pattern="MM/dd/yy" />
														</c:if>
														<br /><br />
													<c:url var="changeFriendUrl" value="control/doChangeProfile.jsp">
													    <c:param name="id" value="${friend.PeopleID}" />
												  </c:url>
													<a href="<c:out value="${changeFriendUrl}"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('NavigFriend','','images/forward-arrow-dark.jpg',1)"><img src="images/forward-arrow-light.jpg" alt="Navigate" name="NavigFriend" width="33" height="33" border="0" id="NavigFriend" /></a>

													<c:url var="unlinkFriendUrl" value="control/doUnlink.jsp">
													  	<c:param name="peopleID" value="${partner.PeopleID}" />
													</c:url>
												    <a href="${unlinkFriendUrl}" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Unlink1','','images/unlink2.png',1)"><img src="images/unlink.png" alt="Unlink profile from tree" name="Unlink1" width="32" height="32" border="0" id="Unlink1" /></a>
													</div>
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
				
				</td>
				<td align="center" valign="top" style="border-left:solid; border-right:solid">
					<!-- children lists -->
					<div style="margin-top:0px">
					<table style="width:200px">
						<tr>
							<td align="center">
								<form method="post" action="control/doAddZnode.jsp">
									<input type="submit" value="${languageBean.zmainAddSon}" />
									<input type="hidden" name="relationship" value="Son" />
								</form>
							</td>
							<td align="center">
								<form method="post" action="control/doAddZnode.jsp">
									<input type="submit" value="${languageBean.zmainAddDaughter}" />
									<input type="hidden" name="relationship" value="Daughter" />
								</form>
							</td>
						</tr>
						<c:forEach items="${treeBean.children}" var="child">
							<tr>
								<td colspan="2">
								<c:if test="${child.AccountID == accountID}">
									<c:set var="scrn" value="screen2"/>
								</c:if>
								<c:if test="${child.AccountID != accountID}">
									<c:set var="scrn" value="screen3"/>
								</c:if>
									<div class="${scrn}" align="center">
										<table>
											<tr>
												<td valign="top">
													<c:if test="${child.ImageName == 'none'}">
														<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
															<br />
															NO
															<br /><br />
															PHOTO
														</div>

													</c:if>
													<c:if test="${child.ImageName != 'none'}">
														<div align="center">
															<img class="image" src='<c:out value="control/doGetImg.jsp?id=${child.PeopleID}" />'>
														</div>
													</c:if>
												</td>
												<td valign="top">
													<div class="textZone">
														<span style="font-size:14px; font-weight:bold">
															* ${languageBean.zmainChild} *
															<br />
															<c:if test="${fn:length(child.Name) > 15}">
																<span title="${child.Name}">${fn:substring(child.Name, 0, 13)}...</span>
															</c:if>
															<c:if test="${fn:length(child.Name) <= 15}">
																${child.Name}
															</c:if>
														</span>
														<c:if test="${child.GotBirthdate == 'on'}">
															<br />
															${languageBean.zmainBornOn} <fmt:formatDate value="${child.Birthdate}" pattern="MM/dd/yy" />
														</c:if>
														<c:if test="${child.IsDeceased == 'on'}">
															<br />
															${languageBean.zmainPassedOn} <fmt:formatDate value="${child.Deceased}" pattern="MM/dd/yy" />
														</c:if>
														<br /><br />
													<c:url var="changeChildUrl" value="control/doChangeProfile.jsp">
													    <c:param name="id" value="${child.PeopleID}" />
													</c:url>
													<a href="<c:out value="${changeChildUrl}"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('NavigChild','','images/forward-arrow-dark.jpg',1)"><img src="images/forward-arrow-light.jpg" alt="Navigate" name="NavigChild" width="33" height="33" border="0" id="NavigChild" /></a>
													 
 												  <c:url var="unlinkChildUrl" value="control/doUnlink.jsp">
													<c:param name="peopleID" value="${child.PeopleID}" />
												  </c:url>
												  <a href="<c:out value="${unlinkChildUrl}"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('UnlinkChild','','images/unlink2.png',1)"><img src="images/unlink.png" alt="Unlink profile from tree" name="UnlinkChild" width="32" height="32" border="0" id="UnlinkChild" /></a>
													</div>
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
						</c:forEach>
					</table>
					</div>

				</td>
				<td align="center" valign="top">
					<table style="width:200px" align="center">
						<tr>
							<td align="center">
								<form method="post" action="control/doAddZnode.jsp">
									<input type="submit" value="${languageBean.zmainAddBrother}" />
									<input type="hidden" name="relationship" value="Brother" />
								</form>
							</td>
							<td align="center">
								<form method="post" action="control/doAddZnode.jsp">
									<input type="submit" value="${languageBean.zmainAddSister}" />
									<input type="hidden" name="relationship" value="Sister" />
								</form>
							</td>
						</tr>
						<c:forEach items="${treeBean.siblings}" var="sibling">
							<tr>
								<td colspan="2">
									<c:if test="${sibling.AccountID == accountID}">
										<c:set var="scrn" value="screen2"/>
									</c:if>
									<c:if test="${sibling.AccountID != accountID}">
										<c:set var="scrn" value="screen3"/>
									</c:if>
									<div class="${scrn}" align="center">
										<table>
											<tr>
												<td valign="top">
													<c:if test="${sibling.ImageName == 'none'}">
														<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
															<br />
															NO
															<br /><br />
															PHOTO
														</div>

													</c:if>
													<c:if test="${sibling.ImageName != 'none'}">
														<div align="center">
															<img class="image" src='<c:out value="control/doGetImg.jsp?id=${sibling.PeopleID}" />'>
														</div>
													</c:if>
												</td>
												<td valign="top">
												  <div class="textZone">
														<span style="font-size:14px; font-weight:bold">
															<c:if test="${sibling.Gender == 'Male'}">
																* ${languageBean.zmainBrother} *
															</c:if>
															<c:if test="${sibling.Gender == 'Female'}">
																* ${languageBean.zmainSister} *
															</c:if>
															<br />
															<c:if test="${fn:length(sibling.Name) > 15}">
																<span title="${sibling.Name}">${fn:substring(sibling.Name, 0, 13)}...</span>
															</c:if>
															<c:if test="${fn:length(sibling.Name) <= 15}">
																${sibling.Name}
															</c:if>
														</span>
														<c:if test="${sibling.GotBirthdate == 'on'}">
															<br />
															${languageBean.zmainBornOn} <fmt:formatDate value="${sibling.Birthdate}" pattern="MM/dd/yy" />
														</c:if>
														<c:if test="${sibling.IsDeceased == 'on'}">
															<br />
															${languageBean.zmainPassedOn} <fmt:formatDate value="${sibling.Deceased}" pattern="MM/dd/yy" />
														</c:if>
														<br /><br />
													<c:url var="changeSiblingUrl" value="control/doChangeProfile.jsp">
													    <c:param name="id" value="${sibling.PeopleID}" />
													</c:url>
													<a href="${changeSiblingUrl}" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Navig','','images/forward-arrow-dark.jpg',1)"><img src="images/forward-arrow-light.jpg" alt="Navigate" name="Navig" width="33" height="33" border="0" id="Navig" /></a> 
													 
													 <c:url var="unlinkUrl" value="control/doUnlink.jsp">
													  	<c:param name="peopleID" value="${sibling.PeopleID}" />
													</c:url>
											        <a href="${unlinkUrl}" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Unlink','','images/unlink2.png',1)"><img src="images/unlink.png" alt="Unlink profile from tree" name="Unlink" width="32" height="32" border="0" id="Unlink" /></a>
													</div>
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
						</c:forEach>
					</table>
				</td>
				
				
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
