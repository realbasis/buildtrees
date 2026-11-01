<%-- Replacement for the O'Reilly <ora:debug type="params"/> tag: request parameters are written to the server log. --%>
<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ attribute name="type" %>
<%
    javax.servlet.jsp.PageContext pc = (javax.servlet.jsp.PageContext) jspContext;
    StringBuilder sb = new StringBuilder("[buildtrees] request parameters:");
    for (java.util.Map.Entry<String, String[]> e : pc.getRequest().getParameterMap().entrySet()) {
        String k = e.getKey();
        boolean secret = k.toLowerCase().contains("pass");
        sb.append(' ').append(k).append('=').append(secret ? "***" : String.join(",", e.getValue()));
    }
    pc.getServletContext().log(sb.toString());
%>
