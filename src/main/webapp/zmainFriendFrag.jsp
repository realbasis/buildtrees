<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

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
