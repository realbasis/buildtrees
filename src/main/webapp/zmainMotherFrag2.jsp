<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>


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
												<form action="zlinkprofile.jsp" method="post">
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
