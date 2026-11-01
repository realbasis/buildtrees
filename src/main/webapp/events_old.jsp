<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/privateLinked.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- InstanceBeginEditable name="doctitle" -->
<title>Family Tree Builder..Mankind Connected</title>
<!-- InstanceEndEditable -->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/linked.css" rel="stylesheet" type="text/css">
<%@include file="/control/stdTags.jspf" %>
<c:set var="theURI" value="${pageContext.request.requestURI}" />
<c:if test="${languageBean == null}">
	<jsp:useBean id="languageBean" class="value.LanguageBean" scope="session" />
</c:if>
<!-- InstanceBeginEditable name="head" -->
<style type="text/css">
div#paint
{
	background-color:white;
	width:600px;
	padding: 10px 10px 10px 10px;
	margin:0px 0px 20px 40px;
	border:solid;
}
.tableau
{
	width:700px;
	font-size:24px;
}

.ligne
{
	width:700px;
	margin-bottom:5px;
}
.cell
{
	width:200px;
/*	background-color:#CCCCCC; */
	background-color:white;
	border:solid 1px blue;
	text-align:center;
	height:60px;
	padding-top:20px;
	margin-bottom:5px;
}
.zhead
{
	width:200px;
	text-align:center;
}
.image
{
	background-color:#CCCCCC;
	width:100px;
	height:100px;
}
a img
{
	border:none;
}
a
{
	text-decoration:none;
}
</style>

<jsp:useBean id="postBean" class="utility.PostBean" />

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<jsp:setProperty name="postBean" property="aid" value="${accountID}" />

<!-- create events list -->
<c:if test="${postBean.processed == true}"></c:if>

<!-- InstanceEndEditable -->
</head>

<body onload="document.getElementById('theText').focus(); createAutoComplete();">

<table align="left" class="noborder"><tr><td>
<div id="zmain">
	<div id="banner" align="center">
		<table align="center" width="100%">
			<tr>
				<td align="left">
					<c:choose>
						<c:when test="${flag == 7}">
							<a href="main.jsp"><img style="border:none; text-decoration:none" src="images/buildtrees_logo2.png"></a>
						</c:when>
						<c:otherwise>
							<a href="index.jsp"><img style="border:none; text-decoration:none" src="images/buildtrees_logo2.png"></a>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<table align="center">
						<tr>
						  <td align="center">
                          <c:choose>
							<c:when test="${flag == null}">                                
							    <!-- InstanceBeginEditable name="EditRegionTop" -->
                                
								<!-- InstanceEndEditable -->
                          </c:when>
						  <c:when test="${flag == 7}">
							    <!-- InstanceBeginEditable name="EditMenu" -->
								<jsp:include flush="true" page="${languageBean.eventsHeadFrag}" />
								<!-- InstanceEndEditable -->
							</c:when>
                            <c:otherwise></c:otherwise>
                            </c:choose>						
						  </td>
					  </tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
	
    <!-- InstanceBeginEditable name="content" -->
	<div id="me" style="margin-top:15px; padding-bottom:20px">
		<div id="paint">
			<h3 style="font-family:Geneva, Arial, Helvetica, sans-serif; font-style:italic">Family Events</h3>
			<c:forEach items="${postBean.list}" var="event">
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
						${msg} <a href="<c:out value="${enter0Url}"/>">enter</a>
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
						${msg} <a href="<c:out value="${enter15Url}"/>">enter</a>
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
						${msg} <a href="<c:out value="${enter31Url}"/>">enter</a>
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
						${msg} <a href="<c:out value="${enter32Url}"/>">enter</a>
					</li>
				</c:if>
			</ul>
			</c:forEach>
		</div>
	</div>
	<!-- InstanceEndEditable -->
</div>
</td></tr></table>

<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-544679-2";
urchinTracker();
</script>

</body>
<!-- InstanceEnd --></html>
