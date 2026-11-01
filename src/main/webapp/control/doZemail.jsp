<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<c:if test="${param.retour == 'CANCEL'}">
    <c:redirect url="/zmain.jsp" />
</c:if>

<c:if test="${param.subject == ''}">
    <c:redirect url="/zemail.jsp">
        <c:param name="errors" value="subject of email cannot be empty!" />
        <c:param name="email" value="${param.email}" />
        <c:param name="name" value="${param.name}" />
		<c:param name="isProfile" value="${param.isProfile}" />
    </c:redirect>
</c:if>

<c:if test="${param.body == ''}">
    <c:redirect url="/zemail.jsp">
        <c:param name="errors" value="content of email cannot be empty!" />
        <c:param name="email" value="${param.email}" />
        <c:param name="name" value="${param.name}" />
		<c:param name="isProfile" value="${param.isProfile}" />
    </c:redirect>
</c:if>

<c:if test="${param.isProfile == 'no'}">
	<c:set var="msg1" value="Click below to build your tree:" />
	<c:set var="msg2" value="  [http://www.buildtrees.com/signup.jsp?email=${param.email}]" />
</c:if>

<%
try {
%>
<mt:mail from="${myemail}" subject="${param.subject}" 
    to="${param.email}" bcc="buildtrees@realbasis.com" server="smtp.embarqmail.com" port="587" 
    username="tba@embarqmail.com" password="123456">
${param.body}

${msg1}
${msg2}

-- sent from www.BuildTrees.Com - Mankind Connected.
</mt:mail>

<%
}
catch (Exception e){
    %>
     <c:redirect url="/zemail.jsp">
        <c:param name="errors" value="email server is temporarily down" />
        <c:param name="email" value="${param.email}" />
        <c:param name="name" value="${param.name}" />
		<c:param name="isProfile" value="${param.isProfile}" />
    </c:redirect>
    <%
}
%>

<c:redirect url="/zemail.jsp">
    <c:param name="email" value="${param.email}" />
    <c:param name="name" value="${param.name}" />
	<c:param name="done" value="true" />
</c:redirect>