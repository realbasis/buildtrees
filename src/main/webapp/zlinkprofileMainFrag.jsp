<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

<c:set var="theURL" value="${pageContext.request.requestURL}" />

		<div style="text-align:center; margin-top:20px; font-weight:bold">

			<c:choose>
			<c:when test="${treeBean.param1 == 'Boyfriend' || treeBean.param1 == 'Girlfriend'}">
				<!-- <h4>Who is the Friend of ${treeBean.me.Name}?</h4> -->
				<h4>ADD FRIEND PROFILE</h4>
			</c:when>
			<c:when test="${treeBean.param1 == 'Husband_Partner'}">
				<!-- <h4>Who is the Friend of ${treeBean.me.Name}?</h4> -->
				<h4>ADD HUSBAND PROFILE</h4>
			</c:when>
			<c:when test="${treeBean.param1 == 'Wife_Partner'}">
				<!-- <h4>Who is the Friend of ${treeBean.me.Name}?</h4> -->
				<h4>ADD WIFE PROFILE</h4>
			</c:when>
			<c:when test="${treeBean.param1 == 'New_Profile'}">
				<!-- <h4>Who is the Friend of ${treeBean.me.Name}?</h4> -->
				<h4>ADD NEW PROFILE</h4>
			</c:when>
			<c:otherwise>
				<!-- <h4>Who is the ${treeBean.param1} of ${treeBean.me.Name}?</h4> -->
				<h4>ADD ${fn:toUpperCase(treeBean.param1)} PROFILE</h4>
			</c:otherwise>
			</c:choose>

			
			<form action="control/doRecordZnode.jsp" method="post">
				<select name="peopleID">
					<c:forEach items="${lnBn.human}" var="row">
						<option value="${row.PeopleID}">${row.Name}</option>
					</c:forEach>
				</select>
				<input type="hidden" name="list" value="true" />
				<input type="hidden" name="gender" value="${lnBn.gender}" />
				<input type="hidden" name="email" value="${row.Email}" />
			</form>
		</div>