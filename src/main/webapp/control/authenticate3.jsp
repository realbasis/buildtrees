<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>

<%@page import="java.util.LinkedList,java.util.SortedMap,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>

<%
    /*** Preventin<c:setg Caching of Pages ***/
    response.addHeader("Pragma", "no-cache");
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.addHeader("Cache-Control", "pre-check=0, post-check=0");
    response.setDateHeader("Expires", 0);
%>

<%@include file="stdTags.jspf" %>

<jsp:useBean id="treeBean" class="value.TreeBean" scope="session" />
<jsp:useBean id="treeLogicBean" class="utility.TreeLogicBean" />

<c:if test="${param.goodBrowser == null || param.goodBrowser != true}">
    <c:redirect url="/index.jsp">
        <c:param name="email" value="${param.email}" />
        <c:param name="errors" value="Login disabled by browser" />
    </c:redirect>
</c:if>

<fmt:setLocale value="en_US" scope="session"/>
<fmt:setTimeZone value="US/Eastern" scope="session"/>

<%

boolean success = true;

ConnBean connBean = null;
ArrayList values = null;
SortedMap maps[] = null;
SortedMap map = null;
TreeMap tMap = null;
String errors = null;
int size = 0;

String email = request.getParameter("email");
String password = request.getParameter("password");

connBean = new ConnBean();
success = connBean.isStarted();

success = treeLogicBean.accountFind(email, password);
maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
if(maps == null) {
    errors = "Login failed!";
    success = false;
}

if(maps.length != 1) {
    errors = "Login failed!";
    success = false;
}

if(success) {
    SortedMap accountMap = maps[0];
    Integer accountID = (Integer) accountMap.get("AccountID");
    
    // Set session variables
    session.setAttribute("accountID", accountID);
    session.setAttribute("myemail", email);
    session.setAttribute("myname", accountMap.get("Name"));
    session.setAttribute("notifyMe", accountMap.get("Notify"));
    session.setAttribute("flag", new Integer(7));
    session.setMaxInactiveInterval(1800); 
    
    // Create family and set in treeBean
    success = treeLogicBean.createFamily(accountID);
    maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
    treeBean.setFamily(maps);
    
    // Define me in treeBean
    treeLogicBean.setMaps(treeBean.getFamily());
    tMap = treeLogicBean.defineMe(email);
    treeBean.setMe(tMap);
    
    // Define pid
    Integer ownerPid = (Integer) treeBean.getMe().get("PeopleID");
    treeBean.setPeopleID(ownerPid);
    session.setAttribute("ownerPid", ownerPid);
    
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

    // Reset sharers flag in Accounts Map
    Integer flagID = (Integer) accountMap.get("Flag");
    if(flagID.intValue() > 0) {
        success = treeLogicBean.resetSharersFlag(accountID);
        success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());
    }
    session.setAttribute("sharersFlag", new Integer(-1));

}

success = connBean.isClosed();

treeBean = treeLogicBean.createTree(treeBean);

request.setAttribute("errors", errors);

%>

<c:if test="${errors != null}">
    <c:redirect url="/index.jsp">
        <c:param name="email" value="${param.email}" />
        <c:param name="errors" value="${errors}" />
    </c:redirect>
</c:if>

<c:redirect url="/zmain.jsp" />
