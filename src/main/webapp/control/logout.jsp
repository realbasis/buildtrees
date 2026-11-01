<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="/error.jsp?debug=log" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@include file="/control/stdTags.jspf" %>

<c:remove var="accountID" scope="session" />
<c:remove var="flag" scope="session" />
<c:set var="flag" value="0" />
<%
		session.invalidate();
%>
<c:choose>
<c:when test="${param.errors == null || param.errors == ''}">
    <c:redirect url="/login.jsp" >
        <c:param name="errors" value="Logged out!" />
    </c:redirect>
</c:when>
<c:otherwise>
    <c:redirect url="/login.jsp" >
        <c:param name="errors" value="${param.errors}" />
    </c:redirect>
</c:otherwise>
</c:choose>