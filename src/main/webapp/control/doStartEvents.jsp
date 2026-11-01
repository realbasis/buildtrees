<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@include file="/control/stdTags.jspf" %>

<c:if test="${logged == null || logged != true}">
    <c:redirect url="/control/doLogoutOwner.jsp">
        <c:param name="errors" value="invalid user!"/>
    </c:redirect>
</c:if>

<c:if test="${param.delay < 0}">
    <c:redirect url="/admin.jsp">
        <c:param name="errors" value="delay value is invalid"/>
    </c:redirect>
</c:if>

<c:if test="${param.lapse < 0}">
    <c:redirect url="/admin.jsp">
        <c:param name="errors" value="lapse value invalid"/>
    </c:redirect>
</c:if>

<jsp:setProperty name="scheduleBean" property="delay0" value="${param.delay}" />
<jsp:setProperty name="scheduleBean" property="lapse" value="${param.lapse}" />
<c:if test="${scheduleBean.started}"></c:if>

<c:redirect url="/admin.jsp"/>