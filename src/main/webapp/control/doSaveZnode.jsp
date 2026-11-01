<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
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

<c:if test="${param.retour == 'Cancel'}">
    <c:redirect url="/zmain.jsp" />
</c:if>

<c:if test="${param.name == ''}">
	<c:redirect url="/zprofile.jsp">
		<c:param name="errors" value="*** Full Name is missing ***" />
    </c:redirect>
</c:if>

<jsp:setProperty name="peopleBean" property="peopleID" value="${treeBean.me.PeopleID}" />
<jsp:setProperty name="peopleBean" property="title" value="${treeBean.me.Title}" />
<jsp:setProperty name="peopleBean" property="accountID" value="${treeBean.me.AccountID}" />
<jsp:setProperty name="peopleBean" property="email" value="${treeBean.me.Email}" />

<jsp:setProperty name="peopleBean" property="name" value="${param.name}" />
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

<%

boolean success = true;

ConnBean connBean = null;
SortedMap maps[] = null;
SortedMap map = null;


TreeBean treeBean = (TreeBean) session.getAttribute("treeBean");
Integer accountID = (Integer) session.getAttribute("accountID");

connBean = new ConnBean();
success = connBean.isStarted();

// create profile
success = treeLogicBean.updateProfile(peopleBean);
success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());

// update account if it is owner profile
String title = peopleBean.getTitle();
if(title.equals("owner")) {
    success = treeLogicBean.updateAccount(peopleBean);
    success = connBean.update(treeLogicBean.getMsg(), treeLogicBean.getValues());
}

// Create family and set in treeBean
success = treeLogicBean.createFamily(accountID);
maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
treeBean.setFamily(maps);

// Create family otro and set in treeBean
success = treeLogicBean.createFamilyOtro(treeBean.getSharers());
maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
treeBean.setFamilyOtro(maps);

// Create family all and set in treeBean
LinkedList list = treeLogicBean.createFamilyAll(treeBean.getFamily(), treeBean.getFamilyOtro());
treeBean.setFamilyAll(list);

// Define family by people set in treeBean
TreeMap familyByPeopleMap = null;
familyByPeopleMap = treeLogicBean.defineFamilyByPeople(treeBean.getFamilyAll());
treeBean.setFambypeople(familyByPeopleMap);

// Redefine me
TreeMap tMap = (TreeMap) familyByPeopleMap.get(peopleBean.getPeopleID());
treeBean.setMe(tMap);

success = connBean.isClosed();

%>

<c:redirect url="/zmain.jsp" />

