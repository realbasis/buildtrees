<%@page contentType="text/html" errorPage=""%>
<%@page pageEncoding="UTF-8"%>

<%@include file="/control/stdTags.jspf" %>

<jsp:useBean id="passBean" class="utility.PasswordBean" />
<jsp:setProperty name="passBean" property="accountID" value="${accountID}" />
<jsp:setProperty name="passBean" property="cpass" value="${param.cpass}" />
<jsp:setProperty name="passBean" property="pass1" value="${param.pass1}" />
<jsp:setProperty name="passBean" property="pass2" value="${param.pass2}" />

<c:if test="${passBean.processed == false}"></c:if>

<c:redirect url="/settings.jsp" >
    <c:param name="errors" value="${passBean.errors}" />
</c:redirect>
