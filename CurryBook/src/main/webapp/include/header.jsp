<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String id = (String) session.getAttribute("idKey"); %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Curry Book</title>
    <link rel="icon" type="image/png" sizes="32x32"  href="../imgs/favicon-32x32.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="../flexslider/flexslider.css">
    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/common.css">
    <link rel="stylesheet" href="../css/fs-slider.css">
    <link rel="stylesheet" href="../css/main.css">
    <link rel="stylesheet" href="../css/sub-style.css">
    <script src="https://kit.fontawesome.com/11390cb447.js" crossorigin="anonymous"></script>
    <script src="../js/jquery-1.12.4.min.js"></script>
    <script src="../js/dropdown.js"></script>
    <script src="../js/navgation.js"></script>
    <script src="../flexslider/jquery.flexslider.js"></script>
    <script src="../js/mb-script.js"></script>
    <script>
        $(function() {
            $('.flexslider').flexslider({
                animation: "slide" //fade
            });
        });
    </script>
</head>
<body>
    <header>
        <nav>
            <h1><a href="../view/index.jsp"><img src="../imgs/dt-logo.png" alt="로고"></a></h1>
            <a href="#" id="trigger">
                <span></span>
                <span></span>
                <span></span>
            </a>

            <ul id="main-menu">
                <li>
                    <a href="#">카레북</a>
                    <ul class="sub-menu">
                    </ul>
                </li>
                <li>
                    <a href="#">맛있게먹는법</a>
                    <ul class="sub-menu">
                        <li><a href="#">카레 종류</a></li>
                        <li><a href="#">카레 토핑</a></li>
                        <li><a href="#">카레 레시피</a></li>
                        <li><a href="#">추천 음료</a></li>
                    </ul>
                </li>
                <li><a href="#">카레지도</a></li>
                	<li>
                	<a href="#">만남광장</a>
	                	<ul class="sub-menu">
	                        <li><a href="#">광 장</a></li>
	                        <li><a href="../poll/pollList.jsp">투표참여</a></li>
	                    </ul>
                	</li>
            </ul>

            <ul class="topmenu dt">
<%
		if(id != null) {
%>
            	<li><a href="#"><strong><%=id %></strong>님 환영합니다.</a></li>
                <li><a href="../member/logout.jsp">로그아웃</a></li>
                <li><a href="../member/mypage.jsp">마이페이지</a></li>
<%
			if(id.equals("admin")) {
%>
				<li><a href="../member/admin-memberList.jsp">회원목록</a></li>
<%
			}
		}else{
%>
                <li><a href="../member/login.jsp">로그인</a></li>
                <li><a href="../member/memberForm.jsp">회원가입</a></li>
<%
		}
%>
            </ul>
            <ul class="topmenu mb">
<%
		if(id != null) {
%>
                <li><a href="#"><a href="../member/logout.jsp"><i class="bi bi-box-arrow-right"></i></a></li>
                <li><a href="#"><a href="../member/mypage.jsp"><i class="bi bi-person-dash-fill"></i></a></li>
<%
			if(id.equals("admin")) {
%>
				<li><a href="../member/admin-memberList.jsp"><i class="bi bi-person-lines-fill"></i></a></li>
<%
			}
		}else{
%>             
                <li><a href="#"><a href="../member/login.jsp"><i class="bi bi-box-arrow-in-right"></i></a></li>
                <li><a href="#"><a href="../member/memberForm.jsp"><i class="bi bi-person-plus-fill"></i></a></li>
<%
		}
%>
            </ul>
        </nav>
    </header>