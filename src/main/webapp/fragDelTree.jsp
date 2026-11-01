<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/control/stdTags.jspf" %>

                                    <div style="margin:20px 20px 10px 20px">
					<p style="font-size:14px; text-align:center; font-weight:bold">
You are about to delete family tree <span style=" text-decoration:underline">${fn:escapeXml(param.name)}</span> and all of its members.
                                        </p>
					<p class="style1" style="font-size:16px; font-weight:bold">
The information will be lost permanently.
                                        </p>
					<p class="style1" style="font-size:16px; font-weight:bold">
Would you like to continue?
                                        </p>
					<p style="text-align:center">
					<table class="noborder">
						<tr>
							<td width="150" align="center">
								<form action="control/doTreeDel.jsp" method="post">
									<input type="submit" value="Yes">
									<input type="hidden" name="treeID" value="${param.treeID}">
								</form>
							</td>
							<td width="150" align="center">
								<form action="mytree.jsp" method="post">
									<input type="submit" value="No">
									<input type="hidden" name="treeID" value="${param.treeID}">
									<input type="hidden" name="ref" value="1">
								</form>
							</td>
						</tr>
					</table>
					</p>
                                    </div>