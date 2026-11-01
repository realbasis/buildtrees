<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>

<%@page import="java.util.LinkedList,java.util.SortedMap,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>

<%@include file="stdTags.jspf" %>

<jsp:useBean id="alarmDateBean" class="utility.AlarmDateBean" />
<jsp:useBean id="treeLogicBean" class="utility.TreeLogicBean" />

<fmt:parseDate var="eventDate" value="${param.eventDate}" pattern="MMM-dd-yyyy" />
<jsp:setProperty name="alarmDateBean" property="date" value="${eventDate}" />
<jsp:setProperty name="alarmDateBean" property="days" value="${param.alarmDays}" />
<c:if test="${alarmDateBean.processed == false}">
    <c:redirect url="/events.jsp">
	<c:param name="ans" value="${alarmDateBean.errors}" />
    </c:redirect>
</c:if>

<sql:update var="result0">
	Insert Into Zevents 
	(Type, Comment, EventDate, AlarmDate, AlarmDays, AccountID) 
	Values (?,?,?,?,?,?)
    <sql:param value="${param.type}" />
    <sql:param value="${param.comment}" />
    <sql:dateParam value="${eventDate}" />
	<sql:dateParam value="${alarmDateBean.newDate}" />
	<sql:param value="${param.alarmDays}" />
	<sql:param value="${accountID}" />
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
	<c:param name="ans" value="NEW EVENT HAS BEEN ADDED!" />
</c:redirect>
