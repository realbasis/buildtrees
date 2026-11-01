<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="control/stdTags.jspf" %>

<c:if test="${sharersFlag > 0}">
	<table align="center">
		<form action="control/doRefreshTree.jsp" method="post">
		<tr>
			<td style="color:red; font-size:12px; text-align:center; font-weight:bold">
				TREE CHANGED...
			</td>
		</tr>
		<tr>
			<td align="center">
				<input type="submit" value="REFRESH" />
			</td>
		</tr>
		</form>
	</table>
</c:if>