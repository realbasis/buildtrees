<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

<c:set var="theURL" value="${pageContext.request.requestURL}" />

<div style="text-align:center; margin-top:20px; font-weight:bold">
				<c:if test="${param.errors != null}">
					<span class="style1" style="font-weight:bold">${param.errors}</span>
				</c:if>
				<c:if test="${treeBean.me.ImageName == 'none'}">
					<p>
						[ PHOTO ]
					</p>
				</c:if>
				<c:if test="${treeBean.me.ImageName != 'none'}">
					<div align="center">
						<table align="center" border="1">
							<tr><td>
								<img align="middle" class="image" src='<c:out value="control/doGetImg.jsp?id=${treeBean.me.PeopleID}" />'>
							</td></tr>
						</table>
					</div>
				</c:if>
				<p>
					<table align="center">
						<tr>
							<td colspan="2">
								<div style="text-align:center; font-size:12px; font-style:italic">Size : less than <span style="font-weight:bold">250 KB</span> - Dim : 120px by 120px - Format : <span style="font-weight:bold">.GIF or .PNG</span></div>
							</td>
						</tr>
						<tr>
							<td>
								<form name="uploadForm" action="control/doImg.jsp" enctype="multipart/form-data" method="post">
									<input type="file" name="uploadfile" onchange="uploadForm.submit();"/>
								</form> 
							</td>
							<td align="left">
								<c:if test="${treeBean.me.ImageName != 'none'}">
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
						Full Name - <span class="style1">required</span>
						<br />
						<input type="text" name="name" value="${treeBean.me.Name}" />
					</p>
				<c:if test="${treeBean.me.GotBirthdate != 'on'}">
					<p>
						Do you know ${treeBean.me.Name}'s date of birth? 
						Yes <input type="radio" name="gotBirthdate" value="on" onclick="showdiv('birthdate')" />   No <input type="radio" name="gotBirthdate" value="off" onclick="cachediv('birthdate')" checked />
						<div id="birthdate" align="center">
							<script>DateInput('birthdate', true, 'MON-DD-YYYY')</script>
						</div>
					</p>
					<script>cachediv('birthdate');</script>
				</c:if>
				<c:if test="${treeBean.me.GotBirthdate == 'on'}">
					<p>
						Do you know  ${treeBean.me.Name}'s date of birth? 
						Yes <input type="radio" name="gotBirthdate" value="on" onclick="showdiv('birthdate')" checked />   No <input type="radio" name="gotBirthdate" value="off" onclick="cachediv('birthdate')" />
						<div id="birthdate" align="center">
							<fmt:formatDate var="birthdate" value="${treeBean.me.Birthdate}" pattern="MMM-dd-yyyy" />
							<script>DateInput('birthdate', true, 'MON-DD-YYYY', '${birthdate}')</script>
						</div>
					</p>
				</c:if>
				<c:if test="${treeBean.me.IsDeceased != 'on'}">
					<p>
						Is ${treeBean.me.Name} still alive? 
						Yes <input type="radio" name="isDeceased" value="off" checked="checked" onclick="cachediv('deceased')" />   No <input type="radio" name="isDeceased" value="on" onclick="showdiv('deceased')" />
						<div id="deceased" align="center">
							When did ${treeBean.me.Name} pass away?
							<script>DateInput('deceased', true, 'MON-DD-YYYY')</script>
						</div>
					</p>
					<script>cachediv('deceased');</script>
				</c:if>
				<c:if test="${treeBean.me.IsDeceased == 'on'}">
					<p>
						Is ${treeBean.me.Name} still alive? 
						Yes <input type="radio" name="isDeceased" value="off" onclick="cachediv('deceased')" />   No <input type="radio" name="isDeceased" value="on" onclick="showdiv('deceased')" checked="checked" />
						<div id="deceased" align="center">
							When did ${treeBean.me.Name} pass away?
							<script>
								<fmt:formatDate var="deceased" value="${treeBean.me.Deceased}" pattern="MMM-dd-yyyy" />
								DateInput('deceased', true, 'MON-DD-YYYY', '${deceased}')
							</script>
						</div>
					</p>
				</c:if>
				<c:if test="${treeBean.me.Email != ''}">
					<input type="hidden" name="email" value="${treeBean.me.Email}" />
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