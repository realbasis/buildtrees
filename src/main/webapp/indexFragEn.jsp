<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

				<div id="screenTop">
					<div style="text-align:center">
					<h2>BuildTrees&#8482; is about Family</h2>
					<table width="100%">
						<tr>
						<c:if test="${accountID == null}">
							<td align="center" style="font-style:italic; color:orange">
							<form action="signup.jsp" name="signupForm" method="post">
								<input type="button" value="Start Your Tree" style="width:120px; height:40px" onClick="signupForm.submit()">
							</form>
							</td>
						</c:if>
						<c:if test="${accountID != null}">
							<td align="center">
							<form action="search.jsp" name="searchForm" method="post">
								<input type="button" value="Search a Tree" style="width:120px; height:40px" onClick="searchForm.submit()">
							</form>
							</td>
						</c:if>
						</tr>
					</table>
					</div>
					<div style="margin-top:10px">
					<table width="80%">
						<tr>
							<td align="center" style="color:green; font-size:14px">User<br>Friendly!</td>
							<td align="center" style="color:green; font-size:14px">Easily<br>Sharable!</td>
							<td align="center" style="color:green; font-size:14px">No <br>Fees!</td>
                            <td align="center" style="color:green; font-size:14px">We Value <br>Your Privacy!</td>
						</tr>
					</table>
					</div>
					
					<p style="text-align:justify; font-size:14px; padding-left:15px; padding-right:15px">BuildTrees&#8482; is an online license-free utilty designed to help people link their family members over the internet.  This is much more than a traditional family tree builder as users can share and contribute on the same tree within a few clicks regardless of their geographic location.  BuildTrees&#8482; goal is to, eventually, connect every human being in this universe.  Please join us in this amazing journey.</p>
					<img src="images/family2.jpg">
					<p style="text-align:justify; font-style:italic; font-size:12px; padding-left:15px; padding-right:15px">"What greater thing is there for human souls than to feel that they are joined for life - to be with each other in silent unspeakable memories." ~ George Eliot</p>
					
				</div>