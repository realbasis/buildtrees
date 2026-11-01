<%@page contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<%@page import="java.util.*,java.io.*,java.sql.Blob" %>
<%@page import="utility.*,value.*" %>


<%
TreeBean treeBean = (TreeBean) session.getAttribute("treeBean");
SortedMap peopleMap = (SortedMap) treeBean.getPeopleMap();
Blob imageBlob = (Blob) peopleMap.get("Image");

// get image from map
response.setContentType("image/jpeg");
InputStream in = imageBlob.getBinaryStream();
int length = (int) imageBlob.length();
int bufferSize = 300000;
byte[] buffer = new byte[bufferSize];
while ((length = in.read(buffer)) != -1) {
    response.getOutputStream().write(buffer, 0, length);
}
in.close();
response.flushBuffer();
// binary response written: stop the JspWriter from touching the response again
out.clear();
out = pageContext.pushBody();
%>