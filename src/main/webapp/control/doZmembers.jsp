<%@page contentType="text/html" errorPage=""%>
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
SortedMap maps[] = null;
SortedMap map = null;
TreeMap tMap = null;

TreeBean treeBean = (TreeBean) session.getAttribute("treeBean");
Integer accountID = (Integer) session.getAttribute("accountID");
Integer guestID = new Integer(request.getParameter("guestID"));
String reaction = request.getParameter("reaction");


connBean = new ConnBean();
success = connBean.isStarted();

if(reaction.equals("abandon")) {
    success = treeLogicBean.createSharersAbandon(accountID, guestID);
    success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());
}
else if(reaction.equals("deny")) {
    success = treeLogicBean.createSharersDeny(accountID, guestID);
    success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());
}
else if(reaction.equals("confirm") || reaction.equals("disconnect")) {
    if(guestID.intValue() > 0) {
        if(reaction.equals("confirm")) {
            success = treeLogicBean.createSharersConfirm(accountID, guestID);
            success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());
        }
        else if(reaction.equals("disconnect")) {
            success = treeLogicBean.createSharersDisconnect(accountID, guestID);
            success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());
    
            success = treeLogicBean.createSharersDelLinks(accountID, guestID);
            success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());
        }
    
        // Create sharers in treeBean
        maps = null;
        success = treeLogicBean.createSharers(accountID);
        maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
        treeBean.setSharers(maps);

        // Create family otro and set in treeBean
        maps = null;
        success = treeLogicBean.createFamilyOtro(treeBean.getSharers());
        maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
        treeBean.setFamilyOtro(maps);
    
        // Create family all and set in treeBean
        LinkedList list = treeLogicBean.createFamilyAll(treeBean.getFamily(), treeBean.getFamilyOtro());
        treeBean.setFamilyAll(list);
    
        // Define family by people set in treeBean
        tMap = null;
        tMap = treeLogicBean.defineFamilyByPeople(treeBean.getFamilyAll());
        treeBean.setFambypeople(tMap);

        // Create links for all profiles
        maps = null;
        success = treeLogicBean.createLinks(accountID, treeBean.getSharers());
        maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
        treeBean.setLinks(maps);
        
        success = treeLogicBean.createEvents(accountID, treeBean.getSharers());
        maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
        treeBean.setEventsMap(maps);

        // Warn sharers
        success = treeLogicBean.warnSharers(treeBean.getSharers(), new Integer(2));
        success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());
    }
}

success = connBean.isClosed();

%>

<c:redirect url="/zmembers.jsp" />