<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<sql:setDataSource var="ds" dataSource="jdbc/choose4me" />

<sql:query dataSource="${ds}" sql="select * from items " var="results" />


<c:forEach var="user" items="${results.rows}" varStatus="row">
    <c:if test="${user.id == voteid}">
        
        <sql:update dataSource="${ds}" sql="update items set points=? where items.id=?">
				<sql:param>${user.points+1}</sql:param>
				<sql:param>${voteid}</sql:param>
	</sql:update>
        <sql:update dataSource="${ds}" var="user4" > 
        INSERT INTO questions (user,item1,userid) VALUES (?,?,?)
        <sql:param>${facebook.pictureURL}</sql:param>
	<sql:param>${user.user}</sql:param>
        <sql:param>${user.title}</sql:param>
        </sql:update>
<html>
<head>       
 <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/pics/favicon.ico">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thanks!</title>
      
    </head>
    <style type="text/css">

</style>
    <body>
       <%
   String site = new String("http://thanosgk.me:8080/Choose4me_new/");
   response.setStatus(response.SC_MOVED_TEMPORARILY);
   response.setHeader("Location", site); 
%>
    </body>
</html>

</c:if>
</c:forEach>