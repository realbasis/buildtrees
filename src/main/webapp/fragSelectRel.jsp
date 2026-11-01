<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/control/stdTags.jspf" %>

					<div>
						<table class="noborder" align="center">
						<form action="people.jsp" method="post" name="addLinkForm">
							<input type="hidden" name="type" value="${param.type}">
							<input type="hidden" name="treeID" value="${param.treeID}">
							<input type="hidden" name="name" value="${param.name}">
							<input type="hidden" name="peopleID" value="${param.peopleID}">
							<input type="hidden" name="ref" value="1">
							<input type="hidden" name="pos" value="1">
							<input type="hidden" name="other" value="${param.other}">
							<input type="hidden" name="accountOwner" value="${param.accountOwner}" />
							<input type="hidden" name="emailo" value="${param.emailo}" />
							<tr>
								<td>Select a relationship type</td>
								<td>
									<select name="title">
										<c:if test="${param.type == 'parent'}">
											<option>Mother</option>
											<option>Father</option>
										</c:if>
										<c:if test="${param.type == 'spouse'}">
											<option>Husband</option>
											<option>Wife</option>
										</c:if>
										<c:if test="${param.type == 'sibling'}">
											<option>Sister</option>
											<option>Brother</option>
										</c:if>
										<c:if test="${param.type == 'child'}">
											<option>Son</option>
											<option>Daughter</option>
										</c:if>
										<c:if test="${param.type == 'other'}">
											<option>Friend</option>
											<option>Girlfriend</option>
											<option>Boyfriend</option>
											<option>Other</option>
										</c:if>
									</select>
								</td>
								<td>
									<input type="submit" value="Continue">
								</td>
							</tr>
						</form>
							<c:url var="cancelUrl" value="/people.jsp">
								<c:param name="ref" value="1" />
								<c:param name="name" value="${param.name}" />
								<c:param name="treeID" value="${param.treeID}" />
								<c:param name="peopleID" value="${param.peopleID}" />
								<c:param name="other" value="${param.other}" />
								<c:param name="accountOwner" value="${param.accountOwner}" />
								<c:param name="emailo" value="${param.emailo}" />
							</c:url>
							<tr>
								<td colspan="3" align="center"><br><a href="<c:out value="${cancelUrl}" />">Go Back</a></td>
							</tr>
						</table>
					</div>