<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/control/stdTags.jspf" %>

					<div align="center">
						<c:if test="${members.rowCount == 0}">
							<p class="style1" style="text-align:center">This family tree is empty</p>
							<p style="text-align:center">
								<form method="post" action="search.jsp">
									<input type="submit" value="Request Access">
									<input type="hidden" name="nameSearch" value="${param.nameSearch}">
								</form>
							</p>
							<p style="text-align:center">
								<c:url var="backUrl" value="/search.jsp">
									<c:param name="nameSearch" value="${param.nameSearch}" />
								</c:url>
								<a href="<c:out value="${backUrl}" />">Back to Search</a>
							</p>
						</c:if>
						<c:if test="${members.rowCount > 0}">
						<table width="400">
							<tr>
								<th colspan="4"><h4>List of Family Members</h4></th>
							</tr>
							<tr>
								<th align="left">Name</th>
								<th align="left">Email</th>
								<th>Birthdate</th>
								<th>Deceased</th>
							</tr>
							<c:forEach items="${members.rows}" var="member">
							<tr>
								<td align="left">
									<c:url var="seeMemberUrl" value="/viewtree.jsp">
										<c:param name="ref" value="1" />
										<c:param name="treeID" value="${param.treeID}" />
										<c:param name="peopleID" value="${member.PeopleID}" />
										<c:param name="name" value="${param.name}" />
										<c:param name="nameSearch" value="${param.nameSearch}" />
									</c:url>
									<a href="<c:out value="${seeMemberUrl}" />">${member.LastName}, ${member.FirstName}</a>
								</td>
								<td align="left">${member.Email}</td>
								<td>
								<c:if test="${member.GotBirthdate == 'on'}">
									<fmt:formatDate var="birthdate" value="${member.Birthdate}" pattern="MM/dd/yy" />
									${birthdate}
								</c:if>
								</td>
								<td>
								<c:if test="${member.IsDeceased == 'on'}">
									<fmt:formatDate var="deceased" value="${member.Deceased}" pattern="MM/dd/yy" />
									${deceased}
								</c:if>
								</td>
							</tr>
							</c:forEach>
						</table>
						</c:if>
					</div>