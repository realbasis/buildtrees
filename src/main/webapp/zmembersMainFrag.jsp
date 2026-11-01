<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.LinkedList,java.util.SortedMap,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>

<%@include file="/control/stdTags.jspf" %>

<jsp:useBean id="treeLogicBean" class="utility.TreeLogicBean" />

<%

boolean success = true;

ConnBean connBean = null;
SortedMap maps[] = null;

TreeBean treeBean = (TreeBean) session.getAttribute("treeBean");
Integer accountID = (Integer) session.getAttribute("accountID");

connBean = new ConnBean();
success = connBean.isStarted();

// create members
success = treeLogicBean.createMembers(accountID);
maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());
treeBean.setMembers(maps);

// create treeMap of members
TreeMap membersTmap = new TreeMap();
int membersSize = 0;
if(maps != null)
    membersSize = maps.length;
for(int i=0; i<membersSize; i++) {
    Integer aid = (Integer) maps[i].get("AccountID");
    membersTmap.put(aid, maps[i]);
}
// add accountID of self in red list
membersTmap.put(accountID, accountID);

// create suggestions
success = treeLogicBean.createSuggestions(treeBean.getSharers());
maps = connBean.select(treeLogicBean.getMsg(), treeLogicBean.getValues());

// eliminate duplicates from members and from suggested list
LinkedList suggestionsList = new LinkedList();
int suggSize = 0;
if(maps != null)
    suggSize = maps.length;
for(int i=0; i<suggSize; i++) {
    Integer suggId = (Integer) maps[i].get("AccountID");
    if(membersTmap.get(suggId) == null) {
		// check that member not already suggested
		int listSize = 0;
                boolean isUnique = true;
		if(suggestionsList != null)
			listSize = suggestionsList.size();
                        for(int j=0; j<listSize; j++) {
                            SortedMap mapAccount = (SortedMap) suggestionsList.get(j);
                            Integer aID = (Integer) mapAccount.get("AccountID");
                            if(aID.intValue() == suggId.intValue())
                                isUnique = false;
                        }
                        if(isUnique)
                            suggestionsList.addLast(maps[i]);
	}
        
}

treeBean.setSuggestions(suggestionsList);

success = connBean.isClosed();

%>

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
				<form action="control/doSendInvite.jsp" method="post">
				<p>
                	<p class="style1" style="font-weight:bold">
                    	Search for ${param.email} is unsuccessful.
                        <br />
                        An invitation to Buildtrees is required.
                    </p>
					<table align="center">
                        <tr>
                            <td style="font-weight:bold" align="center">
                            	First & Last Name <span style="color:red">${param.required}</span>
                                <br />
                            	<input type="text" name="name" value="" />
                            </td>
                            <td>
                                <br />
								<input type="submit" name="todo" value="Cancel" />
							</td>
							<td>
                                <br />
								<input type="submit" name="todo" value="Invite" />
                                <input type="hidden" name="email" value="${param.email}" />
							</td>
						</tr>
					</table>
				</p>
				</form>
			</div>
		</c:if>
        <c:if test="${param.search == 'invalid'}">
			<div style="background-color:#33FF33; padding:20px 4px 4px 4px; width:350px; height:120px">
				<form action="zmembers.jsp" method="post">
				<p>
					<table align="center">
						<tr>
							<td>
								Email is invalid...
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
        <c:if test="${param.search == 'done'}">
			<div style="background-color:#33FF33; padding:20px 4px 4px 4px; width:350px; height:120px">
				<form action="zmembers.jsp" method="post">
				<p>
					<table align="center">
						<tr>
							<td>
								Email has been sent...
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
								<th valign="middle">
									Profile has been found...
								</th>
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
	
	<c:forEach items="${treeBean.members}" var="item">
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
	
<!-- suggestions -->
	<c:forEach items="${treeBean.suggestions}" var="item">
		<table style="margin-top:20px; margin-left:40px">
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
										<br /><br />
									</div>
								</td>
							</tr>
						</table>
					</div>
				</td>
				<td class="memberBox" valign="top">
                	SUGGESTION
                </td>
				<td valign="top">
					<form action="control/doInviteProfile.jsp" method="post">
						<input type="submit" value="Invite" />
						<input type="hidden" name="guestID" value="${item.AccountID}" />
						<input type="hidden" name="guestname" value="${item.Name}" />
						<input type="hidden" name="email" value="${item.Email}" />
					</form>
				</td>
				<td valign="top">
				</td>
			</tr>
		</table>
	</c:forEach>
	
	<h4 style="text-decoration:underline">Disconnecting a member</h4>
	<table style="margin-top:20px; margin-left:40px">
		<form method="post" action="control/doZmembers.jsp">
		<tr>
			<td valign="top">
				<select name="guestID">
					<option value="-1">Select Member</option>
                    <c:forEach items="${treeBean.members}" var="item">
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