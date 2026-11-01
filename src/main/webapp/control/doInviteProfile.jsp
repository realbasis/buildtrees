<%@page contentType="text/html" errorPage=""%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>
<jsp:useBean id="now" class="java.util.Date" />
<jsp:useBean id="sharersBean" class="value.SharersBean" />
<jsp:useBean id="doSharersBean" class="utility.DoSharersBean" />

<jsp:setProperty name="sharersBean" property="myAccountID" value="${accountID}" />
<jsp:setProperty name="sharersBean" property="accountID" value="${param.guestID}" />
<jsp:setProperty name="sharersBean" property="status" value="0" />

<jsp:setProperty name="doSharersBean" property="sharersBean" value="${sharersBean}" />

<sql:update>
	Insert Into Sharers (MyAccountID, AccountID, Status) Values (?,?,?)
    <sql:param value="${sharersBean.myAccountID}" />
    <sql:param value="${sharersBean.accountID}" />
    <sql:param value="1" />
</sql:update>

<sql:update>
	Insert Into Sharers (MyAccountID, AccountID, Status) Values (?,?,?)
	<sql:param value="${sharersBean.accountID}" />
    <sql:param value="${sharersBean.myAccountID}" />
    <sql:param value="0" />
</sql:update>

<c:choose>
	<c:when test="${true}">

<%
try {
%>
    	<mt:mail from="buildtrees@realbasis.com" to="${param.email}" bcc="buildtrees@realbasis.com" 
            subject="help me build my family tree"
            server="smtp.embarqmail.com" port="587" 
			username="tba@embarqmail.com" password="123456"> 

    Dear ${param.guestname},
    
${myname} would like to connect with you so you can build your family tree together.
Simply log into your BuildTrees account at "http://www.buildtrees.com", click on Members (top menu), and accept ${myname} invitation to join the tree.

BuildTrees.com
    
	    </mt:mail>
<%
}
catch (Exception e){}
%>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>

<c:redirect url="/zmembers.jsp">
	<c:param name="search" value="invited" />
	<c:param name="guestID" value="${param.guestID}"/>
	<c:param name="email" value="${param.email}"/>
</c:redirect>
