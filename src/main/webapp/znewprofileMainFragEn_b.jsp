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
			<c:choose>
				<c:when test="${lnBn.listed == true && param.np != true}">
					<select name="peopleID">
						<c:forEach items="${lnBn.human}" var="row">
							<option value="${row.PeopleID}">${row.Name}</option>
						</c:forEach>
						<option value="-2" style="background-color:#00FF33">NEW PERSON</option>
					</select>
					<input type="hidden" name="list" value="true" />
					<input type="hidden" name="gender" value="${lnBn.gender}" />
					<input type="hidden" name="email" value="${row.Email}" />
				</c:when>
				<c:otherwise>
					<input type="hidden" name="list" value="false" />
					<input type="hidden" name="gender" value="${lnBn.gender}" />
					<p>
						<c:if test="${param.errors == null}">
							Full Name - <span class="style1">required</span>
						</c:if>
						<c:if test="${param.errors != null}">
							<span class="style1" style="font-weight:bold">${param.errors}</span>
						</c:if>
						<br />
						<input type="text" name="name" maxlength="20" />
					</p>
					<p>
						<c:choose>
							<c:when test="${treeBean.param1 == 'Boyfriend' || treeBean.param1 == 'Girlfriend'}">
								Do you know Friend's date of birth? 
							</c:when>
							<c:otherwise>
								Do you know ${treeBean.param1}'s date of birth? 
							</c:otherwise>
						</c:choose>
						Yes <input type="radio" name="gotBirthdate" value="on" onclick="showdiv('birthdate')" />   No <input type="radio" name="gotBirthdate" value="off" onclick="cachediv('birthdate')" checked />
						<div id="birthdate"><script>DateInput('birthdate', true, 'MON-DD-YYYY')</script></div>
					</p>
					<script>cachediv('birthdate');</script>
					
					<p>
						<c:choose>
							<c:when test="${treeBean.param1 == 'Boyfriend' || treeBean.param1 == 'Girlfriend'}">
								Is Friend still alive? 
							</c:when>
							<c:otherwise>
								Is ${treeBean.param1} still alive? 
							</c:otherwise>
						</c:choose>
						Yes <input type="radio" name="isDeceased" value="off" checked="checked" onclick="cachediv('deceased')" />   No <input type="radio" name="isDeceased" value="on" onclick="showdiv('deceased')" />
						<div id="deceased">
							When did ${treeBean.param1} pass away?
							<script>DateInput('deceased', true, 'MON-DD-YYYY')</script>
						</div>
					</p>
					<script>cachediv('deceased');</script>
					
					<p>
						Email (optional)
						<br />
						<input type="text" name="email" size="25"/>
						<div>
							By specifying this profile's email address, you could create a bridge
						</div>
						<div>
							between your tree and the person's tree.  The other person also has to
						</div>
						<div>
							specify the email address of your account in his/her tree in order
						</div>
						<div>
							 to allow the completion the bridge.
						</div>
					</p>
				</c:otherwise>
			</c:choose>
			<table align="center">
				<tr>
					<td colspan="2"><hr /></td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="Add to Tree" />
					</td>
					<td>
						<input type="submit" name="retour" value="Cancel" />
					</td>
				</tr>
			</table>
			</form>
		</div>