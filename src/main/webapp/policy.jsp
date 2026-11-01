<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html><!-- InstanceBegin template="/Templates/publicLinked.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<!-- InstanceBeginEditable name="doctitle" -->
<title>Family Tree Builder..Mankind Connected</title>
<!-- InstanceEndEditable -->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/linked.css" rel="stylesheet" type="text/css">
<%@include file="/control/stdTags.jspf" %>
<c:set var="theURI" value="${pageContext.request.requestURI}" />
<c:set var="theURL" value="${pageContext.request.requestURL}" />
<c:if test="${languageBean == null}">
	<jsp:useBean id="languageBean" class="value.LanguageBean" scope="session" />
</c:if>
<c:if test="${param.in != null}">
	<c:if test="${param.in == 'admin'}">
		<c:set var="paswd" value="${param.password}"/>
	</c:if>
</c:if>
<!-- InstanceBeginEditable name="head" -->
<style type="text/css">
.policy
{
	overflow:auto;
	padding: 0.5cm 1cm;
	text-align:justify;
}

</style>

<!-- InstanceEndEditable -->
</head>

<body>

<table align="center" class="noborder"><tr><td>
<div id="main">
	<div id="banner" align="center">
		<table align="center" width="100%">
			<tr>
				<td align="left">
					<c:choose>
						<c:when test="${flag == 7}">
							<a href="main.jsp"><img style="border:none; text-decoration:none" src="images/buildtrees_logo2.png"></a>
						</c:when>
						<c:otherwise>
							<a href="index.jsp"><img style="border:none; text-decoration:none" src="images/buildtrees_logo2.png"></a>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
				</td>
			</tr>
		</table>
	</div>
	<!--
	<div id="menu">
	</div>
	-->
	<div id="content">
		<table align="center" width="100%"><tr>
			<td valign="top" align="left">
				<div id="vmenu">
					<table class="noborder" align="center">
						<c:if test="${flag == null}">
						<c:choose>
							<c:when test="${(fn:endsWith(theURI, 'index.jsp')) || (fn:endsWith(theURI, 'Linked/'))}">
								<tr><td><li> > ${languageBean.home}</li></td></tr>
							</c:when>
							<c:otherwise>
								<tr><td><li> <a href="index.jsp">${languageBean.home}</a></li></td></tr>
							</c:otherwise>
						</c:choose>
						</c:if>
						<c:if test="${flag == 7}">
							<tr><td>
								<p style="text-align:center; color:green; font-style:italic; padding:5px 0 5px 0">
									"${myname}"
									<br>
									You're logged in
								</p>
							</td></tr>
						</c:if>
						<c:if test="${flag == null}">
						<c:choose>
							<c:when test="${fn:endsWith(theURI, 'contactus.jsp')}">
								<tr><td><li> > ${languageBean.contactUs}</li></td></tr>
							</c:when>
							<c:otherwise>
								<tr><td><li> <a href="contactus.jsp">${languageBean.contactUs}</a></li></td></tr>
							</c:otherwise>
						</c:choose>
						</c:if>
						<c:if test="${flag != 7}">
							<c:if test="${fn:endsWith(theURI, 'signup.jsp')}">
								<tr><td><li> > ${languageBean.signup}</li></td></tr>
							</c:if>
						</c:if>
						<c:if test="${flag == 7}">
							<tr><td><li> <a href="control/logout.jsp">Logout</a></li></td></tr>
							<tr><td align="center" style="color:green">
								<br>
								need help? email us at
								<br>
								<a href="mailto:buildtrees@realbasis.com">buildtrees@realbasis.com</a>
								<br>
								<br>
							</td></tr>
						</c:if>
					</table>
					
					<c:if test="${fn:endsWith(theURI, 'signup.jsp') == false && fn:endsWith(theURI, 'forgotPassword.jsp') == false}">
						<c:if test="${flag != 7}">
						<table class="noborder" align="center" style="margin-top:20px;">
							<form action="control/authenticate.jsp" name="loginForm" method="post">
								<tr><td align="center"><div class="style1">${fn:escapeXml(param.errors)}</div></td></tr>
								<tr><td align="center"  style="color:green"> ${languageBean.email}</td></tr>
								<tr><td align="center"> <input type="text" name="email" size="20" value="${param.email}"></td></tr>
								<tr><td align="center"  style="color:green">  ${languageBean.password}</td></tr>
								<tr><td align="center"> <input type="password" name="password" size="20" value="${paswd}"></td></tr>
								<tr><td align="center">
									<input type="submit" name="login" value="${languageBean.login}" onClick="loginForm.login.value='Login...'" style="margin-top:10px; margin-bottom:10px">
								</td></tr>
								<tr><td align="center"> <a href="forgotPassword.jsp">${languageBean.forgotPassword}</a></td></tr>
								<input type="hidden" name="goodBrowser" value="true">
							</form>
						<c:choose>
							<c:when test="${fn:endsWith(theURI, 'signup.jsp')}">
								<tr><td align="center">${languageBean.signup}</td></tr>
							</c:when>
							<c:otherwise>
								<tr><td align="center"><a href="signup.jsp">${languageBean.signup}</a></td></tr>
							</c:otherwise>
						</c:choose>
						</table>
						</c:if>
					</c:if>
						<table class="noborder" align="center" style="margin-top:20px;">
							<tr><td align="center">
								<form action="https://www.paypal.com/cgi-bin/webscr" method="post">
									<input type="hidden" name="cmd" value="_s-xclick">
									<input type="hidden" name="hosted_button_id" value="4323081">
									<input type="image" src="https://www.paypal.com/en_US/i/btn/btn_donateCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
									<img alt="" border="0" src="https://www.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
								</form>
							</td></tr>
						</table>
				</div>
			</td>
			<td valign="top" align="center">
				<div id="crt">
			  <!-- InstanceBeginEditable name="EditRegion3" -->
 	<div class="policy">
	<p><strong>PRIVACY POLICY</strong></p>
	
	<p>Real Basis, LLC has created this privacy statement ("Statement") in order to demonstrate our 
	commitment to customer privacy. Privacy on the Real Basis web site (the "Site") is of great 
	importance to us. Because we gather important information from our customers, we have established 
	this Statement as a means to communicate our information gathering and dissemination practices. 
	We reserve the right to change this Privacy Policy. If we change it, we will provide notification 
	of the change at least thirty (30) business days before the change takes effect and include 
	directions for how you can respond to the change.</p>
	
	<p><strong>Collected Information</strong></p>
	<p>We require customers who register to use the services ("Services") offered on our Site to give 
	us contact information, such as their name, company name, address, phone number, and e-mail address,
	and financial qualification and billing information, such as billing name and address, credit card 
	number, and the number of users within the organization that will be using the Services. At the 
	time you express interest in attaining additional information, or when you register for the service,
	we may also ask for additional personal information, such as title, department name, fax number, 
	or additional company information. Customers can opt out of providing this additional information 
	by not entering it when asked. Customers can view their updated profile to confirm their edits have
	been made.</p>
	
	<p>Real Basis, LLC uses the information that we collect to set up Services for individuals and their organizations. We may also use the information to contact customers to further discuss customer interest in our company, the Services that we provide, and to send information regarding our company or partners, such as promotions and events. Customers are invited to receive an email newsletter by providing an email address. Customer email addresses and any personal customer information will not be distributed or shared with any third parties. Customers can opt out of being contacted by us, or receiving such information from us, at any time by sending an email to support@realbasis.com. Separately, customers are also asked to provide an email address when registering for the Service, in order to receive a username and password. We may also email information regarding updates to the Service or company, and will send a Customer Newsletter. Again, email will not be distributed or shared and customers can opt out of receiving any communication by emailing support@realbasis.com at the time it is distributed, or at the time any customer registers for the Service.
	</p>
	
	<p>Except as we explicitly state at the time we request information, or as provided for in the Real Basis Master Subscription Agreement, we do not disclose to any third-party the information provided. All financial and billing information that we collect through the Site is used solely to check the qualifications of prospective customers and to bill for Services. This billing information is not used by Real Basis, LLC for marketing or promotional purposes. Real Basis, LLC uses a third-party intermediary to manage the credit card processing. This intermediary is solely a link in the distribution chain, and is not permitted to store, retain, or use the information provided, except for the sole purpose of credit card processing. Other third parties, such as content providers, may provide content on the web Site but they are not permitted to collect any information nor does Real Basis, LLC share any user information with these parties.
