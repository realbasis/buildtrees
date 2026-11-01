<%@page contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<%@page import="java.io.InputStream" %>
<%@page import="utility.*,value.*" %>


<%
PeopleBean peopleBean = (PeopleBean) session.getAttribute("peopleBean");
InputStream in = peopleBean == null ? null : peopleBean.getImageIn();
if (in == null) {
    response.sendRedirect(request.getContextPath() + "/images/nophoto.png");
    return;
}
// uploads are kept in memory (api.ImageUpload) so the preview can be shown repeatedly
if (in.markSupported())
    in.reset();
response.setContentType("image/jpeg");
in.transferTo(response.getOutputStream());
response.flushBuffer();
// binary response written: stop the JspWriter from touching the response again
out.clear();
out = pageContext.pushBody();
%>