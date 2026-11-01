<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>


<c:if test="${treeBean.me.AccountID == accountID}">
	<c:set var="scrn" value="screen2"/>
</c:if>
<c:if test="${treeBean.me.AccountID != accountID}">
	<c:set var="scrn" value="screen3"/>
</c:if>
<div>
	<table>
		<tr>
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
													<c:if test="${row.AccountID == accountID}">
														<option value="${row.PeopleID}" selected="selected" style="background-color:#99FF99">${fn:substring(row.Name, 0, 30)}</option>
													</c:if>
													<c:if test="${row.AccountID != accountID}">
														<option value="${row.PeopleID}" selected="selected" style="background-color:#99FF99">*${fn:substring(row.Name, 0, 30)}</option>
													</c:if>
												</c:when>
												<c:when test="${row.AccountID != accountID}">
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
													<c:if test="${row.AccountID == accountID}">
														<option value="${row.PeopleID}" style="background-color:#99FF99">${fn:substring(row.Name, 0, 30)}</option>
													</c:if>
													<c:if test="${row.AccountID != accountID}">
														<option value="${row.PeopleID}" style="background-color:#99FF99">*${fn:substring(row.Name, 0, 30)}</option>
													</c:if>
												</c:when>
												<c:when test="${row.AccountID != accountID}">
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
							<c:if test="${treeBean.me.GotBirthdate == 'on'}">
								${languageBean.zmainBornOn} <fmt:formatDate value="${treeBean.me.Birthdate}" pattern="MM/dd/yyyy" />							</c:if>
							<c:if test="${treeBean.me.IsDeceased == 'on'}">
								<br />
								${languageBean.zmainPassedOn} <fmt:formatDate value="${treeBean.me.Deceased}" pattern="MM/dd/yyyy" />							</c:if>
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
							<c:if test="${treeBean.me.Title == 'owner' && treeBean.me.AccountID != accountID}">
								<c:url var="emailMeUrl" value="zemail.jsp">
									<c:param name="email" value="${treeBean.me.Email}" />
									<c:param name="name" value="${treeBean.me.Name}" />
									<c:param name="isProfile" value="${treeBean.me.IsProfile}" />
								</c:url>
								<a href="<c:out value="${emailMeUrl}"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('EmailMe','','images/sentMail-dark.png',1)"><img src="images/sentMail2.png" alt="Email profile" name="EmailMe" width="32" height="32" border="0" id="EmailMe" /></a>										
							</c:if>
							<c:if test="${treeBean.me.Title != 'owner' && treeBean.me.AccountID == accountID}">
								<a href="control/doDelZnode.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Trash','','images/trash2.png',1)"><img src="images/trash.png" alt="Delete profile" name="Trash" width="32" height="32" border="0" id="Trash" /></a>
							</c:if>
						  </div>
						</td>
					</tr>
				</table>
			</td>
			<td>
				<table style="margin-left:20px">
					<tr>
						<td style="font-size:12px; font-weight:bold" colspan="2">
							Create New Profile
						</td>
					</tr>
					<tr>
						<td>
							<form action="znewprofile.jsp" method="post">
								<input type="submit" value="+Man" />
								<input type="hidden" name="gender" value="Male" />
							</form>
						</td>
						<td>
							<form action="znewprofile.jsp" method="post">
								<input type="submit" value="+Woman" />
								<input type="hidden" name="gender" value="Female" />
							</form>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
