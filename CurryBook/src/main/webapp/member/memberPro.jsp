<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("utf-8"); %>

<%//1. VO에 사용자가 입력한 데이터를 설정(주입)한다. %>
<%//2. DAO에 있는 INSERT 메서드를 호출하여 사용자가 입력한 데이터(VO에서 얻어온다.)를 데이터베이스에 저장한다. %>
<%//useBean 액션태그는 객체를 생성한다. %>
<jsp:useBean id="vo" class="com.curry.member.MemberVO" />
<%
//setProperty 액션태그로 VO의 속성을 초기화한다. 입력폼의 name 속성값과 VO의 인스턴스 변수명을 일치시켜야 한다.
%>
<jsp:setProperty name="vo" property="*" />
<jsp:useBean id="dao" class="com.curry.member.MemberDAO" />

<%
	boolean result = dao.insertMember(vo);
	//DAO 빈에 insertMember()를 호출하면서 사용자가 입력한 데이터를 전달한다.
	//INSERT문의 결과값을 boolean(논리형)으로 받는다.
	
	if(result) { //INSERT문이 성공하면 result에 true, INSERT문이 실패하면 result에 false가 저장된다.
%>
	<script>
		alert("회원가입을 하였습니다.");
		location.href="login.jsp"; //login.jsp로 이동한다.
	</script>
<%
	}else{
%>
	<script>
		alert("회원가입에 실패했습니다.");
		history.back(); //이전 페이지(memberForm.jsp)로 되돌아 간다.
	</script>
<%
	}
%>















