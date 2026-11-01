<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="control/stdTags.jspf" %>

<html>
<head>
<title>JSP Page</title>
<style type="text/css">
.tableau
{
	width:700px;
	font-size:24px;
}

.ligne
{
	width:700px;
	margin-bottom:20px;
}
.cell
{
	width:200px;
	background-color:#CCCCCC;
	border:solid 1px blue;
	text-align:center;
	height:70px;
	vertical-align:middle;
	padding-top:20px;
	padding-bottom:0px;
	margin-bottom:5px;
}
</style>
<jsp:useBean id="now" class="java.util.Date" />
</head>
<body>

<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>

<table align="center"><tr><td>
	<div class="ligne" id="parents">
		<table>
			<tr>
				<td align="right" width="60%">
					<form method="" action="">
						<select name="">
							<option>people 1 test test test test</option>
							<option>people 2</option>
						</select>
						<input type="submit" value="update">
					</form>
				</td>
				<td align="right">
					<p style="margin:0 10px 0 10px">
						Tool | <a href="">Reminders</a> | <a href="">Sync</a> | <a href="">Help</a> | <a href="">Logout</a>
					</p>
				</td>
			</tr>
		</table>
	</div>
	<div class="ligne" id="parents">
		<table width="100%">
			<tr>
				<td align="right" valign="middle">
					<div class="cell">
						<c:if test="${father != 0}">
							<form>
								<input type="submit" value="add father">
							</form>
						</c:if>
						<c:if test="${father == 0}">
							father
						</c:if>
					</div>
				</td>
				<td align="left">
					<div class="cell">
						<c:if test="${mother != 0}">
							<form>
								<input type="submit" value="add mother">
							</form>
						</c:if>
						<c:if test="${father == 0}">
							mother
						</c:if>
					</div>
				</td>
			</tr>
		</table>
	</div>

	<div class="ligne" id="me">
		<table width="100%">
			<tr>
				<td align="center" valign="top">
					<div class="cell">
						<c:if test="${gender == 'male'}">
							<form>
								<input type="submit" value="add wife">
							</form>
						</c:if>
						<c:if test="${gender == null}">
							<form>
								<input type="submit" value="add husband/partner">
							</form>
						</c:if>
						<c:if test="${gender == 0}">
							husband/wife
						</c:if>
					</div>
				</td>
				<td align="center">
					<div class="cell" style="height:200px">
						me
					</div>
				</td>
				<td align="center" valign="top">
					<div class="cell">
						<form>
							<input type="submit" value="add son"> <input type="submit" value="add daughter">
						</form>
					</div>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="ligne">
		<table width="100%">
			<tr>
				<td align="center"></td>
				<td align="center">
					<div class="cell">
						<form>
							<input type="submit" value="add brother"> <input type="submit" value="add sister">
						</form>
					</div>
					<div class="cell">
						Jessica Simpson
					</div>
					<div class="cell">
						Alex
					</div>
				</td>
				<td align="center"></td>
			</tr>
		</table>
	</div>
</td></tr></table>

</body>
</html>
