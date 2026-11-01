<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/control/stdTags.jspf" %>

<c:if test="${param.refx == null}">
				<form action="people.jsp" method="post">
					<table class="noborder">
						<tr>
							<th colspan="2">Add New Person</th>
						</tr>
						<tr>
							<td>Gender<span class="style1">*</span></td>
							<td>
                                                            <select name="gender">
                                                                <option>Male</option>
                                                                <option>Female</option>
                                                            </select>
							</td>
						</tr>
						<tr>
                                                    <td colspan='2' align='center'>
                                                        <br>
                                                        <input type='submit' value='N E X T'>
                                                    </td>
						</tr>
					</table>
                                        <input type="hidden" name="name" value="${param.name}">
					<input type="hidden" name="treeID" value="${param.treeID}">
					<input type="hidden" name="peopleID" value="${param.peopleID}">
					<input type="hidden" name="refx" value="0">
					<input type="hidden" name="ref" value="0">
					<input type="hidden" name="other" value="${param.other}">
					<input type="hidden" name="accountOwner" value="${param.accountOwner}" />
					<input type="hidden" name="emailo" value="${param.emailo}" />
				</form>

</c:if>
<c:if test="${param.refx == 0}">
				<form action="control/doNewPeople.jsp" name="addPeopleForm" method="post">
					<table class="noborder">
                                                <c:if test="${param.gender == 'Male'}">
						<tr>
							<th colspan="2">Create Man's Profile</th>
						</tr>
                                                </c:if>
                                                <c:if test="${param.gender == 'Female'}">
						<tr>
							<th colspan="2">Create Woman's Profile</th>
						</tr>
                                                </c:if>
						<tr><td colspan="2" class="style1"><p style="text-align:center">${fn:escapeXml(param.errors)}</p></td></tr>
						<tr>
							<td>First Name(s)<span class="style1">*</span></td>
							<td>Last Name<span class="style1">*</span></td>
						</tr>
						<tr>
							<td><input type="text" name="firstName" value="${param.firstName}" maxlength="20" size="20"></td>
							<td><input type="text" name="lastName" value="${param.lastName}" maxlength="20" size="20"></td>
						</tr>
						<tr>
							<td>Email::</td>
							<td>Telephone::</td>
						</tr>
						<tr>
							<td><input type="text" name="pemail" value="${param.pemail}"></td>
							<td><input type="text" name="tel" value="${param.tel}"></td>
						</tr>
						<tr>
							<td colspan="2" align="center">Web Site::</td>
						</tr>
						<tr>
							<td colspan="2" align="center"><input type="text" name="web" value="${param.web}" size="40"></td>
						</tr>
					</table>
					
					<table class="noborder">
						<tr>
							<td colspan="3" style="font-style:italic">Dates are recorded only if boxes below are checked!</td>
						</tr>
						<tr>
						<c:choose>
							<c:when test="${param.gotBirthdate == 'on'}">
							<td><input type="checkbox" name="gotBirthdate" value="${param.gotBirthdate}" checked="checked"></td>
							</c:when>
							<c:otherwise>
							<td><input type="checkbox" name="gotBirthdate"></td>
							</c:otherwise>
						</c:choose>
							<td>Born on</td>
						<c:choose>
							<c:when test="${param.birthdate == '' || param.birthdate == null}">
							<td><script>DateInput('birthdate', true, 'MON-DD-YYYY')</script></td>
							</c:when>
							<c:otherwise>
							<td><script>DateInput('birthdate', true, 'MON-DD-YYYY', '${param.birthdate}')</script></td>
							</c:otherwise>
						</c:choose>
						</tr>
						<tr>
						<c:choose>
							<c:when test="${param.isDeceased == 'on'}">
							<td><input type="checkbox" name="isDeceased" checked="checked"></td>
							</c:when>
							<c:otherwise>
							<td><input type="checkbox" name="isDeceased"></td>
							</c:otherwise>
						</c:choose>
							<td>Deceased on</td>
						<c:choose>
							<c:when test="${param.deceased == '' || param.deceased == null}">
							<td><script>DateInput('deceased', true, 'MON-DD-YYYY')</script></td>
							</c:when>
							<c:otherwise>
							<td><script>DateInput('deceased', true, 'MON-DD-YYYY', '${param.deceased}')</script></td>
							</c:otherwise>
						</c:choose>
						</tr>
						<tr>
                        	<td colspan="3" align="center"><input type="submit" value="Save Record" name="addPeople" onClick="addPeopleForm.addPeople.value='Processing...'"></td>
						</tr>
						<input type="hidden" name="name" value="${param.name}">
						<input type="hidden" name="treeID" value="${param.treeID}">
						<input type="hidden" name="gender" value="${param.gender}">
						<input type="hidden" name="other" value="${param.other}">
						<input type="hidden" name="accountOwner" value="${param.accountOwner}" />
						<input type="hidden" name="emailo" value="${param.emailo}" />
					</form>
					</table>
						
</c:if>
				<c:url var="seemembersUrl" value="/mytree.jsp">
					<c:param name="ref" value="1" />
					<c:param name="treeID" value="${param.treeID}" />
					<c:param name="other" value="${param.other}" />
					<c:param name="accountOwner" value="${param.accountOwner}" />
					<c:param name="emailo" value="${param.emailo}" />
				</c:url>
<div><p><a href="<c:out value="${seemembersUrl}"/>">Cancel transaction</a></p></div>