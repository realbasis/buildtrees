<%--
  Minimal paging helper replacing displaytag's <display:table pagesize="..">.
  Exposes pageBegin / pageEnd (for <c:forEach begin end>) and, when
  render="true", prints "previous 1 2 3 next" links that keep the other
  request parameters. The current page is read from request parameter "p".
--%>
<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ attribute name="total" required="true" type="java.lang.Integer" %>
<%@ attribute name="pageSize" required="true" type="java.lang.Integer" %>
<%@ attribute name="render" type="java.lang.Boolean" %>
<%@ variable name-given="pageBegin" variable-class="java.lang.Integer" scope="AT_END" %>
<%@ variable name-given="pageEnd" variable-class="java.lang.Integer" scope="AT_END" %>
<%
    javax.servlet.jsp.PageContext pc = (javax.servlet.jsp.PageContext) jspContext;
    javax.servlet.http.HttpServletRequest req = (javax.servlet.http.HttpServletRequest) pc.getRequest();
    int total = (Integer) jspContext.getAttribute("total");
    int size = Math.max(1, (Integer) jspContext.getAttribute("pageSize"));
    int pages = Math.max(1, (total + size - 1) / size);
    int current = 1;
    try { current = Integer.parseInt(req.getParameter("p")); } catch (Exception ignored) { }
    current = Math.min(Math.max(1, current), pages);
    jspContext.setAttribute("pageBegin", (current - 1) * size);
    jspContext.setAttribute("pageEnd", current * size - 1);

    Boolean render = (Boolean) jspContext.getAttribute("render");
    if (render != null && render && pages > 1) {
        StringBuilder base = new StringBuilder(req.getRequestURI()).append('?');
        for (java.util.Map.Entry<String, String[]> e : req.getParameterMap().entrySet()) {
            if ("p".equals(e.getKey())) continue;
            for (String v : e.getValue()) {
                base.append(java.net.URLEncoder.encode(e.getKey(), "UTF-8")).append('=')
                    .append(java.net.URLEncoder.encode(v, "UTF-8")).append("&amp;");
            }
        }
        StringBuilder sb = new StringBuilder("<div class=\"pagelinks\" style=\"margin:8px 0;font-size:13px\">");
        sb.append(total).append(" items found. ");
        if (current > 1) sb.append("<a href=\"").append(base).append("p=").append(current - 1).append("\">&laquo; Prev</a> ");
        for (int i = 1; i <= pages; i++) {
            if (i == current) sb.append("<strong>").append(i).append("</strong> ");
            else sb.append("<a href=\"").append(base).append("p=").append(i).append("\">").append(i).append("</a> ");
        }
        if (current < pages) sb.append("<a href=\"").append(base).append("p=").append(current + 1).append("\">Next &raquo;</a>");
        sb.append("</div>");
        pc.getOut().write(sb.toString());
    }
%>
