<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

<c:set var="theURL" value="${pageContext.request.requestURL}" />

		<div style="text-align:center; margin-top:20px; font-weight:bold">

			<c:choose>
			<c:when test="${treeBean.param1 == 'Boyfriend'}">
				<!-- <h4>Who is the Friend of ${treeBean.me.Name}?</h4> -->
				<h4>MAN's PROFILE</h4>
				<c:set var="gender" value="Male" />
			</c:when>
			<c:when test="${treeBean.param1 == 'Girlfriend'}">
				<!-- <h4>Who is the Friend of ${treeBean.me.Name}?</h4> -->
				<h4>WOMAN's PROFILE</h4>
				<c:set var="gender" value="Female" />
			</c:when>
			<c:otherwise>
				<!-- <h4>Who is the ${treeBean.param1} of ${treeBean.me.Name}?</h4> -->
				<h4>NEW PROFILE</h4>
			</c:otherwise>
			</c:choose>
			
			
			<div style="background-color:#33FF33; padding:20px 4px 4px 4px; width:300px; height:80px">
				<form action="control/doSearchProfile.jsp" method="post">
				<p>
					<c:if test="${param.emailErrors == null}">
						Search profile by EMAIL?
					</c:if>
					<c:if test="${param.emailErrors != null}">
						<span class="style1" style="font-weight:bold">*** ${param.emailErrors} ***</span>
					</c:if>
					<table align="center">
						<tr>
							<td colspan="2"><hr /></td>
						</tr>
						<tr>
							<td>
								<input type="text" name="email" size="20" value="${param.email}" />
							</td>
							<td>
								<input type="submit" value="Search" />
							</td>
						</tr>
					</table>
				</p>
				</form>
			</div>
			
			<p style="text-align:center; font-weight:bold">
				- OR CREATE A NEW PROFILE BELOW -
			</p>

			<div style="background-color:#33FF33; padding:20px 4px 4px 4px; width:300px; height:350px; margin-top:10px; margin-bottom:10px">
				<form action="control/doAddProfile.jsp" method="post">
					<input type="hidden" name="list" value="false" />
					<input type="hidden" name="gender" value="${gender}" />
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
						<span style="font-style:italic">Gender</span>
						<br />
						<c:choose>
							<c:when test="${treeBean.param1 == 'Boyfriend'}">
								<input type="text" maxlength="20" value="Male" readonly="" />
							</c:when>
							<c:when test="${treeBean.param1 == 'Girlfriend'}">
								<input type="text" maxlength="20" value="Female" readonly="" />
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
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
			
		</div>