<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/control/stdTags.jspf" %>

					<div style="margin:10px 0px 0px 20px">
						<form action="control/doTree.jsp" method="post">
						<table class="noborder">
							<tr><td colspan="2" class="style1"><p style="text-align:center">${fn:escapeXml(param.errors)}</p></td></tr>
							<tr>
								<td><input type="text" name="name" value="${param.name}"></td>
								<td><input type="submit" value="save"></td>
							</tr>
						</table>
						
						<table style="font-size:18px">
							<c:if test="${param.status == 'Public'}">
							<tr>
								<td style="font-size:16px; font-weight:bold; color:green">${fn:escapeXml(ans.Status)} Tree</td>
								<td>
								<form action="" method="post">
									<input type="submit" value="change" style="font-size:10px" title="make tree viewable only by your guests">
									<input type="hidden" name="description" value="${ans.Description}">
								</form>
								</td>
							</tr>
							</c:if>
							<c:if test="${ans.Status == 'Private'}">
							<tr>
								<td style="font-size:12px; font-weight:bold; color:orange">${fn:escapeXml(ans.Status)}</td>
								<td>
								<form action="" method="post">
									<input type="submit" value="change" style="font-size:10px" title="make tree open to the public" >
									<input type="hidden" name="description" value="${ans.Description}">
								</form>
								</td>
							</tr>
							</c:if>
							<input type="hidden" name="treeID" value="${param.treeID}">
							<input type="hidden" name="description" value="${param.description}" />
						</table>
						</form>
				</div>
				<c:url var="viewtreeUrl" value="/mytree.jsp">
			        <c:param name="ref" value="1" />
                    <c:param name="treeID" value="${param.treeID}" />
				</c:url>
				<div><p><a href="<c:out value="${viewtreeUrl}"/>">Go Back</a></p></div>