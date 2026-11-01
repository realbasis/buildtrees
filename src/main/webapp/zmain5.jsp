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
<script type="text/javascript">
<!--
function confirmation() {
	ans = confirm("ERASING PROFILE: ARE YOU SURE?");
	if (ans){
		return true;
	}
	return false;
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>

<jsp:useBean id="nodeBean" class="utility.NodeBean" />
<jsp:useBean id="peopleBean" class="value.PeopleBean" />

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<!-- check account flag -->
<c:if test="${sharersFlag < 1}">
	<sql:query var="sharersCheck">
	    Select * from Accounts Where AccountID = ? And Flag > 0
	    <sql:param value="${accountID}" />
	</sql:query>
	<c:if test="${sharersCheck.rowCount == 1}">
		<!-- update tree -->
		<c:forEach items="${sharersCheck.rows}" var="row">
			<c:remove var="sharersFlag" scope="session" />
			<c:set var="sharersFlag" value="${row.Flag}" scope="session" />
		</c:forEach>
	</c:if>
</c:if>

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
							    <!-- InstanceBeginEditable name="EditMenu" --><body onload="MM_preloadImages('images/forward-arrow-dark.jpg')">
								<jsp:include flush="true" page="${languageBean.zmainHeadFrag}"/>
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
					<jsp:include flush="true" page="${languageBean.zmainHelpFrag}"/>
				</td>
				<td align="center" valign="middle">
					<c:if test="${sharersFlag > 0}">
					    <p style='text-align:center; font-weight:bold; font-size:12px; color:red'>
					        tree modified
					        <br>
					        by other member
					    </p>
					</c:if>
					<jsp:include flush="true" page="zmainRefreshFrag.jsp"/>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="ligne" id="parents">
		<table width="100%">
			<tr>
				<td align="right" valign="middle">
					<c:choose>
						<c:when test="${param.linkType == 'Father'}">	
							<jsp:include page="zmainProfileFrag.jsp">
								<jsp:param name="linkType" value="${param.linkType}"/>
								<jsp:param name="relationship" value="Father"/>
							</jsp:include>
						</c:when>
						<c:otherwise>
							<jsp:include page="zmainProfileFrag.jsp">
								<jsp:param name="linkType" value=""/>
								<jsp:param name="relationship" value="Father"/>
							</jsp:include>
						</c:otherwise>
					</c:choose>
				</td>
				<td align="left" valign="middle">
					<c:choose>
						<c:when test="${param.linkType == 'Mother'}">	
							<jsp:include page="zmainProfileFrag.jsp">
								<jsp:param name="linkType" value="${param.linkType}"/>
								<jsp:param name="relationship" value="Mother"/>
							</jsp:include>
						</c:when>
						<c:otherwise>
							<jsp:include page="zmainProfileFrag.jsp">
								<jsp:param name="linkType" value=""/>
								<jsp:param name="relationship" value="Mother"/>
							</jsp:include>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="ligne" id="me" align="center">
		<table width="100%">
			<tr>
				<td align="center" valign="top" width="33.33%">
					<table style="width:200px" align="center">
						<tr>
						</tr>
					</table>
				</td>
				<td align="center" valign="top">
					<jsp:include page="zmainMeFrag.jsp">
                    	<jsp:param name="linkType" value="${param.linkType}"/>
                    </jsp:include>
				</td>
				<td align="center" valign="top" width="33.33%">
					<table style="width:200px" align="center">
						<tr></tr>
					</table>
				</td>
			</tr>
		</table>
	</div>

	<div class="ligne" id="me">
		<table width="100%" style="margin-bottom:200px" align="center">
			<tr>
				
				<td align="center" valign="top" style="border-top:solid; border-color:white">
					<table style="width:200px" align="center">
						<tr>
							<td align="center">
								<form action="zmain.jsp" method="post">
								<c:if test="${treeBean.me.Gender == 'Male'}">
										<input type="submit" value="${languageBean.zmainAddWife}" />
										<input type="hidden" name="linkType" value="Wife_Partner" />
								</c:if>
								<c:if test="${treeBean.me.Gender == 'Female'}">
										<input type="submit" value="${languageBean.zmainAddHusband}" />
										<input type="hidden" name="linkType" value="Husband_Partner" />
								</c:if>
								</form>	
							</td>
						</tr>
					</table>
					<c:choose>
						<c:when test="${param.linkType == 'Wife_Partner' || param.linkType == 'Husband_Partner'}">
							<jsp:include page="zmainProfileFrag.jsp">
								<jsp:param name="linkType" value="${param.linkType}"/>
								<jsp:param name="relationship" value="Partner"/>
							</jsp:include>
						</c:when>
						<c:otherwise>
							<jsp:include page="zmainProfileFrag.jsp">
								<jsp:param name="linkType" value=""/>
								<jsp:param name="relationship" value="Partner"/>
							</jsp:include>
						</c:otherwise>
					</c:choose>
<!--
					<hr />
					<table style="width:200px" align="center">
						<tr>
							<td align="center">
								<form method="post" action="zmain.jsp">
									<input type="submit" value="+Man" />
									<input type="hidden" name="linkType" value="Boyfriend" />
								</form>
							</td>
							<td align="center">
								<form method="post" action="zmain.jsp">
									<input type="submit" value="+Woman" />
									<input type="hidden" name="linkType" value="Girlfriend" />
								</form>
							</td>
						</tr>
					</table>
					<c:choose>
						<c:when test="${param.linkType == 'Girlfriend' || param.linkType == 'Boyfriend'}">
							<jsp:include page="zmainProfileFrag.jsp">
								<jsp:param name="linkType" value="${param.linkType}"/>
								<jsp:param name="relationship" value="Friend"/>
							</jsp:include>
						</c:when>
						<c:otherwise>
							<jsp:include page="zmainProfileFrag.jsp">
								<jsp:param name="linkType" value=""/>
								<jsp:param name="relationship" value="Friend"/>
							</jsp:include>
						</c:otherwise>
					</c:choose>
				</td>
-->
				
				<td align="center" valign="top" style="border-left:solid; border-right:solid; border-top:solid; border-color:white">
					<table style="width:200px" align="center">
						<tr>
							<td align="center">
								<form method="post" action="zmain.jsp">
									<input type="submit" value="${languageBean.zmainAddSon}" />
									<input type="hidden" name="linkType" value="Son" />
								</form>
							</td>
							<td align="center">
								<form method="post" action="zmain.jsp">
									<input type="submit" value="${languageBean.zmainAddDaughter}" />
									<input type="hidden" name="linkType" value="Daughter" />
								</form>
							</td>
						</tr>
					</table>
					<c:choose>
						<c:when test="${param.linkType == 'Daughter' || param.linkType == 'Son'}">
							<jsp:include page="zmainProfileFrag.jsp">
								<jsp:param name="linkType" value="${param.linkType}"/>
								<jsp:param name="relationship" value="Child"/>
							</jsp:include>
						</c:when>
						<c:otherwise>
							<jsp:include page="zmainProfileFrag.jsp">
								<jsp:param name="linkType" value=""/>
								<jsp:param name="relationship" value="Child"/>
							</jsp:include>
						</c:otherwise>
					</c:choose>
				</td>
				
<!--
				<td align="center" valign="top" style="border-top:solid; border-color:white">
					<table style="width:200px" align="center">
						<tr>
							<td align="center">
								<form method="post" action="zmain.jsp">
									<input type="submit" value="${languageBean.zmainAddBrother}" />
									<input type="hidden" name="linkType" value="Brother" />
								</form>
							</td>
							<td align="center">
								<form method="post" action="zmain.jsp">
									<input type="submit" value="${languageBean.zmainAddSister}" />
									<input type="hidden" name="linkType" value="Sister" />
								</form>
							</td>
						</tr>
					</table>
					<c:choose>
						<c:when test="${param.linkType == 'Sister' || param.linkType == 'Brother'}">
							<jsp:include page="zmainProfileFrag.jsp">
								<jsp:param name="linkType" value="${param.linkType}"/>
								<jsp:param name="relationship" value="Sibling"/>
							</jsp:include>
						</c:when>
						<c:otherwise>
							<jsp:include page="zmainProfileFrag.jsp">
								<jsp:param name="linkType" value=""/>
								<jsp:param name="relationship" value="Sibling"/>
							</jsp:include>
						</c:otherwise>
					</c:choose>
				</td>
-->			
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
