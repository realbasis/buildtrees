<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<c:if test="${param.firstName == ''}">

        <c:redirect url="/people.jsp">
            <c:param name="errors" value="First Name is a required field!" />
            <c:param name="ref" value="1" />
            <c:param name="pos" value="3" />
            <c:param name="treeID" value="${param.treeID}" />
            <c:param name="name" value="${param.name}" />
            <c:param name="peopleID" value="${param.peopleID}" />
            <c:param name="other" value="${param.other}" />
            <c:param name="accountOwner" value="${param.accountOwner}" />
            <c:param name="emailo" value="${param.emailo}" />
        </c:redirect>
        
</c:if>
    
<c:if test="${param.lastName == ''}">

        <c:redirect url="/people.jsp">
            <c:param name="errors" value="Last Name is a required field!" />
            <c:param name="ref" value="1" />
            <c:param name="pos" value="3" />
            <c:param name="treeID" value="${param.treeID}" />
            <c:param name="name" value="${param.name}" />
            <c:param name="peopleID" value="${param.peopleID}" />
            <c:param name="other" value="${param.other}" />
            <c:param name="accountOwner" value="${param.accountOwner}" />
            <c:param name="emailo" value="${param.emailo}" />
        </c:redirect>
        
</c:if>
    
    <fmt:parseDate var="birthdate" value="${param.birthdate}" pattern="MMM-dd-yyyy" />
    <fmt:parseDate var="deceased" value="${param.deceased}" pattern="MMM-dd-yyyy" />
    
    <c:choose>
        <c:when test="${param.gotBirthdate == 'on'}">
            <c:set var="gotBirthdate" value="on" />
        </c:when>
        <c:otherwise>
            <c:set var="gotBirthdate" value="off" />
        </c:otherwise>
    </c:choose>
    
    <c:choose>
        <c:when test="${param.isDeceased == 'on'}">
            <c:set var="isDeceased" value="on" />
        </c:when>
        <c:otherwise>
            <c:set var="isDeceased" value="off" />
        </c:otherwise>
    </c:choose>
    
    <!-- update account parameters -->
    <sql:update var="result">
        Update People Set
            FirstName = ?,
            LastName = ?,
            Email = ?,
            Tel = ?,
            Web = ?,
            GotBirthdate = ?,
            Birthdate = ?,
            IsDeceased = ?,
            Deceased = ?,
            Gender = ?
        Where PeopleID = ?
        <sql:param value="${param.firstName}" />
        <sql:param value="${param.lastName}" />
        <sql:param value="${param.pemail}" />
        <sql:param value="${param.tel}" />
        <sql:param value="${param.web}" />
        <sql:param value="${gotBirthdate}" />
        <sql:dateParam value="${birthdate}" />
        <sql:param value="${isDeceased}" />
        <sql:dateParam value="${deceased}" />
        <sql:param value="${param.gender}" />
        <sql:param value="${param.peopleID}" />
    </sql:update>
    
    <c:redirect url="/people.jsp">
        <c:param name="treeID" value="${param.treeID}" />
        <c:param name="name" value="${param.name}" />
        <c:param name="peopleID" value="${param.peopleID}" />
        <c:param name="ref" value="1" />
        <c:param name="other" value="${param.other}" />
        <c:param name="accountOwner" value="${param.accountOwner}" />
	<c:param name="emailo" value="${param.emailo}" />
    </c:redirect>
