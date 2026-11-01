<%@page contentType="text/html" errorPage=""%>
<%@page pageEncoding="UTF-8"%>

<%@page import="java.util.LinkedList,java.util.SortedMap,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>

<%@include file="stdTags.jspf" %>

<jsp:useBean id="treeLogicBean" class="utility.TreeLogicBean" />

<sql:update>
    Delete From Zevents Where EventID = ?
    <sql:param value="${param.id}" />
</sql:update>

<%

boolean success = true;

ConnBean connBean = null;
SortedMap maps[] = null;
SortedMap map = null;


TreeBean treeBean = (TreeBean) session.getAttribute("treeBean");
Integer accountID = (Integer) session.getAttribute("accountID");

connBean = new ConnBean();
success = connBean.isStarted();

success = treeLogicBean.createEvents(accountID, treeBean.getSharers());
maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
treeBean.setEventsMap(maps);

// Warn sharers
success = treeLogicBean.warnSharers(treeBean.getSharers(), new Integer(2));
success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());

success = connBean.isClosed();

%>

<c:redirect url="/events.jsp">
	<c:param name="ans" value="EVENT DELETED!" />
</c:redirect>
