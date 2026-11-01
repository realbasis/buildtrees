<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<%@include file="/control/stdTags.jspf" %>

        <c:forEach items="${sets.rows}" end="0" var="line">
						
				<p style="font-size:16px; text-align:center">
					<span style="font-weight:bold">Profile of  ${fn:escapeXml(line.FirstName)} ${fn:escapeXml(line.LastName)}</span>
					<c:if test="${param.other != true}">
						<c:if test="${line.AccountID > 0}">
							<sql:query var="books">
								Select Name From Accounts Where AccountID = ?
								<sql:param value="${line.AccountID}"/>
							</sql:query>
							<c:forEach items="${books.rows}" var="book">
								<br><span class="style1" style="font-size:18px">*</span> <span class="style1" style="color:gray">member created by ${book.Name}</span>
							</c:forEach>
						</c:if>
					</c:if>
					<c:if test="${param.other == true && access == 'WRITE'}">
						<c:if test="${line.AccountID == accountID}">
							<br><span class="style1" style="font-size:18px">^</span> <span class="style1" style="color:gray">only you or tree owner can modify this profile</span>
						</c:if>
					</c:if>
				</p>

					<div id="man">
						<table class="noborder" align="center">
						<tr>
							<c:set var="gender" value="${line.Gender}" />
							<td>
								<c:choose>
								<c:when test="${line.ImageName == 'none'}">
								<div id="manphoto">
									<div style="text-align:center; padding-top:40px">
										<p>NO</p>
										<p>PICTURE</p>
									</div>
								</div>
								</c:when>
								<c:otherwise>
									<img src='<c:out value="control/doGetImg.jsp?id=${param.peopleID}" />'>
								</c:otherwise>
								</c:choose>
							</td>
							<td>
								<div id="mandata">
									<ul>
										<li style="text-decoration:underline; margin-top:4px">${fn:escapeXml(line.LastName)}, ${fn:escapeXml(line.FirstName)}</li>
									<c:if test="${line.GotBirthdate == 'on'}">
										<fmt:formatDate var="birthdate" value="${line.Birthdate}" pattern="MMM-dd-yyyy" />
										<li style="list-style:none">Born on ${fn:escapeXml(birthdate)}</li>
									</c:if>
									<c:if test="${line.isDeceased == 'on'}">
										<fmt:formatDate var="deceased" value="${line.Deceased}" pattern="MMM-dd-yyyy" />
										<li style="list-style:none">Departed on ${fn:escapeXml(deceased)}</li>
									</c:if>
										<li style="list-style:none">${fn:escapeXml(line.Gender)}</li>
										<li style="margin-top:6px">Contacts:</li>
									<c:if test="${line.Email != ''}">
										<li style="list-style:none"><a href="mailto:<c:out value="${line.Email}"/>">${fn:escapeXml(line.Email)}</a></li>
									</c:if>
									<c:if test="${line.Tel != ''}">
										<li style="list-style:none">${fn:escapeXml(line.Tel)}</li>
									</c:if>
									<c:if test="${line.Web != ''}">
										<li style="list-style:none"><a href="<c:out value="${fn:escapeXml(line.Web)}" />" target="_blank">${fn:escapeXml(line.Web)}</a></li>
									</c:if>
										<c:url var="delpersonUrl" value="/people.jsp">
											<c:param name="ref" value="1" />
											<c:param name="pos" value="2" />
											<c:param name="name" value="${param.name}" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${param.peopleID}" />
											<c:param name="other" value="${param.other}" />
											<c:param name="accountOwner" value="${param.accountOwner}" />
											<c:param name="emailo" value="${param.emailo}" />
										</c:url>
										<c:url var="editpersonUrl" value="/people.jsp">
											<c:param name="ref" value="1" />
											<c:param name="pos" value="3" />
											<c:param name="name" value="${param.name}" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${param.peopleID}" />
											<c:param name="other" value="${param.other}" />
											<c:param name="accountOwner" value="${param.accountOwner}" />
											<c:param name="emailo" value="${param.emailo}" />
										</c:url>
										<c:url var="loadimgUrl" value="/people.jsp">
											<c:param name="ref" value="1" />
											<c:param name="pos" value="4" />
											<c:param name="name" value="${param.name}" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${param.peopleID}" />
											<c:param name="other" value="${param.other}" />
											<c:param name="accountOwner" value="${param.accountOwner}" />
											<c:param name="emailo" value="${param.emailo}" />
										</c:url>
										
									<c:if test="${line.Locker == false}">
										<c:if test="${param.other != true}">
											<li style="list-style:none; text-align:center; margin-top:10px">[<a href="<c:out value="${editpersonUrl}" />">Edit</a>] - [<a href="<c:out value="${loadimgUrl}" />">Photo</a>] - [<a href="<c:out value="${delpersonUrl}" />">Delete</a>]</li>
										</c:if>
										<c:if test="${param.other == true && access == 'WRITE'}">
											<c:if test="${line.AccountID == accountID}">
												<li style="list-style:none; text-align:center; margin-top:10px">[<a href="<c:out value="${editpersonUrl}" />">Edit</a>] - [<a href="<c:out value="${loadimgUrl}" />">Photo</a>] - [<a href="<c:out value="${delpersonUrl}" />">Delete</a>]</li>
											</c:if>
											<c:if test="${line.AccountID != accountID}">
												<li style="list-style:none; text-align:center; margin-top:10px">[<a href="<c:out value="${editpersonUrl}" />">Edit</a>] - [<a href="<c:out value="${loadimgUrl}" />">Photo</a>]</li>
											</c:if>
										</c:if>
										<!--
										<c:if test="${param.other == true && access == 'READ'}">
											<li style="list-style:none; text-align:center; margin-top:10px">[<a href="<c:out value="${editpersonUrl}" />">Edit</a>] - [<a href="<c:out value="${loadimgUrl}" />">Photo</a>]</li>
										</c:if>
										-->
									</c:if>
									</ul>
									
									<div align="center">
										<c:if test="${(line.AccountID == accountID && param.other == true && access == 'WRITE') || param.other == null || param.other == ''}">
											<c:if test="${line.Locker == false}">
												<form action="control/doLock.jsp" method="post">
													<input type="submit" value="lock" style="color:red; font-size:10px" />
													<input type="hidden" name="lock" value="true" />
													<input type="hidden" name="name" value="${param.name}">
													<input type="hidden" name="treeID" value="${param.treeID}">
													<input type="hidden" name="peopleID" value="${param.peopleID}">
													<input type="hidden" name="gender" value="${line.Gender}">
													<input type="hidden" name="ref" value="1">
													<input type="hidden" name="other" value="${param.other}">
													<input type="hidden" name="accountOwner" value="${param.accountOwner}">
													<input type="hidden" name="emailo" value="${param.emailo}">
												</form>
											</c:if>
											<c:if test="${line.Locker == true}">
												<form action="control/doLock.jsp" method="post">
													<input type="submit" value="unlock" style="color:green; font-size:10px" />
													<input type="hidden" name="lock" value="false" />
													<input type="hidden" name="name" value="${param.name}">
													<input type="hidden" name="treeID" value="${param.treeID}">
													<input type="hidden" name="peopleID" value="${param.peopleID}">
													<input type="hidden" name="gender" value="${line.Gender}">
													<input type="hidden" name="ref" value="1">
													<input type="hidden" name="other" value="${param.other}">
													<input type="hidden" name="accountOwner" value="${param.accountOwner}">
													<input type="hidden" name="emailo" value="${param.emailo}">
												</form>
											</c:if>
										</c:if>
									</div>
								</div>
							</td>
						</tr>
						</table>
					</div>
		</c:forEach>