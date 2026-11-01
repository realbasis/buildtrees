<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<c:if test="${param.relationship == null}">
	<c:redirect url="/zmain.jsp" />
</c:if>

<jsp:setProperty name="treeBean" property="param1" value="${param.relationship}" />

<c:redirect url="/znewprofile.jsp">
	<c:param name="np" value="true"/>
</c:redirect>

<c:redirect url="/znewprofile.jsp" />