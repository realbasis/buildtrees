<%@page contentType="text/html" errorPage=""%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<jsp:useBean id="now" class="java.util.Date" />
<jsp:useBean id="nodeBean" class="utility.NodeBean" />
<jsp:useBean id="peopleBean" class="value.PeopleBean" />
<jsp:useBean id="btrBean" class="utility.BuildTreeBean" />

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

        <c:if test="${param.email == ''}">
            <c:redirect url="/znewprofile.jsp">
                <c:param name="emailErrors" value="*** Please enter email ***" />
				<c:param name="email" value="${param.email}"/>
            </c:redirect>
        </c:if>
		
		<ora:ifValidEmailAddr value="${param.email}" var="isValid" />
	    <c:if test="${!isValid}">
    	    <c:redirect url="/znewprofile.jsp">
                <c:param name="emailErrors" value="*** Email is invalid! ***" />
				<c:param name="email" value="${param.email}"/>
            </c:redirect>
		</c:if>
        
        <jsp:setProperty name="peopleBean" property="peopleID" value="-1" />
        <jsp:setProperty name="peopleBean" property="name" value="${param.name}" />
        <jsp:setProperty name="peopleBean" property="email" value="none" />
        <jsp:setProperty name="peopleBean" property="gotBirthdate" value="${param.gotBirthdate}" />
        <c:set var="birthdate" value="${now}" />
        <c:if test="${param.gotBirthdate == 'on'}">
            <fmt:parseDate var="birthdate" value="${param.birthdate}" pattern="MMM-dd-yyyy" />
        </c:if>
        <jsp:setProperty name="peopleBean" property="birthdate" value="${birthdate}" />
        <jsp:setProperty name="peopleBean" property="isDeceased" value="${param.isDeceased}" />
        <c:set var="deceased" value="${now}" />
        <c:if test="${param.isDeceased == 'on'}">
            <fmt:parseDate var="deceased" value="${param.deceased}" pattern="MMM-dd-yyyy" />
        </c:if>
        <jsp:setProperty name="peopleBean" property="deceased" value="${deceased}" />
        <jsp:setProperty name="peopleBean" property="gender" value="${param.gender}" />
        <jsp:setProperty name="peopleBean" property="accountID" value="${accountID}" />

<jsp:setProperty name="nodeBean" property="treeBean" value="${treeBean}" />
<jsp:setProperty name="nodeBean" property="peopleBean" value="${peopleBean}" />

<!-- create links of person added in both directions -->
<c:if test="${nodeBean.added == false}">
	<c:redirect url="/znewprofile.jsp">
    	<c:param name="errors" value="${nodeBean.errors}" />
    </c:redirect>
</c:if>

<!-- update tree values -->
<c:remove var="treeBean" scope="session"/>
<c:set var="treeBean" value="${nodeBean.treeBean}" scope="session" />

<c:redirect url="/zmain.jsp">
	<c:param name="errors" value="${nodeBean.errors}" />
</c:redirect>