<%@page contentType="text/html" errorPage=""%>
<%@page pageEncoding="UTF-8"%>

<%@page import="java.util.LinkedList,java.util.SortedMap,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>

<%@include file="stdTags.jspf" %>

<jsp:useBean id="now" class="java.util.Date" />
<jsp:useBean id="treeLogicBean" class="utility.TreeLogicBean" />

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<c:if test="${param.retour == 'cancel'}">
    <c:redirect url="/zmain.jsp" />
</c:if>

<!-- case person does exist, create links -->
<%
boolean success = true;

ConnBean connBean = null;
SortedMap maps[] = null;
SortedMap map = null;

TreeMap selfMap = null;
TreeMap elseMap = null;
String linkType = null;
Integer elseID = null;
Integer accountID = null;

TreeBean treeBean = (TreeBean) session.getAttribute("treeBean");
linkType = request.getParameter("linkType");
elseID = new Integer(request.getParameter("peopleID"));
accountID = (Integer) session.getAttribute("accountID");

connBean = new ConnBean();
success = connBean.isStarted();

selfMap = treeBean.getMe();
elseMap = (TreeMap) treeBean.getFambypeople().get(elseID);

success = treeLogicBean.linkProfile(selfMap, elseMap, linkType);
success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());

// reverse link
String revLinkType = treeLogicBean.reverseLink(selfMap, linkType);
success = treeLogicBean.linkProfile(elseMap, selfMap, revLinkType);
success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());

// look for dependant links

// warn sharers
success = treeLogicBean.warnSharers(treeBean.getSharers(), new Integer(2));
success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());

// Recreate links
maps = null;
success = treeLogicBean.createLinks(accountID, treeBean.getSharers());
maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
treeBean.setLinks(maps);

success = connBean.isClosed();

// Recreate tree
treeBean = treeLogicBean.createTree(treeBean);

%>

<c:redirect url="/zmain.jsp" />
