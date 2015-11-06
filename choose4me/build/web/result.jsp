<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<sql:setDataSource var="ds" dataSource="jdbc/choose4me" />

<sql:query dataSource="${ds}" sql="select * from user " var="results" />
<c:forEach var="user" items="${results.rows}" varStatus="row">
    <c:if test="${user.facebook_id == facebook.id}">
        <c:set var="id" value="${user.id}"></c:set>
    </c:if>
</c:forEach>
<%@ page import="java.util.*" %>

<html>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="${pageContext.request.contextPath}/style/css/bootstrap.min.css" rel="stylesheet">
    <link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/style/css/styles3.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/pics/favicon.ico">
    
<body>

<div id="test"></div>
<div class="featurette" id="sec2">
  <div class="container">
          <div class="row">
           <h3>Pick One!</h3>

<%
  List styles = (List) request.getAttribute("styles");
  
   
%>
<c:if test="${styles[0]== NULL}">
<%
   String site = new String("http://thanosgk.me:8080/Choose4me_new/");
   response.setStatus(response.SC_MOVED_TEMPORARILY);
   response.setHeader("Location", site); 
%>

</c:if>
<c:if test="${styles.size()<20}">
    
 <div class="col-md-2 col-md-offset-2 text-center">
            <div class="featurette-item">
            <form action="./item" method="post">
            <button name="selectionid" type="submit2" value="0">
            <img src="${styles[3]}"></button>
            </form>
            <h4>${styles[0]}</h4>
            <br>
            </div>
</div>
<div class="col-md-2 col-md-offset-2 text-center">
            <div class="featurette-item">
             <form action="./item" method="post">
            <button name="selectionid" type="submit2" value="1">
            <img src="${styles[4]}"></button>
            </form>
            <h4>${styles[1]}</h4>
            <br>
            </div>
</div>
            <c:if test="${styles.size()>5}">
            <div class="col-md-2 col-md-offset-2 text-center">
                <div class="featurette-item">
                <form action="./item" method="post">
                <button name="selectionid" type="submit2" value="2">
                <img src="${styles[5]}"></button>
                </form>
                <h4>${styles[2]}</h4>
                <br>
                </div>
            </div>
            </c:if>
            </div>
            </div>
            </div>

</c:if>

<c:if test="${styles.size()>20}">
    
     <div class="col-md-2 col-md-offset-2 text-center">
            <div class="featurette-item">
            <form action="./item" method="post">
            <button name="selectionid" type="submit2" value="0">
            <img src="${styles[15]}"></button>
            </form>
            <h4>${styles[0]}</h4>
            <br>
            </div>
</div>
<div class="col-md-2 col-md-offset-2 text-center">
            <div class="featurette-item">
             <form action="./item" method="post">
            <button name="selectionid" type="submit2" value="1">
            <img src="${styles[16]}"></button>
            </form>
            <h4>${styles[1]}</h4>
            <br>
            </div>
</div> 
<div class="col-md-2 col-md-offset-2 text-center">
            <div class="featurette-item">
             <form action="./item" method="post">
            <button name="selectionid" type="submit2" value="2">
            <img src="${styles[17]}"></button>
            </form>
            <h4>${styles[2]}</h4>
            <br>
            </div>
</div> 
            </div>
            </div>
            </div>

</c:if>

<!-- script references -->
		<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/style/js/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/style/js/scripts.js"></script>
</body>
</html>
