<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@ page language="java" import="api.ImageUpload,java.util.*,java.io.InputStream" %>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<jsp:useBean id="nodeBean" class="utility.NodeBean" />
<jsp:useBean id="peopleBean" class="value.PeopleBean" />

<jsp:setProperty name="nodeBean" property="treeBean" value="${treeBean}" />

<%
    String errors = null;
    boolean flag = false;

    // Servlet multipart API (replaces javazoom MultipartFormDataRequest)
    ImageUpload upload = ImageUpload.read(request, "uploadfile");
    if (!upload.isOk())
        errors = upload.getErrors();
    else
    {
        peopleBean.setImageName(upload.getFileName());
        peopleBean.setImageIn(upload.getInputStream());
        //nodeBean.setPeopleBean(peopleBean);
        //flag = nodeBean.isImgSaved();
        flag = true;
        if(flag == false)
            errors = new String("Invalid image");
    }
    
    if(errors != null)
    {
%>
    <c:redirect url="/zprofile.jsp">
        <c:param name="errors" value="<%= errors %>"/>
    </c:redirect>
<%
    }
    else
    {
%>
	<!-- update image in treeBean -->
	<jsp:setProperty name="treeBean" property="it" value="${nodeBean.treeBean.it}" />
	
    <c:redirect url="/zprofile.jsp" />
<%      
    }
%>
