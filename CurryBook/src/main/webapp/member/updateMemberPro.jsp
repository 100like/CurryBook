<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="vo" class="com.curry.member.MemberVO" />
<jsp:setProperty name="vo" property="*" />
<jsp:useBean id="dao" class="com.curry.member.MemberDAO" />

<%
	boolean result = dao.updateMember(vo);
	
	if(result) { //UPDATE문이 성공하면 result에 true, 실패하면 result에 false가 저장된다.
%>
	<script>
		alert("회원 정보를 수정 하였습니다.");
		location.href="mypage.jsp";
	</script>
<%
	}else{
%>
	<script>
		alert("회원 정보를 수정에 실패했습니다.");
		history.back(); //이전 페이지(updateMember.jsp)로 되돌아 간다.
	</script>
<%
	}
%>





