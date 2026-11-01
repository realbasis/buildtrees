<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="java.util.LinkedList,java.util.SortedMap,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@include file="/control/stdTags.jspf" %>

<c:if test="${accountID == null || accountID == ''}">
	<c:redirect url="/control/logout.jsp">
		<c:param name="errors" value="Session has expired!" />
	</c:redirect>
</c:if>

<jsp:setProperty name="baobabBean" property="peopleID" value="${param.peopleID}" />
<jsp:setProperty name="treeBean" property="peopleMap" value="${baobabBean.peopleMap}" />
<jsp:useBean id="elseBean" class="value.PeopleBean" />

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Family Tree Builder..Mankind Connected</title>
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
	width:120px;
	height:120px;
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
	<table style="width:700px;">
    	<tr>
            <td valign="middle" style="width:280px;">
               	<div id="menuLeftb">
	   				<a href="index.jsp"><img style="border:none; text-decoration:none" src="images/buildtrees_logo2.png"></a>
		        </div>
            </td>
			<td valign="middle" align="left">
            	<div>
                	<table><tr>
                    	<td>
		                	<form method="post" action="details.jsp">
    			            	<input type="submit" value="edit" />
                                <input type="hidden" name="peopleID" value="${param.peopleID}" />
        	    		    </form>
                    	</td>
                        <td>
			                <form method="post" action="index.jsp">
    			            	<input type="submit" value="close" />
        	    		    </form>
                        </td>
                	</tr></table>
                </div>
				<h3 style="text-transform:uppercase"></h3>
			</td>
        </tr>
        <tr>
        	<td colspan="2"><div style="margin-bottom:10px"></div></td>
        </tr>
        
        <tr>
            <td valign="top" colspan="2" align="left">
            
            	<c:if test="${param.edit == null}">
            	<table>
                	<tr>
                    	<td>
                        	<c:if test="${treeBean.peopleMap.ImageName == 'none'}">
								<div>
									<table>
										<tr><td>
											<img  class="image" src="images/nophoto.png" />
										</td></tr>
									</table>
								</div>
							</c:if>
							<c:if test="${treeBean.peopleMap.ImageName != 'none'}">
								<div>
									<table border="1">
										<tr><td>
											<img  class="image" src='<c:out value="control/doGetImg2.jsp" />'>
										</td></tr>
									</table>
								</div>
							</c:if>
                        </td>
                        <td valign="top">
                        	<div style="margin-left:30px">
	                        	<h2>Profile of ${treeBean.peopleMap.Name}</h2>
    	                        	<ul style="font-size:14px; font-weight:bold">
			                            <c:if test="${!(treeBean.peopleMap.BirthPlace == null || treeBean.peopleMap.BirthPlace == '')}">
						        	    	<li>Born in <c:out value="${treeBean.peopleMap.BirthPlace}" /> </li>
							            </c:if>
						                <c:if test="${treeBean.peopleMap.GotBirthdate == 'on'}">
					    	               	<li>Born on <fmt:formatDate value="${treeBean.peopleMap.Birthdate}" pattern="MMM-dd-yyyy" /></li>
					        	        </c:if>
			    		        	    <c:if test="${treeBean.peopleMap.IsDeceased == 'on'}">
				        		    	   	<li>Deceased on <fmt:formatDate value="${treeBean.peopleMap.Deceased}" pattern="MMM-dd-yyyy" /></li>
				    			        </c:if> 
    	                            </ul>
                            	<h2>Family Links</h2>
    	                        	<ul style="font-size:14px; font-weight:bold">
                                    	<c:forEach items="${treeBean.peopleMap.LinksList}" var="line">
	                                    	<jsp:setProperty name="baobabBean" property="peopleID" value="${line.ElseID}" />
                                            <jsp:setProperty name="elseBean" property="peopleMap" value="${baobabBean.peopleMap}" />
			                            	<li>
	                                        	<c:out value="${line.Title}" />: <c:out value="${elseBean.peopleMap.Name}" />
                                            </li>
                                        </c:forEach>
    	                            </ul>
                        	</div>
                        </td>
                    </tr>
                    <tr>
                    	<td colspan="2">
                        </td>
                    </tr>
                </table>
                </c:if>
            </td>
        </tr>
	</table>
</div>

</body>

</html>
