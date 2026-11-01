<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<!-- delete invitation -->
<sql:update>
    Delete From Invitations Where InviteID = ?
    <sql:param value="${param.inviteID}" />
</sql:update>

<sql:query var="result">
    Select Accounts.* from Trees, Accounts Where Trees.TreeID = ? 
    And Accounts.AccountID = Trees.AccountID
    <sql:param value="${param.treeID}" />
</sql:query>

<c:forEach items="${result.rows}" var="row">
    <c:set var="emailo" value="${row.Email}"/>
    <c:set var="accountIDo" value="${row.AccountID}"/>
</c:forEach>

<c:if test="${param.type == 'decline'}">
    <!-- notify owner via email -->
<c:if test="${true}">
<%
try {
%>
    <mt:mail from="buildtrees@realbasis.com" to="${emailo}" bcc="buildtrees@realbasis.com" 
            server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456" 
			subject="BuildTrees Invitation Status">

   ${myname} has decined your invitation to join your family tree ${param.treeName}.
   
   Thanks,
   BuildTrees Staff.

    </mt:mail>

<%
}
catch (Exception e){
    %>
        <mt:mail from="buildtrees@realbasis.com" subject="Failure of Invitation Notification" 
            to="support@realbasis.com" 
			server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456">

    -- Email recipient: ${fn:escapeXml(myemail)}
    -- Account of Sender: ${accountID}
    
        </mt:mail>
    <%
}
%>
</c:if>    

</c:if>

<c:if test="${param.type == 'accept'}">
    <!-- create guest transaction -->
    <sql:update>
        Insert Into Viewers (TreeID, AccountIDo, AccountIDg, Status) Values (?,?,?,?)
        <sql:param value="${param.treeID}" />
        <sql:param value="${accountIDo}" />
        <sql:param value="${accountID}" />
        <sql:param value="Accepted" />
    </sql:update>
    
    <!-- notify owner via email -->
<c:if test="${true}">
<%
try {
%>
    <mt:mail from="buildtrees@realbasis.com" to="${emailo}" bcc="buildtrees@realbasis.com" 
            server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456" 
			subject="BuildTrees Invitation Status">

   ${myname} has accepted your invitation to join your family tree ${param.treeName}.
   
   Thanks,
   BuildTrees Staff.

    </mt:mail>

<%
}
catch (Exception e){
    %>
        <mt:mail from="buildtrees@realbasis.com" subject="Failure of Invitation Notification" 
            to="support@realbasis.com" 
			server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456">

    -- Email recipient: ${fn:escapeXml(myemail)}
    -- Account of Sender: ${accountID}
    
        </mt:mail>
    <%
}
%>
</c:if>
    
</c:if>

<c:redirect url="/main.jsp"/>
