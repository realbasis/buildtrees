<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/privateLinked.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- InstanceBeginEditable name="doctitle" -->
<title>Family Tree Builder..Mankind Connected</title>
<!-- InstanceEndEditable -->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/linked.css" rel="stylesheet" type="text/css">
<%@include file="/control/stdTags.jspf" %>
<c:set var="theURI" value="${pageContext.request.requestURI}" />
<c:if test="${languageBean == null}">
	<jsp:useBean id="languageBean" class="value.LanguageBean" scope="session" />
</c:if>
<!-- InstanceBeginEditable name="head" -->
<style type="text/css">
.tableau
{
	width:700px;
	font-size:24px;
}

.ligne
{
	width:700px;
	margin-bottom:5px;
}
.cell
{
	width:200px;
/*	background-color:#CCCCCC; */
	background-color:white;
	border:solid 1px blue;
	text-align:center;
	height:60px;
	padding-top:20px;
	margin-bottom:5px;
}
.zhead
{
	width:200px;
	text-align:center;
}
.image
{
	background-color:#CCCCCC;
	width:100px;
	height:100px;
}
a img
{
	border:none;
}
a
{
	text-decoration:none;
}
</style>
<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<!-- InstanceEndEditable -->
<%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>

<body onload="document.getElementById('theText').focus(); createAutoComplete();">

<table align="left" class="noborder"><tr><td>
<div id="zmain">
	<div id="banner" align="center">
		<table align="center" width="100%">
			<tr>
				<td align="left">
					<c:choose>
						<c:when test="${flag == 7}">
							<a href="main.jsp"><img style="border:none; text-decoration:none" src="images/buildtrees_logo2.png"></a>
						</c:when>
						<c:otherwise>
							<a href="index.jsp"><img style="border:none; text-decoration:none" src="images/buildtrees_logo2.png"></a>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<table align="center">
						<tr>
						  <td align="center">
                          <c:choose>
							<c:when test="${flag == null}">                                
							    <!-- InstanceBeginEditable name="EditRegionTop" -->
                                
								<!-- InstanceEndEditable -->
                          </c:when>
						  <c:when test="${flag == 7}">
							    <!-- InstanceBeginEditable name="EditMenu" -->
								<jsp:include flush="true" page="${languageBean.settingsHeadFrag}" />
								<!-- InstanceEndEditable -->
							</c:when>
                            <c:otherwise></c:otherwise>
                            </c:choose>						
						  </td>
					  </tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
	
    <!-- InstanceBeginEditable name="content" -->
	<jsp:include flush="true" page="${languageBean.settingsFrag}" />
	<!-- InstanceEndEditable -->
</div>
</td></tr></table>

</body>
<!-- InstanceEnd --></html>
