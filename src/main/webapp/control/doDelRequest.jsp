<%@page contentType="text/html" errorPage="../error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<!-- delete all notifications -->
    <sql:update>
        Delete From Viewers Where ViewerID = ?
        <sql:param value="${param.viewerID}" />
    </sql:update>
    
    <!-- update peoople -->
    <sql:query var="result">
        Select * From People Where TreeID = ? And AccountID = ?
        <sql:param value="${param.treeID}"/>
        <sql:param value="${param.accountIDg}"/>
    </sql:query>
    
    <c:forEach items="${result.rows}" var="row">
        <!-- update people parameters -->
        <sql:update>
            Update People 
            Set
                AccountID = ?
            Where PeopleID = ?
            <sql:param value="-1" />
            <sql:param value="${row.PeopleID}" />
        </sql:update>
    </c:forEach>
	
<%
try {
%>
    <mt:mail from="buildtrees@realbasis.com" to="${param.guestEmail}" bcc="buildtrees@realbasis.com" 
            server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456"	
			subject="Deleted from family tree ${param.treeName}">

	${myname} has deleted your association
	to family tree ${param.treeName}.
	
	Contact ${myname} directly at ${myemail}
	if you have any questions.
   
   Thanks,
   BuildTrees Staff.

    </mt:mail>
<%
}
catch (Exception e){
    %>
        <mt:mail from="buildtrees@realbasis.com" subject="Failure of Email Approval" 
            to="support@realbasis.com" 
			server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456"	>

    -- Email deletion by ${myemail} to join tree forwarded has failed 
    -- Email sender: ${fn:escapeXml(myemail)}
    -- Account of Sender: ${accountID}
    -- Account of Recipient: ${param.accountIDg}
    
        </mt:mail>
    <%
}
%>

    <!-- return -->
    <c:redirect url="/mytree.jsp">
        <c:param name="ref" value="1" />
        <c:param name="treeID" value="${param.treeID}" />
    </c:redirect>
