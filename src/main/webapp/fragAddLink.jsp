<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/control/stdTags.jspf" %>

                    <!-- segregate selection per gender -->
					<c:choose>
						<c:when test="${param.title == 'Other' || param.title == 'Friend'}">
							<sql:query var="maps">
								Select * From People Where (PeopleID != ? And TreeID = ?)
								<sql:param value="${param.peopleID}"/>
								<sql:param value="${param.treeID}"/>
							</sql:query>
						</c:when>
						<c:when test="${param.title == 'Father' || param.title == 'Stepfather' || param.title == 'Brother' || param.title == 'Half brother' || param.title == 'Son' || param.title == 'Stepson' || param.title == 'Boyfriend' || param.title == 'Husband'}">
							<sql:query var="maps">
								Select * From People Where (PeopleID != ? And TreeID = ? And Gender = ?)
								<sql:param value="${param.peopleID}"/>
								<sql:param value="${param.treeID}"/>
								<sql:param value="Male"/>
							</sql:query>
						</c:when>
						<c:otherwise>
							<sql:query var="maps">
								Select * From People Where (PeopleID != ? And TreeID = ? And Gender = ?)
								<sql:param value="${param.peopleID}"/>
								<sql:param value="${param.treeID}"/>
								<sql:param value="Female"/>
							</sql:query>
						</c:otherwise>
					</c:choose>
					
					<!-- get selection of family members -->
					<sql:query var="submaps">
						Select * From Links Where PeopleID = ?
						<sql:param value="${param.peopleID}"/>
					</sql:query>
					
					<!-- ultimage list -->
					<jsp:setProperty name="checkFamilyBean" property="familyMap" value="${maps.rows}" />
					<jsp:setProperty name="checkFamilyBean" property="subfamilyMap" value="${submaps.rows}" />
					<c:set var="familyList" value="${checkFamilyBean.list}"/>
					<c:set var="familySize" value="${checkFamilyBean.list0Size}"/>
					<div>
						<table class="noborder" align="center">
						<form action="control/doNode.jsp" method="post" name="addLinkForm">
							<input type="hidden" name="type" value="${param.type}">
							<input type="hidden" name="title" value="${param.title}">
							<input type="hidden" name="treeID" value="${param.treeID}">
							<input type="hidden" name="name" value="${param.name}">
							<input type="hidden" name="peopleID" value="${param.peopleID}">
							<input type="hidden" name="ref" value="${param.ref}">
							<input type="hidden" name="other" value="${param.other}">
							<input type="hidden" name="accountOwner" value="${param.accountOwner}" />
							<input type="hidden" name="emailo" value="${param.emailo}" />
							<input type="hidden" name="familySize" value="${familySize}" />
							<tr>
								<td align="center">add <span style="font-weight:bold">${param.title}</span></td>
							</tr>
							<c:if test="${familySize > 0}">
							<tr>
								<td align="center">
									<select name="familyID">
									<c:forEach items="${familyList}" var="play">
										<c:choose>
										<c:when test="${param.familyID == play.PeopleID}">
											<option value="${play.PeopleID}" selected="selected">${play.LastName}, ${play.FirstName}</option>
										</c:when>
										<c:otherwise>
											<option value="${play.PeopleID}">${play.LastName}, ${play.FirstName}</option>
										</c:otherwise>
										</c:choose>
									</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th align="center">or new member</th>
							</tr>
							</c:if>
							<tr>
								<td align="center">
									<table>
										<tr>
											<td style="color:red; font-style:italic" colspan="2" align="center">
												${param.errors}
											</td>
										</tr>
										<tr>
											<td>
												First Name <span style="color:red; font-style:italic">* required</span>
												<br />
												<input type="text" name="firstName" />
											</td>
											<td>
												Last Name <span style="color:red; font-style:italic">* required</span>
												<br />
												<input type="text" name="lastName" />
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td align="center">
									<input type="button" value="Save" name="addLink" onClick="addLinkForm.addLink.value='Processing...';addLinkForm.submit()">
								</td>
							</tr>
						</form>
						<!--
							<tr>
								<td colspan="3" align="center" style="color:red">
									<h4>you need to create the members before connecting them!</h4>
									<div>
										<form action="people.jsp" method="post">
											<input type="submit" value="Add Member" style="font-size:10px; width:120px">
											<input type="hidden" name="treeID" value="${param.treeID}">
											<input type="hidden" name="name" value="${param.name}">
											<input type="hidden" name="peopleID" value="${param.peopleID}">
											<input type="hidden" name="ref" value="0">
											<input type="hidden" name="other" value="${param.other}">
											<input type="hidden" name="accountOwner" value="${param.accountOwner}">
											<input type="hidden" name="emailo" value="${param.emailo}">
										</form>
									</div>
								</td>
							</tr>
						-->
							<tr>
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
								<td colspan="3" align="center">
									<br />
									<a href="<c:out value="${cancelUrl}" />">Go Back</a>
								</td>
							</tr>
						</table>
					</div>

