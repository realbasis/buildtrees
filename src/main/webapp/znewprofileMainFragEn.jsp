<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

<c:set var="theURL" value="${pageContext.request.requestURL}" />

<div style="text-align:center; margin-top:20px; margin-bottom:60px; font-weight:bold; height:400px;">
	<table align="center"><tr>
		<td>
			<p style="text-align:center; font-weight:bold;">
				- CREATE A NEW PROFILE -
			</p>
			<br />
				<form action="control/doAddProfile.jsp" method="post">
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
						Gender
						<br />
						<select name="gender">
						<c:choose>
							<c:when test="${param.gender == 'Male'}">
								<option selected="selected">Male</option>
								<option>Female</option>
							</c:when>
							<c:when test="${param.gender == 'Female'}">
								<option>Male</option>
								<option selected="selected">Female</option>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
						</select>
					</p>
					<p>
						Do you know Person's date of birth? 
						Yes <input type="radio" name="gotBirthdate" value="on" onclick="showdiv('birthdate')" />   No <input type="radio" name="gotBirthdate" value="off" onclick="cachediv('birthdate')" checked />
						<div id="birthdate"><script>DateInput('birthdate', true, 'MON-DD-YYYY')</script></div>
					</p>
					<script>cachediv('birthdate');</script>
					<p>
						Is Person still alive? 
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
							<input type="submit" name="retour" value="Cancel" />
						</td>
						<td>
							<input type="submit" value="Save" />
						</td>
					</tr>
				</table>
			</form>
		</td>
	</tr></table>
</div>