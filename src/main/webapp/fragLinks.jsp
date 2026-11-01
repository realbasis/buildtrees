<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<%@include file="/control/stdTags.jspf" %>

<c:forEach items="${sets.rows}" end="0" var="line">
	<c:set var="otherAccountID" value="${line.AccountID}" />
	<p style="font-size:16px; text-align:center;font-weight:bold">
Family & Friends of ${fn:escapeXml(line.FirstName)} ${fn:escapeXml(line.LastName)}
    </p>
</c:forEach>

						<c:if test="${param.other != true}">
	             	    	<c:if test="${param.updateStatus != null && param.updateStatus != ''}">
    	            	    	<p class="style1">${fn:escapeXml(param.updateStatus)} updates</p>
							</c:if>
						</c:if>
						<c:if test="${param.other == true && access == 'WRITE'}">
							<c:if test="${otherAccountID == accountID}">
								<c:if test="${param.updateStatus != null && param.updateStatus != ''}">
	    	            	    	<p class="style1">${fn:escapeXml(param.updateStatus)} updates</p>
								</c:if>
							</c:if>
						</c:if>

						<table class="noborder">
						<c:if test="${(param.other != true) || (param.other == true && otherAccountID == accountID && access == 'WRITE')}">
							<tr>
								<td colspan="5" style="font-size:12; font-style:italic">* Click <img src="images/del.png"> to delete link to family member</td>
							</tr>
						</c:if>
							<tr>
								<td valign="top" width="100">
									<c:url var="addTypeUrl" value="/people.jsp">
										<c:param name="ref" value="1" />
										<c:param name="pos" value="0" />
										<c:param name="treeID" value="${param.treeID}" />
										<c:param name="peopleID" value="${param.peopleID}" />
										<c:param name="name" value="${param.name}" />
										<c:param name="type" value="parent" />
										<c:param name="other" value="${param.other}" />
										<c:param name="accountOwner" value="${param.accountOwner}" />
										<c:param name="emailo" value="${param.emailo}" />
									</c:url>
									
								<c:choose>
									<c:when test="${(param.other != true) || (param.other == true && otherAccountID == accountID  && access == 'WRITE')}">
										<p style="text-align:center">[<a href="<c:out value="${addTypeUrl}"/>">add Parent</a>]</p>
									</c:when>
									<c:otherwise>
										<p style="text-align:center; text-decoration:underline; color:green">Parents</p>
									</c:otherwise>
								</c:choose>
									
<!--										<p style="text-align:center; color:green">[Parents]</p> -->
									<sql:query var="parentRes">
										Select Links.*, People.FirstName, People.LastName, People.Birthdate, People.ImageName 
										From Links, People 
										Where (Links.PeopleID = ? And Links.FamilyID = People.PeopleID And Links.Type = ?)
										<sql:param value="${param.peopleID}"/>
										<sql:param value="parent"/>
									</sql:query>
									<c:forEach items="${parentRes.rows}" var="phrase">
										<c:url var="tomanUrl" value="/people.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="other" value="${param.other}" />
											<c:param name="accountOwner" value="${param.accountOwner}" />
											<c:param name="emailo" value="${param.emailo}" />
										</c:url>
										<c:url var="dellinkUrl" value="/control/doDelLink.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${param.peopleID}" />
											<c:param name="familyID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="other" value="${param.other}" />
											<c:param name="accountOwner" value="${param.accountOwner}" />
											<c:param name="emailo" value="${param.emailo}" />
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>
												${phrase.Title} 
												<c:if test="${(param.other != true) || (param.other == true && otherAccountID == accountID && access == 'WRITE')}">
													<a href="<c:out value="${dellinkUrl}"/>" title="delete relationship"><img src="images/del.png" style="border:none"></a>
												</c:if>
												<br>
												<a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a>
											</p>
										</div>
									</c:forEach>	
								</td>
								<td valign="top" width="100">
								<c:if test="${param.gender == 'Male'}">
									<c:url var="addTypeUrl" value="/people.jsp">
										<c:param name="ref" value="1" />
										<c:param name="pos" value="1" />
										<c:param name="treeID" value="${param.treeID}" />
										<c:param name="peopleID" value="${param.peopleID}" />
										<c:param name="name" value="${param.name}" />
										<c:param name="type" value="spouse" />
										<c:param name="title" value="Wife" />
										<c:param name="other" value="${param.other}" />
										<c:param name="accountOwner" value="${param.accountOwner}" />
										<c:param name="emailo" value="${param.emailo}" />
									</c:url>
								</c:if>
								<c:if test="${param.gender == 'Female'}">
									<c:url var="addTypeUrl" value="/people.jsp">
										<c:param name="ref" value="1" />
										<c:param name="pos" value="1" />
										<c:param name="treeID" value="${param.treeID}" />
										<c:param name="peopleID" value="${param.peopleID}" />
										<c:param name="name" value="${param.name}" />
										<c:param name="type" value="spouse" />
										<c:param name="title" value="Husband" />
										<c:param name="other" value="${param.other}" />
										<c:param name="accountOwner" value="${param.accountOwner}" />
										<c:param name="emailo" value="${param.emailo}" />
									</c:url>
								</c:if>

								<c:choose>
									<c:when test="${(param.other != true) || (param.other == true && otherAccountID == accountID && access == 'WRITE')}">
										<p style="text-align:center">[<a href="<c:out value="${addTypeUrl}"/>">add Spouse</a>]</p>
									</c:when>
									<c:otherwise>
										<p style="text-align:center; text-decoration:underline; color:green">Spouse</p>
									</c:otherwise>
								</c:choose>

