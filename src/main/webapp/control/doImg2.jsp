<%@page contentType="text/html" errorPage=""%>
<%@ page language="java" import="api.ImageUpload,java.util.*,java.io.InputStream" %>
<%@page import="utility.*,value.*" %>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<%
    String errors = null;
    boolean flag = false;
    PeopleBean peopleBean = (PeopleBean) session.getAttribute("peopleBean");
    
    if(peopleBean == null)
	peopleBean = new PeopleBean();

    // Servlet multipart API (replaces javazoom MultipartFormDataRequest)
    ImageUpload upload = ImageUpload.read(request, "uploadfile");
    if (!upload.isOk())
        errors = upload.getErrors();
    else
    {
        peopleBean.setImageName(upload.getFileName());
        peopleBean.setImageIn(upload.getInputStream());
        session.setAttribute("peopleBean",peopleBean);
        flag = true;
    }
    
    if(errors != null)
    {
%>
    <c:redirect url="/newfamily.jsp">
        <c:param name="errors" value="<%= errors %>"/>
    </c:redirect>
<%
    }
    else
    {
%>
    <c:redirect url="/newfamily.jsp" />
<%

    }
%>
