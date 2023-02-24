<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="pdao" class="com.curry.poll.PollDAO" />

<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	//tblPollItem 테이블 listnum 컬럼(투표번호)의 데이터형이 INT형이므로 정수형으로 변환하여 비교해야한다.
	String[] itemnum = request.getParameterValues("itemnum");
	//이중답변을 허용할 경우 itemnum에는 pollForm.jsp에서 체크한 여러 개의 투표항목(아이템)값이 저장되므로 getParameterValues()로 값을 얻는다.
	String msg = null;
	
	boolean flag = pdao.updatePoll(num, itemnum);
	//투표번호와 투표항목(아이템)번호를 전달하여 투표횟수(count)를 갱신(수정)한다.
	if(flag) msg = "투표가 정상적으로 등록되었습니다.";
	else msg = "투표 등록에 실패했습니다.";
%>
<script>
	alert("<%=msg %>");
	location.href="pollList.jsp?num=<%=num%>";
</script>








