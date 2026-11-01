<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

<style type="text/css">
div#paint
{
	background-color:white;
	font-size:11px;
}
div#paint ul
{
	margin:0;
}
</style>

<jsp:useBean id="postBean" class="utility.PostBean" />
<jsp:setProperty name="postBean" property="aid" value="${accountID}" />
<jsp:setProperty name="postBean" property="treeBean" value="${treeBean}" />

<!-- create events list -->
<c:if test="${postBean.processed == true}"></c:if>

<div id="paint">
		<ul>
			<li> * F A M I L Y * * * A N N I V E R S A R I E S * </li>
			<c:forEach items="${postBean.listAnniv}" var="event">
				<c:if test="${event.Days == 0}">
					<c:if test="${event.Author == 'me'}">
						<c:url var="enter0Url" value="control/doChangeProfile.jsp">
							<c:param name="id" value="${event.PeopleID}"/>
						</c:url>
						<c:if test="${event.Type == 'Birthday'}">
							<c:set var="msg" value="Today, it is the birthday of ${event.Name}, who will be ${event.Age}."/>
						</c:if>
						<c:if test="${event.Type == 'Death'}">
							<c:set var="msg" value="Today, it is the day we lost ${event.Name}.  He rested in peace ${event.Age} ago."/>
						</c:if>
					</c:if>
					<c:if test="${event.Author != 'me'}">
						<c:url var="enter0Url" value="control/doBridge.jsp">
							<c:param name="peopleID" value="${event.PeopleID}"/>
						</c:url>
						<c:if test="${event.Type == 'Birthday'}">
							<c:set var="msg" value="Today, according to ${event.Author}, it is the birthday of ${event.Name}, who will be ${event.Age}."/>
						</c:if>
						<c:if test="${event.Type == 'Death'}">
							<c:set var="msg" value="Today, according to ${event.Author}, it is the day we lost ${event.Name}.  He rested in peace ${event.Age} ago."/>
						</c:if>
					</c:if>
					<li style="color:red">
						${msg}
					</li>
				</c:if>
				<c:if test="${event.Days > 0 && event.Days <= 15}">
					<c:if test="${event.Author == 'me'}">
						<c:url var="enter15Url" value="control/doChangeProfile.jsp">
							<c:param name="id" value="${event.PeopleID}"/>
						</c:url>
						<c:if test="${event.Type == 'Birthday'}">
							<c:set var="msg" value="In ${event.Days} days, it will be the birthday of ${event.Name}, who will be ${event.Age}."/>
						</c:if>
						<c:if test="${event.Type == 'Death'}">
							<fmt:formatDate var="date" value="${event.Date}" pattern="MMM-dd-yyyy"/>
							<c:set var="msg" value="In ${event.Days} days, it will be the day we lost ${event.Name}.  This event happened on ${date}."/>
						</c:if>
					</c:if>
					<c:if test="${event.Author != 'me'}">
						<c:url var="enter15Url" value="control/doBridge.jsp">
							<c:param name="peopleID" value="${event.PeopleID}"/>
						</c:url>
						<c:if test="${event.Type == 'Birthday'}">
							<c:set var="msg" value="According to ${event.Author}, in ${event.Days} days, it will be the birthday of ${event.Name}, who will be ${event.Age}."/>
						</c:if>
						<c:if test="${event.Type == 'Death'}">
							<fmt:formatDate var="date" value="${event.Date}" pattern="MMM-dd-yyyy"/>
							<c:set var="msg" value="According to ${event.Author}, in ${event.Days} days, it will be the day we lost ${event.Name}.  This event happened on ${date}."/>
						</c:if>
					</c:if>
					<li style="color:#996600">
						${msg}
					</li>
				</c:if>
				<c:if test="${event.Days > 15 && event.Days <= 31}">
					<c:if test="${event.Author == 'me'}">
						<c:url var="enter31Url" value="control/doChangeProfile.jsp">
							<c:param name="id" value="${event.PeopleID}"/>
						</c:url>
						<c:if test="${event.Type == 'Birthday'}">
							<c:set var="msg" value="In ${event.Days} days, it will be the birthday of ${event.Name}, who will be ${event.Age}."/>
						</c:if>
						<c:if test="${event.Type == 'Death'}">
							<fmt:formatDate var="date" value="${event.Date}" pattern="MMM-dd-yyyy"/>
							<c:set var="msg" value="In ${event.Days} days, it will be the day we lost ${event.Name}.  This event happened on ${date}."/>
						</c:if>
					</c:if>
					<c:if test="${event.Author != 'me'}">
						<c:url var="enter31Url" value="control/doBridge.jsp">
							<c:param name="peopleID" value="${event.PeopleID}"/>
						</c:url>
						<c:if test="${event.Type == 'Birthday'}">
							<c:set var="msg" value="According to ${event.Author}, in ${event.Days} days, it will be the birthday of ${event.Name}, who will be ${event.Age}."/>
						</c:if>
						<c:if test="${event.Type == 'Death'}">
							<fmt:formatDate var="date" value="${event.Date}" pattern="MMM-dd-yyyy"/>
							<c:set var="msg" value="According to ${event.Author}, in ${event.Days} days, it will be the day we lost ${event.Name}.  This event happened on ${date}."/>
						</c:if>
					</c:if>
					<li style="color:orange">
						${msg}
					</li>
				</c:if>
				<c:if test="${event.Days > 31}">
					<c:if test="${event.Author == 'me'}">
						<c:url var="enter32Url" value="control/doChangeProfile.jsp">
							<c:param name="id" value="${event.PeopleID}"/>
						</c:url>
						<c:if test="${event.Type == 'Birthday'}">
							<c:set var="msg" value="In ${event.Days} days, it will be the birthday of ${event.Name}, who will be ${event.Age}."/>
						</c:if>
						<c:if test="${event.Type == 'Death'}">
							<fmt:formatDate var="date" value="${event.Date}" pattern="MMM-dd-yyyy"/>
							<c:set var="msg" value="In ${event.Days} days, it will be the day we lost ${event.Name}.  This event happened on ${date}."/>
						</c:if>
					</c:if>
					<c:if test="${event.Author != 'me'}">
						<c:url var="enter32Url" value="control/doBridge.jsp">
							<c:param name="peopleID" value="${event.PeopleID}"/>
						</c:url>
						<c:if test="${event.Type == 'Birthday'}">
							<c:set var="msg" value="According to ${event.Author}, in ${event.Days} days, it will be the birthday of ${event.Name}, who will be ${event.Age}."/>
						</c:if>
						<c:if test="${event.Type == 'Death'}">
							<fmt:formatDate var="date" value="${event.Date}" pattern="MMM-dd-yyyy"/>
							<c:set var="msg" value="According to ${event.Author}, in ${event.Days} days, it will be the day we lost ${event.Name}.  This event happened on ${date}."/>
						</c:if>
					</c:if>
					<li>
						${msg}
					</li>
				</c:if>
			</c:forEach>
		</ul>
</div>