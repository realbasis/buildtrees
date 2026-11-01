<%@page contentType="text/html" errorPage=""%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<jsp:useBean id="nodeBean" class="utility.NodeBean" />
<jsp:useBean id="peopleBean" class="value.PeopleBean" />

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<%




%>

<c:choose>
	<c:when test="${param.reaction == 'confirm'}">
<%




%>
		<sql:update>
			update Sharers set Status=? where 
			(MyAccountID=? and AccountID=?) or (AccountID=? and MyAccountID=?)
			<sql:param value="2" />
        	    	<sql:param value="${accountID}" />
                        <sql:param value="${param.guestID}" />
			<sql:param value="${accountID}" />
                        <sql:param value="${param.guestID}" />
		</sql:update>
		
		<!-- update tree -->
		<jsp:setProperty name="peopleBean" property="accountID" value="${accountID}" />
		<jsp:setProperty name="peopleBean" property="email" value="${myemail}" />
		<jsp:setProperty name="nodeBean" property="peopleBean" value="${peopleBean}" />
		<jsp:setProperty name="nodeBean" property="treeBean" value="${treeBean}" />
		
		<c:if test="${nodeBean.sharersChanged == true}"></c:if>
		
		<c:remove var="treeBean" scope="session" />
        <c:set var="treeBean" value="${nodeBean.treeBean}" scope="session" />
        <c:set var="ownerPid" value="${treeBean.owner.PeopleID}" scope="session" />

		<sql:update>
			update Accounts set Flag=? where AccountID=?
			<sql:param value="1" />
		    <sql:param value="${param.guestID}" />
		</sql:update>
	</c:when>
	<c:when test="${param.reaction == 'deny'}">
		<sql:update>
			delete from Sharers where 
			(MyAccountID=? and AccountID=?) or (MyAccountID=? and AccountID=?)
	    	<sql:param value="${accountID}" />
		    <sql:param value="${param.guestID}" />
			<sql:param value="${param.guestID}" />
			<sql:param value="${accountID}" />
		</sql:update>
	</c:when>
	<c:when test="${param.reaction == 'abandon'}">
		<sql:update>
			delete from Sharers where 
			(MyAccountID=? and AccountID=?) or (AccountID=? and MyAccountID=?)
	    	<sql:param value="${accountID}" />
		    <sql:param value="${param.guestID}" />
			<sql:param value="${accountID}" />
		    <sql:param value="${param.guestID}" />
		</sql:update>
	</c:when>
	<c:when test="${param.reaction == 'disconnect'}">
		<c:if test="${param.guestID == -1}">
			<c:redirect url="/zmembers.jsp" />
		</c:if>
		<sql:update>
			delete from Sharers where 
			(MyAccountID=? and AccountID=?) or (MyAccountID=? and AccountID=?)
	    	<sql:param value="${accountID}" />
		    <sql:param value="${param.guestID}" />
			<sql:param value="${param.guestID}" />
			<sql:param value="${accountID}" />
		</sql:update>
		
		<!-- delete links -->
		<sql:update>
			delete from Zlinks where 
			(AccountID=? and OtherID=?) or (AccountID=? and OtherID=?)
	    	<sql:param value="${accountID}" />
		    <sql:param value="${param.guestID}" />
			<sql:param value="${param.guestID}" />
			<sql:param value="${accountID}" />
		</sql:update>
		
		<!-- update tree -->
		<jsp:setProperty name="peopleBean" property="accountID" value="${accountID}" />
		<jsp:setProperty name="peopleBean" property="email" value="${myemail}" />
		<jsp:setProperty name="nodeBean" property="peopleBean" value="${peopleBean}" />
		<jsp:setProperty name="nodeBean" property="treeBean" value="${treeBean}" />
		
		<c:if test="${nodeBean.sharersChanged == true}"></c:if>
		
		<c:remove var="treeBean" scope="session" />
        <c:set var="treeBean" value="${nodeBean.treeBean}" scope="session" />
        <c:set var="ownerPid" value="${treeBean.owner.PeopleID}" scope="session" />

		<sql:update>
			update Accounts set Flag=? where AccountID=?
			<sql:param value="1" />
		    <sql:param value="${param.guestID}" />
		</sql:update>
		
	</c:when>
	<c:otherwise>
		<c:redirect url="/control/logout.jsp">
			<c:param name="errors" value="Unexpected error." />
		</c:redirect>
	</c:otherwise>
</c:choose>

<c:redirect url="/zmembers.jsp" />