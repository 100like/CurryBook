<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String id = (String) session.getAttribute("idKey"); %>

<jsp:include page="../include/header.jsp" flush="false" />

	<div class="sub-bn sub-bn-bg-1">
		<h4>Login Success</h4>
	</div>
	
<%
	if(id != null) { //로그인 했으면
%>
	<div class="mb-container login-container">
		<p class="text-center fs-4 lh-lg"><strong><%=id %></strong>님 환영합니다.</p>
		<div class="flex">
			<a href="logout.jsp" class="btn btn-outline-warning">로그아웃</a>
			<a href="mypage.jsp" class="btn btn-outline-secondary">나의 정보</a>
<%
		if(id.equals("admin")) {
%>
			<a href="admin-memberList.jsp" class="btn btn-outline-dark">회원 목록</a>
<%
		}
%>
		</div>
	</div>
<%
	}else{ //로그인 안했으면
%>
	<script>
		alert("로그인에 실패했습니다.");
		location.href="login.jsp";
	</script>
<%
	}
%>

<jsp:include page="../include/footer.jsp" flush="false" />



