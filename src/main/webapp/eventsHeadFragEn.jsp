<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

<c:set var="theURL" value="${pageContext.request.requestURL}" />

								<div id="parents">
									<table width="100%">
										<tr>
											<td align="right" valign="top" colspan="2">
												<nav class="appnav" aria-label="Account">
													<span aria-current="page">Alarms</span>
													<a href="zmembers.jsp">Members</a>
													<a href="zmain.jsp">My Tree</a>
													<a href="settings.jsp">Settings</a>
													<a href="control/logout.jsp">Logout</a>
												</nav>
											</td>
										</tr>
									</table>
								</div>