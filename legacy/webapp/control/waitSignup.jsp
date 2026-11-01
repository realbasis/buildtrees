<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="/WEB-INF/taglib144.tld" prefix="w" %>

<w:wait>
<w:infoPage>
<div style="margin:50px 0 0 50px;font-size:18px;color:blue">
    <p style='margin-top:25px'> Page is being loaded.  Please wait...</p>
</div>
</w:infoPage>

<w:realPage> 
  <jsp:include page="/control/doSignup.jsp"/> 
</w:realPage> 

</w:wait>