<!--									<p style="text-align:center; color:green">[Spouse]</p> -->
									<sql:query var="spouseRes">
										Select Links.*, People.FirstName, People.LastName, People.Birthdate, People.ImageName 
										From Links, People 
										Where (Links.PeopleID = ? And Links.FamilyID = People.PeopleID And Links.Type = ?)
										<sql:param value="${param.peopleID}"/>
										<sql:param value="spouse"/>
									</sql:query>
									<c:forEach items="${spouseRes.rows}" var="phrase">
										<c:url var="tomanUrl" value="/people.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="other" value="${param.other}" />
											<c:param name="accountOwner" value="${param.accountOwner}" />
											<c:param name="emailo" value="${param.emailo}" />
										</c:url>
										<c:url var="dellinkUrl" value="/control/doDelLink.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${param.peopleID}" />
											<c:param name="familyID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="other" value="${param.other}" />
											<c:param name="accountOwner" value="${param.accountOwner}" />
											<c:param name="emailo" value="${param.emailo}" />
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>
												${phrase.Title} 
												<c:if test="${(param.other != true) || (param.other == true && otherAccountID == accountID && access == 'WRITE')}">
													<a href="<c:out value="${dellinkUrl}"/>" title="delete relationship"><img src="images/del.png" style="border:none"></a>
												</c:if>
												<br>
												<a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a>
											</p>
										</div>
									</c:forEach>	
								</td>
								<td valign="top" width="100">
									<c:url var="addTypeUrl" value="/people.jsp">
										<c:param name="ref" value="1" />
										<c:param name="pos" value="0" />
										<c:param name="treeID" value="${param.treeID}" />
										<c:param name="peopleID" value="${param.peopleID}" />
										<c:param name="name" value="${param.name}" />
										<c:param name="type" value="child" />
										<c:param name="other" value="${param.other}" />
										<c:param name="accountOwner" value="${param.accountOwner}" />
										<c:param name="emailo" value="${param.emailo}" />
									</c:url>

								<c:choose>
									<c:when test="${(param.other != true) || (param.other == true && otherAccountID == accountID && access == 'WRITE')}">
										<p style="text-align:center">[<a href="<c:out value="${addTypeUrl}"/>">add Child</a>]</p>
									</c:when>
									<c:otherwise>
										<p style="text-align:center; text-decoration:underline; color:green">Children</p>
									</c:otherwise>
								</c:choose>

<!--									<p style="text-align:center; color:green">[Children]</p> -->
									<sql:query var="childRes">
										Select Links.*, People.FirstName, People.LastName, People.Birthdate, People.ImageName 
										From Links, People 
										Where (Links.PeopleID = ? And Links.FamilyID = People.PeopleID And Links.Type = ?) 
										Order By Birthdate
										<sql:param value="${param.peopleID}"/>
										<sql:param value="child"/>
									</sql:query>
									<c:forEach items="${childRes.rows}" var="phrase">
										<c:url var="tomanUrl" value="/people.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="other" value="${param.other}" />
											<c:param name="accountOwner" value="${param.accountOwner}" />
											<c:param name="emailo" value="${param.emailo}" />
										</c:url>
										<c:url var="dellinkUrl" value="/control/doDelLink.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${param.peopleID}" />
											<c:param name="familyID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="other" value="${param.other}" />
											<c:param name="accountOwner" value="${param.accountOwner}" />
											<c:param name="emailo" value="${param.emailo}" />
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>
												${phrase.Title} 
												<c:if test="${(param.other != true) || (param.other == true && otherAccountID == accountID && access == 'WRITE')}">
													<a href="<c:out value="${dellinkUrl}"/>" title="delete relationship"><img src="images/del.png" style="border:none"></a>
												</c:if>
												<br>
												<a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a>
											</p>
										</div>
									</c:forEach>
								</td>
								<td valign="top" width="100">
									<c:url var="addTypeUrl" value="/people.jsp">
										<c:param name="ref" value="1" />
										<c:param name="pos" value="0" />
										<c:param name="treeID" value="${param.treeID}" />
										<c:param name="peopleID" value="${param.peopleID}" />
										<c:param name="name" value="${param.name}" />
										<c:param name="type" value="sibling" />
										<c:param name="other" value="${param.other}" />
										<c:param name="accountOwner" value="${param.accountOwner}" />
										<c:param name="emailo" value="${param.emailo}" />
									</c:url>

								<c:choose>
									<c:when test="${(param.other != true) || (param.other == true && otherAccountID == accountID && access == 'WRITE')}">
										<p style="text-align:center">[<a href="<c:out value="${addTypeUrl}"/>">add Sibling</a>]</p>
									</c:when>
									<c:otherwise>
										<p style="text-align:center; text-decoration:underline; color:green">Siblings</p>
									</c:otherwise>
								</c:choose>

