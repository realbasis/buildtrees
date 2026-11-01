<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<jsp:useBean id="famBean" class="utility.CheckFamilyBean" />

<sql:query var="myFamRes">
    Select Links.Type, Links.Title, Links.PeopleID, Links.FamilyID, People.FirstName, People.LastName 
    From Links, People 
    Where (Links.PeopleID = ? And People.PeopleID = Links.FamilyID)
    <sql:param value="${param.peopleID}" />
</sql:query>

<jsp:setProperty name="famBean" property="subfamilyMap" value="${myFamRes.rows}" />
<jsp:setProperty name="famBean" property="peopleID" value="${param.peopleID}" />
<jsp:setProperty name="famBean" property="gender" value="${param.gender}" />

<c:set var="familySize" value="0" />

<c:forEach items="${myFamRes.rows}" var="link">

    <sql:query var="otraFamRes">
        Select Links.Type, Links.Title, Links.PeopleID, Links.FamilyID, People.FirstName, People.LastName 
	From Links, People 
	Where (Links.PeopleID = ? And People.PeopleID = Links.FamilyID And Links.FamilyID != ?)
        <sql:param value="${link.FamilyID}" />
        <sql:param value="${param.peopleID}" />
    </sql:query>
    
    <!-- one link at a time -->
    <jsp:setProperty name="famBean" property="familyMap" value="${otraFamRes.rows}" />
    <c:set var="familyList" value="${famBean.list3}" />
    <c:set var="familySize" value="${famBean.list3Size + familySize}" />
    
    <c:forEach items="${familyList}" var="unit">
        <!-- create secondary links -->
        <sql:update>
            Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
            <sql:param value="${unit.Type}" />
            <sql:param value="${unit.Title}" />
            <sql:param value="${unit.PeopleID}" />
            <sql:param value="${unit.FamilyID}" />
        </sql:update>
    </c:forEach>

</c:forEach>

<c:redirect url="/people.jsp">
    <c:param name="treeID" value="${param.treeID}" />
    <c:param name="name" value="${param.name}" />
    <c:param name="peopleID" value="${param.peopleID}" />
    <c:param name="ref" value="${param.ref}" />
    <c:param name="updateStatus" value="${familySize}" />
    <c:param name="other" value="${param.other}" />
    <c:param name="accountOwner" value="${param.accountOwner}" />
    <c:param name="emailo" value="${param.emailo}" />
</c:redirect>

