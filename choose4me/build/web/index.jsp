<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>


<sql:setDataSource var="ds" dataSource="jdbc/choose4me" />

<sql:query dataSource="${ds}" sql="select * from user" var="results" />
<sql:query dataSource="${ds}" sql="select * from questions" var="results2" />

<!DOCTYPE HTML>
<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/style/template/css/skel.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/style/template/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/style/template/css/style-desktop.css" />
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/pics/favicon.ico">
<title>Choose 4 your friends</title>
<tag:notloggedin> 
<jsp:include page="notloggedin.jsp" />
</tag:notloggedin>

<tag:loggedin>
<c:forEach var="user" items="${results.rows}" varStatus="row">
    <c:if test="${user.facebook_id.equals(facebook.id)}">       
        <title>Choose4me|Welcome ${facebook.name}</title>
        <c:set var="check" value="1"></c:set>
        <c:set var="xristis" value="${user.id}"></c:set>
    </c:if>
 </c:forEach>
        
<c:if test="${check != 1}">
<sql:update dataSource="${ds}" var="user2" > 
        INSERT INTO user (username,facebook_id,picurl) VALUES (?,?,?)
        <sql:param>${facebook.name}</sql:param>
	<sql:param>${facebook.id}</sql:param>
        <sql:param>${facebook.pictureURL}</sql:param>
        </sql:update>
</c:if> 

<body class="homepage">
<div id="header-wrapper" class="wrapper">
    <div id="header">
        <div id="logo">
		<h1><a>Welcome</a></h1>
                <h1><a>${facebook.name} </a></h1><br>
                <a><img alt="Brand" src="${facebook.pictureURL}"></a>
                
		</div>
        <nav id="nav">
            <ul>
                <script>	function basicPopup(url) {
popupWindow = window.open(url,'popUpWindow','height=500,width=500,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes');
	}</script>   
            <li><a href="./">${facebook.name}</a></li>
            <li><a href="poll?userid=${xristis}&delete=0">View Poll</a></li>
            <li><a href="poll?userid=${xristis}&delete=1">Delete poll</a></li>
            <li><a href="./logout">Logout</a></li>
            </ul>
        </nav>
    </div>
</div>
<div id="intro-wrapper" class="wrapper style1">
	<div class="title">Pick one item for the poll!</div>
<section id="intro" class="container">
    <center> 	

<form method="POST" action="choose4me" id="search">
    Select one
    Type:
    <select name="type" size="1" style="width: 200px;">
      <option value="movie">Movies</option>
      <option value="book">Books</option>
      <option value="music">Music CD</option>
    </select>
    <input  style="width: 350px;" name="q" type="text" size="40" placeholder="Search..." />
    <br><br>
    <input type="Submit" >
</form>

</section>
</div>
<div class="wrapper style2">
    <div class="title">Your friends picks</div>
        <div id="main" class="container">
            <section id="features">
		<header class="style1">
                <div class="feature-list">
                <c:forEach var="user2" items="${results2.rows}" varStatus="row">
                <c:if test="${user2.item1==xristis}">
                <div class="row">
		<div class="6u">
		<section>
                <h3><img alt="Brand" src="${user2.user}">  suggests ${user2.userid}</h3>  
		</section>
		</div>
                </div>
                
                </c:if>
                </c:forEach>
                </div>
		</header>
        </div>
</div>
</body>
</tag:loggedin>
</html>
