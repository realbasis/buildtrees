<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

<c:set var="theURL" value="${pageContext.request.requestURL}" />

		<div style="text-align:center; margin-top:20px; font-weight:bold">

			<c:choose>
			<c:when test="${treeBean.param1 == 'Boyfriend' || treeBean.param1 == 'Girlfriend'}">
				<!-- <h4>Who is the Friend of ${treeBean.me.Name}?</h4> -->
				<h4>sintiougol tounbodiral (AMI ou AMIE)</h4>
			</c:when>
			<c:otherwise>
				<!-- <h4>Who is the ${treeBean.param1} of ${treeBean.me.Name}?</h4> -->
				<h4>sintiougal tounbodiral</h4>
			</c:otherwise>
			</c:choose>

			
			<form action="control/doRecordZnode.jsp" method="post">
			<c:choose>
				<c:when test="${lnBn.listed == true && param.np != true}">
					<select name="peopleID">
						<c:forEach items="${lnBn.human}" var="row">
							<option value="${row.PeopleID}">${row.Name}</option>
						</c:forEach>
						<option value="-2" style="background-color:#00FF33">BEYDOUGOL HIMBE</option>
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
							Yettorè é hindè - <span class="style1">obligatoire</span>
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
								Co Gnaladè hondè ho djibina co welldi?
							</c:when>
							<c:otherwise>
								CO Hondétouma ho djibina co Tagado?
							</c:otherwise>
						</c:choose>
						Oui <input type="radio" name="gotBirthdate" value="on" onclick="showdiv('birthdate')" />   Non <input type="radio" name="gotBirthdate" value="off" onclick="cachediv('birthdate')" checked />
						<div id="birthdate"><script>DateInput('birthdate', true, 'MON-DD-YYYY')</script></div>
					</p>
					<script>cachediv('birthdate');</script>
					
					<p>
						<c:choose>
							<c:when test="${treeBean.param1 == 'Boyfriend' || treeBean.param1 == 'Girlfriend'}">
								Taou si tagado on hi no houri hadioni?
							</c:when>
							<c:otherwise>
								Taou si tagado on no houri hadioni?
							</c:otherwise>
						</c:choose>
						Oui <input type="radio" name="isDeceased" value="off" checked="checked" onclick="cachediv('deceased')" />   Nom <input type="radio" name="isDeceased" value="on" onclick="showdiv('deceased')" />
						<div id="deceased">
							Co gnaladè hondè ho maye co tagado?
							<script>DateInput('deceased', true, 'MON-DD-YYYY')</script>
						</div>
					</p>
					<script>cachediv('deceased');</script>
					
					<p>
						Email (optionnel)
						<br />
						<input type="text" name="email" size="25"/>
						<div>
							En spécifiant l'addresse email, vous pouvez initier un pont entre
						</div>
						<div>
							légalmongal é godogo kadi .Co gotoun,
						</div>
						<div>
							l'autre personne doit spécifier l'addresse email de votre compte
						</div>
						<div>
							Dère légalmaco dadièrè huidimacodin wawahi sintioudé ho pont.
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
						<input type="submit" name="retour" value="Annuler" />
					</td>
					<td>
						<input type="submit" value="Wadougol" />
					</td>
				</tr>
			</table>
			</form>
		</div>