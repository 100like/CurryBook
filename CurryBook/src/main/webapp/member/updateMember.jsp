<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String id = (String) session.getAttribute("idKey"); %>
<jsp:useBean id="vo" class="com.curry.member.MemberVO" />
<jsp:useBean id="dao" class="com.curry.member.MemberDAO" />
<% vo = dao.getMyInfo(id); %>
    
<jsp:include page="../include/header.jsp" flush="false" />
<script>
	function zipCheck() {
		url = "zipCheck.jsp?check=y";
		window.open(url, "ZipCodeCheck", "width=500, height=300, scrollbars=yes");
	}
</script>

	<div class="sub-bn sub-bn-bg-2">
		<h4>Member Update</h4>
	</div>
	
	<div class="mb-container join-container">
		<form name="regFrm" action="updateMemberPro.jsp" method="post">
			<ul>
				<li><input type="text" name="id" class="form-control" value="<%=id %>" readonly autofocus required></li>
				<li><input type="password" name="pwd" value="<%=vo.getPwd() %>" class="form-control" required></li>
				<li><input type="text" name="name" value="<%=vo.getName() %>" class="form-control" required></li>
				<li>
					성별 : 
					<input type="radio" name="gender" value="1" checked> 남자 &nbsp;&nbsp; 
					<input type="radio" name="gender" value="2"> 여자
				</li>
				<li>생일 : <input type="text" name="birth" value="<%=vo.getBirth() %>" class="form-control input-birth"></li>
				<li><input type="email" name="email" value="<%=vo.getEmail() %>" class="form-control" required></li>
				<li>
					<input type="text" name="zipcode" value="<%=vo.getZipcode() %>" class="form-control input-zipcode" readonly>
					<input type="button" value="우편번호 찾기" class="btn btn-outline-success btn-zipcode" onClick="zipCheck()">
				</li>
				<li><input type="text" name="addr" value="<%=vo.getAddr() %>" class="form-control"></li>
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
				<button type="submit" class="btn btn-success">정보수정</button>
				<a href="mypage.jsp" class="btn btn-warning">나의정보</a>
			</div>
		</form>
	</div>

<jsp:include page="../include/footer.jsp" flush="false" />









