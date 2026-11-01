<%@page contentType="text/html" errorPage=""%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<jsp:useBean id="now" class="java.util.Date" />
<jsp:useBean id="newNodeBn" class="utility.NewNodeBean" />
<jsp:useBean id="peopleBn" class="value.PeopleBean" />
<jsp:useBean id="connBn" class="utility.ConnBean" />

<c:if test="${param.retour == 'Cancel'}">
    <c:redirect url="/zmain.jsp" />
</c:if>

<!-- create connection to database -->
<jsp:setProperty name="treeBn" property="conn" value="${connBn.conn}" />
<c:if test="${treeBn.connBn.started == false}">
    <c:redirect url="/control/logout.jsp" >
        <c:param name="errors" value="${treeBn.connBn.errors}" />
    </c:redirect>
</c:if>

<!-- check if person comes from list or not -->
<c:choose>
    <c:when test="${param.list == true}">
        <!-- case person is in list of nodes -->
        <c:choose>
            
            <c:when test="${param.peopleID == -1}">
                <!-- case no one was selected -->
                <c:redirect url="/znewprofile.jsp" />
            </c:when>
            <c:when test="${param.peopleID == -2}">
                <!-- case person does not exists -->
                <c:redirect url="/znewprofile.jsp">
                    <c:param name="np" value="true" />
                </c:redirect>
            </c:when>
            <c:when test="${param.peopleID > 0}">
                <!-- case person does exist, create links -->
                
                <jsp:setProperty name="peopleBn" property="peopleID" value="${param.peopleID}" />
                <jsp:setProperty name="peopleBn" property="accountID" value="${accountID}" />
                
                <jsp:setProperty name="newNodeBn" property="fambypeople" value="${treeBn.fambypeople}" />
                <jsp:setProperty name="newNodeBn" property="root" value="${treeBn.me}" />
                <jsp:setProperty name="newNodeBn" property="peopleBn" value="${peopleBn}" />
                <jsp:setProperty name="newNodeBn" property="list" value="${param.list}" />
                <jsp:setProperty name="newNodeBn" property="relationship" value="${treeBn.relationship}" />
                <jsp:setProperty name="newNodeBn" property="conn" value="${connBn.conn}" />
                <jsp:setProperty name="newNodeBn" property="treeBn" value="${treeBn}" />
                
                <!-- create links of person added in both directions -->
                <c:if test="${newNodeBn.branchUpdated == false}">
                    <c:redirect url="/control/logout.jsp" >
                        <c:param name="errors" value="${newNodeBn.errors}" />
                    </c:redirect>
                </c:if>
            
            </c:when>
            <c:otherwise>
                <c:redirect url="/control/logout.jsp" >
                    <c:param name="errors" value="Unexpected error." />
                </c:redirect>
            </c:otherwise>
        </c:choose>
    
    </c:when>
    <c:when test="${param.list == false}">
            
        <!-- case person does not exist -->
        <c:if test="${param.name == ''}">
            <c:redirect url="/znewprofile.jsp">
                <c:param name="errors" value="*** Please enter Full Name ***" />
            </c:redirect>
        </c:if>
        
        <jsp:setProperty name="peopleBn" property="name" value="${param.name}" />
        <jsp:setProperty name="peopleBn" property="email" value="${param.email}" />
        
        <jsp:setProperty name="peopleBn" property="gotBirthdate" value="${param.gotBirthdate}" />
        <c:set var="birthdate" value="${now}" />
        <c:if test="${param.gotBirthdate == 'on'}">
            <fmt:parseDate var="birthdate" value="${param.birthdate}" pattern="MMM-dd-yyyy" />
        </c:if>
        <jsp:setProperty name="peopleBn" property="birthdate" value="${birthdate}" />
        
        <jsp:setProperty name="peopleBn" property="isDeceased" value="${param.isDeceased}" />
        <c:set var="deceased" value="${now}" />
        <c:if test="${param.isDeceased == 'on'}">
            <fmt:parseDate var="deceased" value="${param.deceased}" pattern="MMM-dd-yyyy" />
        </c:if>
        <jsp:setProperty name="peopleBn" property="deceased" value="${deceased}" />
        
        <jsp:setProperty name="peopleBn" property="gender" value="${param.gender}" />
        <jsp:setProperty name="peopleBn" property="accountID" value="${accountID}" />
        
        <!-- create links -->
        <jsp:setProperty name="newNodeBn" property="relationship" value="${treeBn.relationship}" />
        <jsp:setProperty name="newNodeBn" property="fambypeople" value="${treeBn.fambypeople}" />
        <jsp:setProperty name="newNodeBn" property="root" value="${treeBn.me}" />
        <jsp:setProperty name="newNodeBn" property="peopleBn" value="${peopleBn}" />
        <jsp:setProperty name="newNodeBn" property="list" value="${param.list}" />
        <jsp:setProperty name="newNodeBn" property="conn" value="${connBn.conn}" />
        <jsp:setProperty name="newNodeBn" property="treeBn" value="${treeBn}" />
        
        <!-- create links of person added in both directions -->
        <c:if test="${newNodeBn.branchUpdated == false}">
            <c:redirect url="/control/logout.jsp" >
                    <c:param name="errors" value="${newNodeBn.errors}" />
            </c:redirect>
        </c:if>
        
    </c:when>
    <c:otherwise>
        <c:redirect url="/control/logout.jsp" >
            <c:param name="errors" value="Unexpected error." />
        </c:redirect>
    </c:otherwise>
</c:choose>

<!-- update links -->
<c:if test="${treeBn.restarted == false}">
    <c:redirect url="/control/logout.jsp" >
        <c:param name="errors" value="${treeBn.errors}" />
    </c:redirect>
</c:if>

<jsp:setProperty name="newNodeBn" property="treeBn" value="${treeBn}" />
<c:if test="${newNodeBn.treeUpdated == false}">
    <c:redirect url="/control/logout.jsp" >
        <c:param name="errors" value="${newNodeBn.errors}" />
    </c:redirect>
</c:if>

<c:if test="${newNodeBn.doUpdate == true}">
    <!-- update links again -->
    <c:if test="${treeBn.restarted == false}">
        <c:redirect url="/control/logout.jsp" >
            <c:param name="errors" value="${treeBn.errors}" />
        </c:redirect>
    </c:if>
</c:if>

<!-- close dB connection -->
<c:if test="${connBn.closed == false}">
    <c:redirect url="/control/logout.jsp" >
        <c:param name="errors" value="${connBn.errors}" />
    </c:redirect>
</c:if>

<c:redirect url="/zmain.jsp" />