<!--									<p style="text-align:center; color:green">[Siblings]</p> -->
									<sql:query var="siblingRes">
										Select Links.*, People.FirstName, People.LastName, People.Birthdate, People.ImageName 
										From Links, People 
										Where (Links.PeopleID = ? And Links.FamilyID = People.PeopleID And Links.Type = ?) 
										Order By Birthdate
										<sql:param value="${param.peopleID}"/>
										<sql:param value="sibling"/>
									</sql:query>
									<c:forEach items="${siblingRes.rows}" var="phrase">
										<c:url var="tomanUrl" value="/people.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="other" value="${param.other}" />
											<c:param name="accountOwner" value="${param.accountOwner}" />
											<c:param name="emailo" value="${param.emailo}" />
										</c:url>
										<c:url var="dellinkUrl" value="/control/doDelLink.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${param.peopleID}" />
											<c:param name="familyID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="other" value="${param.other}" />
											<c:param name="accountOwner" value="${param.accountOwner}" />
											<c:param name="emailo" value="${param.emailo}" />
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>
												${phrase.Title} 
												<c:if test="${(param.other != true) || (param.other == true && otherAccountID == accountID && access == 'WRITE')}">
													<a href="<c:out value="${dellinkUrl}"/>" title="delete relationship"><img src="images/del.png" style="border:none"></a>
												</c:if>
												<br>
												<a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a>
											</p>
										</div>
									</c:forEach>
								</td>
								<td valign="top" width="100">
									<c:url var="addTypeUrl" value="/people.jsp">
										<c:param name="ref" value="1" />
										<c:param name="pos" value="0" />
										<c:param name="treeID" value="${param.treeID}" />
										<c:param name="peopleID" value="${param.peopleID}" />
										<c:param name="name" value="${param.name}" />
										<c:param name="type" value="other" />
										<c:param name="other" value="${param.other}" />
										<c:param name="accountOwner" value="${param.accountOwner}" />
										<c:param name="emailo" value="${param.emailo}" />
									</c:url>

								<c:choose>
									<c:when test="${(param.other != true) || (param.other == true && otherAccountID == accountID && access == 'WRITE')}">
										<p style="text-align:center">[<a href="<c:out value="${addTypeUrl}"/>">add Other</a>]</p>
									</c:when>
									<c:otherwise>
										<p style="text-align:center; text-decoration:underline; color:green">Other</p>
									</c:otherwise>
								</c:choose>

<!--									<p style="text-align:center; color:green">[Friends]</p> -->
									<sql:query var="otherRes">
										Select Links.*, People.FirstName, People.LastName, People.Birthdate, People.ImageName 
										From Links, People 
										Where (Links.PeopleID = ? And Links.FamilyID = People.PeopleID And Links.Type = ?)
										<sql:param value="${param.peopleID}"/>
										<sql:param value="other"/>
									</sql:query>
									<c:forEach items="${otherRes.rows}" var="phrase">
										<c:url var="tomanUrl" value="/people.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="other" value="${param.other}" />
											<c:param name="accountOwner" value="${param.accountOwner}" />
											<c:param name="emailo" value="${param.emailo}" />
										</c:url>
										<c:url var="dellinkUrl" value="/control/doDelLink.jsp">
											<c:param name="ref" value="1" />
											<c:param name="treeID" value="${param.treeID}" />
											<c:param name="peopleID" value="${param.peopleID}" />
											<c:param name="familyID" value="${phrase.FamilyID}" />
											<c:param name="name" value="${param.name}" />
											<c:param name="other" value="${param.other}" />
											<c:param name="accountOwner" value="${param.accountOwner}" />
											<c:param name="emailo" value="${param.emailo}" />
										</c:url>
										<div style="margin-bottom:5px;font-size:9; text-align:center">
											<p>
												${phrase.Title} 
												<c:if test="${(param.other != true) || (param.other == true && otherAccountID == accountID && access == 'WRITE')}">
													<a href="<c:out value="${dellinkUrl}"/>" title="delete relationship"><img src="images/del.png" style="border:none"></a>
												</c:if>
												<br>
												<a href="<c:out value="${tomanUrl}" />">${phrase.FirstName} ${phrase.LastName}</a>
											</p>
										</div>
									</c:forEach>
								</td>
							</tr>
							<c:url var="cancelUrl" value="/mytree.jsp">
								<c:param name="ref" value="1" />
								<c:param name="name" value="${param.name}" />
								<c:param name="treeID" value="${param.treeID}" />
								<c:param name="peopleID" value="${param.peopleID}" />
								<c:param name="other" value="${param.other}" />
								<c:param name="accountOwner" value="${param.accountOwner}" />
								<c:param name="emailo" value="${param.emailo}" />
							</c:url>
							<tr>
								<td colspan="5" align="center">
									<br />
									<a href="<c:out value="${cancelUrl}" />">Back to Tree</a>
								</td>
							</tr>
						</table>
						