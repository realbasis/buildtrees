<%@page contentType="text/html" errorPage="/error.jsp?debug=log"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/control/stdTags.jspf" %>

                                                <table class="noborder" align="center">
							<tr>
								<td colspan="2" align="center">
									<p style="text-align:center; font-size:14px">You are about to <span style="font-weight:bold">delete</span> this person and all its associations to the tree!</p>
									<p class="style1" style="text-align:center; font-size:22px">Would you like to continue?</p>
								</td>
							</tr>
							<tr>
								<td align="center">
									<form action="control/doDelNode.jsp" method="post" name="delNodeForm">
										<input type="hidden" name="treeID" value="${param.treeID}">
										<input type="hidden" name="name" value="${param.name}">
										<input type="hidden" name="peopleID" value="${param.peopleID}">
										<input type="hidden" name="ref" value="1">
										<input type="submit" value="Yes" name="delNode" onClick="delNodeForm.delNode.value='Processing...'">
										<input type="hidden" name="other" value="${param.other}">
										<input type="hidden" name="accountOwner" value="${param.accountOwner}" />
										<input type="hidden" name="emailo" value="${param.emailo}" />
									</form>
								</td>
								<td align="center">
									<form action="people.jsp" method="post">
										<input type="hidden" name="treeID" value="${param.treeID}">
										<input type="hidden" name="name" value="${param.name}">
										<input type="hidden" name="peopleID" value="${param.peopleID}">										<input type="hidden" name="ref" value="1">
										<input type="submit" value="No">
										<input type="hidden" name="other" value="${param.other}">
										<input type="hidden" name="accountOwner" value="${param.accountOwner}" />
										<input type="hidden" name="emailo" value="${param.emailo}" />
									</form>
								</td>
							</tr>
						</table>