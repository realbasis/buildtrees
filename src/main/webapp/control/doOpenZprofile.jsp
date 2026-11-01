<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<jsp:useBean id="profileBean" class="utility.ProfileBean" />
<jsp:useBean id="peopleBean" class="value.PeopleBean" />

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<jsp:setProperty name="peopleBean" property="peopleID" value="${param.peopleID}" />
<jsp:setProperty name="profileBean" property="peopleBean" value="${peopleBean}" />

<jsp:setProperty name="profileBean" property="treeBean" value="${treeBean}" />

<c:if test="${profileBean.processed == false}"></c:if>
    
<!-- update tree values -->
<c:remove var="treeBean" scope="session"/>
<c:set var="treeBean" value="${profileBean.treeBean}" scope="session" />

<c:redirect url="/zprofile.jsp" />


