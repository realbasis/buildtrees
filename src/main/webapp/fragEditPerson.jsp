<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/control/stdTags.jspf" %>

					<c:forEach items="${sets.rows}" end="0" var="line">
						<form action="control/doSavePeople.jsp" method="post" name="savePeopleForm">
							<table class="noborder">
								<tr><td colspan="2" class="style1">
									<p style="text-align:center">${fn:escapeXml(param.errors)}</p>
								</td></tr>
								<tr>
									<td><span class="style1">*</span>First Name(s)</td>
									<td><span class="style1">*</span>Last Name</td>
								</tr>
								<tr>
									<td><input type="text" name="firstName" value="${line.FirstName}" maxlength="20"></td>
									<td><input type="text" name="lastName" value="${line.LastName}" maxlength="20"></td>
								</tr>
								<tr>
									<td>Email::</td>
									<td>Telephone::</td>
								</tr>
								<tr>
									<td><input type="text" name="pemail" value="${line.Email}"></td>
									<td><input type="text" name="tel" value="${line.Tel}"></td>
								</tr>
								<tr>
									<td colspan="2" align="center">Web Site::</td>
								</tr>
								<tr>
									<td colspan="2" align="center">
										<input type="text" name="web" value="${line.Web}" size="40">
									</td>
								</tr>
							</table>
							<table class="noborder">
								<tr>
									<td colspan="3" style="font-style:italic">Dates are recorded only if boxes below are checked!</td>
								</tr>
								<tr>
								<c:choose>
									<c:when test="${line.GotBirthdate == 'on'}">
									<td><input type="checkbox" name="gotBirthdate" checked="checked"></td>
									<td>Born on</td>
									<td>
										<fmt:formatDate var="birthdate" value="${line.Birthdate}" pattern="MMM-dd-yyyy" />
										<script>DateInput('birthdate', true, 'MON-DD-YYYY', '${birthdate}')</script>
									</td>
									</c:when>
									<c:otherwise>
									<td>
										<input type="checkbox" name="gotBirthdate">
									</td>
									<td>Born on</td>
									<td><script>DateInput('birthdate', true, 'MON-DD-YYYY')</script></td>
									</c:otherwise>
								</c:choose>
								</tr>
								<tr>
								<c:choose>
									<c:when test="${line.IsDeceased == 'on'}">
									<td><input type="checkbox" name="isDeceased" checked="checked"></td>
									<td>Deceased on</td>
									<td>
										<fmt:formatDate var="deceased" value="${line.Deceased}" pattern="MMM-dd-yyyy" />
										<script>DateInput('deceased', true, 'MON-DD-YYYY', '${deceased}')</script>
									</td>
									</c:when>
									<c:otherwise>
									<td><input type="checkbox" name="isDeceased"></td>
									<td>Deceased on</td>
									<td><script>DateInput('deceased', true, 'MON-DD-YYYY')</script></td>
									</c:otherwise>
								</c:choose>
								</tr>
								<tr>
									<td colspan="3" align="center"><input type="submit" value="Save Record" name="savePeople" onClick="savePeopleForm.savePeople.value='Processing...'"></td>
								</tr>
							</table>
								<input type="hidden" name="name" value="${param.name}">
								<input type="hidden" name="treeID" value="${param.treeID}">
								<input type="hidden" name="peopleID" value="${param.peopleID}">
								<input type="hidden" name="gender" value="${line.Gender}">
								<input type="hidden" name="ref" value="1">
								<input type="hidden" name="other" value="${param.other}">
								<input type="hidden" name="accountOwner" value="${param.accountOwner}">
								<input type="hidden" name="emailo" value="${param.emailo}">
						</form>
					</c:forEach>
					<c:url var="viewpeopleUrl" value="/people.jsp">
						<c:param name="ref" value="1" />
						<c:param name="treeID" value="${param.treeID}" />
						<c:param name="name" value="${param.name}" />
						<c:param name="peopleID" value="${param.peopleID}" />
						<c:param name="other" value="${param.other}" />
						<c:param name="accountOwner" value="${param.accountOwner}" />
						<c:param name="emailo" value="${param.emailo}" />
					</c:url>
					<div><p><a href="<c:out value="${viewpeopleUrl}"/>">Cancel transaction</a></p></div>
