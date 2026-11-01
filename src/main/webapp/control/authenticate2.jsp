<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>

<%
    /*** Preventin<c:setg Caching of Pages ***/
    response.addHeader("Pragma", "no-cache");
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.addHeader("Cache-Control", "pre-check=0, post-check=0");
    response.setDateHeader("Expires", 0);
%>

<%@include file="/control/stdTags.jspf" %>

<jsp:useBean id="treeBean" class="value.TreeBean" scope="session" />
<jsp:useBean id="treeLogicBean" class="utility.TreeLogicBean" />

<jsp:useBean id="authBean" class="utility.AuthBean" />
<jsp:useBean id="accountBean" class="value.AccountBean" />

<c:if test="${param.goodBrowser == null || param.goodBrowser != true}">
    <c:redirect url="/index.jsp">
        <c:param name="email" value="${param.email}" />
        <c:param name="errors" value="Login disabled by browser" />
    </c:redirect>
</c:if>

<jsp:setProperty name="accountBean" property="email" value="${param.email}" />
<jsp:setProperty name="accountBean" property="password" value="${param.password}" />
<jsp:setProperty name="authBean" property="accountBean" value="${accountBean}" />
<jsp:setProperty name="authBean" property="treeBean" value="${treeBean}" />

<c:choose>
    <c:when test="${authBean.authed == false}">
        <c:redirect url="/index.jsp">
            <c:param name="email" value="${param.email}" />
            <c:param name="errors" value="${authBean.errors}" />
        </c:redirect>
    </c:when>
    <c:otherwise>
        <c:set var="accountID" value="${authBean.accountBean.accountID}" scope="session" />
        <c:set var="myemail" value="${authBean.accountBean.email}" scope="session" />
        <c:set var="myname" value="${authBean.accountBean.name}" scope="session" />
        <c:set var="notifyMe" value="${authBean.accountBean.notify}" scope="session" />
        
        <fmt:setLocale value="en_US" scope="session"/>
        <fmt:setTimeZone value="US/Eastern" scope="session"/>
        <c:set var="links" value="null" scope="session" />
        <c:set var="flag" value="7" scope="session" />

        <c:remove var="treeBean" scope="session" />
        <c:set var="treeBean" value="${authBean.treeBean}" scope="session" />
        <c:set var="ownerPid" value="${treeBean.owner.PeopleID}" scope="session" />
	       
        <%-- Set Session Span --%>
        <%
            session.setMaxInactiveInterval(1800); 
        %>
        
    </c:otherwise>
</c:choose>

<c:redirect url="/zmain.jsp" />
