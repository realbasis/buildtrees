<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="control/stdTags.jspf" %>

<jsp:useBean id="spamBean" class="utility.SpamBean" />

				<div align="center" style="width:436px;">
					<form action="control/doSignup.jsp" method="post" name="signupForm">
		                <table class="noborder">
						  <tr>
                		    <th colspan="2"><div align="left">Create your account and build your family tree!</div></th>
		                  </tr>
						  <tr>
                		    <td colspan="2">
								<div align="center" class="style1">${fn:escapeXml(param.errors)}</div>
							</td>
		                  </tr>
						  <tr align="left">
                		    <td>Votre Nom<span class="style1">*</span>::</td>
		                    <td><input type="text" name="name" value="${param.name}"></td>
        		          </tr>
						  <!--
        		          <tr align="left">
                		    <td>First Name<span class="style1">*</span>::</td>
		                    <td><input type="text" name="firstName" value="${param.firstName}"></td>
        		          </tr>
						  <tr align="left">
                		    <td>Last Name<span class="style1">*</span>::</td>
		                    <td><input type="text" name="lastName" value="${param.lastName}"></td>
        		          </tr>
						  -->
                		  <tr align="left">
		                    <td>Votre Email<span class="style1">*</span>::</td>
        		            <td><input type="text" name="email" value="${param.email}"></td>
                		  </tr>
						  <tr align="left">
		                    <td>Votre Genre<span class="style1">*</span>::</td>
        		            <td>
								<select name="gender">
									<option>SELECT</option>
									<c:if test="${param.gender == 'Male'}">
										<option selected="selected" value="Male">Homme</option>
									</c:if>
									<c:if test="${param.gender != 'Male'}">
										<option value="Male">Homme</option>
									</c:if>
									<c:if test="${param.gender == 'Female'}">
										<option selected="selected" value="Female">Femme</option>
									</c:if>
									<c:if test="${param.gender != 'Female'}">
										<option value="Female">Femme</option>
									</c:if>
								</select>
							</td>
                		  </tr>
						  <!--
						  <tr align="left">
        		            <td>Password hint<span class="style1">*</span>::</td>
                		    <td><input name="petName" type="text" value="${param.petName}"></td>
		                  </tr>
						  <tr align="left">
		                    <td>Username (at least 6 chars)<span class="style1">*</span>::</td>
        		            <td><input type="text" name="user" value="${param.user}"></td>
                		  </tr>
						  -->
						  <tr align="left">
		                    <td>Mot de passe (min 6 lettres)<span class="style1">*</span>::</td>
        		            <td><input type="password" name="pass1" value="${param.pass1}"></td>
                		  </tr>
						  <tr align="left">
		                    <td>Confirmer mot de passe<span class="style1">*</span>::</td>
        		            <td><input type="password" name="pass2" value="${param.pass2}"></td>
                		  </tr>
						  <tr>
		                    <th align="right">
								<span style="color:red">code anti-spam:</span>  ${spamBean.spam1} + ${spamBean.spam2} = 
								<input type="hidden" name="spam1" value="${spamBean.spam1}">
								<input type="hidden" name="spam2" value="${spamBean.spam2}">
							</th>
        		            <td align="left">
								<input type="text" name="spam" size="2" maxlength="2">
							</td>
                		  </tr>
						  <tr align="center">
						  	<td></td>
                		    <td align="center"><input type="submit" name="signupB" value="Créer votre compte" onClick="signupForm.signupB.value='Processing...'"></td>
		                  </tr>
						  <input type="hidden" name="petName" value="12345678">
						  <!--
						  <tr>
                		    <td colspan="2" style="color:green">
								<p>
									Examples of PASSWORD HINTS:
									<ul>
										<li>Mother's maiden name</li>
										<li>Your favorite pet's name</li>
										<li>City where you were born</li>
									</ul>
								</p>
							</td>
		                  </tr>
						  -->
<!--
						  <tr>
                		    <th colspan="2"><div align="left">Terms of Service</div></th>
		                  </tr>
						  <tr>
                		    <td colspan="2"><div align="center" class="style2">Please, review the following terms</div></td>
		                  </tr>
						  <tr>
							<td colspan="2"><div align="left">
			                  <textarea cols="50" rows="12" wrap="physical" readonly title="Real Basis, LLC Terms of Service">
