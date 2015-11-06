<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<sql:setDataSource var="ds" dataSource="jdbc/choose4me" />

<sql:query dataSource="${ds}" sql="select * from user " var="results" />
<c:forEach var="user" items="${results.rows}" varStatus="row">
    <c:if test="${user.facebook_id == facebook.id}">
        <c:set var="id" value="${user.id}"></c:set>
    </c:if>
</c:forEach>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/pics/favicon.ico">
    </head>
    <body>
        
        <c:if test="${list.size()<20}">
        <c:set var="epilogi" value="${selectionid}"></c:set>
        <sql:update dataSource="${ds}" var="user2" > 
        INSERT INTO items (title,photo,user) VALUES (?,?,?)
        <sql:param>${list[epilogi]}</sql:param>
	<sql:param>${list[epilogi+3]}</sql:param>
        <sql:param>${id}</sql:param>
        </sql:update>
        
        </c:if>
        
        <c:if test="${list.size()>20}">
        <c:set var="epilogi" value="${selectionid}"></c:set>
        <sql:update dataSource="${ds}" var="user2" > 
        INSERT INTO items (title,photo,user) VALUES (?,?,?)
        <sql:param>${list[epilogi]}</sql:param>
	<sql:param>${list[epilogi+15]}</sql:param>
        <sql:param>${id}</sql:param>
        </sql:update>
        </c:if>
        
        <%
        String site = new String("http://thanosgk.me:8080/Choose4me_new/");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site); 
        %>
    </body>
</html>
