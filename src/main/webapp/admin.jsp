<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<html>
<head>
	<title>
    <%@include file="/control/stdTags.jspf" %>
    
    <jsp:useBean id="adminBean" class="utility.AdminBean" />
    <c:choose>
		<c:when test="${scheduleBean == null}">
			<jsp:useBean id="scheduleBean" class="utility.ScheduleBean" scope="application" />
		</c:when>
		<c:otherwise>
		</c:otherwise>
    </c:choose>
    
    <c:if test="${logged == null || logged != true}">
        <c:redirect url="/control/doLogoutOwner.jsp">
            <c:param name="errors" value="invalid user!"/>
        </c:redirect>
    </c:if>
    
    <c:if test="${scheduleBean.status == 'running'}">
        <c:set var="buttonStatus" value="disabled"/>
    </c:if>
    <c:if test="${scheduleBean.status == 'stopped'}">
        <c:set var="buttonStatus" value=""/>
    </c:if>
    
    <c:if test="${scheduleBean.status == 'running'}">
        <c:set var="buttonStopStatus" value=""/>
    </c:if>
    <c:if test="${scheduleBean.status == 'stopped'}">
        <c:set var="buttonStopStatus" value="disabled"/>
    </c:if>

    <sql:query var="result">
        Select * from Accounts Order By CreationDate
    </sql:query> 
    
    <sql:query var="people">
        Select * from Zpeople Order By CreationDate
    </sql:query>
    
    <sql:query var="sharers">
        Select * from Sharers
    </sql:query>
  
    <jsp:setProperty name="adminBean" property="accounts" value="${result.rows}" />
    <jsp:setProperty name="adminBean" property="people" value="${people.rows}" />
    <jsp:setProperty name="adminBean" property="sharers" value="${sharers.rows}" />
    </title>
<%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>

<body>

<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>

<p style="text-align:right"><a href='control/doLogoutOwner.jsp'>logout</a></p>
<p>
    <c:if test="${param.errors != null}">
        <span style="color:red">* ${param.errors} *</span>
    </c:if>
</p>

<div>
    <h4>STATUS: <span style="color:orange">${scheduleBean.status}</span></h4>
    <table border='1'>
        <tr>
            <form action='control/doStartEvents.jsp' method="post">
            <td>
                Delay (min)
                <br>
                <input type="text" ${buttonStatus} name='delay' size="4" maxlength="4" value="${scheduleBean.delay0}">
            </td>
            <td>
                Lapse (min)
                <br>
                <input type="text" size="4" maxlength="4" value="${scheduleBean.lapse}" disabled="disabled">
				<input type="hidden" name="lapse" value="1440">
            </td>
            <td>
                <br>
                <input type="submit" ${buttonStatus} value='START'>
            </td>
            </form>
            <form action='control/doStopEvents.jsp' method="post">
            <td>
                <br>
                <input type="submit" value="STOP" ${buttonStopStatus}>
            </td>
            </form>
        </tr>
    </table>
    <hr>
    <h4>User Accounts (${result.rowCount}) / (${people.rowCount} profiles)</h4>
    <table>
        <tr>
            <td>
            	<form method='post' action=''>
                	<select name="">
                    	<c:forEach items="${result.rows}" var="ans">
                        	<option>${ans.Name}: ${ans.Email}/${ans.AccountID}</option>
                        </c:forEach>
                    </select>
                    <input type="submit" value="Show">
                </form>
            </td>
        <c:if test="${result.rowCount > 0}">
            <c:if test="${param.cle == null}">
            <td>
	            <form method='post' action='admin.jsp'>
    	        	<input type="submit" value="Show All">
        	        <input type="hidden" name="cle" value="2">
            	</form>
            </td>
            <td>
	            <form method='post' action='admin.jsp'>
    	        	<input type="submit" value="Show Stats">
        	        <input type="hidden" name="cle" value="3">
            	</form>
            </td>
            </c:if>
            <c:if test="${param.cle > 0}">
            <td>
                <form method='post' action='admin.jsp'>
  	                <input type="submit" value="Close">
           	    </form>
            </td>
            </c:if>
        </c:if>
	    </tr>
    </table>
</div>

<c:if test="${param.cle != null}">
	<c:if test="${param.cle == 2}">
            <%-- was displaytag; plain JSTL table (click a header to sort in the browser) --%>
            <table id="statsTable" style="border:solid 1px blue;border-collapse:collapse" border="1" cellpadding="3">
                <thead>
                    <tr style="cursor:pointer">
                        <th>ID</th><th>Name</th><th>Email</th><th>Created</th><th>Notify</th><th>Profiles</th><th>Members</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach items="${adminBean.stats}" var="st">
                    <tr>
                        <td style="text-align:center"><c:out value="${st.AccountID}" /></td>
                        <td style="text-align:left"><c:out value="${st.Name}" /></td>
                        <td style="text-align:left"><c:out value="${st.Email}" /></td>
                        <td><fmt:formatDate value="${st.CreationDate}" pattern="MM/dd/yy" /></td>
                        <td style="text-align:center"><c:out value="${st.Notify}" /></td>
                        <td style="text-align:center"><c:out value="${st.Count}" /></td>
                        <td style="text-align:center"><c:out value="${st.CountSharers}" /></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <script>
            (function () {
                var t = document.getElementById('statsTable');
                if (!t) return;
                var ths = t.tHead.rows[0].cells;
                for (var i = 0; i < ths.length; i++) (function (col) {
                    var asc = true;
                    ths[col].onclick = function () {
                        var rows = Array.prototype.slice.call(t.tBodies[0].rows);
                        rows.sort(function (a, b) {
                            var x = a.cells[col].textContent.trim(), y = b.cells[col].textContent.trim();
                            var nx = parseFloat(x), ny = parseFloat(y);
                            var r = (!isNaN(nx) && !isNaN(ny)) ? nx - ny : x.localeCompare(y);
                            return asc ? r : -r;
                        });
                        asc = !asc;
                        rows.forEach(function (r) { t.tBodies[0].appendChild(r); });
                    };
                })(i);
            })();
            </script>
    </c:if>
	<c:if test="${param.cle == 3}">
            <c:if test="${adminBean.statsCreated == true}"></c:if>
            
            <%-- was Cewolf/JFreeChart; charts are now inline SVG (utility.ActivityChart) --%>
            <div style="margin:10px 0">${adminBean.accountsChart.svg}</div>
            <div style="margin:10px 0">${adminBean.peopleChart.svg}</div>
    </c:if>
</c:if>

</body>
</html>
