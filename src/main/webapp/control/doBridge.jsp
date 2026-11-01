<%@page contentType="text/html" errorPage=""%>
<%@page pageEncoding="UTF-8"%>

<%@include file="/control/stdTags.jspf" %>

<jsp:useBean id="btrBean" class="utility.BuildTreeBean" />
<jsp:useBean id="peopleBean" class="value.PeopleBean" />

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<jsp:setProperty name="peopleBean" property="peopleID" value="${param.peopleID}" />
<jsp:setProperty name="peopleBean" property="accountID" value="${accountID}" />

<jsp:setProperty name="btrBean" property="peopleBean" value="${peopleBean}" />
<jsp:setProperty name="btrBean" property="treeBean" value="${treeBean}" />
<c:if test="${btrBean.bridged == true}"></c:if>

<c:remove var="treeBean" scope="session" />
<c:set var="treeBean" value="${btrBean.treeBean}" scope="session" />

<c:redirect url="${btrBean.out}" />