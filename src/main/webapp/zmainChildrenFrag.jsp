<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

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
