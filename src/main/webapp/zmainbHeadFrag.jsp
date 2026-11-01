<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

<c:set var="theURL" value="${pageContext.request.requestURL}" />

								<div id="parents" style="margin-top:15px">
									<table width="100%">
										<tr>
											<td align="right" valign="top">
												<p style="font-size:16px; font-weight:bold">
													My Tree | <a href="settings.jsp">Settings</a> | <a href="control/logout.jsp">Logout</a>
												</p>
											</td>
										</tr>
									</table>
								</div>