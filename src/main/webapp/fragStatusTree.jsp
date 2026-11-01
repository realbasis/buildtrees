<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/control/stdTags.jspf" %>

				<div style="margin:10px 20px 10px 20px">
					
					<c:if test="${param.status == 'Public'}">
						<p style="font-size:18px; text-align:left">
The status of tree <span style="font-weight:bold; text-decoration:underline">${param.name}</span> is currently set to <span style="font-weight:bold">'Public'</span>, so it can be visited by anyone on the internet.
                                                </p>
						<p style="font-size:18px; text-align:left">
By changing your status to Private, only viewers who have been granted access can view the tree.
						</p>
						<p>
						<form action="control/doStatusTrees.jsp" method="post">
							<table>
								<tr>
									<td><input type="submit" value="Toggle Status"></td>
								</tr>
							</table>
							<input type="hidden" name="treeID" value="${param.treeID}">
							<input type="hidden" name="name" value="${param.name}">
							<input type="hidden" name="status" value="${param.status}">
							<input type="hidden" name="ref" value="${param.ref}">
						</form>
						</p>
						<c:url var="viewtreeUrl" value="/mytree.jsp">
							<c:param name="ref" value="1" />
							<c:param name="treeID" value="${param.treeID}" />
						</c:url>
						<div><p><a href="<c:out value="${viewtreeUrl}"/>">Go Back</a></p></div>
					</c:if>
					
					<c:if test="${param.status == 'Private'}">
						<p style="font-size:18px; text-align:left">
The status of tree <span style="font-weight:bold; text-decoration:underline">${param.name}</span> is currently set to <span style="font-weight:bold">'Private'</span>, so a guest can only view the tree if access is granted by account owner.
                                                </p>
						<p>
						<form action="control/doStatusTrees.jsp" method="post">
							<table>
								<tr>
									<td style="text-align:center" class="style1">${param.errors}</td>
								</tr>
								<tr>
									<td><input type="submit" value="Toggle Status"></td>
								</tr>
							</table>
							<input type="hidden" name="treeID" value="${param.treeID}">
							<input type="hidden" name="name" value="${param.name}">
							<input type="hidden" name="status" value="${param.status}">
							<input type="hidden" name="ref" value="${param.ref}">
						</form>
						</p>
						<c:url var="viewtreeUrl" value="/mytree.jsp">
							<c:param name="ref" value="1" />
							<c:param name="treeID" value="${param.treeID}" />
						</c:url>
						<div><p><a href="<c:out value="${viewtreeUrl}"/>">Go Back</a></p></div>
					</c:if>

				</div>