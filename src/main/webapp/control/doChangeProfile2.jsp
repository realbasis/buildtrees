<%@page contentType="text/html" errorPage=""%>
<%@page pageEncoding="UTF-8"%>

<%@page import="java.util.LinkedList,java.util.SortedMap,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>

<%@include file="/control/stdTags.jspf" %>

<jsp:useBean id="treeLogicBean" class="utility.TreeLogicBean" />
<jsp:useBean id="btrBean" class="utility.BuildTreeBean" />

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<jsp:setProperty name="treeBean" property="peopleID" value="${param.id}" />
<jsp:setProperty name="btrBean" property="treeBean" value="${treeBean}" />
<c:if test="${btrBean.profileChanged == true}"></c:if>

<c:remove var="treeBean" scope="session" />
<c:set var="treeBean" value="${btrBean.treeBean}" scope="session" />

<c:if test="${param.out == null}">
    <c:redirect url="/zmain.jsp" />
</c:if>

<c:redirect url="${param.out}" />