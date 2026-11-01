<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<html>
<head>
    <title></title>
    <%@include file="/control/stdTags.jspf" %>
</head>
<body>

<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>


    <table>
        <tr><td colspan='2' style="color:red">${param.errors}</td>
        <tr>
        <form action='control/doLoginOwner.jsp' method="post">
            <td><input type="password" name='password'></td>
            <td><input type="submit" value='login'></td>
            <input type="hidden" name='flag' value='7'>
        </form>
        <form action='index.jsp' method="post">
            <td><input type="submit" value='home'></td>
        </form>
        </tr>
    </table>
    

</body>
</html>
