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

div#zmain
{
	background-color:#66FFFF;
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

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<!-- InstanceEndEditable -->
</head>

<body onload="document.getElementById('theText').focus(); createAutoComplete();MM_preloadImages('images/forward-arrow-dark.jpg','images/bridge2.png')">

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
											<td align="right" valign="top" colspan="2">
												<p style="font-size:16px; font-weight:bold">
													<!--
													Dashboard | <a href="">Settings</a> | <a href="">Sync</a> | <a href="">Reminders</a> | <a href="">Help</a> | <a href="control/logout.jsp">Logout</a>
													-->
													Tree of ${treeBean.owner.Name} | <a href="zmain.jsp">My Tree</a> | <a href="events.jsp">Events</a> | <a href="control/logout.jsp">Logout</a>
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
		<div style="margin-top:20px">
		<table width="100%">
			<tr>
				<td align="center" valign="top">
					<table style="width:200px" align="center">
						<tr></tr>
					</table>
				</td>
				<td align="center" valign="top">
					<div style="border-color:blue;" class="screen">
						<table>
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
											Born on <fmt:formatDate value="${treeBean.me.Birthdate}" pattern="MM/dd/yyyy" />
										</c:if>
										<c:if test="${treeBean.me.IsDeceased == 'on'}">
											<br />
											Passed on <fmt:formatDate value="${treeBean.me.Deceased}" pattern="MM/dd/yyyy" />
										</c:if>
								  </div>
								</td>
							</tr>
						</table>
					</div>
				</td>
				<td align="center" valign="top">
					<table style="width:200px" align="center">
						<tr></tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="center" valign="top">
				</td>
				<td align="center" valign="top">
					<hr style="color:#006600; height:5px;" />
				</td>
				<td align="center" valign="top">
				</td>
			</tr>
		</table>
		</div>
	</div>
	
	<div class="ligne" id="parents">
		<table width="100%">
			<tr>
				<td align="right" valign="middle">
					
						<c:if test="${treeBean.father == null}">
							<div style="border:solid 1px blue; width:200px; background-color:#FFFFFF" align="center">
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
												<span style="font-size:14px; font-weight:bold;">
													* FATHER *
												</span>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</c:if>
						<c:if test="${treeBean.father != null}">
							<c:if test="${father.OtherID != ownerPid}">
								<c:set var="scrn" value="screen2"/>
							</c:if>
							<c:if test="${father.OtherID == ownerPid}">
								<c:set var="scrn" value="screen3"/>
							</c:if>
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
										  <div style="background-color:white; width:120px">
												<span style="font-size:14px; font-weight:bold;">
													* FATHER *
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
													Born on <fmt:formatDate value="${treeBean.father.Birthdate}" pattern="MM/dd/yy" />
												</c:if>
												<c:if test="${treeBean.father.IsDeceased == 'on'}">
													<br />
													Passed on <fmt:formatDate value="${treeBean.father.Deceased}" pattern="MM/dd/yy" />
												</c:if>
												<br /><br />
												<c:url var="changeDadUrl" value="control/doChangeProfile.jsp">
												    <c:param name="id" value="${treeBean.father.PeopleID}" />
													<c:param name="out" value="/zotree.jsp" />
												</c:url>
											  
											  <a href="${changeDadUrl}" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Navigater','','images/forward-arrow-dark.jpg',1)"><img src="images/forward-arrow-light.jpg" alt="Navigate to this profile" name="Navigater" width="33" height="33" border="0" id="Navigater" /></a>
										    <c:if test="${treeBean.father.OtherID == ownerPid}">
											  	<c:url var="bridgeUrl" value="control/doBridge.jsp">
												    <c:param name="peopleID" value="${treeBean.father.OtherID}" />
												</c:url>
										    	<a href="${bridgeUrl}" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('BridgeDad','','images/bridge2.png',1)"><img src="images/bridge.png" alt="Bridge to other tree" name="BridgeDad" width="32" height="32" border="0" id="BridgeDad" /></a>
										    </c:if>
								    	  </div>
										</td>
									</tr>
								</table>
							</div>
						</c:if>

				</td>
				<td align="left" valign="middle">
					
						<c:if test="${treeBean.mother == null}">
							<div style="border:solid 1px blue; width:200px; background-color:#FFFFFF" align="center">
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
												<span style="font-size:14px; font-weight:bold;">
													* MOTHER *
												</span>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</c:if>
						<c:if test="${treeBean.mother != null}">
							<c:if test="${mother.OtherID != ownerPid}">
								<c:set var="scrn" value="screen2"/>
							</c:if>
							<c:if test="${mother.OtherID == ownerPid}">
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
										  <div style="background-color:white; width:120px">
												<span style="font-size:14px; font-weight:bold">
													* MOTHER *
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
													Born on <fmt:formatDate value="${treeBean.mother.Birthdate}" pattern="MM/dd/yy" />
												</c:if>
												<c:if test="${treeBean.mother.IsDeceased == 'on'}">
													<br />
													Passed on <fmt:formatDate value="${treeBean.mother.Deceased}" pattern="MM/dd/yy" />
												</c:if>
												<br /><br />
												<c:url var="changeMomUrl" value="control/doChangeProfile.jsp">
												    <c:param name="id" value="${treeBean.mother.PeopleID}" />
													<c:param name="out" value="/zotree.jsp" />
												</c:url>
										    <a href="${changeMomUrl}" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('NavigateMom','','images/forward-arrow-dark.jpg',1)"><img src="images/forward-arrow-light.jpg" alt="Navigat to this profile" name="NavigateMom" width="33" height="33" border="0" id="NavigateMom" /></a>
										    <c:if test="${treeBean.mother.OtherID == ownerPid}">
										  	  <c:url var="bridgeMomUrl" value="control/doBridge.jsp">
											      <c:param name="peopleID" value="${treeBean.mother.OtherID}" />
											  </c:url>
										    	<a href="${bridgeMomUrl}" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('BridgeMom','','images/bridge2.png',1)"><img src="images/bridge.png" alt="Bridge to other tree" name="BridgeMom" width="32" height="32" border="0" id="BridgeMom" /></a>							</c:if>
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

	<div class="ligne" id="me">
		<table width="100%">
			<tr>
				<td align="center" valign="top">
					<table style="width:200px" align="center">
						<tr>
							<td align="center" colspan="2">
								<c:if test="${treeBean.me.Gender == 'Male'}">
										<h3 style="text-decoration:underline">Wife Or Partner</h3>
								</c:if>
								<c:if test="${treeBean.me.Gender == 'Female'}">
										<h3 style="text-decoration:underline">Husband Or Partner</h3>
								</c:if>
							</td>
						</tr>
						<c:forEach items="${treeBean.partners}" var="partner">
							<tr>
								<td colspan="2">
									<c:if test="${partner.OtherID != ownerPid}">
										<c:set var="scrn" value="screen2"/>
									</c:if>
									<c:if test="${partner.OtherID == ownerPid}">
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
															* PARTNER *
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
															Born on <fmt:formatDate value="${partner.Birthdate}" pattern="MM/dd/yy" />
														</c:if>
														<c:if test="${partner.IsDeceased == 'on'}">
															<br />
															Passed on <fmt:formatDate value="${partner.Deceased}" pattern="MM/dd/yy" />
														</c:if>
														<br /><br />
														<c:url var="changePartnerUrl" value="control/doChangeProfile.jsp">
														    <c:param name="id" value="${partner.PeopleID}" />
															<c:param name="out" value="/zotree.jsp" />
														</c:url>
													  
												    <a href="${changePartnerUrl}" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('NavigatePartner','','images/forward-arrow-dark.jpg',1)"><img src="images/forward-arrow-light.jpg" alt="Navigat to this profile" name="NavigatePartner" width="33" height="33" border="0" id="NavigatePartner" /></a>
											 <c:if test="${partner.OtherID == ownerPid}">
											 	<c:url var="bridgePartnerUrl" value="control/doBridge.jsp">
												    <c:param name="peopleID" value="${partner.OtherID}" />
												</c:url>
											   <a href="${bridgePartnerUrl}" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('BridgePartner','','images/bridge2.png',1)"><img src="images/bridge.png" alt="Bridge to other tree" name="BridgePartner" width="32" height="32" border="0" id="BridgePartner" /></a>								
											 </c:if>
													</div>
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
						</c:forEach>
					</table>
					
					<table style="width:200px" align="center">
						<tr>
							<td><hr style="color:#006600; height:5px;" /></td>
						</tr>
					</table>
					
					<!-- handle friends -->
					<table style="width:200px" align="center">
						<c:forEach items="${treeBean.friends}" var="friend">
							<tr>
								<td colspan="2">
									<c:if test="${!(friend.OtherID > 0)}">
										<c:set var="scrn" value="screen2"/>
									</c:if>
									<c:if test="${friend.OtherID > 0}">
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
															* FRIEND *
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
															Born on <fmt:formatDate value="${friend.Birthdate}" pattern="MM/dd/yy" />
														</c:if>
														<c:if test="${friend.IsDeceased == 'on'}">
															<br />
															Passed on <fmt:formatDate value="${friend.Deceased}" pattern="MM/dd/yy" />
														</c:if>
														<br />
														<c:url var="changeFriendUrl" value="control/doChangeProfile.jsp">
													    	<c:param name="id" value="${friend.PeopleID}" />
															<c:param name="out" value="/zotree.jsp" />
												  		</c:url>
														<a href="<c:out value="${changeFriendUrl}"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('NavigFriend','','images/forward-arrow-dark.jpg',1)"><img src="images/forward-arrow-light.jpg" alt="Navigate" name="NavigFriend" width="33" height="33" border="0" id="NavigFriend" /></a>

														<c:if test="${friend.OtherID == ownerPid}">
													 	  	<c:url var="bridgeUrl" value="control/doBridge.jsp">
														    	<c:param name="peopleID" value="${friend.OtherID}" />
														  	</c:url>
															<a href="<c:out value="${bridgeUrl}"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('FriendBridge','','images/bridge2.png',1)"><img src="images/bridge.png" alt="Bridge to other tree" name="FriendBridge" width="32" height="32" border="0" id="FriendBridge" /></a>
														</c:if>
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
				<td align="center" valign="top" style="border-left:solid; border-right:solid">
					<!-- children lists -->
					<div style="margin-top:0px">
					<table style="width:200px">
						<tr>
							<td colspan="2" align="center">
								<h3 style="text-decoration:underline">Sons And Daughters</h3>
							</td>
						</tr>
						<c:forEach items="${treeBean.children}" var="child">
							<tr>
								<td colspan="2">
								<c:if test="${child.OtherID != ownerPid}">
									<c:set var="scrn" value="screen2"/>
								</c:if>
								<c:if test="${child.OtherID == ownerPid}">
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
												  <div style="background-color:white; width:120px">
														<span style="font-size:14px; font-weight:bold">
															* CHILD *
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
															Born on <fmt:formatDate value="${child.Birthdate}" pattern="MM/dd/yy" />
														</c:if>
														<c:if test="${child.IsDeceased == 'on'}">
															<br />
															Passed on <fmt:formatDate value="${child.Deceased}" pattern="MM/dd/yy" />
														</c:if>
														<br /><br />
														<c:url var="changeChildUrl" value="control/doChangeProfile.jsp">
														    <c:param name="id" value="${child.PeopleID}" />
															<c:param name="out" value="/zotree.jsp" />
														</c:url>
												    <a href="${changeChildUrl}" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('NavigateChild','','images/forward-arrow-dark.jpg',1)"><img src="images/forward-arrow-light.jpg" alt="Navigat to this profile" name="NavigateChild" width="33" height="33" border="0" id="NavigateChild" /></a>
											 <c:if test="${child.OtherID == ownerPid}">
											 	<c:url var="bridgeChildUrl" value="control/doBridge.jsp">
												    <c:param name="peopleID" value="${child.OtherID}" />
												</c:url>
												<a href="${bridgeChildUrl}" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('BridgeChild','','images/bridge2.png',1)"><img src="images/bridge.png" alt="Bridge to other tree" name="BridgeChild" width="32" height="32" border="0" id="BridgeChild" /></a>
											  </c:if>
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
							<td align="center" colspan="2">
								<h3 style="text-decoration:underline">Brothers And Sisters</h3>
							</td>
						</tr>
						<c:forEach items="${treeBean.siblings}" var="sibling">
							<tr>
								<td colspan="2">
									<c:if test="${sibling.OtherID != ownerPid}">
										<c:set var="scrn" value="screen2"/>
									</c:if>
									<c:if test="${sibling.OtherID == ownerPid}">
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
												  <div style="background-color:white; width:120px">
														<span style="font-size:14px; font-weight:bold">
															* SIBLING *
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
															Born on <fmt:formatDate value="${sibling.Birthdate}" pattern="MM/dd/yy" />
														</c:if>
														<c:if test="${sibling.IsDeceased == 'on'}">
															<br />
															Passed on <fmt:formatDate value="${sibling.Deceased}" pattern="MM/dd/yy" />
														</c:if>
														<br /><br />
														<c:url var="changeSiblingUrl" value="control/doChangeProfile.jsp">
														    <c:param name="id" value="${sibling.PeopleID}" />
															<c:param name="out" value="/zotree.jsp" />
														</c:url>
												    	<a href="${changeSiblingUrl}" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('NavigateSibling','','images/forward-arrow-dark.jpg',1)"><img src="images/forward-arrow-light.jpg" alt="Navigat to this profile" name="NavigateSibling" width="33" height="33" border="0" id="NavigateSibling" /></a>
											 <c:if test="${sibling.OtherID == ownerPid}">
											 	<c:url var="bridgeSiblingUrl" value="control/doBridge.jsp">
												    <c:param name="peopleID" value="${sibling.OtherID}" />
												</c:url>
											   <a href="${bridgeSiblingUrl}" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('BridgeSibling','','images/bridge2.png',1)"><img src="images/bridge.png" alt="Bridge to other tree" name="BridgeSibling" width="33" height="33" border="0" id="BridgeSibling" /></a>
											 </c:if>
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
