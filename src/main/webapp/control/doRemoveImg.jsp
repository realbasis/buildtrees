<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="value.*" %>
<%@include file="stdTags.jspf" %>

<%
PeopleBean peopleBean = (PeopleBean) session.getAttribute("peopleBean");
peopleBean.setImageIn(null);
peopleBean.setImageName(null);
peopleBean.setImage(null);
session.setAttribute("peopleBean",peopleBean);
%>

<c:redirect url="/newfamily.jsp" />