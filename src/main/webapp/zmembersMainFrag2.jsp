<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

<sql:query var="result">
	select Sharers.Status, Zpeople.* from Sharers, Zpeople 
	where Sharers.MyAccountID=? 
	And Zpeople.Title=? 
	And Sharers.AccountID = Zpeople.AccountID 
	Order By Status
  	<sql:param value="${accountID}" />
	<sql:param value="owner" />
</sql:query>

<div class="ligne" id="parents" style="margin:30px 10px 60px 50px">
	<h3>Members of your family tree</h3>
	
		<c:if test="${param.search == null}">
			<div style="background-color:#33FF33; padding:20px 4px 4px 4px; width:350px; height:120px">
				<form action="control/doFindProfile.jsp" method="post">
				<p>
					Search people by EMAIL
					<c:if test="${param.emailErrors != null}">
						<br />
						<span class="style1" style="font-weight:bold">
							*** ${param.emailErrors} ***
						</span>
					</c:if>
					<table align="center">
						<tr>
							<td colspan="2"><hr /></td>
						</tr>
						<tr>
							<td>
								<input type="text" name="email" size="25" value="${param.email}" />
							</td>
							<td>
								<input type="submit" value="Search" />
							</td>
						</tr>
					</table>
				</p>
				</form>
			</div>
		</c:if>
		<c:if test="${param.search == 'no'}">
			<div style="background-color:#33FF33; padding:20px 4px 4px 4px; width:350px; height:120px">
				<form action="zmembers.jsp" method="post">
				<p>
					<table align="center">
						<tr>
							<td>
								Email not found...
							</td>
							<td>
								<input type="submit" value="Continue" />
							</td>
						</tr>
					</table>
				</p>
				</form>
			</div>
		</c:if>
		<c:if test="${param.search == 'yes'}">
			<div style="background-color:#33FF33; padding:20px 4px 20px 4px; width:350px; height:200px">
				<sql:query var="zpeople">
					Select * from Zpeople Where Email = ? And AccountID = ?
			        <sql:param value="${param.email}" />
					<sql:param value="${param.guestID}" />
				</sql:query>
				<c:forEach items="${zpeople.rows}" var="item">
					<p>
						<table align="center">
							<tr>
								<td valign="middle">
									Profile has been found...
								</td>
								<td>
									<form action="control/doInviteProfile.jsp" method="post">
										<input type="submit" value="Invite" />
										<input type="hidden" name="guestID" value="${param.guestID}" />
										<input type="hidden" name="guestname" value="${item.Name}" />
										<input type="hidden" name="email" value="${item.Email}" />
									</form>
								</td>
								<td>
									<form action="zmembers.jsp" method="post">
										<input type="submit" value="Cancel" />
									</form>
								</td>
							</tr>
						</table>
					</p>
					<div class="screen" style="border:solid 1px" align="center">
						<table>
							<tr>
								<td valign="top">
									<c:if test="${item.ImageName == 'none'}">
										<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
											<br />
											NO
											<br /><br />
											PHOTO
										</div>
									</c:if>
									<c:if test="${item.ImageName != 'none'}">
												<div align="center">
													<img class="image" src='<c:out value="control/doGetImg.jsp?id=${item.PeopleID}" />'>
												</div>
											</c:if>
								</td>
								<td valign="top">
									<div class="textZone">
										<span style="font-size:14px; font-weight:bold">
											<br />
											<c:if test="${fn:length(item.Name) > 15}">
												<span title="${item.Name}">${fn:substring(item.Name, 0, 13)}...</span>
											</c:if>
											<c:if test="${fn:length(item.Name) <= 15}">
												${item.Name}
											</c:if>
										</span>
										<c:if test="${item.GotBirthdate == 'on'}">
											<br />
											${languageBean.zmainBornOn} <fmt:formatDate value="${item.Birthdate}" pattern="MM/dd/yy" />
										</c:if>
										<c:if test="${item.IsDeceased == 'on'}">
											<br />
											${languageBean.zmainPassedOn} <fmt:formatDate value="${item.Deceased}" pattern="MM/dd/yy" />
										</c:if>
										<br /><br />
									</div>
								</td>
							</tr>
						</table>
					</div>
				</c:forEach>
			</div>
		</c:if>
		<c:if test="${param.search == 'invited'}">
			<div style="background-color:#33FF33; padding:20px 4px 20px 4px; width:350px; height:120px">
					<p>
						<table align="center">
							<tr>
								<td valign="middle">
									Profile has been invited to join you...
								</td>
								<td>
									<form action="zmembers.jsp" method="post">
										<input type="submit" value="Continue" />
									</form>
								</td>
							</tr>
						</table>
					</p>
			</div>
		</c:if>
	
	<c:forEach items="${result.rows}" var="item">
	<table style="margin-top:20px; margin-left:40px">
		<c:if test="${item.Status == 0}">
			<tr>
				<td>
					<div class="screen" style="border:solid 1px" align="center">
						<table>
							<tr>
								<td valign="top">
									<c:if test="${item.ImageName == 'none'}">
										<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
											<br />
											NO
											<br /><br />
											PHOTO
										</div>
									</c:if>
									<c:if test="${item.ImageName != 'none'}">
												<div align="center">
													<img class="image" src='<c:out value="control/doGetImg.jsp?id=${item.PeopleID}" />'>
												</div>
											</c:if>
								</td>
								<td valign="top">
									<div class="textZone">
										<span style="font-size:14px; font-weight:bold">
											<br />
											<c:if test="${fn:length(item.Name) > 15}">
												<span title="${item.Name}">${fn:substring(item.Name, 0, 13)}...</span>
											</c:if>
											<c:if test="${fn:length(item.Name) <= 15}">
												${item.Name}
											</c:if>
										</span>
										<c:if test="${item.GotBirthdate == 'on'}">
											<br />
											${languageBean.zmainBornOn} <fmt:formatDate value="${item.Birthdate}" pattern="MM/dd/yy" />
										</c:if>
										<c:if test="${item.IsDeceased == 'on'}">
											<br />
											${languageBean.zmainPassedOn} <fmt:formatDate value="${item.Deceased}" pattern="MM/dd/yy" />
										</c:if>
										<br /><br />
									</div>
								</td>
							</tr>
						</table>
					</div>
				</td>
				<td class="memberBox" valign="top">GOT INVITE</td>
				<td valign="top">
					<form method="post" action="control/doZmembers.jsp">
						<input type="submit" name="reaction" value="confirm" />
						<input type="hidden" name="guestID" value="${item.AccountID}" />
					</form>
				</td>
				<td valign="top">
					<form method="post" action="control/doZmembers.jsp">
						<input type="submit" name="reaction" value="deny" />
						<input type="hidden" name="guestID" value="${item.AccountID}" />
					</form>
				</td>
			</tr>
		</c:if>
		<c:if test="${item.Status == 1}">
			<tr>
				<td>
					<div class="screen" style="border:solid 1px" align="center">
						<table>
							<tr>
								<td valign="top">
									<c:if test="${item.ImageName == 'none'}">
										<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
											<br />
											NO
											<br /><br />
											PHOTO
										</div>
									</c:if>
									<c:if test="${item.ImageName != 'none'}">
												<div align="center">
													<img class="image" src='<c:out value="control/doGetImg.jsp?id=${item.PeopleID}" />'>
												</div>
											</c:if>
								</td>
								<td valign="top">
									<div class="textZone">
										<span style="font-size:14px; font-weight:bold">
											<br />
											<c:if test="${fn:length(item.Name) > 15}">
												<span title="${item.Name}">${fn:substring(item.Name, 0, 13)}...</span>
											</c:if>
											<c:if test="${fn:length(item.Name) <= 15}">
												${item.Name}
											</c:if>
										</span>
										<c:if test="${item.GotBirthdate == 'on'}">
											<br />
											${languageBean.zmainBornOn} <fmt:formatDate value="${item.Birthdate}" pattern="MM/dd/yy" />
										</c:if>
										<c:if test="${item.IsDeceased == 'on'}">
											<br />
											${languageBean.zmainPassedOn} <fmt:formatDate value="${item.Deceased}" pattern="MM/dd/yy" />
										</c:if>
										<br /><br />
									</div>
								</td>
							</tr>
						</table>
					</div>
				</td>
				<td class="memberBox" valign="top">INVITE PENDING</td>
				<td colspan="2" valign="top">
					<form method="post" action="control/doZmembers.jsp">
						<input type="submit" name="reaction" value="abandon" />
						<input type="hidden" name="guestID" value="${item.AccountID}" />
					</form>
				</td>
			</tr>	
		</c:if>
		<c:if test="${item.Status == 2}">
			<tr>
				<td>
					<div class="screen" style="border:solid 1px" align="center">
						<table>
							<tr>
								<td valign="top">
									<c:if test="${item.ImageName == 'none'}">
										<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
											<br />
											NO
											<br /><br />
											PHOTO
										</div>
									</c:if>
									<c:if test="${item.ImageName != 'none'}">
												<div align="center">
													<img class="image" src='<c:out value="control/doGetImg.jsp?id=${item.PeopleID}" />'>
												</div>
											</c:if>
								</td>
								<td valign="top">
									<div class="textZone">
										<span style="font-size:14px; font-weight:bold">
											<br />
											<c:if test="${fn:length(item.Name) > 15}">
												<span title="${item.Name}">${fn:substring(item.Name, 0, 13)}...</span>
											</c:if>
											<c:if test="${fn:length(item.Name) <= 15}">
												${item.Name}
											</c:if>
										</span>
										<c:if test="${item.GotBirthdate == 'on'}">
											<br />
											${languageBean.zmainBornOn} <fmt:formatDate value="${item.Birthdate}" pattern="MM/dd/yy" />
										</c:if>
										<c:if test="${item.IsDeceased == 'on'}">
											<br />
											${languageBean.zmainPassedOn} <fmt:formatDate value="${item.Deceased}" pattern="MM/dd/yy" />
										</c:if>
										<br /><br />
									</div>
								</td>
							</tr>
						</table>
					</div>
				</td>
				<td class="memberBox" valign="top">CONNECTED</td>
				<td colspan="2"></td>
			</tr>
		</c:if>
	</table>	
	</c:forEach>
	
	<h4 style="text-decoration:underline">Disconnecting a member</h4>
	<table style="margin-top:20px; margin-left:40px">
		<form method="post" action="control/doZmembers.jsp">
		<tr>
			<td valign="top">
				<select name="guestID">
					<option value="-1">Select Member</option>
					<c:forEach items="${result.rows}" var="item">
						<c:if test="${item.Status == 2}">
							<option value="${item.AccountID}">${item.Name}</option>
						</c:if>
					</c:forEach>
				</select>
			</td>
			<td valign="top">
				<input type="submit" name="reaction" value="disconnect" />
			</td>
			<td valign="top">
				<p style="font-weight:bold; color:red; font-size:14px; text-align:center; width:300px">
					Warning!  Disconnecting a member
					<br />
					can alter the family tree
				</p>
			</td>
		</tr>
		</form>
	</table>
</div>