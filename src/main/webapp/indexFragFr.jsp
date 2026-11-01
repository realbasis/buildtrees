<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/control/stdTags.jspf" %>

				<div id="screenTop">
					<div style="text-align:center">
					<h2>BuildTrees&#8482; pour la Famille</h2>
					<table width="100%">
						<tr>
						<c:if test="${accountID == null}">
							<td align="center" style="font-style:italic; color:orange">
							<form action="signup.jsp" name="signupForm" method="post">
								<input type="button" value="Créez Votre Arbre" style="width:120px; height:40px" onClick="signupForm.submit()">
							</form>
							</td>
						</c:if>
						<c:if test="${accountID != null}">
							<td align="center">
							<form action="search.jsp" name="searchForm" method="post">
								<input type="button" value="Recherchez Votre Arbre" style="width:120px; height:40px" onClick="searchForm.submit()">
							</form>
							</td>
						</c:if>
						</tr>
					</table>
					</div>
					<div style="margin-top:10px">
					<table width="80%">
						<tr>
							<td align="center" style="color:green; font-size:18px">Simple à<br>Utiliser!</td>
							<td align="center" style="color:green; font-size:18px">Facile à<br>Partager!</td>
							<td align="center" style="color:green; font-size:18px">Complètement <br>Gratuit!</td>
						</tr>
					</table>
					</div>
					<p style="text-align:justify; font-size:14px; padding-left:15px; padding-right:15px">BuildTrees&#8482; est une solution gratuite qui permet de retrouver ses liens de famille à partir d'un site internet.  En effet, cet outil est beaucoup plus qu'un arbre généalogique traditionnel étant donné que les utilisateurs peuvent participer à la construction d'un même arbre en quelques clicks et de n’ importe où dans le monde.  L'objectif de BuildTrees&#8482; est qu'un jour tout le monde puisse retrouver ses liens de famille par rapport au reste de l'humanité.  Vous êtes invités donc à nous accompagner dans ce voyage magnifique.</p>
					<img src="images/family2.jpg">
					<p style="text-align:justify; font-style:italic; font-size:12px; padding-left:15px; padding-right:15px">"Quel sentiment extraordinaire que d'être liés pour la vie - être lies par des souvenirs silencieux et inexplicables" ~ George Eliot</p>	
				</div>