<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<!-- check invalid state - case familyID is null -->
<c:if test="${familyID == null}">
<%
try {
%>
	<mt:mail from="buildtrees@realbasis.com" subject="Invalid doNode state" 
			to="support@realbasis.com" 
			server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456"> 
	${now}
    Dear Real Basis staff, Your customer has experienced a software error. See 
    below... 
    
    This is the case when familyID is null.
	
    Type: ${param.type}
    Title: ${param.title}
    PeopleID: ${param.peopleID}
    AccountID: ${accountID}
    
    See logs for more details! 
	</mt:mail>
<%
}
catch (Exception e){
}
%>
</c:if>

<!-- check if it is a new member -->
<c:if test="${param.familySize <= 0 && (param.firstName == '' || param.lastName == '')}">

<c:redirect url="/people.jsp">
    <c:param name="treeID" value="${param.treeID}" />
    <c:param name="name" value="${param.name}" />
    <c:param name="peopleID" value="${param.peopleID}" />
    <c:param name="ref" value="${param.ref}" />
    <c:param name="other" value="${param.other}" />
    <c:param name="accountOwner" value="${param.accountOwner}" />
    <c:param name="emailo" value="${param.emailo}" />
</c:redirect>

</c:if>

<c:choose>
<c:when test="${param.firstName != '' && param.lastName != ''}">
    
    <c:if test="${param.other != true}">
        <c:set var="myaccountid" value="-1" />
    </c:if>
    <c:if test="${param.other == true}">
        <c:set var="myaccountid" value="${accountID}" />
    </c:if>
    
    <sql:update var="result0">
        Insert Into People (FirstName, LastName, AccountID) Values (?,?,?)
        <sql:param value="${param.firstName}" />
        <sql:param value="${param.lastName}" />
        <sql:param value="${myaccountid}" />
    </sql:update>
    
    <sql:query var="result0">
        Select MAX(PeopleID) from People
    </sql:query>
    <c:forEach items="${result0.rowsByIndex}" var="ans" end="0">
        <c:set var="familyID" value="${ans[0]}" />
    </c:forEach>
    
</c:when>
<c:otherwise>
    <c:set var="familyID" value="${param.familyID}" />
</c:otherwise>
</c:choose>

<!-- create link -->
<sql:update>
    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
    <sql:param value="${param.type}" />
    <sql:param value="${param.title}" />
    <sql:param value="${param.peopleID}" />
    <sql:param value="${familyID}" />
</sql:update>

<!-- get gender -->
<sql:query var="result">
    Select * from People Where PeopleID = ?
    <sql:param value="${param.peopleID}" />
</sql:query>
<c:forEach items="${result.rows}" var="row" end="0">
    <c:set var="gender" value="${row.Gender}" />
</c:forEach>

