<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

<c:set var="theURL" value="${pageContext.request.requestURL}" />

	<div class="ligne" id="parents" style="height:400px;; margin-left:50px; margin-top:30px">
			<table style="margin-top:20px; margin-left:40px">
				<c:if test="${param.errors != null}">
				<tr>
					<td style="font-size:14px; font-style:italic;color:red; text-align:center; font-weight:bold">
						${param.errors}
					</td>
				</tr>
				</c:if>
				<tr>
					<td>
						<table>
							<td style="font-weight:bold" width="130" valign="top">
								Langue Préférée: 
							</td>
							<td>
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
						</table>
						 
												
					</td>
				</tr>
				<form action="control/doSetPassword.jsp" method="post">
				<tr>
					<td align="center" style="font-style:italic; color:orange">
						<hr  style="color:green">
					</td>
				</tr>
				<tr>
					<td style="font-weight:bold">
						Haala fèdiou cucca
						<br>
						<input type="password" name="cpass">
					</td>
				</tr>
				<tr>
					<td style="font-weight:bold">
						Haala fèdiou kessa
						<br>
						<input type="password" name="pass1">
					</td>
				</tr>
				<tr>
					<td style="font-weight:bold">
						Haala fèdiou goga
						<br>
						<input type="password" name="pass2">
					</td>
				</tr>
				<tr>
					<td align="left">
						<br>
						<input type="submit" value="Wadougol">
					</td>
				</tr>
				</form>
				<tr>
					<td align="center" style="font-style:italic; color:orange">
						<hr  style="color:green">
					</td>
				</tr>
				<tr>
					<c:if test="${notifyMe == 'yes'}">
						<c:set var="yesSelected" value="selected" />
					</c:if>
					<c:if test="${notifyMe == 'no'}">
						<c:set var="noSelected" value="selected" />
					</c:if>
					<form action="control/doChangeNotify.jsp" method="post" name="changeNotify">
					<td style="font-weight:bold">
						Recevoir des alertes par email concernant les anniversaires ?  
						<c:if test="${notifyMe == 'yes'}"><img src="images/check.png" /></c:if>  
						<select name="notify" onChange="changeNotify.submit()">
							<option ${yesSelected} value="yes">aye</option>
							<option ${noSelected} value="no">alla</option>
						</select>
					</td>
					</form>
				</tr>
			</table>
	</div>