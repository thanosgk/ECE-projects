<!DOCTYPE html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<sql:setDataSource var="ds" dataSource="jdbc/choose4me" />

<sql:query dataSource="${ds}" sql="select * from user " var="results2" />
<html lang="en">


    <head>
        <meta charset=utf-8>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Results</title>    
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/pics/favicon.ico">
        <link href='http://fonts.googleapis.com/css?family=Roboto:400,300,700&amp;subset=latin,latin-ext' rel='stylesheet' type='text/css'>

        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/template2/css/bootstrap.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/template2/css/bootstrap-responsive.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/template2/css/style2.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/template2/css/pluton.css" />
     
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/template2/css/jquery.cslider.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/template2/css/jquery.bxslider.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/template2/css/animate.css" />
        </head>
       
        <c:choose>
	<c:when test="${delete==1}">
	<sql:update dataSource="${ds}" sql="delete from items where user=? " var="results3" >
        <c:forEach var="user3" items="${results2.rows}" varStatus="row">
            <c:if test="${user3.facebook_id == facebook.id}">
                <sql:param>${user3.id}</sql:param>
            </c:if>
        </c:forEach>
        </sql:update>
        <sql:update dataSource="${ds}" sql="delete from questions where item1=? " var="results4" >
        <c:forEach var="user4" items="${results2.rows}" varStatus="row">
            <c:if test="${user4.facebook_id == facebook.id}">
                <sql:param>${user4.id}</sql:param>
            </c:if>
        </c:forEach>
        </sql:update>
   
    
        <%
        String site = new String("http://thanosgk.me:8080/Choose4me_new/");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site); 
        %>
         
       
        </c:when>
        <c:otherwise>
        <title>Results!</title>	
        <body>
        <sql:query dataSource="${ds}" sql="select * from items where user=?" var="results1" >
        <sql:param>${userid}</sql:param>
        </sql:query>
        <c:forEach var="user2" items="${results2.rows}" varStatus="row">
        <c:if test="${user2.facebook_id == facebook.id}">
        <c:set var="id" value="${user2.id}"></c:set>
        
           
                <c:choose>
                <c:when test="${id == userid}">
                <div class="section primary-section" id="service">
                <div class="container">
                <!-- Start title section -->
                <a href="/Choose4me_new/">
                <img src="${pageContext.request.contextPath}/pics/back.png" width="70" height="70" alt="back" />
                </a>
                <div class="title">
                   <h1>Results</h1>
                   <br><br><br>
                   <form action="./post" method="post">
                    <button name="message" type="submit" value="http://thanosgk.me:8080/Choose4me_new/poll?userid=${userid}&delete=0">
                    <img src="${pageContext.request.contextPath}/pics/share.png" alt="share" />
                   </div>
                   
                
                
               
                <c:set var="sum" value="0"></c:set>
                <c:forEach var="user" items="${results1.rows}" varStatus="row">
                <c:set var="sum" value="${sum+user.points}"></c:set>
                
                <div class="row-fluid">
                    
                    <div class="span4">
                            <div>
                                
                            
                           
                            </div>
                    </div>     
                    </div>  
              </c:forEach>
                
                
                
                </div>
             </div>
             <div class="section primary-section" id="about">
                <div class="triangle"></div>
                <div class="about-text centered">
                    <h3>Votes</h3>
                    
                </div>
                
                <div class="row-fluid">
                    <div class="span6">
                        <ul class="skills">
                            <c:forEach var="user" items="${results1.rows}" varStatus="row">
                            <img  src="${user.photo}" alt="service 1">
                            <br><br>
                            <li>
                                <span class="bar" data-width="${(user.points/sum)*100}%"></span>
                                <h3>${user.title}</h3>
                            </li>
                            
                            
                            </c:forEach>           
                        </ul>
                    </div>
                </div>     
            </div>
            
           </c:when>
        
            
          <c:when test="${id != userid}">
              <div class="section primary-section" id="service">
                <div class="container">
                   <div class="title">
                   <h1>Choose the best!</h1>
                   </div>
              <c:forEach var="user" items="${results1.rows}" varStatus="row">
                  
                <div class="row-fluid">
                
              <center>
            <form action="./vote" method="post">
            <button name="voteid" type="submit2" value="${user.id}">
            <img src="${user.photo}"></button>
            </form>
            <h4>${user.title}</h4>
            </center>
            </div>
            
                        
            </c:forEach>
             </div>
            </div>
           </c:when>
            
           </c:choose>
          
                    
        
        
       
 
    	<!-- script references -->
        <script type="text/javascript" src="${pageContext.request.contextPath}/style/template2/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/style/template2/js/jquery.mixitup.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/style/template2/js/bootstrap.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/style/template2/js/modernizr.custom.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/style/template2/js/jquery.bxslider.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/style/template2/js/jquery.cslider.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/style/template2/js/jquery.placeholder.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/style/template2/js/jquery.inview.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/style/template2/js/app.js"></script> 
   

</c:if>
</c:forEach>
        <c:if test="${id == NULL}">
            <div class="title">
                <h1>Please login to application  before you can vote !</h1>
                <a href="/Choose4me_new/">Go</a>
            </div>
        
        </c:if>

</c:otherwise>

</c:choose>
        
</body>
</html>