</p>

	<p>Customers of the Service will be using the Site to host data and information ("Data"). Real Basis, LLC will not review, share, distribute, print, or reference any such Data except as provided in the Real Basis Master Subscription Agreement, or as may be required by law. Individual records may at times be viewed or accessed only for the purpose of resolving a problem, support issue, or suspected violation of the Master Subscription Agreement, or as may be required by law. Of course, customers are responsible for maintaining the confidentiality and security of their user registration and password.
</p>

	<p>Real Basis, LLC may also collect certain information from visitors and customers of the Site, such as Internet addresses. This information is logged in order to help diagnose technical problems, and to administer our Site in order to constantly improve the quality of the Service. We may also track and analyze non-identifying and aggregate usage and volume statistical information from our visitors and customers and provide such information to third parties.
</p>

	<p><strong>Cookies:</strong></p>
	<p>When you interact with the Real Basis Website we strive to make that experience easy and meaningful. When you come to our Web site, our Web server sends a cookie to your computer. Cookies are files that Web browsers place on a computer's hard drive and are used to tell us whether customers and visitors have visited the Site previously.</p>
	<p>Standing alone, cookies do not identify you personally. They merely recognize your browser. Unless you choose to identify yourself to Real Basis, LLC, either by responding to a promotional offer, opening an account, or registering for a 30-day Test Drive, you remain anonymous to Real Basis, LLC. Cookies come in two flavors: session and persistent-based. Session cookies exist only during an online session. They disappear from your computer when you close your browser window or turn off your computer. Persistent cookies remain on your computer after you've closed your browser or turned off your computer. They include such information as a unique identifier for your browser.</p>
	<p>Real Basis, LLC uses session cookies containing encrypted information to allow the system to uniquely identify you while you are logged in. This information allows Real Basis, LLC to process your online transactions and requests. Session cookies help us make sure you are who you say you are after you've logged in and are required in order to use the Real Basis application. Real Basis, LLC uses persistent cookies that only the company can read and use, to identify the fact that you are a Real Basis customer or prior Website visitor (whatever the case may be). We are especially careful about the security and confidentiality of the information stored in persistent cookies. For example, we do not store account numbers or passwords in persistent cookies. Users who disable their Web browsers' ability to accept cookies will be able to browse our Website but will not be able to successfully use our service.

