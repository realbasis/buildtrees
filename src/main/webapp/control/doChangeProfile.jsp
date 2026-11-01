<%@page contentType="text/html" errorPage=""%>
<%@page pageEncoding="UTF-8"%>

<%@page import="java.util.LinkedList,java.util.SortedMap,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>

<%@include file="/control/stdTags.jspf" %>

<jsp:useBean id="treeLogicBean" class="utility.TreeLogicBean" />

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<%

TreeBean treeBean = (TreeBean) session.getAttribute("treeBean");
Integer id = new Integer(request.getParameter("id"));

TreeMap familyByPeopleMap = treeBean.getFambypeople();
TreeMap tMap = (TreeMap) familyByPeopleMap.get(id);
treeBean.setMe(tMap);

// Recreate tree
treeBean = treeLogicBean.createTree(treeBean);

%>

<c:if test="${param.out == null}">
    <c:redirect url="/zmain.jsp" />
</c:if>

<c:redirect url="${param.out}" />