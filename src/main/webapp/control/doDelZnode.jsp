<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>

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

boolean success = true;

ConnBean connBean = null;
ArrayList values = null;
SortedMap maps[] = null;
SortedMap map = null;
Integer meID = null;

TreeBean treeBean = (TreeBean) session.getAttribute("treeBean");
Integer accountID = (Integer) session.getAttribute("accountID");
Integer ownerPid = (Integer) session.getAttribute("ownerPid");

connBean = new ConnBean();
success = connBean.isStarted();

// Delete links
success = treeLogicBean.deleteProfileLinks(treeBean);
success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());

// Delete node
success = treeLogicBean.deleteProfile(treeBean);
success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());

// Set me
TreeMap familyByPeopleMap = treeBean.getFambypeople();
TreeMap tMap = (TreeMap) familyByPeopleMap.get(ownerPid);
treeBean.setMe(tMap);

// Create family and set in treeBean
success = treeLogicBean.createFamily(accountID);
maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
if(maps != null) {
    treeBean.setFamily(maps);
}

// Create family all and set in treeBean
LinkedList list = treeLogicBean.createFamilyAll(treeBean.getFamily(), treeBean.getFamilyOtro());
if(list != null)
    treeBean.setFamilyAll(list);

// Warn sharers
success = treeLogicBean.warnSharers(treeBean.getSharers(), new Integer(2));
success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());

success = connBean.isClosed();

// Recreate tree
treeBean = treeLogicBean.createTree(treeBean);

%>

<c:redirect url="/zmain.jsp"/>
