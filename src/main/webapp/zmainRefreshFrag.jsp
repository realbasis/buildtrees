<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.LinkedList,java.util.SortedMap,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>

<%@include file="control/stdTags.jspf" %>

<jsp:useBean id="treeLogicBean" class="utility.TreeLogicBean" />

<%

boolean success = true;

ConnBean connBean = null;
ArrayList values = null;
SortedMap maps[] = null;
SortedMap map = null;
TreeMap tMap = null;
TreeMap me_tMap = null;
Integer me_ID = null;
String errors = null;
int size = 0;

TreeBean treeBean = (TreeBean) session.getAttribute("treeBean");
Integer accountID = (Integer) session.getAttribute("accountID");
Integer sharersFlag = (Integer) session.getAttribute("sharersFlag");

int flag = sharersFlag.intValue();

if(flag > 0) {
    connBean = new ConnBean();
    success = connBean.isStarted();

/*** create family ***/
    // Create family and set in treeBean
    success = treeLogicBean.createFamily(accountID);
    maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
    if(maps != null) {
        treeBean.setFamily(maps);
    }
    
/*** create sharers and family otro ***/
    // Create sharers in treeBean
    maps = null;
    success = treeLogicBean.createSharers(accountID);
    maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
    if(maps != null)
        treeBean.setSharers(maps);
	
	// Create events
	success = treeLogicBean.createEvents(accountID, treeBean.getSharers());
	maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
	treeBean.setEventsMap(maps);
    
    // Create family otro and set in treeBean
    maps = null;
    success = treeLogicBean.createFamilyOtro(treeBean.getSharers());
    maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
    if(maps != null) {
        treeBean.setFamilyOtro(maps);
    }

/**** Create family all ****/
    // Create family all and set in treeBean
    LinkedList list = treeLogicBean.createFamilyAll(treeBean.getFamily(), treeBean.getFamilyOtro());
    if(list != null)
        treeBean.setFamilyAll(list);
    
    // Define family by people set in treeBean
    tMap = null;
    tMap = treeLogicBean.defineFamilyByPeople(treeBean.getFamilyAll());
    if(tMap != null)
        treeBean.setFambypeople(tMap);
    
    // Create links for all profiles
    maps = null;
    success = treeLogicBean.createLinks(accountID, treeBean.getSharers());
    maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
    if(maps != null) {
        treeBean.setLinks(maps);
    }
    
    // Reset sharers flag in Accounts Map
    success = treeLogicBean.resetSharersFlag(accountID);
    success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());
    session.setAttribute("sharersFlag", new Integer(-1));

    success = connBean.isClosed();
    
    // check if meID still exists.
    me_tMap = treeBean.getMe();
    me_ID = (Integer) me_tMap.get("PeopleID");
    tMap = treeBean.getFambypeople();
    if(tMap.get(me_ID) == null) {
        me_tMap = (TreeMap) tMap.get(treeBean.getPeopleID());
        treeBean.setMe(me_tMap);
    }
    
    // recreate tree
    treeBean = treeLogicBean.createTree(treeBean);
    
}
%>