1. ACCEPTANCE OF TERMS 
Real Basis, LLC provides its service to you, subject to the following Terms of Service ("TOS"), which may be updated by us from time to time without notice to you. All guidelines or rules (including but not limited to our Spam Policy) are hereby incorporated by reference into the TOS.

2. DESCRIPTION OF SERVICE
Real Basis, LLC provides users with access to a rich collection of resources, including, various communications tools, forums, shopping services, search services, personalized content and branded programming through its network of properties which may be accessed through any various medium or device now known or hereafter known or developed (the "Service). You also understand and agree that the Service may include advertisements and that these advertisements are necessary for Real Basis, LLC to provide the Service. You also understand and agree that the Service may include certain communications from Real Basis, LLC, such as service announcements, administrative messages and newsletter, and that these communications are considered part of Real Basis, LLC membership and you will not be able to opt out of receiving them. Unless explicitly stated otherwise, any new features that augment or enhance the current Service, including the release of new Real Basis, LLC properties, shall be subject to the TOS. You understand and agree that the Service is provided "AS-IS" and that Real Basis, LLC assumes no responsibility for the timeliness, deletion, mis-delivery or failure to store any user communications or personalization settings. You are responsible for obtaining access to the Service and that access may involve third party fees (such as Internet service provider or airtime charges). You are responsible for those fees, including those fees associated with the display or delivery of advertisements. In addition, you must provide and are responsible for all equipment necessary to access the Service.

3. YOUR REGISTRATION OBLIGATIONS 
In consideration of your use of the Service, you represent that you are of legal age to form a binding contract and are not a person barred from receiving services under the laws of the United States or other applicable jurisdiction. You also agree to: (a) provide true, accurate, current and complete information about yourself as prompted by the Service's registration form (such information being the "Registration Data") and (b) maintain and promptly update the Registration Data to keep it true, accurate, current and complete. If you provide any information that is untrue, inaccurate, not current or incomplete, or Real BAsis, LLC has reasonable grounds to suspect that such information is untrue, inaccurate, not current or incomplete, Real Basis, LLC has the right to suspend or terminate your account and refuse any and all current or future use of the Service (or any portion thereof). Real Basis, LLC is concerned about the safety and privacy of all its users.

4. REAL BASIS, LLC PRIVACY POLICY 
Registration Data and certain other information about you is subject to our Privacy Policy. For more information, see our full privacy policy at http://www.realbasis.com/privacy.html.  You understand that through your use of the Service you consent to the collection and use (as set forth in the Privacy Policy) of this information, including the transfer of this information to the United States and/or other countries for storage, processing and use by Real Basis, LLC and its affiliates.

5. MEMBER ACCOUNT, PASSWORD AND SECURITY 
You will receive a password and account designation upon completing the Service's registration process. You are responsible for maintaining the confidentiality of the password and account, and are fully responsible for all activities that occur under your password or account. You agree to (a) immediately notify Real Basis, LLC of any unauthorized use of your password or account or any other breach of security, and (b) ensure that you exit from your account at the end of each session. Real Basis, LLC cannot and will not be liable for any loss or damage arising from your failure to comply with this Section 5.

6. MEMBER CONDUCT 
You understand that all information, data, text, software, music, sound, photographs, graphics, video, messages or other materials ("Content"), whether publicly posted or privately transmitted, are the sole responsibility of the person from which such Content originated. This means that you, and not Real Basis, LLC, are entirely responsible for all Content that you upload, post, email, transmit or otherwise make available via the Service. Real Basis, LLC does not control the Content posted via the Service and, as such, does not guarantee the accuracy, integrity or quality of such Content. You understand that by using the Service, you may be exposed to Content that is offensive, indecent or objectionable. Under no circumstances will Real Basis, LLC be liable in any way for any Content, including, but not limited to, for any errors or omissions in any Content, or for any loss or damage of any kind incurred as a result of the use of any Content posted, emailed, transmitted or otherwise made available via the Service.
You agree to not use the Service to:
a.	upload, post, email, transmit or otherwise make available any Content that is unlawful, harmful, threatening, abusive, harassing, tortious, defamatory, vulgar, obscene, libelous, invasive of another's privacy, hateful, or racially, ethnically or otherwise objectionable;
b.	harm minors in any way;
c.	impersonate any person or entity, including, but not limited to, a Real Basis, LLC official, forum leader, guide or host, or falsely state or otherwise misrepresent your affiliation with a person or entity;
d.	forge headers or otherwise manipulate identifiers in order to disguise the origin of any Content transmitted through the Service;
e.	upload, post, email, transmit or otherwise make available any Content that you do not have a right to make available under any law or under contractual or fiduciary relationships (such as inside information, proprietary and confidential information learned or disclosed as part of employment relationships or under nondisclosure agreements);
f.	upload, post, email, transmit or otherwise make available any Content that infringes any patent, trademark, trade secret, copyright or other proprietary rights ("Rights") of any party;
g.	upload, post, email, transmit or otherwise make available any unsolicited or unauthorized advertising, promotional materials, "junk mail," "spam," "chain letters," "pyramid schemes," or any other form of solicitation, except in those areas (such as shopping rooms) that are designated for such purpose (please read our complete Spam Policy);
h.	upload, post, email, transmit or otherwise make available any material that contains software viruses or any other computer code, files or programs designed to interrupt, destroy or limit the functionality of any computer software or hardware or telecommunications equipment;
i.	disrupt the normal flow of dialogue, cause a screen to "scroll" faster than other users of the Service are able to type, or otherwise act in a manner that negatively affects other users' ability to engage in real time exchanges;
j.	interfere with or disrupt the Service or servers or networks connected to the Service, or disobey any requirements, procedures, policies or regulations of networks connected to the Service;
k.	intentionally or unintentionally violate any applicable local, state, national or international law, including, but not limited to, regulations promulgated by the U.S. Securities and Exchange Commission, any rules of any national or other securities exchange, including, without limitation, the New York Stock Exchange, the American Stock Exchange or the NASDAQ, and any regulations having the force of law;
l.	provide material support or resources (or to conceal or disguise the nature, location, source, or ownership of material support or resources) to any organization(s) designated by the United States government as a foreign terrorist organization pursuant to section 219 of the Immigration and Nationality Act;
m.	"stalk" or otherwise harass another; and/or
n.	collect or store personal data about other users in connection with the prohibited conduct and activities set forth in paragraphs a through n above.
You acknowledge that Real Basis, LLC may or may not pre-screen Content, but that Real Basis, LLC and its designees shall have the right (but not the obligation) in their sole discretion to pre-screen, refuse, or move any Content that is available via the Service. Without limiting the foregoing, Real Basis, LLC and its designees shall have the right to remove any Content that violates the TOS or is otherwise objectionable. You agree that you must evaluate, and bear all risks associated with, the use of any Content, including any reliance on the accuracy, completeness, or usefulness of such Content. In this regard, you acknowledge that you may not rely on any Content created by Real Basis, LLC or submitted to Real Basis, LLC, including without limitation information in Real Basis, LLC Message Boards, and in all other parts of the Service.
You acknowledge, consent and agree that Real Basis, LLC may access, preserve, and disclose your account information and Content if required to do so by law or in a good faith belief that such access preservation or disclosure is reasonably necessary to: (a) comply with legal process; (b) enforce the TOS; (c) respond to claims that any Content violates the rights of third-parties; (d) respond to your requests for customer service; or (e) protect the rights, property, or personal safety of Real Basis, LLC, its users and the public.
You understand that the technical processing and transmission of the Service, including your Content, may involve (a) transmissions over various networks; and (b) changes to conform and adapt to technical requirements of connecting networks or devices.
You understand that the Service and software embodied within the Service may include security components that permit digital materials to be protected, and use of these materials is subject to usage rules set by Real Basis, LLC and/or content providers who provide content to the Service. You may not attempt to override or circumvent any of the usage rules embedded into the Service. Any unauthorized reproduction, publication, further distribution or public exhibition of the materials provided on the Service, in whole or in part, is strictly prohibited.

7. SPECIAL ADMONITIONS FOR INTERNATIONAL USE 
Recognizing the global nature of the Internet, you agree to comply with all local rules regarding online conduct and acceptable Content. Specifically, you agree to comply with all applicable laws regarding the transmission of technical data exported from the United States or the country in which you reside.

8. CONTENT SUBMITTED OR MADE AVAILABLE FOR INCLUSION ON THE SERVICE
Real Basis, LLC does not claim ownership of Content you submit or make available for inclusion on the Service. However, with respect to Content you submit or make available for inclusion on publicly accessible areas of the Service, you grant Real Basis, LLC the following world-wide, royalty free and non-exclusive license(s), as applicable:
"	With respect to Content you submit or make available for inclusion on publicly accessible areas, the license to use, distribute, reproduce, modify, adapt, publicly perform and publicly display such Content on the Service solely for the purpose for which such Content was submitted or made available. This license exists only for as long as you elect to continue to include such Content on the Service and will terminate at the time you remove or Real Basis, LLC removes such Content from the Service.
"	With respect to photos, graphics, audio or video you submit or make available for inclusion on publicly accessible area of the Service, the license to use, distribute, reproduce, modify, adapt, publicly perform and publicly display such Content on the Service solely for the purpose for which such Content was submitted or made available. This license exists only for as long as you elect to continue to include such Content on the Service and will terminate at the time you remove or Real Basis, LLC removes such Content from the Service.
"	With respect to Content other than photos, graphics, audio or video you submit or make available for inclusion on publicly accessible areas of the Service, the perpetual, irrevocable and fully sublicensable license to use, distribute, reproduce, modify, adapt, publish, translate, publicly perform and publicly display such Content (in whole or in part) and to incorporate such Content into other works in any format or medium now known or later developed.
"Publicly accessible" areas of the Service are those areas of the Real Basis network of properties that are intended by Real Basis, LLC to be available to the general public.

9. INDEMNITY 
You agree to indemnify and hold Real Basis, LLC, and its subsidiaries, affiliates, officers, agents, co-branders or other partners, and employees, harmless from any claim or demand, including reasonable attorneys' fees, made by any third party due to or arising out of Content you submit, post, transmit or make available through the Service, your use of the Service, your connection to the Service, your violation of the TOS, or your violation of any rights of another.

10. NO RESALE OF SERVICE 
You agree not to reproduce, duplicate, copy, sell, trade, resell or exploit for any commercial purposes, any portion of the Service, use of the Service, or access to the Service.

11. GENERAL PRACTICES REGARDING USE AND STORAGE 
You acknowledge that Real Basis, LLC may establish general practices and limits concerning use of the Service, including without limitation the maximum number of days that email messages, message board postings or other uploaded Content will be retained by the Service, the maximum number of email messages that may be sent from or received by an account on the Service, the maximum size of any email message that may be sent from or received by an account on the Service, the maximum disk space that will be allotted on Real Basis, LLC servers on your behalf, and the maximum number of times (and the maximum duration for which) you may access the Service in a given period of time. You agree that Real Basis, LLChas no responsibility or liability for the deletion or failure to store any messages and other communications or other Content maintained or transmitted by the Service. You acknowledge that Real Basis, LLC reserves the right to log off accounts that are inactive for an extended period of time. You further acknowledge that Real Basis, LLC reserves the right to modify these general practices and limits from time to time.

12. MODIFICATIONS TO SERVICE 
Real Basis, LLC reserves the right at any time and from time to time to modify or discontinue, temporarily or permanently, the Service (or any part thereof) with or without notice. You agree that Real Basis, LLC shall not be liable to you or to any third party for any modification, suspension or discontinuance of the Service.

13. TERMINATION 
You agree that Real Basis, LLC may, under certain circumstances and without prior notice, immediately terminate your Real Basis, LLC account, any associated email address, and access to the Service. Cause for such termination shall include, but not be limited to, (a) breaches or violations of the TOS or other incorporated agreements or guidelines, (b) requests by law enforcement or other government agencies, (c) a request by you (self-initiated account deletions), (d) discontinuance or material modification to the Service (or any part thereof), (e) unexpected technical or security issues or problems, (f) extended periods of inactivity, (g) you have engaged in fraudulent or illegal activities, and/or (h) nonpayment of any fees owed by you in connection with the Services.  Termination of your Real Basis, LLC account includes (a) removal of access to all offerings within the Service, (b) deletion of your password and all related information, files and content associated with or inside your account (or any part thereof), and (c) barring further use of the Service. Further, you agree that all terminations for cause shall be made in Real Basis, LLC's sole discretion and that Real Basis, LLC shall not be liable to you or any third-party for any termination of your account, any associated email address, or access to the Service.

14. DEALINGS WITH ADVERTISERS 
Your correspondence or business dealings with, or participation in promotions of, advertisers found on or through the Service, including payment and delivery of related goods or services, and any other terms, conditions, warranties or representations associated with such dealings, are solely between you and such advertiser. You agree that Real Basis, LLC shall not be responsible or liable for any loss or damage of any sort incurred as the result of any such dealings or as the result of the presence of such advertisers on the Service.

15. LINKS 
The Service may provide, or third parties may provide, links to other World Wide Web sites or resources. Because Real Basis, LLC has no control over such sites and resources, you acknowledge and agree that Real Basis, LLC is not responsible for the availability of such external sites or resources, and does not endorse and is not responsible or liable for any Content, advertising, products, or other materials on or available from such sites or resources. You further acknowledge and agree that Real Basis, LLC shall not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with use of or reliance on any such Content, goods or services available on or through any such site or resource.

16. REAL BASIS LLC'S PROPRIETARY RIGHTS 
You acknowledge and agree that the Service and any necessary software used in connection with the Service ("Software") contain proprietary and confidential information that is protected by applicable intellectual property and other laws. You further acknowledge and agree that Content contained in sponsor advertisements or information presented to you through the Service or advertisers is protected by copyrights, trademarks, service marks, patents or other proprietary rights and laws. Except as expressly authorized by Real Basis, LLC or advertisers, you agree not to modify, rent, lease, loan, sell, distribute or create derivative works based on the Service or the Software, in whole or in part.
Real Basis, LLC grants you a personal, non-transferable and non-exclusive right and license to use the object code of its Software on a single computer; provided that you do not (and do not allow any third party to) copy, modify, create a derivative work of, reverse engineer, reverse assemble or otherwise attempt to discover any source code, sell, assign, sublicense, grant a security interest in or otherwise transfer any right in the Software. You agree not to modify the Software in any manner or form, or to use modified versions of the Software, including (without limitation) for the purpose of obtaining unauthorized access to the Service. You agree not to access the Service by any means other than through the interface that is provided by Real Basis, LLC for use in accessing the Service.

17. DISCLAIMER OF WARRANTIES 
YOU EXPRESSLY UNDERSTAND AND AGREE THAT: 
a.	YOUR USE OF THE SERVICE IS AT YOUR SOLE RISK. THE SERVICE IS PROVIDED ON AN "AS IS" AND "AS AVAILABLE" BASIS. REAL BASIS LLC EXPRESSLY DISCLAIMS ALL WARRANTIES OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.
b.	REAL BASIS, LLC MAKES NO WARRANTY THAT (i) THE SERVICE WILL MEET YOUR REQUIREMENTS, (ii) THE SERVICE WILL BE UNINTERRUPTED, TIMELY, SECURE, OR ERROR-FREE, (iii) THE RESULTS THAT MAY BE OBTAINED FROM THE USE OF THE SERVICE WILL BE ACCURATE OR RELIABLE, (iv) THE QUALITY OF ANY PRODUCTS, SERVICES, INFORMATION, OR OTHER MATERIAL PURCHASED OR OBTAINED BY YOU THROUGH THE SERVICE WILL MEET YOUR EXPECTATIONS, AND (V) ANY ERRORS IN THE SOFTWARE WILL BE CORRECTED.
c.	ANY MATERIAL DOWNLOADED OR OTHERWISE OBTAINED THROUGH THE USE OF THE SERVICE IS DONE AT YOUR OWN DISCRETION AND RISK AND THAT YOU WILL BE SOLELY RESPONSIBLE FOR ANY DAMAGE TO YOUR COMPUTER SYSTEM OR LOSS OF DATA THAT RESULTS FROM THE DOWNLOAD OF ANY SUCH MATERIAL.
d.	NO ADVICE OR INFORMATION, WHETHER ORAL OR WRITTEN, OBTAINED BY YOU FROM REAL BASIS, LLC OR THROUGH OR FROM THE SERVICE SHALL CREATE ANY WARRANTY NOT EXPRESSLY STATED IN THE TOS.
e.	A SMALL PERCENTAGE OF USERS MAY EXPERIENCE EPILEPTIC SEIZURES WHEN EXPOSED TO CERTAIN LIGHT PATTERNS OR BACKGROUNDS ON A COMPUTER SCREEN OR WHILE USING THE SERVICE. CERTAIN CONDITIONS MAY INDUCE PREVIOUSLY UNDETECTED EPILEPTIC SYMPTOMS EVEN IN USERS WHO HAVE NO HISTORY OF PRIOR SEIZURES OR EPILEPSY. IF YOU, OR ANYONE IN YOUR FAMILY, HAVE AN EPILEPTIC CONDITION, CONSULT YOUR PHYSICIAN PRIOR TO USING THE SERVICE. IMMEDIATELY DISCONTINUE USE OF THE SERVICE AND CONSULT YOUR PHYSICIAN IF YOU EXPERIENCE ANY OF THE FOLLOWING SYMPTOMS WHILE USING THE SERVICE -- DIZZINESS, ALTERED VISION, EYE OR MUSCLE TWITCHES, LOSS OF AWARENESS, DISORIENTATION, ANY INVOLUNTARY MOVEMENT, OR CONVULSIONS.

18. LIMITATION OF LIABILITY 
YOU EXPRESSLY UNDERSTAND AND AGREE THAT REAL BASIS SHALL NOT BE LIABLE TO YOU FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL OR EXEMPLARY DAMAGES, INCLUDING BUT NOT LIMITED TO, DAMAGES FOR LOSS OF PROFITS, GOODWILL, USE, DATA OR OTHER INTANGIBLE LOSSES (EVEN IF REAL BASIS, LLC HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES), RESULTING FROM: (i) THE USE OR THE INABILITY TO USE THE SERVICE; (ii) THE COST OF PROCUREMENT OF SUBSTITUTE GOODS AND SERVICES RESULTING FROM ANY GOODS, DATA, INFORMATION OR SERVICES PURCHASED OR OBTAINED OR MESSAGES RECEIVED OR TRANSACTIONS ENTERED INTO THROUGH OR FROM THE SERVICE; (iii) UNAUTHORIZED ACCESS TO OR ALTERATION OF YOUR TRANSMISSIONS OR DATA; (iv) STATEMENTS OR CONDUCT OF ANY THIRD PARTY ON THE SERVICE; OR (v) ANY OTHER MATTER RELATING TO THE SERVICE.

19. EXCLUSIONS AND LIMITATIONS 
SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OF CERTAIN WARRANTIES OR THE LIMITATION OR EXCLUSION OF LIABILITY FOR INCIDENTAL OR CONSEQUENTIAL DAMAGES. ACCORDINGLY, SOME OF THE ABOVE LIMITATIONS OF SECTIONS 17 AND 18 MAY NOT APPLY TO YOU.

20. SPECIAL ADMONITION FOR SERVICES RELATING TO FINANCIAL MATTERS 
If you intend to create or join any service, receive or request any news, messages, alerts or other information from the Service concerning companies, stock quotes, investments or securities, please read the above Sections 17 and 18 again. They go doubly for you. In addition, for this type of information particularly, the phrase "Let the investor beware" is apt. The Service is provided for informational purposes only, and no Content included in the Service is intended for trading or investing purposes. Real Basis, LLC and its licensors shall not be responsible or liable for the accuracy, usefulness or availability of any information transmitted or made available via the Service, and shall not be responsible or liable for any trading or investment decisions made based on such information.

21. NO THIRD PARTY BENEFICIARIES
You agree that, except as otherwise expressly provided in this TOS, there shall be no third party beneficiaries to this Agreement.

22. NOTICE 
Real Basis, LLC may provide you with notices, including those regarding changes to the TOS, by either email, regular mail, or postings on the Service.

23. TRADEMARK INFORMATION 
The Real Basis logo is a trademarks of Real Basis, LLC. Without Real Basis, LLC's prior permission, you agree not to display or use in any manner, the Real Basis, LLC logo.

24. NOTICE AND PROCEDURE FOR MAKING CLAIMS OF COPYRIGHT OR INTELLECTUAL PROPERTY INFRINGEMENT
Real Basis, LLC respects the intellectual property of others, and we ask our users to do the same. Real Basis, LLC may, in appropriate circumstances and at its discretion, disable and/or terminate the accounts of users who may be repeat infringers. If you believe that your work has been copied in a way that constitutes copyright infringement, or your intellectual property rights have been otherwise violated, please provide Real Basis, LLC's Copyright Agent the following information:
1.	an electronic or physical signature of the person authorized to act on behalf of the owner of the copyright or other intellectual property interest;
2.	a description of the copyrighted work or other intellectual property that you claim has been infringed;
3.	a description of where the material that you claim is infringing is located on the site;
4.	your address, telephone number, and email address;
5.	a statement by you that you have a good faith belief that the disputed use is not authorized by the copyright owner, its agent, or the law;
6.	a statement by you, made under penalty of perjury, that the above information in your Notice is accurate and that you are the copyright or intellectual property owner or authorized to act on the copyright or intellectual property owner's behalf.
Real Basis, LLC's Agent for Notice of claims of copyright or other intellectual property infringement can be reached as follows:
By mail:
Copyright Agent
c/o Real Basis, LLC.
12565 Research Parkway Suite 300 
Orlando, FL 32826
By phone: (321) 206-0323
By fax: (407)737-2512
By email: info@realbasis.com

25. GENERAL INFORMATION 
Entire Agreement. The TOS constitute the entire agreement between you and Real Basis, LLC and governs your use of the Service, superseding any prior agreements between you and Real Basis, LLC with respect to the Service. You also may be subject to additional terms and conditions that may apply when you use or purchase certain other Real Basis, LLC services, affiliate services, third-party content or third-party software.
Choice of Law and Forum. The TOS and the relationship between you and Real Basis, LLC shall be governed by the laws of the State of California without regard to its conflict of law provisions. You and Real Basis, LLC agree to submit to the personal and exclusive jurisdiction of the courts located within the county of Santa Clara, California.
Waiver and Severability of Terms. The failure of Real Basis, LLC to exercise or enforce any right or provision of the TOS shall not constitute a waiver of such right or provision. If any provision of the TOS is found by a court of competent jurisdiction to be invalid, the parties nevertheless agree that the court should endeavor to give effect to the parties' intentions as reflected in the provision, and the other provisions of the TOS remain in full force and effect.
No Right of Survivorship and Non-Transferability. You agree that your Real Basis, LLC account is non-transferable and any rights within your account terminate upon your death. Upon receipt of a copy of a death certificate, your account may be terminated and all contents therein permanently deleted.
Statute of Limitations. You agree that regardless of any statute or law to the contrary, any claim or cause of action arising out of or related to use of the Service or the TOS must be filed within one (1) year after such claim or cause of action arose or be forever barred.
The section titles in the TOS are for convenience only and have no legal or contractual effect.

26. VIOLATIONS
Please report any violations of the TOS to our Customer Care group.
								</textarea>
							</div></td>
		                  </tr>
-->
<!--
        		          <tr>
                		    <td colspan="2">
								<div align="center">
								<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
								  <tr>
								  	<td>
										<div align="center">
											<img src="PassImageServlet/<% /*=passlineValueEncoded */ %>" border="0">
										</div>
									</td>
									<td>
										<div>
											<p style="margin-left:4px">Security Code:: <input type="text" name="passline" size="9"></p>
										</div>
									</td>
								  </tr>
				                </table>
								</div>
								<div align="center" style="margin-top:10px">
								<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
								  <tr>
				                    <td colspan="2" align="center">
										<div align="center">
			        		              <input type="button" name="submitYes" value="Join Now" onClick="signupForm.submitYes.value='Signing up...';document.signupForm.submit()">
				                      	</div>
										<div align="center" style="color:green; margin:10px 0 10px 0; font-weight:bold">
											At BuildTrees, we value your privacy
										</div>
									</td>
				                  </tr>
				                </table>
								</div>
							</td>
        		          </tr>
						  <input type="hidden" name="passline_enc" value="<% /* =passlineValueEncoded */ %>">
-->						  
				      </table>
				  </form>
				</div>			  
