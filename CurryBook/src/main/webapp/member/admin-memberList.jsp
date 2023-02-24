<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.curry.member.MemberVO" %>

<jsp:useBean id="dao" class="com.curry.member.MemberDAO" />
<% Vector<MemberVO> mlist = dao.getMemberList(); %>

<jsp:include page="../include/header.jsp" flush="false" />
<style>
.memberlist > th {text-align:center;}

</style>
<script>
	$(document).ready(function(){
		$('button#userid').on('click', function(){
			//$(this)는 선택한 DOM에 이벤트가 포함된 상태이다.
			var id = $(this).val(); //val()는 input 요소의 value 속성값을 얻는다.
			//val('속성값')는 input 요소의 value 속성값을 지정한다.
			alert(id+'님을 선택했습니다.'); //id값을 얻어 왔는지 확인한다.
			var url = 'admin-update.jsp?userid='+id;
			//url에 포함하여 데이터를 전달하는 방법은 'get' 방법이다.
			//회원의 아이디값을 url에 포함하여 admin-mypage.jsp로 전달한다.
			//alert(url)로 url 변수에 원하는 값이 저장되었는 지 확인한다.
			$(location).attr('href', url); //input 요소일 경우 $(location)의 href 속성에 url 속성값을 지정하여 페이지 전환을 한다.
		});
		
		/*
		현재 페이지에서 검색어에 해당하는 텍스트가 있는 행을 조회하여 출력한다.
		이벤트 연결(등록) 메서드인 keyup()는 키보드의 키를 눌렀다가 뗄 때 이벤트를 이벤트 처리 함수로 연결한다.
		val()는 입력폼의 값을 얻어온다.
		toLowerCase()는 입력한 값이 영문자이면 모두 소문자로 변경한다.
		filter()는 선택한 요소의 '하위 요소'에서 입력폼에 입력한 텍스트를 찾는다.
		toggle()는 이벤트 효과 메서드로 요소가 안보이면 보이게 하고 보이면 안보이게 한다.
		※ 검색어가 행에 있으면 보이게 한다. 검색어가 행에 없으면 안보이게 한다.
		text()는 선택한 요소에서 텍스트 얻는다.
		indexOf()는 텍스트가 있으면 순번(index)를 반환한다.
		문자열이 존재하지 않으면 -1을 반환한다.
		*/
		$('#search').keyup(function() {
			var value = $(this).val().toLowerCase();
			$('.search-row').filter(function() {
				$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
			});
		});
	});
</script>
	<div class="sub-bn sub-bn-bg-3">
		<h4>Member List</h4>
	</div>
	
	<div class="mb-container list-container">
	<input type="text" placeholder="검색어 입력" id="search" class="form-control search-box">
	
	<table class="table table-hover align-middle">
		<tr class="table-success memberlist">
			<th>아이디</th>
			<th>이름</th>
			<th>성별</th>
			<th>생일</th>
			<th>이메일</th>
			<th>우편번호</th>
			<th>주소</th>
			<th>유입경로</th>
			<th>마켓팅활용동의</th>
		</tr>
<%
if(mlist.isEmpty()) {
%>
		<tr><td>회원 목록이 없습니다.</td></tr>
<%
}else{
	for(int i=0; i<mlist.size(); i++) { //Vector 클래스는 size()로 크기를 얻는다.
		MemberVO mvo = mlist.get(i);
		//Vector에 있는 ZipcodeVO의 객체를 인덱스 번호로 하나씩 순차적으로 얻어온다.
		String id = mvo.getId();
		String name = mvo.getName();
		String birth = mvo.getBirth();
		String email = mvo.getEmail();
		String zipcode = mvo.getZipcode();
		String addr = mvo.getAddr();
		String path = mvo.getPath();
%>

		<tr class="search-row">
			<td><button type="button" id="userid" value="<%=id %>" ><%=id %></button></td>
			<td><%=name %></td>
<%
String gender = null;
if(mvo.getGender().equals("1")) {
	gender = "남자";
}else{
	gender = "여자";
}
%>
			<td><%=gender %></td>
			<td><%=birth %></td>
			<td><%=email %></td>
			<td><%=zipcode %></td>
			<td><%=addr %></td>
			<td><%=path %></td>
			<td>
<%
String[] hb = mvo.getMarketing();
String[] lists = {"인터넷","SNS","문자","우편","없음"};

for(int j=0; j<hb.length; j++) {
	if(hb[j].equals("1")) {
		String marketing = lists[j];
%>
				<%=marketing %>&nbsp;
<%
	}
}
%>
			</td>
		</tr>
<%
	} //for-end
} //else-end
%>	
	</table>
	</div>

<jsp:include page="../include/footer.jsp" flush="false" />