</p>
	<p><strong>Third Party Sites:</strong></p>
	<p>The Site contains links to other web sites. Real Basis, LLC is not responsible for the privacy practices or the content of these other web sites. Customers and visitors will need to check the policy statement of these other web sites to understand their policies. Customers and visitors who access a linked site may be disclosing their private information. It is the responsibility of the user to keep such information private and confidential.
</p>
	<p><strong>Security:</strong></p>
	<p>Our Site has security measures in place to help protect against the loss, misuse, and alteration of the Data under our control. When our Site is accessed using Netscape Navigator, or Microsoft Internet Explorer versions 5.5 or higher, Secure Socket Layer (SSL) technology protects information using both server authentication and data encryption to help ensure that Data is safe, secure, and available only to you. Real Basis, LLC also implements an advanced security method based on dynamic data and encoded session identifications, and hosts the Site in a secure server environment that uses a firewall and other advanced technology to prevent interference or access from outside intruders. Finally, Real Basis, LLC provides unique user names and passwords that must be entered each time a customer logs on. These safeguards help prevent unauthorized access, maintain data accuracy, and ensure the appropriate use of Data.</p>
	<p><strong>Opt-Out Policy:</strong></p>
	<p>Real Basis, LLC offers its visitors and customers a means to choose how we may use information provided. If, at any time after registering for information or ordering Services, you change your mind about receiving information from us or about sharing your information with third parties, send us a request specifying your new choice. Simply send your request to <a href="mailto:support@realbasis.com">support@realbasis.com.</a></p>
	<p><strong>Correcting and Updating Your Information</strong></p>
	<p>To update billing information or to discontinue the Service and have data returned, please email: 
	<a href="mailto:support@realbasis.com">support@realbasis.com</a> or call (321) 206-0323.
</p>
	<p><strong>Additional Information:</strong></p>
	<p>Questions regarding this Statement or the practices of this Site should be directed to Real Basis's Administrator by e-mailing such questions to:
	<a href="mailto:support@realbasis.com">support@realbasis.com</a></p>
	<p>Legal All contents Copyright 2005 RealBasis LLC. All rights reserved. Privacy Policy.</p>
	</div>
			  <!-- InstanceEndEditable -->
			  	</div>
			 </td>
			<td valign="top" align="right">
				<div id="rvmenu">
					<c:if test="${flag == null}">
					</c:if>
				</div>
			</td>
		</tr></table>
	</div>
	<div id="footnotes">
		<p style="font-size:10px">Powered by Real Basis LLC - Copyright 2003-2010.  <a href="policy.jsp">Privacy Policy</a>.</p>
	</div>
</div>
</td></tr></table>

<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-544679-2";
urchinTracker();
</script>

</body>
<!-- InstanceEnd --></html>
