<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="java.util.LinkedList,java.util.SortedMap,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="control/stdTags.jspf" %>

<jsp:useBean id="treeLogicBean" class="utility.TreeLogicBean" />

<%
boolean success = true;

LinkedList list = null;
SortedMap map[] = null;
TreeMap tMap = null;
Integer pid = null;
String linkType = null;

TreeBean treeBean = (TreeBean) session.getAttribute("treeBean");
Integer accountID = (Integer) session.getAttribute("accountID");
linkType = request.getParameter("linkType");

if(linkType.equals("Father")) {
    
    tMap = treeBean.getMe();
    pid = treeBean.getPeopleID();

    list = treeLogicBean.pullProfileSelect(pid, treeBean.getFamilyAll(), linkType);
    request.setAttribute("namesSelect", list);
    
}
%>

<c:if test="${param.linkType == 'Father'}">
	<div class="screen2">
		<table align="center">
			<form action="control/doRecordZnode.jsp" method="post">
				<input type="hidden" name="linkType" value="${param.linkType}" />
				<tr>
					<td valign="middle" colspan="2">
						<div style="background-color:white; margin-top:30px">
							<select name="peopleID">
								<c:forEach items="${namesSelect}" var="row">
									<c:if test="${row.AccountID == accountID}">
										<option value="${row.PeopleID}">${row.Name}</option>
									</c:if>
									<c:if test="${row.AccountID != accountID}">
										<option value="${row.PeopleID}">*${row.Name}</option>
									</c:if>
								</c:forEach>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td align="right">
						<input type="submit" name="retour" value="cancel" />
					</td>
					<td align="left">
						<input type="submit" value="link" />
					</td>
				</tr>
			</form>
		</table>
	</div>
</c:if>

<c:if test="${param.linkType != 'Father'}">
	<c:if test="${treeBean.father == null}">
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
							<form action="zmain.jsp" method="post">
								<input type="submit" value="${languageBean.zmainAddFather}" style="font-size:12px" />
								<input type="hidden" name="linkType" value="Father" />
							</form>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</c:if>
	<c:if test="${treeBean.father.AccountID == accountID}">
		<c:set var="scrn" value="screen2"/>
	</c:if>
	<c:if test="${treeBean.father.AccountID != accountID}">
		<c:set var="scrn" value="screen3"/>
	</c:if>
	<c:if test="${treeBean.father != null}">
		<div class="${scrn}" align="center">
			<table>
				<tr>
					<td valign="top">
						<c:if test="${treeBean.father.ImageName == 'none'}">
							<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
								<br />
								NO
								<br /><br />
								PHOTO
							</div>
						</c:if>
						<c:if test="${treeBean.father.ImageName != 'none'}">
							<div align="center">
								<img class="image" src='<c:out value="control/doGetImg.jsp?id=${treeBean.father.PeopleID}" />'>
							</div>
						</c:if>
					</td>
					<td valign="top">
					  <div class="textZone">
						<span style="font-size:14px; font-weight:bold">
							* ${languageBean.zmainFather} *
							<br />
							<c:if test="${fn:length(treeBean.father.Name) > 15}">
								<span title="${treeBean.father.Name}">${fn:substring(treeBean.father.Name, 0, 13)}...</span>
							</c:if>
							<c:if test="${fn:length(treeBean.father.Name) <= 15}">
								${treeBean.father.Name}
							</c:if>
						</span>
						<c:if test="${treeBean.father.GotBirthdate == 'on'}">
							<br />
							${languageBean.zmainBornOn} <fmt:formatDate value="${treeBean.father.Birthdate}" pattern="MM/dd/yy" />
						</c:if>
						<c:if test="${treeBean.father.GotBirthdate != 'on'}">
							<br />
							-
						</c:if>	
						<c:if test="${treeBean.father.IsDeceased == 'on'}">
							<br />
							${languageBean.zmainPassedOn} <fmt:formatDate value="${treeBean.father.Deceased}" pattern="MM/dd/yy" />
						</c:if>
						<c:if test="${treeBean.father.IsDeceased != 'on'}">
							<br />
							-
						</c:if>
						<br /><br />
						<c:url var="changeDadUrl" value="control/doChangeProfile.jsp">
						    <c:param name="id" value="${treeBean.father.PeopleID}" />
					    </c:url>
						  <a href="<c:out value="${changeDadUrl}"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('NavigateDad','','images/forward-arrow-dark.jpg',1)"><img src="images/forward-arrow-light.jpg" alt="Navigate to this profile" name="NavigateDad" width="33" height="33" border="0" id="NavigateDad" /></a>
											
						<c:url var="unlinkUrl" value="control/doUnlink.jsp">
						  <c:param name="peopleID" value="${treeBean.father.PeopleID}" />
						</c:url>
						<a href="<c:out value="${unlinkUrl}"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('unlink','','images/unlink2.png',1)"><img src="images/unlink.png" alt="Unlink profile from tree" name="unlink" width="32" height="32" border="0" id="unlink" /></a>
					 </div>
					</td>
				</tr>
			</table>
		</div>
	</c:if>
</c:if>