<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="dao" class="com.curry.member.MemberDAO" />
<%
	String id = request.getParameter("id");
	boolean result = dao.checkId(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복 확인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/sub-style.css">
</head>
<body>
	<div class="idcheck-container">
	<h2>아이디 중복 확인</h2>
		<p>입력한 아이디는 <strong><%=id %></strong>입니다.</p>

		<p>
<%
	if(result) out.println("아이디가 중복되어 입력한 아이디는 사용할 수 없습니다.");
	else out.println("입력한 아이디를 사용할 수 있습니다.");
%>
		</p>
		<div class="flex"><button onClick="self.close()" class="btn btn-outline-danger close-btn">닫기</button></div>
	</div>
</body>
</html>





