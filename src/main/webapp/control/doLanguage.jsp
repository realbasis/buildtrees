<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<c:if test="${param.language == null}">
    <mt:mail from="buildtrees@realbasis.com" to="support@realbasis.com" 
            server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456" 
			subject="BuildTrees Error: param.language">

	File: doLanguage.jsp.  Error in parameters.  Javascript disabled.
	
    </mt:mail>
	
	<c:if test="${param.theURL == null}">
		<c:redirect url="/index.jsp" />
	</c:if>
	<c:redirect url="${param.theURL}" />
	
</c:if>

<jsp:setProperty name="languageBean" property="language" value="${param.language}"/>

<c:redirect url="${param.theURL}" />
<c:redirect url="/index.jsp" />
