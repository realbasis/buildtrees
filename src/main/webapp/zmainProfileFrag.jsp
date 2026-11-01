<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="java.util.LinkedList,java.util.SortedMap,java.util.TreeMap,java.util.ArrayList" %>
<%@page import="utility.*,value.*,api.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="control/stdTags.jspf" %>

<jsp:useBean id="treeLogicBean" class="utility.TreeLogicBean" />
<jsp:useBean id="profileDef" class="api.ProfileDefinition" />

<c:set var="testthis" value="0" />

<%
boolean success = true;

LinkedList list = null;
SortedMap map[] = null;
TreeMap tMap = null;
TreeMap profileMap = null;
Integer pid = null;
String linkType = null;
String relationship = null;
LinkedList profileList = null;
Integer listSize = null;

TreeBean treeBean = (TreeBean) session.getAttribute("treeBean");
Integer accountID = (Integer) session.getAttribute("accountID");
linkType = request.getParameter("linkType");
relationship = request.getParameter("relationship");

request.setAttribute("profileTerms", profileDef.defineTerms(relationship));
request.setAttribute("profileLevel", profileDef.defineLevel(relationship));

profileList = profileDef.defineList(treeBean, relationship);
if(profileList == null)
    listSize = new Integer(0);
else
    listSize = new Integer(profileList.size());

request.setAttribute("profileList", profileList);
request.setAttribute("listSize", listSize);

if(!linkType.equals("")) {
    
    tMap = treeBean.getMe();
    pid = treeBean.getPeopleID();

    list = treeLogicBean.pullProfileSelect(treeBean, linkType, accountID);

}
else if(linkType.equals("")) {
    
    list = treeBean.getFamilyAll();
    
}

    Integer namesSelectSize = null;
    if(list == null)
        namesSelectSize = new Integer(0);
    else
        namesSelectSize = new Integer(list.size());
    
    request.setAttribute("namesSelect", list);
    request.setAttribute("namesSelectSize", namesSelectSize);

%>

<c:if test="${param.linkType != ''}">
    <c:if test="${namesSelectSize > 0}">
	<div class="screen2">
		<table align="center">
			<form action="control/doRecordZnode.jsp" method="post">
				<input type="hidden" name="linkType" value="${param.linkType}" />
				<tr>
					<td valign="middle" colspan="2">
						<div style="background-color:white; margin-top:30px">
							<select name="peopleID">
								<c:forEach items="${namesSelect}" var="row">
           	                            <c:choose>
	                                    	<c:when test="${row.GotBirthdate == 'on'}">
                                            	<c:set var="bYear" value="${fn:split(row.Birthdate,'-')}" />
                                                <c:set var="bYear" value="${bYear[0]}" />
                                            </c:when>
                                            <c:otherwise>
                                            	<c:set var="bYear" value="" />
                                            </c:otherwise>
                                        </c:choose>

									<c:if test="${row.AccountID == accountID}">
										<option value="${row.PeopleID}">${row.Name} ${bYear}</option>
									</c:if>
									<c:if test="${row.AccountID != accountID}">
										<option value="${row.PeopleID}">*${row.Name} ${bYear}</option>
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
</c:if>

<c:if test="${param.linkType == ''}">
        <c:if test="${listSize == 0 && profileLevel == 1}">
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
									<c:if test="${namesSelectSize > 1}">
										<input type="submit" value="${profileTerms.AddButton}" style="font-size:12px" />
                                    </c:if>
                                    <c:if test="${namesSelectSize == 1}">
										<input type="submit" value="${profileTerms.AddButton}" style="font-size:12px; color:gray" disabled="disabled" />
                                    </c:if>
									<input type="hidden" name="linkType" value="${param.relationship}" />
							</form>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<br>
	</c:if>
</c:if>

<c:forEach items="${profileList}" var="profileMap">
	<c:if test="${profileMap.AccountID == accountID}">
		<c:set var="scrn" value="screen2"/>
	</c:if>
	<c:if test="${profileMap.AccountID != accountID}">
		<c:set var="scrn" value="screen3"/>
	</c:if>

		<div class="${scrn}" align="center">
			<table>
				<tr>
					<td valign="top">
						<c:if test="${profileMap.ImageName == 'none'}">
							<div class="image" style="font-weight:bold; margin-bottom:5px; border:solid 1px;" align="center">
								<br />
								NO
								<br /><br />
								PHOTO
							</div>
						</c:if>
						<c:if test="${profileMap.ImageName != 'none'}">
							<div align="center">
								<img class="image" src='<c:out value="control/doGetImg.jsp?id=${profileMap.PeopleID}" />'>
							</div>
						</c:if>
					</td>
					<td valign="top">
					  <div class="textZone">
						<span style="font-size:14px; font-weight:bold">
							* ${profileTerms.Title} *
							<br />
							<c:if test="${fn:length(profileMap.Name) > 15}">
								<span title="${profileMap.Name}">${fn:substring(profileMap.Name, 0, 13)}...</span>
							</c:if>
							<c:if test="${fn:length(profileMap.Name) <= 15}">
								${profileMap.Name}
							</c:if>
						</span>
						<c:if test="${profileMap.GotBirthdate == 'on'}">
							<br />
							${languageBean.zmainBornOn} <fmt:formatDate value="${profileMap.Birthdate}" pattern="MM/dd/yy" />
						</c:if>
						<c:if test="${profileMap.GotBirthdate != 'on'}">
							<br />
							-
						</c:if>	
						<c:if test="${profileMap.IsDeceased == 'on'}">
							<br />
							${languageBean.zmainPassedOn} <fmt:formatDate value="${profileMap.Deceased}" pattern="MM/dd/yy" />
						</c:if>
						<c:if test="${profileMap.IsDeceased != 'on'}">
							<br />
							-
						</c:if>
						<br /><br />
						<div align="right">
						<c:url var="changeDadUrl" value="control/doChangeProfile.jsp">
						    <c:param name="id" value="${profileMap.PeopleID}" />
					    </c:url>
						  <a href="<c:out value="${changeDadUrl}"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('NavigateDad','','images/forward-arrow-dark.jpg',1)"><img src="images/forward-arrow-light.jpg" alt="Navigate to this profile" name="NavigateDad" width="33" height="33" border="0" id="NavigateDad" /></a>
						  
						<c:url var="unlinkUrl" value="control/doUnlink.jsp">
							  <c:param name="peopleID" value="${profileMap.PeopleID}" />
						</c:url>
						<c:choose>
							<c:when test="${treeBean.me.AccountID != accountID}">
								<c:if test="${profileMap.AccountID == accountID}">
									<a href="<c:out value="${unlinkUrl}"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('unlink','','images/unlink2.png',1)"><img src="images/unlink.png" alt="Unlink profile from tree" name="unlink" width="32" height="32" border="0" id="unlink" /></a>
								</c:if>
							</c:when>
							<c:otherwise>						
								<a href="<c:out value="${unlinkUrl}"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('unlink','','images/unlink2.png',1)"><img src="images/unlink.png" alt="Unlink profile from tree" name="unlink" width="32" height="32" border="0" id="unlink" /></a>
							</c:otherwise>
						</c:choose>
						</div>
					 </div>
					</td>
				</tr>
			</table>
		</div>
	<br>
</c:forEach>
