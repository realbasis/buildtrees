<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

<c:set var="theURL" value="${pageContext.request.requestURL}" />

			<div style="text-align:center; margin-top:20px; font-weight:bold">
				<c:if test="${param.errors != null}">
					<span class="style1" style="font-weight:bold">${param.errors}</span>
				</c:if>
				<c:if test="${treeBean.it.ImageName == 'none'}">
					<p>
						[ PHOTO ]
					</p>
				</c:if>
				<c:if test="${treeBean.it.ImageName != 'none'}">
					<div align="center">
						<table align="center" border="1">
							<tr><td>
								<img align="middle" class="image" src='<c:out value="control/doGetImg.jsp?id=${treeBean.it.PeopleID}" />'>
							</td></tr>
						</table>
					</div>
				</c:if>
				<p>
					<table align="center">
						<tr>
							<td colspan="2">
								<div style="text-align:center; font-size:12px; font-style:italic">Taille : moins de <span style="font-weight:bold">250 KB</span> - Dim : 120px by 120px - Format : <span style="font-weight:bold">.GIF or .PNG</span></div>
							</td>
						</tr>
						<tr>
							<td>
								<form name="uploadForm" action="control/doImg.jsp" enctype="multipart/form-data" method="post">
									<input type="file" name="uploadfile" onchange="uploadForm.submit();"/>
								</form> 
							</td>
							<td align="left">
								<c:if test="${treeBean.it.ImageName != 'none'}">
									<form name="rmvForm" action="control/doDelImg.jsp" method="post">
										<input type="submit" name="remove" value="remove" style="font-size:10px" onClick="rmvForm.remove.value='Removing...';"/>
									</form>
								</c:if>
							</td>
						</tr>
					</table>
					
				</p>
				<form action="control/doSaveZnode.jsp" method="post">
					<p>
						Nom et prénom - <span class="style1">obligatoire</span>
						<br />
						<input type="text" name="name" maxlength="20" value="${treeBean.it.Name}" />
					</p>
					<c:if test="${treeBean.it.GotBirthdate != 'on'}">
					<p>
						Connaissez-vous la date de naissance de ${treeBean.it.Name}? 
						Oui <input type="radio" name="gotBirthdate" value="on" onclick="showdiv('birthdate')" />   Non <input type="radio" name="gotBirthdate" value="off" onclick="cachediv('birthdate')" checked />
						<div id="birthdate" align="center">
							<script>DateInput('birthdate', true, 'MON-DD-YYYY')</script>
						</div>
					</p>
					<script>cachediv('birthdate');</script>
					</c:if>
					<c:if test="${treeBean.it.GotBirthdate == 'on'}">
					<p>
						Quelle est la date de naissance de ${treeBean.it.Name}? 
						
						Oui <input type="radio" name="gotBirthdate" value="on" onclick="showdiv('birthdate')" checked />   Non <input type="radio" name="gotBirthdate" value="off" onclick="cachediv('birthdate')" />
						<div id="birthdate" align="center">
							<fmt:formatDate var="birthdate" value="${treeBean.it.Birthdate}" pattern="MMM-dd-yyyy" />
							<script>DateInput('birthdate', true, 'MON-DD-YYYY', '${birthdate}')</script>
						</div>
					</p>
					</c:if>
					<c:if test="${treeBean.it.IsDeceased != 'on'}">
					<p>
						Est-ce que ${treeBean.it.Name} est encore vivant(e)?
						Oui <input type="radio" name="isDeceased" value="off" checked="checked" onclick="cachediv('deceased')" />   Non <input type="radio" name="isDeceased" value="on" onclick="showdiv('deceased')" />
						<div id="deceased" align="center">
							Quelle est la date de décès de ${treeBean.it.Name}?
							<script>DateInput('deceased', true, 'MON-DD-YYYY')</script>
						</div>
					</p>
					<script>cachediv('deceased');</script>
					</c:if>
					<c:if test="${treeBean.it.IsDeceased == 'on'}">
					<p>
						Est-ce que ${treeBean.it.Name} est encore vivant(e)?
						Oui <input type="radio" name="isDeceased" value="off" onclick="cachediv('deceased')" />   Non <input type="radio" name="isDeceased" value="on" onclick="showdiv('deceased')" checked="checked" />
						<div id="deceased" align="center">
							Quelle est la date de décès de ${treeBean.it.Name}?
							<script>
								<fmt:formatDate var="deceased" value="${treeBean.it.Deceased}" pattern="MMM-dd-yyyy" />
								DateInput('deceased', true, 'MON-DD-YYYY', '${deceased}')
							</script>
						</div>
					</p>
					</c:if>
					<c:if test="${false}">
					<p>
						Email (optional)
						<br />
						<input type="text" name="email" size="25" value="${treeBean.it.Email}" />
						<p style="text-align:justify; width:400px">
							En spécifiant l'addresse email, vous pouvez initier un pont entre
							votre arbre et celui d'une autre personne.  De la meme facon,
							l'autre personne doit spécifier l'addresse email de votre compte
							dans son arbre généalogique afin de pouvoir créer le pont.
						</p>
					</p>
					</c:if>
					<c:if test="${treeBean.it.Email != ''}">
						<p>
							<span style="color:blue; font-size:18px;">Email: ${treeBean.it.Email}</span>
							<br />
						<c:if test="${treeBean.it.IsProfile == 'yes' && treeBean.it.Title == 'node'}">
							<span class="style1">NOTE: PERSONNE A UN COMPTE SUR BUILDTREES</span>
							<br />
						</c:if>
						</p>
						<input type="hidden" name="email" value="${treeBean.it.Email}" />
						<!--
						<p>
							Modifying the email address is a sensitive transaction because it can affect 
							<br />
							other trees besides your own.  Accordingly, you have to delete the whole profile 
							<br />
							and create a new one in order to specify another email address.
						</p>
						-->
					</c:if>
					<div align="center">
						<table align="center">
							<tr>
								<td colspan="2"><hr /></td>
							</tr>
							<tr>
								<td>
									<input type="submit" name="retour" value="Cancel" />
								</td>
								<td>
									<input type="submit" name="save" value="Save" /> 
								</td>
							</tr>
						</table>
					</div>
			</form>
		</div>