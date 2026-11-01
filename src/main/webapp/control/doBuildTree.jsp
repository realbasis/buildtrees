<%@page contentType="text/html" errorPage=""%>
<%@page pageEncoding="UTF-8"%>

<%@page import="java.util.LinkedList,java.util.SortedMap,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>

<%@include file="stdTags.jspf" %>

<jsp:useBean id="treeLogicBean" class="utility.TreeLogicBean" />

<%

boolean success = true;

ConnBean connBean = null;
SortedMap maps[] = null;
SortedMap map = null;
TreeMap tMap = null;

BaobabBean baobab = (BaobabBean) application.getAttribute("baobabBean");
TreeBean treeBean = (TreeBean) session.getAttribute("treeBean");
String theText = request.getParameter("theText");

treeLogicBean.createBaobab(baobab.getPeopleMaps(),theText);
treeBean.setList(treeLogicBean.getList());

%>

<c:redirect url="/">
    <c:param name="theText" value="${param.theText}" />
</c:redirect>