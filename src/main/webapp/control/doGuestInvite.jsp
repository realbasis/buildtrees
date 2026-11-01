<%@page contentType="text/html" errorPage=""%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>
<jsp:useBean id="now" class="java.util.Date" />

<c:if test="${param.guestname == ''}">
    <c:redirect url="/invite.jsp">
        <c:param name="errors" value="guest name is a required field!" />
        <c:param name="treeID" value="${param.treeID}" />
        <c:param name="ref" value="5" />
        <c:param name="email" value="${param.email}" />
        <c:param name="body" value="${param.body}" />
        <c:param name="guestname" value="${param.guestname}" />
        <c:param name="name" value="${param.name}"/>
        <c:param name="other" value="${param.other}" />
        <c:param name="emailo" value="${param.emailo}" />
	<c:param name="accountOwner" value="${param.accountOwner}" />
    </c:redirect>
</c:if>

<ora:ifValidEmailAddr value="${param.email}" var="isValid" />
<c:if test="${!isValid}">
    <c:redirect url="/invite.jsp">
        <c:param name="errors" value="please enter valid email!" />
        <c:param name="treeID" value="${param.treeID}" />
        <c:param name="ref" value="5" />
        <c:param name="email" value="${param.email}" />
        <c:param name="body" value="${param.body}" />
        <c:param name="guestname" value="${param.guestname}" />
	<c:param name="other" value="${param.other}" />
	<c:param name="name" value="${param.name}"/>
	<c:param name="emailo" value="${param.emailo}" />
	<c:param name="accountOwner" value="${param.accountOwner}" />
    </c:redirect>
</c:if>

<!-- check if guest has an account on buildtrees -->
<sql:query var="result">
    Select * from Accounts Where Email = ?
    <sql:param value="${param.email}" />
</sql:query>
<c:if test="${result.rowCount > 1}">
    <!-- error in program -->
    <mt:mail from="buildtrees@realbasis.com" subject="Duplicate email in database" 
            to="support@realbasis.com" 
			server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456">

    ${param.email} is a duplicate field in the database.
    
    Buildtrees staff.
    
    </mt:mail>
</c:if>
<c:if test="${result.rowCount == 1}">
    <!-- guest has an account in buildtrees, now check if guest has already joined tree -->
    <c:forEach items="${result.rows}" var="row">
        <c:set var="accountIDg" value="${row.AccountID}"/>
    </c:forEach>
    <sql:query var="result2">
        Select * from Viewers Where TreeID = ? And AccountIDg = ? And AccountIDo = ?
        <sql:param value="${param.treeID}" />
        <sql:param value="${accountIDg}" />
        <sql:param value="${accountID}" />
    </sql:query>
    <c:if test="${result2.rowCount > 0}">
        <c:redirect url="/invite.jsp">
            <c:param name="errors" value="this guest has already joined your tree!" />
            <c:param name="treeID" value="${param.treeID}" />
            <c:param name="ref" value="5" />
            <c:param name="email" value="${param.email}" />
            <c:param name="body" value="${param.body}" />
            <c:param name="guestname" value="${param.guestname}" />
            <c:param name="other" value="${param.other}" />
            <c:param name="name" value="${param.name}"/>
            <c:param name="emailo" value="${param.emailo}" />
            <c:param name="accountOwner" value="${param.accountOwner}" />
        </c:redirect>
    </c:if>
    
    <c:if test="${result2.rowCount == 0}">
        <!-- check if guest has already been invited -->
        <sql:query var="result3">
            Select * from Invitations Where Emailg = ? And TreeID = ?
            <sql:param value="${param.email}" />
            <sql:param value="${param.treeID}" />
        </sql:query>
        <c:if test="${result3.rowCount > 0}">
            <c:redirect url="/invite.jsp">
                <c:param name="errors" value="this guest has already been invited!" />
                <c:param name="treeID" value="${param.treeID}" />
                <c:param name="ref" value="5" />
                <c:param name="email" value="${param.email}" />
                <c:param name="body" value="${param.body}" />
                <c:param name="guestname" value="${param.guestname}" />
                <c:param name="other" value="${param.other}" />
                <c:param name="name" value="${param.name}"/>
                <c:param name="emailo" value="${param.emailo}" />
                <c:param name="accountOwner" value="${param.accountOwner}" />
            </c:redirect>
        </c:if>
        <c:if test="${result3.rowCount == 0}">
            <!-- case brand new invitation -->
            <sql:update>
                Insert Into Invitations (Emailg, AccountNameo, TreeName, TreeID, DateStamp) 
                Values (?,?,?,?,?)
                <sql:param value="${param.email}" />
                <sql:param value="${myname}" />
                <sql:param value="${param.name}" />
                <sql:param value="${param.treeID}" />
                <sql:dateParam value="${now}" />
            </sql:update>
            
            <!-- email invitation -->
