<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<jsp:useBean id="now" class="java.util.Date" />
<jsp:useBean id="nodeBean" class="utility.NodeBean" />
<jsp:useBean id="peopleBean" class="value.PeopleBean" />

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<c:if test="${param.retour == 'Cancel'}">
    <c:redirect url="/zmain.jsp" />
</c:if>

<c:if test="${param.name == ''}">
	<c:redirect url="/zprofile.jsp">
		<c:param name="errors" value="*** Full Name is missing ***" />
    </c:redirect>
</c:if>

<jsp:setProperty name="nodeBean" property="treeBean" value="${treeBean}" />

<jsp:setProperty name="peopleBean" property="peopleID" value="${treeBean.it.peopleID}" />
<jsp:setProperty name="peopleBean" property="title" value="${treeBean.it.Title}" />

<jsp:setProperty name="peopleBean" property="name" value="${param.name}" />
<jsp:setProperty name="peopleBean" property="email" value="${param.email}" />
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
<jsp:setProperty name="peopleBean" property="accountID" value="${treeBean.it.AccountID}" />

<jsp:setProperty name="nodeBean" property="peopleBean" value="${peopleBean}" />

<c:if test="${nodeBean.saved == false}">
	<c:redirect url="/zprofile.jsp">
    	<c:param name="errors" value="${nodeBean.errors}" />
    </c:redirect>
</c:if>
    
<!-- update tree values -->
<c:remove var="treeBean" scope="session"/>
<c:set var="treeBean" value="${nodeBean.treeBean}" scope="session" />

<c:redirect url="/zmain.jsp" />
