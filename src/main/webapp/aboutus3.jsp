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
	width:560px;
	padding:5px 10px 10px 10px;
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
													<a href="index.jsp">Home</a> | About Us | <a href="contactus.jsp">Contact Us</a>
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
			<div id="screenTop" align="center">
					<div style="text-align:center">
						<h3>BuildTrees&#8482; is about Family</h3>
					</div>
					
					<p style="text-align:justify; font-size:14px; padding-left:15px; padding-right:15px">BuildTrees&#8482; is an online license-free utilty designed to help people link their family members over the internet.  This is much more than a traditional family tree builder as users can share and contribute on the same tree within a few clicks regardless of their location.  BuildTrees&#8482; goal is to, eventually, connect every human being in this universe. Join us in this amazing journey.</p>
					<img src="images/family2.jpg">
					<p style="text-align:justify; font-style:italic; font-size:12px; padding-left:15px; padding-right:15px">"What greater thing is there for human souls than to feel that they are joined for life - to be with each other in silent unspeakable memories." ~ George Eliot</p>
					<p style="text-align:left; font-weight:bold; margin-left:25px">Lamine Ba,  Founder.</p>
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
