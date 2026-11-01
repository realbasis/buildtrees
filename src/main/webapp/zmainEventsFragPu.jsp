<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

<style type="text/css">
div#paint
{
	background-color:white;
	font-size:11px;
}
</style>

<jsp:useBean id="postBean" class="utility.PostBean" />
<jsp:setProperty name="postBean" property="aid" value="${accountID}" />
<jsp:setProperty name="postBean" property="treeBean" value="${treeBean}" />

<!-- create events list -->
<c:if test="${postBean.processed == true}"></c:if>

<div id="paint">
			<c:forEach items="${postBean.listAnniv}" var="event">
			<ul>
				<c:if test="${event.Days == 0}">
					<c:if test="${event.Author == 'me'}">
						<c:url var="enter0Url" value="control/doChangeProfile.jsp">
							<c:param name="id" value="${event.PeopleID}"/>
						</c:url>
						<c:if test="${event.Type == 'Birthday'}">
							<c:set var="msg" value="Handè, co l'anniversaire ho ${event.Name}, mo diogu ${event.Age} ans."/>
						</c:if>
						<c:if test="${event.Type == 'Death'}">
							<c:set var="msg" value="Handè co gnaladè co men madji don ${event.Name}.  Hi mo dani è boutou bula${event.Age} ans."/>
						</c:if>
					</c:if>
					<c:if test="${event.Author != 'me'}">
						<c:url var="enter0Url" value="control/doBridge.jsp">
							<c:param name="peopleID" value="${event.PeopleID}"/>
						</c:url>
						<c:if test="${event.Type == 'Birthday'}">
							<c:set var="msg" value="Handè, onssoumana ${event.Author}, co l'anniversaire ho ${event.Name}, mo diogu ${event.Age} ans."/>
						</c:if>
						<c:if test="${event.Type == 'Death'}">
							<c:set var="msg" value="Handè, onssouma ${event.Author}, co gnaladè co men madji don ${event.Name}.  hi mo dani è boutou bula ${event.Age} ans."/>
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
							<c:set var="msg" value="Dère ${event.Days} gnaladè, wonahi l'anniversaire ho ${event.Name}, mo hébaye ${event.Age} ans."/>
						</c:if>
						<c:if test="${event.Type == 'Death'}">
							<fmt:formatDate var="date" value="${event.Date}" pattern="MMM-dd-yyyy"/>
							<c:set var="msg" value="Dère ${event.Days} gnaladè, wonahi co men madji don ${event.Name}, co honbo maye le ${date}."/>
						</c:if>
					</c:if>
					<c:if test="${event.Author != 'me'}">
						<c:url var="enter15Url" value="control/doBridge.jsp">
							<c:param name="peopleID" value="${event.PeopleID}"/>
						</c:url>
						<c:if test="${event.Type == 'Birthday'}">
							<c:set var="msg" value="Onssouma ${event.Author}, dère ${event.Days} gnaladè, wonahi l'anniversaire ho ${event.Name}, mo hébaye${event.Age} ans."/>
						</c:if>
						<c:if test="${event.Type == 'Death'}">
							<fmt:formatDate var="date" value="${event.Date}" pattern="MMM-dd-yyyy"/>
							<c:set var="msg" value="Onssouma ${event.Author}, dère ${event.Days} gnaladè, wonahi gnaladè co men madji don ${event.Name}, co honbo maye le ${date}."/>
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
							<c:set var="msg" value="Dère ${event.Days} gnaladè, wonahi l'anniversaire ho ${event.Name}, mo hébaye ${event.Age} ans."/>
						</c:if>
						<c:if test="${event.Type == 'Death'}">
							<fmt:formatDate var="date" value="${event.Date}" pattern="MMM-dd-yyyy"/>
							<c:set var="msg" value="Dère ${event.Days} gnaladè, wonahi gnaladè co men madji don ${event.Name}, co maye le ${date}."/>
						</c:if>
					</c:if>
					<c:if test="${event.Author != 'me'}">
						<c:url var="enter31Url" value="control/doBridge.jsp">
							<c:param name="peopleID" value="${event.PeopleID}"/>
						</c:url>
						<c:if test="${event.Type == 'Birthday'}">
							<c:set var="msg" value="Onssouma ${event.Author}, dère ${event.Days} gnaladè, wonahi l'anniversaire ho ${event.Name}, mo hébaye${event.Age} ans."/>
						</c:if>
						<c:if test="${event.Type == 'Death'}">
							<fmt:formatDate var="date" value="${event.Date}" pattern="MMM-dd-yyyy"/>
							<c:set var="msg" value="Onssouma ${event.Author}, dère${event.Days} gnaladè, wonahi gnaladè co men madji don  ${event.Name}, co hombo maye le ${date}."/>
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
							<c:set var="msg" value="Dère ${event.Days} gnaladè, wonahi l'anniversaire ho ${event.Name}, mo hébaye${event.Age} ans."/>
						</c:if>
						<c:if test="${event.Type == 'Death'}">
							<fmt:formatDate var="date" value="${event.Date}" pattern="MMM-dd-yyyy"/>
							<c:set var="msg" value="Dère ${event.Days} gnaladè, wonahi gnaladè,co men madji don ${event.Name}, co hombo maye le ${date}."/>
						</c:if>
					</c:if>
					<c:if test="${event.Author != 'me'}">
						<c:url var="enter32Url" value="control/doBridge.jsp">
							<c:param name="peopleID" value="${event.PeopleID}"/>
						</c:url>
						<c:if test="${event.Type == 'Birthday'}">
							<c:set var="msg" value="Onssouma ${event.Author}, dère${event.Days} gnaladè, wonahi l'anniversaire ho${event.Name}, mo hébaye${event.Age} ans."/>
						</c:if>
						<c:if test="${event.Type == 'Death'}">
							<fmt:formatDate var="date" value="${event.Date}" pattern="MMM-dd-yyyy"/>
							<c:set var="msg" value="Onssouma ${event.Author}, dère${event.Days} gnaladè, wonahi gnaladè co men madji don${event.Name}, co hombo mayele ${date}."/>
						</c:if>
					</c:if>
					<li>
						${msg}
					</li>
				</c:if>
			</ul>
			</c:forEach>
</div>