<%
try {
%>
    
<c:if test="${true}">
            <mt:mail from="${myemail}" to="${param.email}" bcc="buildtrees@realbasis.com" 
            subject="help me build my family tree ${param.name}"
            server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456"> 

    Dear ${param.guestname},
    
I invite you to join and help me build my family tree ${param.name}.
Simply log into your BuildTrees account at "http://www.buildtrees.com"
and accept my invitation.

Thanks,
${myname}.			

PS:
${param.body}
    
            </mt:mail>
        </c:if>
            <c:redirect url="/invite.jsp">
                <c:param name="errors" value="the invitation has been sent successfully!" />
                <c:param name="treeID" value="${param.treeID}" />
                <c:param name="ref" value="5" />
                <c:param name="other" value="${param.other}" />
                <c:param name="name" value="${param.name}"/>
                <c:param name="emailo" value="${param.emailo}" />
                <c:param name="accountOwner" value="${param.accountOwner}" />
            </c:redirect>
<%
}
catch (Exception e){
    %>

        <mt:mail from="buildtrees@realbasis.com" subject="Invitation Failure" to="support@realbasis.com" 
        server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456">

    -- Email invitation forwarded to ${param.email} has failed 
    -- Name: ${fn:escapeXml(param.guestname)}
    
        </mt:mail>
        
            <c:redirect url="/invite.jsp">
                <c:param name="errors" value="the invitation has not been sent: unexpected error" />
                <c:param name="treeID" value="${param.treeID}" />
                <c:param name="ref" value="5" />
                <c:param name="email" value="${param.email}" />
                <c:param name="body" value="${param.body}" />
                <c:param name="guestname" value="${param.guestname}" />
                <c:param name="other" value="${param.other}" />
                <c:param name="name" value="${param.name}"/>
                <c:param name="emailo" value="${param.emailo}" />
                <c:param name="accountOwner" value="${param.accountOwner}" />
            </c:redirect>
    <%
}
%>

            
        </c:if>
    </c:if>
</c:if>

<!-- guest does not have an account in buildtrees -->
<c:if test="${result.rowCount == 0}">
    <!-- check if guest has already been invited -->
        <sql:query var="result3">
            Select * from Invitations Where Emailg = ? And TreeID = ?
            <sql:param value="${param.email}" />
            <sql:param value="${param.treeID}" />
        </sql:query>
        <c:if test="${result3.rowCount > 0}">
            <c:redirect url="/invite.jsp">
                <c:param name="errors" value="this guest has already been invited!" />
                <c:param name="treeID" value="${param.treeID}" />
                <c:param name="ref" value="5" />
                <c:param name="email" value="${param.email}" />
                <c:param name="body" value="${param.body}" />
                <c:param name="guestname" value="${param.guestname}" />
                <c:param name="other" value="${param.other}" />
                <c:param name="name" value="${param.name}"/>
                <c:param name="emailo" value="${param.emailo}" />
                <c:param name="accountOwner" value="${param.accountOwner}" />
            </c:redirect>
        </c:if>
        <c:if test="${result3.rowCount == 0}">
            <!-- case brand new invitation -->
            <sql:update>
                Insert Into Invitations (Emailg, AccountNameo, TreeName, TreeID, DateStamp) 
                Values (?,?,?,?,?)
                <sql:param value="${param.email}" />
                <sql:param value="${myname}" />
                <sql:param value="${param.name}" />
                <sql:param value="${param.treeID}" />
                <sql:dateParam value="${now}" />
            </sql:update>
            
            <!-- email invitation -->
<%
try {
%>
    
<c:if test="${true}">
            <mt:mail from="${myemail}" to="${param.email}" bcc="buildtrees@realbasis.com" 
            subject="help me build my family tree ${param.name}" 
			server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456"> 

    Dear ${param.guestname},
    
I invite you to join and help me build my family tree ${param.name}.
Simply signup for a BuildTrees account at "http://www.buildtrees.com/signup.jsp"
and accept my invitation.

Thanks,
${myname}.			

PS:
${param.body}
    
        </mt:mail>
       </c:if>
            <c:redirect url="/invite.jsp">
                <c:param name="errors" value="the invitation has been sent successfully!" />
                <c:param name="treeID" value="${param.treeID}" />
                <c:param name="ref" value="5" />
                <c:param name="other" value="${param.other}" />
                <c:param name="name" value="${param.name}"/>
                <c:param name="emailo" value="${param.emailo}" />
                <c:param name="accountOwner" value="${param.accountOwner}" />
            </c:redirect>
<%
}
catch (Exception e){
    %>

        <mt:mail from="buildtrees@realbasis.com" subject="Invitation Failure" 
            to="support@realbasis.com" 
			server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456">

    -- Email invitation forwarded to ${param.email} has failed 
    -- Name: ${fn:escapeXml(param.guestname)}
    
        </mt:mail>
        
            <c:redirect url="/invite.jsp">
                <c:param name="errors" value="the invitation has not been sent: unexpected error" />
                <c:param name="treeID" value="${param.treeID}" />
                <c:param name="ref" value="5" />
                <c:param name="email" value="${param.email}" />
                <c:param name="body" value="${param.body}" />
                <c:param name="guestname" value="${param.guestname}" />
                <c:param name="other" value="${param.other}" />
                <c:param name="name" value="${param.name}"/>
                <c:param name="emailo" value="${param.emailo}" />
                <c:param name="accountOwner" value="${param.accountOwner}" />
            </c:redirect>
    <%
}
%>

      </c:if>
</c:if>