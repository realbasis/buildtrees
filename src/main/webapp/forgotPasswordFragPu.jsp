<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

<jsp:useBean id="spamBean" class="utility.SpamBean" />

				<div align="center" style="width:436px; margin:10px 0 10px 0">
					<form action="control/doGetPassword.jsp" method="post" name="getPasswordForm">
		                <table class="noborder">
						  <tr>
                		    <th colspan="2"><div align="left" style="margin:10px 0 10px 0">Hiyté haala fédiou</div></th>
		                  </tr>
						  <tr>
                		    <td colspan="2">
								<div align="center" class="style1" style="background-color:yellow; font-size:14px;">${fn:escapeXml(param.errors)}</div>
							</td>
		                  </tr>
						  <tr align="left">
		                    <td>Votre Email::</td>
        		            <td><input type="text" name="email" value="${param.email}" size="30"></td>
                		  </tr>
						  <tr>
		                    <th align="right">
								<span style="color:red">Code anti-spam:</span>  ${spamBean.spam1} + ${spamBean.spam2} = 
								<input type="hidden" name="spam1" value="${spamBean.spam1}">
								<input type="hidden" name="spam2" value="${spamBean.spam2}">
							</th>
        		            <td align="left">
								<input type="text" name="spam" size="2" maxlength="2">
							</td>
                		  </tr>
						  <!--
						  <tr align="left">
		                    <td>Password Hint::</td>
        		            <td><input type="password" name="petName" value="${param.petName}" size="30"></td>
                		  </tr>
						  -->
						  <tr>
				          	<td colspan="2" align="center">
								<div align="center" style="margin:10px 0 10px 0">
			        		    	<input type="submit" name="submitYes" value="diocougol" onClick="getPasswordForm.submitYes.value='Processing...'">
									<h5><a href="signup.jsp" style="text-decoration:underline">Winditagol è compte késso</a></h5>
				                </div>
							</td>
						  </tr>
						 </table>
					</form>
				</div>
