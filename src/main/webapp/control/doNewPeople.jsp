<%@page contentType="text/html" errorPage="../error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<c:if test="${param.firstName == ''}">
    
        <c:redirect url="/people.jsp">
            <c:param name="errors" value="First Name is a required field!" />
            <c:param name="ref" value="0" />
            <c:param name="refx" value="0" />
            <c:param name="treeID" value="${param.treeID}" />
            <c:param name="name" value="${param.name}" />
            <c:param name="lastName" value="${param.lastName}" />
            <c:param name="pemail" value="${param.pemail}" />
            <c:param name="tel" value="${param.tel}" />
            <c:param name="web" value="${param.web}" />
            <c:param name="gender" value="${param.gender}" />
            <c:param name="gotBirthdate" value="${param.gotBirthdate}" />
            <c:param name="isDeceased" value="${param.isDeceased}" />
            <c:param name="birthdate" value="${param.birthdate}" />
            <c:param name="deceased" value="${param.deceased}" />
            <c:param name="other" value="${param.other}" />
            <c:param name="accountOwner" value="${param.accountOwner}" />
            <c:param name="emailo" value="${param.emailo}" />
        </c:redirect>
</c:if>
    
<c:if test="${param.lastName == ''}">

        <c:redirect url="/people.jsp">
            <c:param name="errors" value="Last Name is a required field!" />
            <c:param name="ref" value="0" />
            <c:param name="refx" value="0" />
            <c:param name="treeID" value="${param.treeID}" />
            <c:param name="name" value="${param.name}" />
            <c:param name="firstName" value="${param.firstName}" />
            <c:param name="pemail" value="${param.pemail}" />
            <c:param name="tel" value="${param.tel}" />
            <c:param name="web" value="${param.web}" />
            <c:param name="gender" value="${param.gender}" />
            <c:param name="gotBirthdate" value="${param.gotBirthdate}" />
            <c:param name="isDeceased" value="${param.isDeceased}" />
            <c:param name="birthdate" value="${param.birthdate}" />
            <c:param name="deceased" value="${param.deceased}" />
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
    
    <c:if test="${param.other != true}">
        <c:set var="myaccountid" value="-1" />
    </c:if>
    <c:if test="${param.other == true}">
        <c:set var="myaccountid" value="${accountID}" />
    </c:if>
    
    
    <!-- update account parameters -->
    <sql:update var="result">
        Insert Into People 
            (FirstName, LastName, Email, Tel, Web, Gender, TreeID, GotBirthdate, IsDeceased, Birthdate, Deceased, AccountID) 
            Values (?,?,?,?,?,?,?,?,?,?,?,?)
        <sql:param value="${param.firstName}" />
        <sql:param value="${param.lastName}" />
        <sql:param value="${param.pemail}" />
        <sql:param value="${param.tel}" />
        <sql:param value="${param.web}" />
        <sql:param value="${param.gender}" />
        <sql:param value="${param.treeID}" />
        <sql:param value="${gotBirthdate}" />
        <sql:param value="${isDeceased}" />
        <sql:dateParam value="${birthdate}" />
        <sql:dateParam value="${deceased}" />
        <sql:param value="${myaccountid}" />
    </sql:update>
    
    <sql:query var="result2">
        Select MAX(PeopleID) from People
    </sql:query>
    <c:forEach items="${result2.rowsByIndex}" var="ans" end="0">
        <c:set var="peopleID" value="${ans[0]}" />
    </c:forEach>
    
    <!-- go to person profile -->
    <c:redirect url="/people.jsp">
        <c:param name="treeID" value="${param.treeID}" />
        <c:param name="name" value="${param.name}" />
        <c:param name="peopleID" value="${peopleID}" />
        <c:param name="ref" value="1" />
        <c:param name="other" value="${param.other}" />
        <c:param name="accountOwner" value="${param.accountOwner}" />
	<c:param name="emailo" value="${param.emailo}" />
    </c:redirect>
