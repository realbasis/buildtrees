<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<!-- update account parameters -->
    <sql:update>
        Update Viewers Set
            Status = ?
        Where ViewerID = ?
        <sql:param value="${param.status}" />
        <sql:param value="${param.viewerID}" />
    </sql:update>
    
<!-- look for members owned by account (only for pending requests) -->
    <c:if test="${param.accountIDg > 0 && param.ref == 1}">
        <sql:query var="result">
            Select * from People Where (TreeID = ? And AccountID = ?)
            <sql:param value="${param.treeID}" />
            <sql:param value="${param.accountIDg}" />
        </sql:query>

<%
try {
%>
    <mt:mail from="buildtrees@realbasis.com" to="${param.guestEmail}" bcc="buildtrees@realbasis.com" 
            server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456" 
			subject="Welcome to family tree ${param.treeName}">

	${myname} (${myemail}) has accepted your request 
	to join family tree ${param.treeName}.
	
	Simply log into your account at "http://www.buildtrees.com"
	in order to navigate family tree ${param.treeName}.
   
   Thanks,
   BuildTrees Staff.

    </mt:mail>
<%
}
catch (Exception e){
    %>
        <mt:mail from="buildtrees@realbasis.com" subject="Failure of Email Approval" 
            to="support@realbasis.com" server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456">

    -- Email approval by ${myemail} to join tree forwarded to ${param.accountName} (${param.ownerEmail}) has failed 
    -- Email sender: ${fn:escapeXml(myemail)}
    -- Account of Sender: ${accountID}
    -- Account of Recipient: ${param.accountIDg}
    
        </mt:mail>
    <%
}
%>

        <c:if test="${result.rowCount == 0}">
            <c:redirect url="/defmember.jsp">
                <c:param name="ref" value="1" />
                <c:param name="treeID" value="${param.treeID}" />
                <c:param name="accountIDg" value="${param.accountIDg}" />
                <c:param name="accountName" value="${param.accountName}" />
            </c:redirect>
        </c:if>
		
    </c:if>
    
    <c:redirect url="/mytree.jsp">
        <c:param name="ref" value="1" />
        <c:param name="treeID" value="${param.treeID}" />
    </c:redirect>
    