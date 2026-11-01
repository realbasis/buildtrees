<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/control/stdTags.jspf" %>

                                                <table class="noborder" align="center">
							<tr>
								<td align="center">
									<p style="text-align:center; font-size:14px; font-weight:bold">Upload a photo of the person here</p>
									<p style="text-align:center; font-size:12px; font-style:italic">Size: less than <span style="font-weight:bold">250 KB</span> - Dim: 170px by 170px - Format: <span style="font-weight:bold">JPEG or GIF</span></p>
								</td>
							</tr>
							<tr>
						      <td align="center" class="style1">${fn:escapeXml(param.errors)}</td>
						    </tr>
							<tr>
								<td align="center">
									<form name="uploadForm" action="control/doDbUpload.jsp" enctype="multipart/form-data" method="post">
										<input type="file" name="uploadfile"/>
										<input TYPE=Button name='Upload' Value='Upload' onClick="uploadForm.Upload.value='Uploading...';uploadForm.submit()">
										<input type="hidden" name="treeID" value="${param.treeID}">
										<input type="hidden" name="name" value="${param.name}">
										<input type="hidden" name="peopleID" value="${param.peopleID}">
										<input type="hidden" name="ref" value="${param.ref}">
										<input type="hidden" name="pos" value="${param.pos}">
										<input type="hidden" name="other" value="${param.other}">
										<input type="hidden" name="accountOwner" value="${param.accountOwner}" />
										<input type="hidden" name="emailo" value="${param.emailo}" />
									</form>
								</td>
							</tr>
							<tr>
								<td align="center">
									<form action="control/doDelImg.jsp" method="post" name="delImgForm">
										<input type="button" name="delImg" value="Erase Current Photo" onClick="delImgForm.delImg.value='Deleting...';delImgForm.submit()">
										<input type="hidden" name="treeID" value="${param.treeID}">
										<input type="hidden" name="name" value="${param.name}">
										<input type="hidden" name="peopleID" value="${param.peopleID}">
										<input type="hidden" name="ref" value="${param.ref}">
										<input type="hidden" name="other" value="${param.other}">
										<input type="hidden" name="accountOwner" value="${param.accountOwner}" />
										<input type="hidden" name="emailo" value="${param.emailo}" />
									</form>
								</td>
							</tr>
						</table>
							<c:url var="viewpeopleUrl" value="/people.jsp">
								<c:param name="ref" value="1" />
								<c:param name="treeID" value="${param.treeID}" />
								<c:param name="name" value="${param.name}" />
								<c:param name="peopleID" value="${param.peopleID}" />
								<c:param name="other" value="${param.other}" />
								<c:param name="accountOwner" value="${param.accountOwner}" />
								<c:param name="emailo" value="${param.emailo}" />
							</c:url>
							<div><p><a href="<c:out value="${viewpeopleUrl}"/>">Cancel transaction</a></p></div>