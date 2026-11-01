<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/control/stdTags.jspf" %>

<h4 style="text-align:center; margin-top:10px">INVITE A GUEST TO HELP YOU BUILD YOUR TREE</h4>
<div>
	<c:if test="${param.ref == 5}">
    <table>
        <tr>
            <td align='center' style='color:red; font-style:italic'>${param.errors}</td>
        </tr>
		<tr>
			<td align="center">
				<form action="invite.jsp" method="post">
					<input type="submit" value="send another email">
					<input type="hidden" name="treeID" value="${param.treeID}">
					<input type="hidden" name="name" value="${param.name}">
					<input type="hidden" name="peopleID" value="${param.peopleID}">
					<input type="hidden" name="ref" value="1">
					<input type="hidden" name="other" value="${param.other}">
					<input type="hidden" name="accountOwner" value="${param.accountOwner}">
					<input type="hidden" name="emailo" value="${param.emailo}">
				</form>
			</td>
		</tr>
	</table>
	</c:if>
	<form action='control/doGuestInvite.jsp' method='post' name="inviteForm">
	<c:if test="${param.ref != 5}">
    <table>
        <tr>
            <td colspan='2' align='center' style='color:red; font-style:italic'>${param.errors}</td>
        </tr>
		<tr>
            <td>Guest Name: <span class="style1">*</span></td>
            <td><input type="text" name='guestname' value="${param.guestname}" size='50'></td>
        </tr>
        <tr>
            <td>Guest Email: <span class="style1">*</span></td>
            <td><input type="text" name='email' value="${param.email}" size='50'></td>
        </tr>
	</table>
	<table>
		<tr>
			<td colspan="2"><hr style="color:green" /></td>
		</tr>
        <tr>
            <th colspan='2' style="color:green" align="left">
				Message: (optional)
			</th>
        </tr>
        <tr>
            <td colspan='2'>
                <textarea cols='50' rows='4' name='body'>${param.body}</textarea>
            </td>
        </tr>
		<tr>
			<td colspan="2"><hr style="color:green" /></td>
		</tr>
        <tr>
            <td align='left'>
				<table>
					<tr>
						<!--
						<td><input type='checkbox' name='selfcopy'></td>
						<td>Get Copy</td>
						-->
						<td colspan="2"></td>
					</tr>
				</table>
			</td>
            <td align='right'><input type='submit' value='SEND EMAIL' name="sendEmail" onclick="inviteForm.sendEmail.value='Processing...'"></td>
        </tr>
            <input type='hidden' name='treeID' value="${param.treeID}">
			<input type='hidden' name='name' value="${param.name}">
			<input type='hidden' name='other' value="${param.other}">
			<input type="hidden" name="emailo" value="${param.emailo}">
			<input type="hidden" name="accountOwner" value="${param.accountOwner}" />
    </table>
	</c:if>
	</form>
</div>
<c:url var="viewtreeUrl" value="/mytree.jsp">
    <c:param name="ref" value="1" />
    <c:param name="treeID" value="${param.treeID}" />
	<c:param name="other" value="${param.other}" />
	<c:param name="emailo" value="${param.emailo}" />
	<c:param name="accountOwner" value="${param.accountOwner}" />
</c:url>
<div style="margin-bottom:10px"><p><a href="<c:out value="${viewtreeUrl}"/>">Back to Tree</a></p></div>