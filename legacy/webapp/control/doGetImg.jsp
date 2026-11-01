<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="stdTags.jspf" %>

<%@ taglib uri="/WEB-INF/taglib48.tld" prefix="sqlx" %>
 
<jsp:useBean id="connBean" class="value.ConnBean" />

<sqlx:openConnection driver="com.mysql.jdbc.Driver" id="A" url="${connBean.url}" user="${connBean.user}" password="${connBean.passwd}"/>

<sqlx:setBlobQuery id="A" query="select Image from Zpeople where PeopleId=?" contentType="image/jpeg">
    <sqlx:setParameter position="1" type="int">${param.id}</sqlx:setParameter>
</sqlx:setBlobQuery>
    
<sqlx:closeConnection id="A" />
