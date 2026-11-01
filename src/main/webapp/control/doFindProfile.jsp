<%@page contentType="text/html" errorPage=""%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<jsp:useBean id="now" class="java.util.Date" />
<jsp:useBean id="nodeBean" class="utility.NodeBean" />
<jsp:useBean id="peopleBean" class="value.PeopleBean" />
<jsp:useBean id="btrBean" class="utility.BuildTreeBean" />

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

        <c:if test="${param.email == ''}">
            <c:redirect url="/zmembers.jsp">
                <c:param name="emailErrors" value="*** Please enter email ***" />
		<c:param name="email" value="${param.email}"/>
            </c:redirect>
        </c:if>
		
		<c:if test="${param.email == myemail}">
            <c:redirect url="/zmembers.jsp">
                <c:param name="emailErrors" value="*** Email is invalid! ***" />
				<c:param name="email" value="${param.email}"/>
            </c:redirect>
        </c:if>
		
		<ora:ifValidEmailAddr value="${param.email}" var="isValid" />
	    <c:if test="${!isValid}">
    	    <c:redirect url="/zmembers.jsp">
                <c:param name="emailErrors" value="*** Email is invalid! ***" />
				<c:param name="email" value="${param.email}"/>
            </c:redirect>
		</c:if>
		
<sql:query var="ans">
	Select * from Accounts Where Email = ?
        <sql:param value="${param.email}" />
</sql:query>
        
<c:if test="${ans.rowCount == 0}">
	<c:redirect url="/zmembers.jsp">
    	<c:param name="search" value="no" />
        <c:param name="email" value="${param.email}"/>
    </c:redirect>
</c:if>

<c:if test="${ans.rowCount == 1}">
	<!-- check if it is not already a friend -->
	<c:forEach items="${ans.rows}" var="item">
		<sql:query var="result">
			Select * from Sharers Where MyAccountID = ? And AccountID = ?
        	<sql:param value="${accountID}" />
        	<sql:param value="${item.AccountID}" />
		</sql:query>
		<c:if test="${result.rowCount > 0}">
			<c:forEach items="${result.rows}" var="line">
				<c:if test="${line.Status == 2}">
	            	<c:redirect url="/zmembers.jsp">
		                <c:param name="emailErrors" value="Individual is already a member of your family" />
						<c:param name="email" value="${param.email}"/>
        		    </c:redirect>
				</c:if>
				<c:if test="${line.Status == 1}">
	            	<c:redirect url="/zmembers.jsp">
		                <c:param name="emailErrors" value="Individual has not responded to your invitation yet" />
						<c:param name="email" value="${param.email}"/>
        		    </c:redirect>
				</c:if>
				<c:if test="${line.Status == 0}">
	            	<c:redirect url="/zmembers.jsp">
		                <c:param name="emailErrors" value="Individual has sent you an invitation!" />
						<c:param name="email" value="${param.email}"/>
        		    </c:redirect>
				</c:if>
			</c:forEach>
        </c:if>
		
		<!-- propose invitation request -->
		<c:if test="${result.rowCount == 0}">
			<c:redirect url="/zmembers.jsp">
				<c:param name="search" value="yes" />
				<c:param name="guestID" value="${item.AccountID}"/>
				<c:param name="email" value="${param.email}"/>
            </c:redirect>
		</c:if>
	</c:forEach>
	
</c:if>