<!-- create transpose link -->
<c:choose>
    <c:when test="${param.type == 'parent'}">
    
        <c:choose>
            <c:when test="${param.title == 'Mother'}">

                <c:if test="${gender == 'Male'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="child" />
                    <sql:param value="Son" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
                <c:if test="${gender == 'Female'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="child" />
                    <sql:param value="Daughter" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
            
            </c:when>
            <c:when test="${param.title == 'Father'}">
            
                <c:if test="${gender == 'Male'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="child" />
                    <sql:param value="Son" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
                <c:if test="${gender == 'Female'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="child" />
                    <sql:param value="Daughter" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
            
            </c:when>
            <c:when test="${param.title == 'Stepmother'}">
            
                <c:if test="${gender == 'Male'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="child" />
                    <sql:param value="Stepson" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
                <c:if test="${gender == 'Female'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="child" />
                    <sql:param value="Stepdaughter" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
            
            </c:when>
            <c:when test="${param.title == 'Stepfather'}">
            
                <c:if test="${gender == 'Male'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="child" />
                    <sql:param value="Stepson" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
                <c:if test="${gender == 'Female'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="child" />
                    <sql:param value="Stepdaughter" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
            
            </c:when>
            <c:when test="${param.title == 'Other'}">
            
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="child" />
                    <sql:param value="Other" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
            
            </c:when>
            <c:otherwise>
                <c:redirect url="/control/logout.jsp" />
                <!-- send bug to staff -->
            </c:otherwise>
        </c:choose>
    
    </c:when>
    <c:when test="${param.type == 'spouse'}">
    
        <c:choose>
            <c:when test="${param.title == 'Wife'}">

                <c:if test="${gender == 'Male'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="spouse" />
                    <sql:param value="Husband" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
                <c:if test="${gender == 'Female'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="spouse" />
                    <sql:param value="Wife" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
            
            </c:when>
            <c:when test="${param.title == 'Husband'}">
            
                <c:if test="${gender == 'Male'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="spouse" />
                    <sql:param value="Husband" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
                <c:if test="${gender == 'Female'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="spouse" />
                    <sql:param value="Wife" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
            
            </c:when>
            <c:when test="${param.title == 'Other'}">
            
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="spouse" />
                    <sql:param value="Other" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
            
            </c:when>
            <c:otherwise>
                <c:redirect url="/control/logout.jsp" />
                <!-- send bug to staff -->
            </c:otherwise>
        </c:choose>
    
    </c:when>
    <c:when test="${param.type == 'sibling'}">
    
        <c:choose>
            <c:when test="${param.title == 'Sister'}">
            
                <c:if test="${gender == 'Male'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="sibling" />
                    <sql:param value="Brother" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
                <c:if test="${gender == 'Female'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="sibling" />
                    <sql:param value="Sister" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
            
            </c:when>
            <c:when test="${param.title == 'Brother'}">
            
                <c:if test="${gender == 'Male'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="sibling" />
                    <sql:param value="Brother" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
                <c:if test="${gender == 'Female'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="sibling" />
                    <sql:param value="Sister" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
            
            </c:when>
            <c:when test="${param.title == 'Half brother'}">
            
                <c:if test="${gender == 'Male'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="sibling" />
                    <sql:param value="Half brother" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
                <c:if test="${gender == 'Female'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="sibling" />
                    <sql:param value="Half sister" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
            
            </c:when>
            <c:when test="${param.title == 'Half sister'}">
            
                <c:if test="${gender == 'Male'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="sibling" />
                    <sql:param value="Half brother" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
                <c:if test="${gender == 'Female'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="sibling" />
                    <sql:param value="Half sister" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
            
            </c:when>
            <c:when test="${param.title == 'Other'}">
            
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="sibling" />
                    <sql:param value="Other" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
            
            </c:when>
            <c:otherwise>
                <c:redirect url="/control/logout.jsp" />
                <!-- send bug to staff -->
            </c:otherwise>
        </c:choose>
    
    </c:when>
    <c:when test="${param.type == 'child'}">
    
        <c:choose>
            <c:when test="${param.title == 'Son'}">
            
                <c:if test="${gender == 'Male'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="parent" />
                    <sql:param value="Father" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
                <c:if test="${gender == 'Female'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="parent" />
                    <sql:param value="Mother" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
            
            </c:when>
            <c:when test="${param.title == 'Daughter'}">
            
                <c:if test="${gender == 'Male'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="parent" />
                    <sql:param value="Father" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
                <c:if test="${gender == 'Female'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="parent" />
                    <sql:param value="Mother" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
            
            </c:when>
            <c:when test="${param.title == 'Stepdaughter'}">
            
                <c:if test="${gender == 'Male'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="parent" />
                    <sql:param value="Stepfather" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
                <c:if test="${gender == 'Female'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="parent" />
                    <sql:param value="Stepmother" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
            
            </c:when>
            <c:when test="${param.title == 'Stepson'}">
            
                <c:if test="${gender == 'Male'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="parent" />
                    <sql:param value="Stepfather" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
                <c:if test="${gender == 'Female'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="parent" />
                    <sql:param value="Stepmother" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
            
            </c:when>
            <c:when test="${param.title == 'Other'}">
            
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="parent" />
                    <sql:param value="Other" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
            
            </c:when>
            <c:otherwise>
                <c:redirect url="/control/logout.jsp" />
                <!-- send bug to staff -->
            </c:otherwise>
        </c:choose>
    
    </c:when>
    <c:when test="${param.type == 'other'}">
    
        <c:choose>
            <c:when test="${param.title == 'Friend'}">
            
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="other" />
                    <sql:param value="Friend" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
            
            </c:when>
            <c:when test="${param.title == 'Girlfriend'}">
            
                <c:if test="${gender == 'Male'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="other" />
                    <sql:param value="Boyfriend" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
                <c:if test="${gender == 'Female'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="other" />
                    <sql:param value="Girlfriend" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
            
            </c:when>
            <c:when test="${param.title == 'Boyfriend'}">
            
                <c:if test="${gender == 'Male'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="other" />
                    <sql:param value="Boyfriend" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
                <c:if test="${gender == 'Female'}">
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="other" />
                    <sql:param value="Girlfriend" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
                </c:if>
            
            </c:when>
            <c:when test="${param.title == 'Other'}">
            
                <sql:update>
                    Insert Into Links (Type, Title, PeopleID, FamilyID) Values (?,?,?,?)
                    <sql:param value="other" />
                    <sql:param value="Other" />
                    <sql:param value="${familyID}" />
                    <sql:param value="${param.peopleID}" />
                </sql:update>
            
            </c:when>
            <c:otherwise>
                <c:redirect url="/control/logout.jsp" />
                <!-- send bug to staff -->
            </c:otherwise>
        </c:choose>
    
    </c:when>
    <c:otherwise>
        <c:redirect url="/control/logout.jsp" />
        <!-- send bug to staff -->
    </c:otherwise>
</c:choose>

<c:redirect url="/people.jsp">
    <c:param name="treeID" value="${param.treeID}" />
    <c:param name="name" value="${param.name}" />
    <c:param name="peopleID" value="${param.peopleID}" />
    <c:param name="ref" value="${param.ref}" />
    <c:param name="other" value="${param.other}" />
    <c:param name="accountOwner" value="${param.accountOwner}" />
    <c:param name="emailo" value="${param.emailo}" />
</c:redirect>
