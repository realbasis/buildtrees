<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

<jsp:useBean id="partnerBean" class="utility.PartnerMgtBean" />

<jsp:setProperty name="partnerBean" property="treeBean" value="${treeBean}" />

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
												<form action="zlinkprofile.jsp" method="post">
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
								<form action="zlinkprofile.jsp" method="post">
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
												    <a href="${unlinkUrl}" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Unlink1','','images/unlink2.png',1)"><img src="images/unlink.png" alt="Unlink profile from tree" name="Unlink1" width="32" height="32" border="0" id="Unlink1" /></a>
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
