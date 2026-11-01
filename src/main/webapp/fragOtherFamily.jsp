<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/control/stdTags.jspf" %>

                                                <!-- look for extended family - got p1p2Type, p1p2Title -->
						<sql:query var="otrafamilyMap">
						    Select Links.Type, Links.Title, Links.PeopleID, Links.FamilyID, People.FirstName, People.LastName 
							From Links, People 
							Where (Links.PeopleID = ? And People.PeopleID = Links.FamilyID And Links.FamilyID != ?)
						    <sql:param value="${param.p2ID}" />
							<sql:param value="${param.peopleID}" />
						</sql:query>
						
						<!-- verify that extended family does not already exist -->
						<sql:query var="mifamilyMap">
						    Select Links.Type, Links.Title, Links.PeopleID, Links.FamilyID, People.FirstName, People.LastName 
							From Links, People 
							Where (Links.PeopleID = ? And People.PeopleID = Links.FamilyID And Links.FamilyID != ?)
						    <sql:param value="${param.peopleID}" />
							<sql:param value="${param.p2ID}" />
						</sql:query>
						
						<jsp:setProperty name="checkFamilyBean" property="familyMap" value="${otrafamilyMap.rows}" />
						<jsp:setProperty name="checkFamilyBean" property="subfamilyMap" value="${mifamilyMap.rows}" />
						<jsp:setProperty name="checkFamilyBean" property="peopleID" value="${param.peopleID}" />
						<jsp:setProperty name="checkFamilyBean" property="familyID" value="${param.p2ID}" />
						<jsp:setProperty name="checkFamilyBean" property="p1p2Title" value="${param.p1p2Title}" />
						<c:set var="familyList2" value="${checkFamilyBean.list2}"/>
						<c:set var="familySize" value="${checkFamilyBean.list2Size}"/>
						<p class="style1">Type - Title - PeopleID - FamilyID - Name</p>
						<c:forEach items="${familyList2}" var="person">
							<p>${person.Type} - ${person.Title} - ${person.PeopleID} - ${person.FamilyID} - ${person.FirstName} ${person.LastName}</p>
							<!-- create secondary links -->
							<sql:update>
							    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
							    <sql:param value="${person.Type}" />
							    <sql:param value="${person.Title}" />
							    <sql:param value="${person.PeopleID}" />
							    <sql:param value="${person.FamilyID}" />
							</sql:update>
						</c:forEach>
						<div>
						<p class="style1">Family tree has been updated.</p>
						<p>
							<form action="people.jsp" method="post">
								<input type="hidden" name="treeID" value="${param.treeID}">
								<input type="hidden" name="name" value="${param.name}">
								<input type="hidden" name="peopleID" value="${param.peopleID}">
								<input type="hidden" name="ref" value="${param.ref}">
								<input type="submit" value="Continue">
							</form>
						</p>
						</div>