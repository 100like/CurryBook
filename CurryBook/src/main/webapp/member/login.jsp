<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../include/header.jsp" flush="false" />

	<div class="sub-bn sub-bn-bg-1">
		<h4>Member Login</h4>
	</div>

	<div class="mb-container login-container">
		<form name="loginFrm" action="loginPro.jsp" method="post">
			<ul>
				<li><input type="text" name="id" placeholder="아이디 입력" autofocus required class="form-control input-box"></li>
				<li><input type="password" name="pwd" placeholder="비밀번호 입력" required class="form-control input-box"></li>
			</ul>
			<div class="flex">
				<input type="submit" value="로그인" class="btn btn-success">
				<input type="reset" value="다시쓰기" class="btn btn-outline-dark">
				<a href="memberForm.jsp" class="btn btn-outline-warning">회원가입</a>
			</div>
		</form>
	</div>

<jsp:include page="../include/footer.jsp" flush="false" />








