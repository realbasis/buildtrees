<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

<c:set var="theURL" value="${pageContext.request.requestURL}" />

								<div id="parents">
									<table width="100%">
										<tr>
										<!--
											<td align="center">
												<form action="control/doLanguage.jsp" method="post" name="changeLanguage">
													<select name="language" onChange="changeLanguage.submit()">
														<c:forEach items="${languageBean.list}" var="it">
															<c:choose>
																<c:when test="${languageBean.language == it.Cle0}">
																	<option value="${it.Cle0}" selected="selected">${it.Cle1}</option>
																</c:when>
																<c:otherwise>
																	<option value="${it.Cle0}">${it.Cle1}</option>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</select>
													<input type="hidden" name="theURL" value="${theURL}">
												</form>
											</td>
										-->
											<td align="right" valign="top" colspan="2">
												<nav class="appnav" aria-label="Account">
													<span aria-current="page">Paramétrage</span>
													<a href="events.jsp">Alarmes</a>
													<a href="zmain.jsp">Léggal Engal</a>
													<a href="control/logout.jsp">Ombougol</a>
												</nav>
											</td>
										</tr>
									</table>
								</div>