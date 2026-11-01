<%@page contentType="text/html" errorPage=""%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<jsp:useBean id="now" class="java.util.Date" />
<jsp:useBean id="mailerBean" class="value.MailerBean" />

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<c:if test="${param.todo == 'Cancel'}">
	<c:redirect url="/zmembers.jsp" />
</c:if>

<c:if test="${param.name == ''}">
	<c:redirect url="/zmembers.jsp">
    	<c:param name="search" value="no" />
		<c:param name="email" value="${param.email}"/>
        <c:param name="required" value=" * required *"/>
    </c:redirect>
</c:if>

<%
try {
%>
        <mt:mail from="buildtrees@realbasis.com" subject="Let's build our family tree" 
            bcc="support@realbasis.com" to="${param.email}" cc="${myemail}" 
            server="${mailerBean.smtp}" port="${mailerBean.port}" 
			username="${mailerBean.username}" password="${mailerBean.password}">

Dear ${param.name},

${myname} is inviting you to signup on Buildtreees (www.buildtrees.com) so you can collaborate on the family tree.

Buildtrees is an online family tree builder where family members can collaborate over the internet.  Furthermore, family events can be scheduled and sent to family members within a few clicks.

Note, however, that this is not another social networking website.  Instead, it is a tool that allows you to discover your family and connect with it by taking advantage of the power of the internet.

At last, we advise you to contact ${myname} in order to share specifics about the way the family tree has been constructed up to now.

Regards, Lamine.
BuildTrees Staff.

        </mt:mail>

<%
}
catch (Exception e){
    %>
	<c:redirect url="/zmembers.jsp">
    	<c:param name="search" value="invalid" />
    </c:redirect>
    <%
}
%>

<sql:query var="ans">
	Select * from Sollicitations Where Email = ? And Status = ?
        <sql:param value="${param.email}" />
        <sql:param value="1" />
</sql:query>
        
<c:if test="${ans.rowCount == 0}">
    <sql:update>
        Insert Into Sollicitations (Email, FromAID, Stamp) Values (?,?,?)
        <sql:param value="${param.email}" />
        <sql:param value="${accountID}" />
        <sql:dateParam value="${now}" />
    </sql:update>
</c:if>

<c:redirect url="/zmembers.jsp">
   	<c:param name="search" value="done" />
</c:redirect>
