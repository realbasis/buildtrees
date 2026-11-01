<%@page contentType="text/html" errorPage=""%>
<%@page pageEncoding="UTF-8"%>

<%@page import="java.util.LinkedList,java.util.SortedMap,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>

<%@include file="stdTags.jspf" %>

<jsp:useBean id="now" class="java.util.Date" />
<jsp:useBean id="peopleBean" class="value.PeopleBean" />
<jsp:useBean id="treeLogicBean" class="utility.TreeLogicBean" />

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<c:if test="${param.retour != null}">
    <c:redirect url="/index.jsp">
    	<c:param name="theText" value="${param.theText}" />
    </c:redirect>
</c:if>

<c:if test="${param.gender == 'SELECT'}">
	<c:redirect url="/newfamily.jsp">
    	<c:param name="theText" value="${param.theText}" />
    	<c:param name="errors" value="select a gender" />
    </c:redirect>
</c:if>        
        <jsp:setProperty name="peopleBean" property="peopleID" value="-1" />
        <jsp:setProperty name="peopleBean" property="name" value="${param.theText}" />
        <jsp:setProperty name="peopleBean" property="email" value="none" />
        <jsp:setProperty name="peopleBean" property="gotBirthdate" value="${param.gotBirthdate}" />
        <c:set var="birthdate" value="${now}" />
        <c:if test="${param.gotBirthdate == 'on'}">
            <fmt:parseDate var="birthdate" value="${param.birthdate}" pattern="MMM-dd-yyyy" />
        </c:if>
        <jsp:setProperty name="peopleBean" property="birthdate" value="${birthdate}" />
        <jsp:setProperty name="peopleBean" property="isDeceased" value="${param.isDeceased}" />
        <c:set var="deceased" value="${now}" />
        <c:if test="${param.isDeceased == 'on'}">
            <fmt:parseDate var="deceased" value="${param.deceased}" pattern="MMM-dd-yyyy" />
        </c:if>
        <jsp:setProperty name="peopleBean" property="deceased" value="${deceased}" />
        <jsp:setProperty name="peopleBean" property="creationDate" value="${now}" />
        <jsp:setProperty name="peopleBean" property="gender" value="${param.gender}" />
        <jsp:setProperty name="peopleBean" property="accountID" value="${accountID}" />

<%

boolean success = true;

ConnBean connBean = null;
SortedMap maps[] = null;
SortedMap map = null;
Integer meID = null;


TreeBean treeBean = (TreeBean) session.getAttribute("treeBean");
Integer accountID = (Integer) session.getAttribute("accountID");

connBean = new ConnBean();
success = connBean.isStarted();

// create profile
success = treeLogicBean.createProfile(peopleBean);
success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());

// Get meID
/*** temp commented
success = treeLogicBean.findLastProfile();
maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
meID = (Integer) maps[0].get("PeopleID");
***/
meID = (Integer) treeBean.getMe().get("PeopleID");

// Create family and set in treeBean
success = treeLogicBean.createFamily(accountID);
maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
treeBean.setFamily(maps);

// Create family all and set in treeBean
LinkedList list = treeLogicBean.createFamilyAll(treeBean.getFamily(), treeBean.getFamilyOtro());
treeBean.setFamilyAll(list);

// Define family by people set in treeBean
TreeMap familyByPeopleMap = null;
familyByPeopleMap = treeLogicBean.defineFamilyByPeople(treeBean.getFamilyAll());
treeBean.setFambypeople(familyByPeopleMap);

// Redefine me
TreeMap tMap = (TreeMap) familyByPeopleMap.get(meID);
treeBean.setMe(tMap);

success = connBean.isClosed();

// Recreate baobab
// treeBean = treeLogicBean.createTree(treeBean);

%>

<c:redirect url="/details.jsp">
	<c:param name="peopleID" value="${treeBean.me.PeopleID}" />
</c:redirect>
