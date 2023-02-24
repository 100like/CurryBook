<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../include/header.jsp" flush="false" />

	<div class="sub-bn sub-bn-bg-2">
		<h4>Member Join</h4>
	</div>
	
	<div class="mb-container join-container">
		<form name="regFrm" action="memberPro.jsp" method="post">
			<ul>
				<li>
					<input type="text" name="id" placeholder="아이디 입력" class="form-control input-id" autofocus required>
					<input type="button" value="아이디 중복 확인" onClick="idCheck(this.form.id.value)" class="btn btn-outline-success">
					<%//아이디 중복 확인 버튼을 클릭(=onClick)하면 idCheck()를 호출하면서 사용자가 입력한 아이디 값을 전달한다.%>
					<div class="clear"></div>
				</li>
				<li><input type="password" name="pwd" placeholder="비밀번호 입력" class="form-control" required></li>
				<li><input type="password" name="repwd" placeholder="비밀번호 확인" class="form-control" required></li>
				<li><input type="text" name="name" placeholder="이름 입력" class="form-control" required></li>
				<li>
					성별 : 
					<input type="radio" name="gender" value="1" checked> 남자 &nbsp;&nbsp; 
					<input type="radio" name="gender" value="2"> 여자
				</li>
				<li>
					생일 : <input type="text" name="birth" class="form-control input-birth">
					<div class="clear"></div>
				</li>
				<li><input type="email" name="email" placeholder="이메일 입력" class="form-control" required></li>
				<li>
					<input type="text" name="zipcode" placeholder="우편번호" class="form-control input-zipcode" readonly>
					<input type="button" value="우편번호 찾기" class="btn btn-outline-success btn-zipcode" onClick="zipCheck()">
					<div class="clear"></div>
				</li>
				<li><input type="text" name="addr" placeholder="주소" class="form-control"></li>
				<li>
					마켓팅활용동의 : <br>
					<input type="checkbox" name="marketing" value="인터넷" checked> 인터넷&nbsp;&nbsp;
					<input type="checkbox" name="marketing" value="SNS"> SNS&nbsp;&nbsp;
					<input type="checkbox" name="marketing" value="문자"> 문자&nbsp;&nbsp;
					<input type="checkbox" name="marketing" value="우편"> 우편&nbsp;&nbsp;
					<input type="checkbox" name="marketing" value="없음"> 없음
				</li>
				<li>
					<select name="path" class="form-control">
						<option value="0" disabled selected>유입경로를 선택하세요</option>
						<option value="검색">검색</option>
						<option value="지인추천">지인추천</option>
						<option value="광고">광고</option>					
						<option value="SNS">SNS</option>
						<option value="기타">기타</option>
					</select>
				</li>
			</ul>
			<div class="flex">
				<%//버튼 요소는 a 태그, button 태그, input 태그로 만든다. 페이지 이동이 필요하면 a 태그를 사용하지만, 페이지 이동이 필요 없으면 button 태그를 사용한다. %>
				<%//회원가입 버튼을 누르면 inputCheck() 함수를 호출하여 데이터 유효성 검증 작업을 한다. required 키워드로 유효성 검증 작업을 한다. %>
				<%// <button onClick="inputCheck()" class="btn btn-outline-primary">회원가입</button> %>
				<button onClick="submitCheck()" class="btn btn-warning">회원가입</button>
				<button type="reset" class="btn btn-outline-dark">다시쓰기</button>
				<a href="login.jsp" class="btn btn-outline-success">로그인</a>
			</div>
		</form>
	</div>
	<div class="clear"></div>

<jsp:include page="../include/footer.jsp" flush="false" />














