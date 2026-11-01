<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@ page language="java" import="javazoom.upload.*,java.util.*" %>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<jsp:useBean id="uploadImg" class="api.UploadImg" />
<jsp:useBean id="upBean" class="javazoom.upload.UploadBean" >

<c:set var="hostname" value="${configBean.hostname}" />

<%
  Properties props = new Properties();
  String hostname = (String) pageContext.getAttribute("hostname");
  String url = "jdbc:mysql://"+hostname+":3306/connected";

  // Modify info below to fit to your database settings.
  props.put("user","realbasis");
  props.put("password","dakar");
  upBean.setDatabasestore("com.mysql.jdbc.Driver", url, props);
  
  // If you have get a JDBC Connection from a javax.sql.DataSource
  // Then use upBean.setDatabasestore(YourConnection);
  // Also, uncomment and modify variables below if you need to map to your own database schema.
  UploadBean.SQLUPLOADTABLE = "People";
  UploadBean.SQLUPLOADID = "PeopleID";
  UploadBean.SQLUPLOADFILENAME = "ImageName";
  UploadBean.SQLUPLOADFILE = "Image";
  // Note that if you need to modify SQL request then see UploadBean
  // add-ons section to plug a custom DBStore implementation (BLOB, ...).
  upBean.setDatabasestoreimplementation("");
%>
</jsp:useBean>
<jsp:setProperty name="upBean" property="overwrite" value="true" />

<%
    String errors = null;
    String treeID = null;
    String name = null;
    String peopleID = null;
    String ref = null;
    String pos = null;
    boolean flag = false;
    
    if (!MultipartFormDataRequest.isMultipartFormData(request))
        errors = new String("Invalid image format! File upload failed.");
    else
    {
        // Uses MultipartFormDataRequest to parse the HTTP request.
        MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
        if (mrequest == null)
            errors = new String("Invalid image format! File upload failed.");
        else
        {
            // Set hidden variables
            treeID = mrequest.getParameter("treeID");
            name = mrequest.getParameter("name");
            peopleID = mrequest.getParameter("peopleID");
            ref = mrequest.getParameter("ref");
            pos = mrequest.getParameter("pos");
            
            Hashtable files = null;
            files = mrequest.getFiles();
	    	if ( (files == null) || (files.isEmpty()) )
                errors = new String("Invalid image format! File upload failed.");
            else
            {
                UploadFile file = (UploadFile) files.get("uploadfile");
                // check file size
                long size = file.getFileSize();
                if (file == null)
                    errors = new String("Please select file");
                else if(size <=0)
                    errors = new String("File is not found!");
                else if(size > 250000)
                    errors = new String("File is too large!");
                else
                {
                    // check file type jpeg or png
                    String filename = file.getFileName();
                    
                    if( (!filename.endsWith(".jpg")) && (!filename.endsWith(".JPG")) && (!filename.endsWith(".gif")) && (!filename.endsWith(".GIF")) )
                        errors = new String("Invalid image format! File upload failed.");
                    else
                    {
                        // Store uploaded files in database now. Third parameter allows to pass options Map.
                        flag = uploadImg.update(upBean.getDatabasestore(), Integer.valueOf(peopleID).intValue(), filename, file.getInpuStream(), (int) file.getFileSize());
                        
                        if(flag == false)
                            errors = new String("Invalid image");
                    }
	     	}
            }
	}
    }
    
    upBean.getDatabasestore().close();
    
    if(errors != null)
    {
%>

<c:redirect url="/people.jsp">
    <c:param name="errors" value="<%= errors %>" />
    <c:param name="treeID" value="<%= treeID %>" />
    <c:param name="name" value="<%= name %>" />
    <c:param name="peopleID" value="<%= peopleID %>" />
    <c:param name="ref" value="<%= ref %>" />
    <c:param name="pos" value="<%= pos %>" />
    <c:param name="other" value="${param.other}" />
    <c:param name="accountOwner" value="${param.accountOwner}" />
    <c:param name="emailo" value="${param.emailo}" />
</c:redirect>
<%
    }
    else
    {
%>
<c:redirect url="/people.jsp">
    <c:param name="treeID" value="<%= treeID %>" />
    <c:param name="name" value="<%= name %>" />
    <c:param name="peopleID" value="<%= peopleID %>" />
    <c:param name="ref" value="<%= ref %>" />
    <c:param name="other" value="${param.other}" />
    <c:param name="accountOwner" value="${param.accountOwner}" />
    <c:param name="emailo" value="${param.emailo}" />
</c:redirect>
<%      
    }
%>
