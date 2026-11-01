<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

<jsp:useBean id="postBean" class="utility.PostBean" />
<c:set var="theURL" value="${pageContext.request.requestURL}" />

<!-- create events list -->
<jsp:setProperty name="postBean" property="aid" value="${accountID}" />
<c:if test="${postBean.processed == true}"></c:if>


	<div id="me" style="margin-top:15px; padding-bottom:20px">
		<div>
			<form method="post" action="control/doRecordZevent.jsp">
				<table align="center">
					<tr>
						<td colspan="5" align="center" style="font-style:italic; color:red; font-weight:bold">
							${param.ans}
						</td>
					</tr>
					<tr>
						<td>
							<br />
							Type
							<br />
							<select name="type">
								<option>Baptism</option>
								<option>Funeral</option>
								<option>Reunion</option>
								<option>Wedding</option>
								<option>Other</option>
							</select>
						</td>
						<td>
							<br />
							Comment
							<br />
							<input type="text" name="comment" />
						</td>
						<td>
							<br />
							Date of event
							<br />
							<script>DateInput('eventDate', true, 'MON-DD-YYYY')</script>
						</td>
						<td align="center" width="100">
							Days Between 
							Alarm & Event
							<br />
							<select name="alarmDays">
								<c:forEach items="${languageBean.gapList}" var="row">
									<option>${row}</option>
								</c:forEach>
							</select>
						</td>
						<td>
							<br /><br />
							<input type="submit" value="record event" />
						</td>
					</tr>
				</table>
			</form>
		</div>
		
		<div class="paint">
			<h3 style="font-family:Geneva, Arial, Helvetica, sans-serif; font-style:italic">${languageBean.familyEvents}</h3>
			<c:forEach items="${postBean.listEvents}" var="event">
				<ul>
					<li>
						<c:if test="${event.Rang == 'no'}">
							<fmt:formatDate var="alarmDate" value="${event.AlarmDate}" pattern="MMM-dd-yyyy" />
							<c:url var="removeUrl" value="control/doDelEvent.jsp">
								<c:param name="id" value="${event.EventID}"/>
							</c:url>
							<c:if test="${event.Author == 'me'}">
								<c:set var="msg" value="On ${alarmDate}, you will receive a reminder for the event  [${event.Type} ${event.Comment}] occuring ${event.AlarmDays} days later." />
							</c:if>
							<c:if test="${event.Author != 'me'}">
								<c:set var="msg" value="According to ${event.Author}, on ${alarmDate}, you will receive a reminder for event [${event.Type} ${event.Comment}] occuring ${event.AlarmDays} later." />
							</c:if>
							${msg}    <a href="<c:out value="${removeUrl}"/>">remove</a>
						</c:if>
					</li>
				</ul>
			</c:forEach>
		</div>
		
		<div class="paint">
			<h3 style="font-family:Geneva, Arial, Helvetica, sans-serif; font-style:italic">${languageBean.familyAnniv}</h3>
			<c:forEach items="${postBean.listAnniv}" var="event">
			<ul>
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
						${msg} <a href="<c:out value="${enter0Url}"/>">view</a>
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
						${msg} <a href="<c:out value="${enter15Url}"/>">view</a>
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
						${msg} <a href="<c:out value="${enter31Url}"/>">view</a>
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
						${msg} <a href="<c:out value="${enter32Url}"/>">view</a>
					</li>
				</c:if>
			</ul>
			</c:forEach>
		</div>
	</div>