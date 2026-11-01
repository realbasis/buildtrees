<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<!-- create notification -->
<sql:update>
    Insert Into Viewers (TreeID, AccountIDo, AccountIDg, Status) Values (?,?,?,?)
    <sql:param value="${param.treeID}" />
    <sql:param value="${param.accountIDo}" />
    <sql:param value="${param.accountIDg}" />
    <sql:param value="Pending" />
</sql:update>

<!-- send email -->
<sql:query var="treequery">
    Select * From Accounts Where AccountID = ?
    <sql:param value="${param.accountIDo}"/>
</sql:query>
<%
try {
%>
    <mt:mail from="buildtrees@realbasis.com" to="${param.ownerEmail}" bcc="buildtrees@realbasis.com" 
            server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456" 
			subject="${myname} wants to join your family tree">

   You have received a request by ${myname} (${myemail}) to join one of your family trees.
   Please log into your buildtrees account at "http://www.buildtrees.com/".
   Then accept or deny ${myname} request.
   
   Thanks,
   BuildTrees Staff.

    </mt:mail>
<%
}
catch (Exception e){
    %>
        <mt:mail from="buildtrees@realbasis.com" subject="Failure of Email Request" 
            to="support@realbasis.com" 
			server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456">

    -- Email request by ${myemail} to join tree forwarded to ${param.ownerEmail} has failed 
    -- Email sender: ${fn:escapeXml(myemail)}
    -- Account of Sender: ${param.accountIDg}
    -- Account of Recipient: ${param.accountIDo}
    
        </mt:mail>
    <%
}
%>

<c:redirect url="/search.jsp">
    <c:param name="ref" value="3" />
</c:redirect>
