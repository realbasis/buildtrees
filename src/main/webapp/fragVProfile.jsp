<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/control/stdTags.jspf" %>

<sql:query var="sets">
    Select * From People Where PeopleID = ?
   	<sql:param value="${param.peopleID}"/>
</sql:query>
			<c:choose>
				<c:when test="${sets.rowCount == 1}">
					<c:forEach items="${sets.rows}" end="0" var="line">
						<p style="font-size:16px; font-weight:bold; text-align:center">Profile of <span style="font-weight:bold">${fn:escapeXml(line.FirstName)} ${fn:escapeXml(line.LastName)}</span></p>

					<div id="man">
						<table class="noborder" align="center">
						<tr>
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
									</ul>
								</div>
							</td>
						</tr></table>
					</div>
<hr>
					<p style="font-size:16px; font-weight:bold; text-align:center">
						Family & Friends of  ${fn:escapeXml(line.FirstName)} ${fn:escapeXml(line.LastName)}
					</p>
				</c:forEach>
						<table class="noborder">
							<tr>
								<td valign="top" width="100">
									<p style="text-align:center">[Parents]</p>
									<sql:query var="parentRes">
										Select Links.*, People.FirstName, People.LastName, People.Birthdate, People.ImageName 
										From Links, People 
										Where (Links.PeopleID = ? And Links.FamilyID = People.PeopleID And Links.Type = ?)
										<sql:param value="${param.peopleID}"/>
										<sql:param value="parent"/>
									</sql:query>
									<c:forEach items="${parentRes.rows}" var="phrase">
										<c:url var="tomanUrl" value="/viewtree.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="nameSearch" value="${param.nameSearch}" />
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>${phrase.Title}<br><a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a></p>
										</div>
									</c:forEach>	
								</td>
								<td valign="top" width="100">
									<p style="text-align:center">[Spouse]</p>
									<sql:query var="spouseRes">
										Select Links.*, People.FirstName, People.LastName, People.Birthdate, People.ImageName 
										From Links, People 
										Where (Links.PeopleID = ? And Links.FamilyID = People.PeopleID And Links.Type = ?)
										<sql:param value="${param.peopleID}"/>
										<sql:param value="spouse"/>
									</sql:query>
									<c:forEach items="${spouseRes.rows}" var="phrase">
										<c:url var="tomanUrl" value="/viewtree.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="nameSearch" value="${param.nameSearch}" />
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>${phrase.Title}<br><a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a></p>
										</div>
									</c:forEach>	
								</td>
								<td valign="top" width="100">
									<p style="text-align:center">[Children]</p>
									<sql:query var="childRes">
										Select Links.*, People.FirstName, People.LastName, People.Birthdate, People.ImageName 
										From Links, People 
										Where (Links.PeopleID = ? And Links.FamilyID = People.PeopleID And Links.Type = ?) 
										Order By Birthdate
										<sql:param value="${param.peopleID}"/>
										<sql:param value="child"/>
									</sql:query>
									<c:forEach items="${childRes.rows}" var="phrase">
										<c:url var="tomanUrl" value="/viewtree.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="nameSearch" value="${param.nameSearch}" />
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>${phrase.Title}<br><a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a></p>
										</div>
									</c:forEach>
								</td>
								<td valign="top" width="100">
									<p style="text-align:center">[Siblings]</p>
									<sql:query var="siblingRes">
										Select Links.*, People.FirstName, People.LastName, People.Birthdate, People.ImageName 
										From Links, People 
										Where (Links.PeopleID = ? And Links.FamilyID = People.PeopleID And Links.Type = ?) 
										Order By Birthdate
										<sql:param value="${param.peopleID}"/>
										<sql:param value="sibling"/>
									</sql:query>
									<c:forEach items="${siblingRes.rows}" var="phrase">
										<c:url var="tomanUrl" value="/viewtree.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="nameSearch" value="${param.nameSearch}" />
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>${phrase.Title}<br><a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a></p>
										</div>
									</c:forEach>
								</td>
								<td valign="top" width="100">
									<p style="text-align:center">[Other]</p>
									<sql:query var="otherRes">
										Select Links.*, People.FirstName, People.LastName, People.Birthdate, People.ImageName 
										From Links, People 
										Where (Links.PeopleID = ? And Links.FamilyID = People.PeopleID And Links.Type = ?)
										<sql:param value="${param.peopleID}"/>
										<sql:param value="other"/>
									</sql:query>
									<c:forEach items="${otherRes.rows}" var="phrase">
										<c:url var="tomanUrl" value="/viewtree.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="nameSearch" value="${param.nameSearch}" /> 
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>${phrase.Title}<br><a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a></p>
										</div>
									</c:forEach>
								</td>
							</tr>
						</table>
					</c:when>
					<c:otherwise>
						<!-- we have an error -->
						<p>Individual was not found.  Please try again.</p>
						<p>If this problem persists, contact us at <a href="mailto:support@realbasis.com">support@realbasis.com</a></p>
					</c:otherwise>
				</c:choose>
