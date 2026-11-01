<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

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
