<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<%@include file="/control/stdTags.jspf" %>

<c:choose>
	<c:when test="${scheduleBean == null}">
		<jsp:useBean id="scheduleBean" class="utility.ScheduleBean" scope="application" />
		<jsp:setProperty name="scheduleBean" property="delay0" value="0" />
		<jsp:setProperty name="scheduleBean" property="lapse" value="24" />
		<c:if test="${scheduleBean.started}"></c:if>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>