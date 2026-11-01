<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/control/stdTags.jspf" %>

                    <sql:query var="members">
						Select * From People Where TreeID = ? Order By LastName
						<sql:param value="${param.treeID}"/>
					</sql:query>
					<div align="center">
						<c:if test="${members.rowCount == 0}">
							<h3>This family tree is empty.</h3>
						</c:if>
						<c:if test="${members.rowCount > 0}">
						<table>
							<tr>
								<th align="right">
									<h5>List of Family Members (${members.rowCount})</h5>
								</th>
								<td align="left">
									<c:if test="${param.other != true}">
									<form action="people.jsp" method="post">
										<input type="submit" value="add" style="font-size:9px" />
										<input type="hidden" name="ref" value="0" />
										<input type="hidden" name="treeID" value="${param.treeID}" />
										<input type="hidden" name="name" value="${param.name}" />
										<input type="hidden" name="other" value="${param.other}" />
										<input type="hidden" name="accountOwner" value="${param.accountOwner}" />
										<input type="hidden" name="emailo" value="${param.emailo}" />
									</form>
									</c:if>
									<c:if test="${param.other == true && access == 'WRITE'}">
									<form action="people.jsp" method="post">
										<input type="submit" value="add" style="font-size:9px" />
										<input type="hidden" name="ref" value="0" />
										<input type="hidden" name="treeID" value="${param.treeID}" />
										<input type="hidden" name="name" value="${param.name}" />
										<input type="hidden" name="other" value="${param.other}" />
										<input type="hidden" name="accountOwner" value="${param.accountOwner}" />
										<input type="hidden" name="emailo" value="${param.emailo}" />
									</form>
									</c:if>
								</td>
							</tr>
						</table>
						
						<table>
							<tr>
								<td style="text-decoration:underline" width="120">Name</td>
								<td style="text-decoration:underline" width="120">Email</td>
								<td style="text-decoration:underline">Map</td>
								<td style="text-decoration:underline">
									<c:if test="${param.access == 'Accepted'}">
										Delete
									</c:if>
								</td>
								<!--
								<td style="text-decoration:underline">Birthdate</td>
								<td style="text-decoration:underline">Deceased</td>
								-->
							</tr>
							<tr>
								<td colspan="4"><hr /></td>
							</tr>
							<c:forEach items="${members.rows}" var="member">
							<tr>
								<td align="left" width="120">
									<c:url var="seeMemberUrl" value="/people.jsp">
										<c:param name="ref" value="1" />
										<c:param name="treeID" value="${param.treeID}" />
										<c:param name="peopleID" value="${member.PeopleID}" />
										<c:param name="name" value="${param.name}" />
										<c:param name="other" value="${param.other}" />
										<c:param name="accountOwner" value="${param.accountOwner}" />
										<c:param name="emailo" value="${param.emailo}" />
									</c:url>
									<c:if test="${param.other != true}">
										<c:if test="${member.AccountID > 0}">
											<c:set var="signx" value="*" />
										</c:if>
										<c:if test="${member.AccountID <= 0}">
											<c:set var="signx" value="" />
										</c:if>
									</c:if>
									<c:if test="${param.other == true}">
										<c:if test="${member.AccountID == accountID}">
											<c:set var="signx" value="^" />
										</c:if>
										<c:if test="${member.AccountID != accountID}">
											<c:set var="signx" value="" />
										</c:if>
									</c:if>
									<a href="<c:out value="${seeMemberUrl}" />"><span class="style1" style="font-size:18px">${signx}</span>${member.LastName}, ${member.FirstName}</a>
								</td>
								<td align="left" width="120"><a href="mailto:${member.Email}">${member.Email}</a></td>
								<td>
									<form action="people.jsp" method="post">
										<input type="submit" value="view" style="font-size:9px" />
										<input type="hidden" name="ref" value="1" />
										<input type="hidden" name="treeID" value="${param.treeID}" />
										<input type="hidden" name="peopleID" value="${member.PeopleID}" />
										<input type="hidden" name="name" value="${param.name}" />
										<input type="hidden" name="other" value="${param.other}" />
										<input type="hidden" name="accountOwner" value="${param.accountOwner}" />
										<input type="hidden" name="emailo" value="${param.emailo}" />
									</form>
								</td>
							<c:if test="${param.other != true || (param.other == true && (member.AccountID == accountID))}">
								<td class="style1" align="center">
								<c:if test="${param.access == 'Accepted'}">
									<c:url var="delpeopleUrl" value="/people.jsp">
										<c:param name="treeID" value="${param.treeID}" />
										<c:param name="peopleID" value="${member.PeopleID}" />
										<c:param name="ref" value="1" />
										<c:param name="pos" value="2" />
										<c:param name="name" value="${param.name}" />
										<c:param name="other" value="${param.other}" />
										<c:param name="accountOwner" value="${param.accountOwner}" />
										<c:param name="emailo" value="${param.emailo}" />
									</c:url>
									<a href="<c:out value="${delpeopleUrl}" />">X</a>
								</c:if>
								</td>
							</c:if>
							<c:if test="${param.other == true  && (member.AccountID != accountID)}">
								<td></td>
							</c:if>
							</tr>
							<tr>
								<td colspan="4"><hr /></td>
							</tr>
							</c:forEach>
							<c:if test="${param.other == true}">
							<tr>
								<th colspan="5"><span class="style1" style="font-size:18px">^</span> <span class="style1" style="color:gray">members you created</span></th>
							</tr>
							</c:if>
							<c:if test="${param.other != true}">
							<tr>
								<th colspan="5"><span class="style1" style="font-size:18px">*</span> <span class="style1" style="color:gray">members created by guests</span></th>
							</tr>
							</c:if>
						</table>
						</c:if>
					</div>