<%@page contentType="text/html" errorPage=""%>
<%@page pageEncoding="UTF-8"%>

<%@page import="java.util.LinkedList,java.util.SortedMap,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>

<%@include file="stdTags.jspf" %>

<jsp:useBean id="treeLogicBean" class="utility.TreeLogicBean" />

<c:if test="${param.goodBrowser == null || param.goodBrowser != true}">
    <c:redirect url="/index.jsp">
        <c:param name="email" value="${param.email}" />
        <c:param name="errors" value="Login disabled by browser" />
    </c:redirect>
</c:if>

<%

boolean success = true;

ConnBean connBean = null;
ArrayList values = null;
SortedMap maps[] = null;
SortedMap map = null;
SortedMap accountMap = null;
TreeMap tMap = null;
String errors = null;
int size = 0;

BaobabBean baobab = (BaobabBean) application.getAttribute("baobabBean");
TreeBean treeBean = (TreeBean) session.getAttribute("treeBean");
String email = request.getParameter("email");
String password = request.getParameter("password");
String remember = request.getParameter("remember");

connBean = new ConnBean();
success = connBean.isStarted();

accountMap = treeLogicBean.accountFind(baobab.getAccountsMaps(), email, password);
// the connection is not used further here: give it back (it used to leak)
if(success)
    connBean.isClosed();
if(accountMap == null) {
    errors = "Login failed!";
    success = false;
}

if(success) {
    Integer accountID = (Integer) accountMap.get("AccountID");
    
    // Set session variables
    session.setAttribute("accountID", accountID);
    session.setAttribute("myemail", email);
    session.setAttribute("myname", accountMap.get("Name"));
    session.setAttribute("notifyMe", accountMap.get("Notify"));
    session.setAttribute("flag", new Integer(7));
    session.setMaxInactiveInterval(-1);
    
    // set cookie if required
    //if(remember != null) {
    if(false) {
        if(remember.equals("on")) {
            //creation cookie pour la session
            String cookieContent = email+":"+password;
            Cookie nom_du_Cookie= new Cookie ("buildtreesCookie",cookieContent);
            nom_du_Cookie.setMaxAge (7 * 24 * 60 * 60);
            response.addCookie(nom_du_Cookie);
        }
    }

}

request.setAttribute("errors", errors);

%>

<c:if test="${errors != null}">
    <c:redirect url="/login.jsp">
        <c:param name="email" value="${param.email}" />
        <c:param name="errors" value="${errors}" />
    </c:redirect>
</c:if>

<c:redirect url="/index.jsp" />
