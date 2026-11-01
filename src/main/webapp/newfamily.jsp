<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="java.util.LinkedList,java.util.SortedMap,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@include file="/control/stdTags.jspf" %>

<c:if test="${param.theText != null}">
	<c:if test="${peopleBean == null}">
		<jsp:useBean id="peopleBean" class="value.PeopleBean" scope="session" />
    </c:if>
    <jsp:setProperty name="peopleBean" property="name" value="${param.theText}" />
</c:if>

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/login.jsp">
		<c:param name="errors" value="login is required" />
	</c:redirect>
</c:if>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Family Tree Builder..Mankind Connected</title>
<script type="text/javascript">
var xmlhttp

function loadContent(str)
{

 xmlhttp=GetXmlHttpObject();

  if (xmlhttp==null)
  {
   alert ("Your browser does not support Ajax HTTP");
   return;
  }

    var url="control/doImg2.jsp";
    url=url+"?q="+str;

    xmlhttp.onreadystatechange=getOutput;
    xmlhttp.open("GET",url,true);
    xmlhttp.send(null);
}

function getOutput()
{
  if (xmlhttp.readyState==4)
  {
  document.getElementById("prtCnt").innerHTML=xmlhttp.responseText;
  }
}

function GetXmlHttpObject()
{
    if (window.XMLHttpRequest)
    {
       return new XMLHttpRequest();
    }
    if (window.ActiveXObject)
    {
      return new ActiveXObject("Microsoft.XMLHTTP");
    }
 	return null;
}
</script>
<script src="js/calendarDateInput.js" type="text/javascript"></script>
<script src="js/divStatus.js" type="text/javascript"></script>
<style type="text/css">
body {
	font-family: "Times New Roman", Times, serif;
	font-size: 12px;
	background-color:#99FF99;
}

td {
	font-family: "Times New Roman", Times, serif;
	font-size: 12px;
}

th {
	font-family: "Times New Roman", Times, serif;
	font-size: 12px;
}

input, button {
	color:blue;
	font-size:16px;
}

.bodystyle {
	font-family: "Times New Roman", Times, serif;
	font-size: 12px;
}

.small {
	font-family: "Times New Roman", Times, serif;
	font-size: 9px;
}

.medium {
	font-family: "Times New Roman", Times, serif;
	font-size: 12px;
}

.big {
	font-family: "Times New Roman", Times, serif;
	font-size: 16px;
}

.xbig {
	font-family: "Times New Roman", Times, serif;
	font-size: 24px;
}

.expanded {
	font-family: "Times New Roman", Times, serif;
	font-size: 12px;
	line-height: 16px;
	letter-spacing: 2px;
}

.justified {
	font-family: "Times New Roman", Times, serif;
	text-align: justify;
}

.footer {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 9px;
	color: #999999;
}
.cachediv
{
	visibility:hidden;
}
.showdiv
{
	visibility:visible;
}
.box1 {
	padding: 3px;
	border-width: thin;
	border-style: solid;
	border-color: #CCCCCC #666666 #666666 #CCCCCC;
}

.box2 {
	font-style: italic;
	word-spacing: 2pt;
	padding: 3px;
	border-width: thin;
	border-style: solid;
}
div#menu
{
	font-size:14px;
	margin-bottom:20px;
	background-color:#006600;
	color:white;
}
div#menu a
{
	font-size:16px;
	text-decoration:underline;
	color:white;

}
div#menu a:hover
{
	text-decoration:underline;
	color:white;
}
div#menu3a
{
	font-size:14px;
}
div#menuRight input
{
	font-size:12px;
}
div#menuRight
{
	font-size:16px;
}

div#content
{
	margin-left:30px;
	margin-top:15px;
/*	border-left:solid 1px white; */
}
.odd {

}
.even {

}
.menuFont {
	font-size:16px;
}
.image
{
	background-color:#CCCCCC;
	/*
	width:120px;
	height:120px;
	*/
	width:60px;
	height:60px;
}
input, select
{
	font-size:10px;
}
</style>
</head>

<body onload="document.getElementById('theText').focus(); createAutoComplete();">

