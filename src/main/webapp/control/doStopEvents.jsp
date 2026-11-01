<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@include file="/control/stdTags.jspf" %>

<c:if test="${logged == null || logged != true}">
    <c:redirect url="/control/doLogoutOwner.jsp">
        <c:param name="errors" value="invalid user!"/>
    </c:redirect>
</c:if>

<c:if test="${scheduleBean.canceled}"></c:if>

<c:redirect url="/admin.jsp"/>