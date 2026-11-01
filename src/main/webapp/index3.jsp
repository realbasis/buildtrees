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
	<div class="ligne" id="parents">
		<table width="100%">
			<tr>
				<td align="left" valign="middle">
					<jsp:include flush="true" page="zmainHelpFragEn.jsp"/>
				</td>
				<td align="center" valign="middle"></td>
			</tr>
		</table>
	</div>
	
	<div class="ligne" id="parents">
		<table width="100%">
			<tr>
				<td align="right" valign="middle">
					<div class="screen2" align="center">
						<table>
							<tr>
								<td valign="top">
									<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
										<br />
										NO
										<br /><br />
										PHOTO
									</div>
								</td>
								<td valign="top">
									<div style="background-color:white;">
                                    	<input type="submit" value="+Father" style="font-size:12px; color:gray" disabled="disabled"  />
									</div>
								</td>
							</tr>
						</table>
					</div>
					<br>
				</td>
				<td align="left" valign="middle">
					<div class="screen2" align="center">
						<table>
							<tr>
								<td valign="top">
									<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
										<br />
										NO
										<br /><br />
										PHOTO
									</div>
								</td>
								<td valign="top">
									<div style="background-color:white;">
                                    	<input type="submit" value="+Mother" style="font-size:12px; color:gray" disabled="disabled"/>
									</div>
								</td>
							</tr>
						</table>
					</div>
                    <br />
				</td>
			</tr>
		</table>
	</div>
	
	<div class="ligne" id="me" align="center">
		<table width="100%">
			<tr>
            	<td align="center" valign="top" width="25%"></td>
				<td align="center" valign="top">
<div>
	<table>
		<tr>
			<td>
				<table style="border-color:blue; border-width:thick" class="screen2">
					<tr>
						<td valign="top">
							<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
								<br />
								NO
								<br /><br />
								PHOTO
							</div>
						</td>
						<td valign="top">
						  <div class="textZone">
                          	<table align="center">
                            	<form method="post" action="control/authenticate.jsp" name="loginForm">
                                    <tr>
                                            <th align="center">YOUR PROFILE</th>
									</tr>
                                    <tr>
                	                	<td align="center">email</td>
                    	            </tr>
                        	        <tr>
                            	    	<td align="center">
                                	    	<input type="text" name="email" style="font-size:10px" />
                                    	</td>
	                                </tr>
    	                            <tr>
        	                        	<td align="center">password</td>
            	                    </tr>
                	                <tr>
                    	            	<td align="center">
                        	            	<input type="password" name="password" style="font-size:10px" />
                  	                  </td>
                    	            </tr>
                        	        <tr>
                            	    	<td align="center">
                                	    	new user? Y<input type="radio" name="existing" /> N<input type="radio" name="existing" checked="checked" />
                                    	</td>
	                                </tr>
    	                            <tr>
        	                        	<td align="center">
                                            <input type="submit" name="login" value="signup" onClick="loginForm.login.value='signup...'">
                	                    </td>
                    	            </tr>
                                    <input type="hidden" name="goodBrowser" value="true">
                                 </form>
                            </table>
							<br /><br />
						  </div>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
						</td>
					</tr>
				</table>
			</td>
			<td>
				<table style="margin-left:20px">
					<tr>
						<td style="font-size:12px; font-weight:bold" colspan="2">
							Create New Profile
						</td>
					</tr>
					<tr>
						<td>
							<input type="submit" value="+Man" style="color:gray" disabled />

						</td>
						<td>
							<input type="submit" value="+Woman" style="color:gray" disabled />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
				</td>
			</tr>
		</table>
	</div>

	<div class="ligne" id="me">
		<table width="90%" style="margin-bottom:200px" align="center">
			<tr>
				
				<td align="center" valign="top" style="border-top:solid; border-left:solid; border-color:white">
					<table style="width:200px" align="center">
						<tr>
							<td align="center">
                            	<input type="submit" value="+Partner" disabled="disabled" style="color:gray" />
							</td>
						</tr>
					</table>
                </td>
				<td align="center" valign="top" style="border-left:solid; border-right:solid; border-top:solid; border-color:white">
					<table style="width:200px" align="center">
						<tr>
							<td align="center">
                            	<input type="submit" value="+Son" disabled="disabled" style="color:gray" />
							</td>
							<td align="center">
                            	<input type="submit" value="+Daughter" disabled="disabled" style="color:gray" />
							</td>
						</tr>
					</table>
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
