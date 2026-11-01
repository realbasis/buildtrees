<%@page contentType="text/html" errorPage="/error.jsp?debug=log" pageEncoding="UTF-8" %>

<%@page import="java.util.LinkedList,java.util.SortedMap,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>

<%@include file="stdTags.jspf" %>

<jsp:useBean id="treeLogicBean" class="utility.TreeLogicBean" />

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<%
// delete links
boolean success = true;

ConnBean connBean = null;
SortedMap maps[] = null;

TreeBean treeBean = (TreeBean) session.getAttribute("treeBean");
Integer accountID = (Integer) session.getAttribute("accountID");
Integer peopleID = new Integer(request.getParameter("peopleID"));

connBean = new ConnBean();
success = connBean.isStarted();

// delete links
SortedMap me = treeBean.getMe();
Integer meID = (Integer) me.get("PeopleID");
success = treeLogicBean.unlinkProfile(meID, peopleID);
success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());

success = treeLogicBean.warnSharers(treeBean.getSharers(), new Integer(2));
success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());

// update family links
success = treeLogicBean.createLinks(accountID, treeBean.getSharers());
maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
treeBean.setLinks(maps);

success = connBean.isClosed();

// Recreate tree
treeBean = treeLogicBean.createTree(treeBean);

%>

<!-- update links -->
<c:if test="<%=success%>">
    <c:redirect url="/zmain.jsp" />
</c:if>

<c:redirect url="/control/logout.jsp" >
    <c:param name="errors" value="unexpected error." />
</c:redirect>