<div id="menu">
<table width="100%">
	<tr>
    	<td align="left">
        	<div id="menuLeft">
            	<a href="index.jsp" class="menuFont">Home</a> | <a href="aboutus.jsp" class="menuFont">About Us</a>
            </div>
        </td>
        <td align="right">
        	<div id="menuRight">
            	<table>
                	<tr>
                        <th class="menuFont">Welcome to ${myname} | </th>
                        <td class="menuFont">
                        	<a href="control/logout.jsp">Logout</a>
                        </td>
                        <td>
                        	<div style="margin-left:20px;font-style:italic; font-size:10px">
                        		Real Basis LLC copyright @ 2011
                        	</div>
                        </td>
                    </tr>
                </table>
			</div>
        </td>
    </tr>
</table>
</div>

<div id="menu2">
	<table style="width:800px;">
    	<tr>
            <td valign="middle" style="width:280px;">
               	<div id="menuLeftb">
	   				<a href="index.jsp"><img style="border:none; text-decoration:none" src="images/buildtrees_logo2.png"></a>
		        </div>
            </td>
			<td valign="middle" align="left">
			</td>
        </tr>
        <tr>
        	<td colspan="2"><div style="margin-bottom:10px"></div></td>
        </tr>
        
        <tr>
        </tr>
        	<td valign="top" align="center">
            	<table align="center" style="border:1px solid green; width:650px;">
                    <tr>
                        <th align="center" valign="top">
                        	Profile of 
                            <br />
                            <input type="text" name="name" value="${peopleBean.name}" />
                        </th>
                        <th align="center" valign="top">
                        	Gender
                            <br /> 
							<select name="gender">
    	                    	<option>SELECT</option>
        	                	<option>Male</option>
            	            	<option>Female</option>
							</select> 
                        </th>
                        <th align="center" valign="top">
                        	Do you know birthdate? 
						Yes <input type="radio" name="gotBirthdate" value="on" onclick="showdiv('birthdate')" />   No <input type="radio" name="gotBirthdate" value="off" onclick="cachediv('birthdate')" checked />
							<div id="birthdate">
                            	Date born?
								<script>DateInput('birthdate', true, 'MON-DD-YYYY')</script>
                            </div>
							<script>cachediv('birthdate');</script>
                        </th>
                        <th align="center" valign="top">
                        	Is still alive? 
						Yes <input type="radio" name="isDeceased" value="off" checked="checked" onclick="cachediv('deceased')" />   No <input type="radio" name="isDeceased" value="on" onclick="showdiv('deceased')" />
						<div id="deceased">
							Date deceased?
							<script>DateInput('deceased', true, 'MON-DD-YYYY')</script>
						</div>
							<script>cachediv('deceased');</script>
                        </th>
                    </tr>
                    <tr>
                    	<th valign="top" colspan="6" align="left">
                        	<table>
                            	<tr>
                                	<td valign="middle">
			                        	<c:if test="${peopleBean.imageIn == null}">
		    		                    	<img  class="image" src="images/nophoto.png">
        	        		            </c:if>
            	            		    <c:if test="${peopleBean.imageIn != null}">
	            	              			<img  class="image" src="control/doGetImgNew.jsp">
		            	                </c:if>
                                    </td>
                                    <td valign="middle">
                          				<div style="text-align:center; font-size:12px; font-style:italic">
                                    		Max size <span style="font-weight:bold">250 KB</span> - 120px by 120px - <span style="font-weight:bold">JPG, GIF or PNG</span>
	                                    </div>
                                        <c:if test="${peopleBean.imageIn == null}">
	                                    	<form name="uploadForm_a" action="control/doImg2.jsp" enctype="multipart/form-data" method="post">
    	                                    	<input type="file" accept="image/jpg,image/gif,image/png" name="uploadfile" onchange="document.uploadForm_a.submit()" o/>
            	                            </form>
                                        </c:if>
                                        <c:if test="${peopleBean.imageIn != null}">
	                                    	<form action="control/doRemoveImg.jsp" method="post">
    	                                    	<input type="submit" value="remove" />
        	                                </form>
		                                </c:if>
                                    </td>
                                </tr>
                        	</table>
                        </th>
                    </tr>
                </table>
            </td>
            <td valign="top">
            	<table>
                	<tr>
                    	<td align="center" valign="top">
                        	<form method="post" action="index.jsp">
								<input type="submit" name="retour" value="Cancel" />
                                <input type="hidden" name="theText" value="${peopleBean.name}" />
                            </form>
                        </td>
                        <td align="center" valign="top">
                        	<input type="button" value="Save" onclick="document.addForm.submit()" />
                        </td>
                    </tr>
                </table>
            </td>
        <tr>
            <td valign="top" colspan="2" align="center">
					<br />
                    <table align="center">
						<tr>
							<td>
                            	<form method="post" action="index.jsp">
									<input type="submit" name="retour" value="Cancel" />
                                    <input type="hidden" name="theText" value="${peopleBean.name}" />
                                </form>
							</td>
							<td>
								<input type="button" value="Save" onclick="document.addForm.submit()" />
							</td>
						</tr>
                        <tr>
							<td colspan="2"><hr /></td>
						</tr>
					</table>
                    <p>
                    	<div id="imageBox">
							<table>
								<tr><td align="center">
                                	<c:if test="${peopleBean.imageIn == null}">
	                                	<img  class="image" src="images/nophoto.png">
                                    </c:if>
                                    <c:if test="${peopleBean.imageIn != null}">
	                                	<img  class="image" src="control/doGetImgNew.jsp">
                                    </c:if>
								</td></tr>
                                <c:if test="${peopleBean.imageIn == null}">
                                <tr><td>
									<div style="text-align:center; font-size:12px; font-style:italic">
                                    	Max size <span style="font-weight:bold">250 KB</span> - 120px by 120px - <span style="font-weight:bold">JPG, GIF or PNG</span>
                                    </div>
								</td></tr>
                                <tr>
                                	<td align="center">
         	                           	<iframe id="uploadFrameID" name="uploadFrame" height="0" width="0" 
            frameborder="0" scrolling="yes"></iframe>              
                                    	<form name="uploadForm" action="control/doImg2.jsp" enctype="multipart/form-data" method="post" target="uploadFrame">
                                        	<input type="file" accept="image/jpg,image/gif,image/png" name="uploadfile" onchange="uploadForm.submit();"/>
                                        </form>
									</td>
								</tr>
                                </c:if>
                                <c:if test="${peopleBean.imageIn != null}">
                                <tr>
                                	<td align="center">
                                    	<form action="control/doRemoveImg.jsp" method="post">
                                        	<input type="submit" value="remove" />
                                        </form>
									</td>
								</tr>
                                </c:if>
							</table>
                            </form>
						</div>
                        <br />
                        <div id="prtCnt"></div>
                    </p>
					<p>
                    	<c:if test="${param.errors != null}">
	                    	<span style="color:red">*** ${param.errors} ***</span>
	                        <br />
                        </c:if>
                    </p>
                    <form action="control/doAddProfile.jsp" method="post" name="addForm">
	                	<input type="hidden" name="name" value="${param.theText}" />
                    <p>
						Gender of ${param.theText} :: 
						<select name="gender">
                        	<option>SELECT</option>
                        	<option>Male</option>
                        	<option>Female</option>
						</select> 
					</p>
					<p>
						Do you know ${param.theText}'s date of birth? 
						Yes <input type="radio" name="gotBirthdate" value="on" onclick="showdiv('birthdate')" />   No <input type="radio" name="gotBirthdate" value="off" onclick="cachediv('birthdate')" checked />
						<div id="birthdate"><script>DateInput('birthdate', true, 'MON-DD-YYYY')</script></div>
					</p>
					<script>cachediv('birthdate');</script>
					<p>
						Is ${param.theText} still alive? 
						Yes <input type="radio" name="isDeceased" value="off" checked="checked" onclick="cachediv('deceased')" />   No <input type="radio" name="isDeceased" value="on" onclick="showdiv('deceased')" />
						<div id="deceased">
							When did ${param.theText} pass away?
							<script>DateInput('deceased', true, 'MON-DD-YYYY')</script>
						</div>
					</p>
					<script>cachediv('deceased');</script>

					<p>
                    	Name of father
                        <br />
                        <input type="text" name="father" />
                	</p>
                    <p>
                    	Name of mother
                        <br />
                        <input type="text" name="mother" />
                	</p>
                    <p>
                    	Name of children (separated by semi-colon ';')
                        <br />
                        <input type="text" name="father" size="40" />
                	</p>
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
        </tr>
	</table>
</div>

</body>

</html>
