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
div#screenTop
{
	width:520px;
	padding:10px 10px 10px 10px;
	margin-left:100px;
}
a img
{
	border:none;
}
a
{
	text-decoration:none;
}
p
{
	font-size:14px;
}
</style>
<!-- InstanceEndEditable -->
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
                                <div id="parents" style="margin-top:15px">
									<table width="100%">
										<tr>
											<td align="right" valign="top">
												<p style="font-size:16px; font-weight:bold">
													<a href="index.jsp">Home</a> | <a href="aboutus.jsp">About Us</a> | Contact Us
												</p>
											</td>
										</tr>
									</table>
								</div>
								<!-- InstanceEndEditable -->
                          </c:when>
						  <c:when test="${flag == 7}">
							    <!-- InstanceBeginEditable name="EditMenu" -->
							
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
					<div style="padding:10px 10px 10px 10px; height:400px">
					<table>
						<tr>
							<td><img src="images/ireland.png" width="150"></td>
							<td align="center" style="text-align:justify">
								<div style="margin-left:25px; margin-top:20px">
									<h1 style="text-decoration:underline">Contact Us</h1>
									<p>
										Email: <a href="mailto:buildtrees@realbasis.com">buildtrees@realbasis.com</a>
									</p>
                	                <p>Telephone: (910) 502-0220</p>
                                    <!--
                                    <p style="font-weight:bold">
                                    	Note: we tend to respond much faster by EMAIL.
                                    </p>
                                    -->
								</div>
							</td>
						</tr>
					</table>
				</div>
	<!-- InstanceEndEditable -->
</div>
</td></tr></table>

<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-544679-2";
urchinTracker();
</script>

</body>
<!-- InstanceEnd --></html>
