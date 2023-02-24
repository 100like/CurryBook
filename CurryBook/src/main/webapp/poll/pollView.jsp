<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.curry.poll.PollItemVO" %>
<%@ page import="com.curry.poll.PollListVO" %>
    
<jsp:useBean id="pdao" class="com.curry.poll.PollDAO" />

<%
	request.setCharacterEncoding("utf-8");
	int number = 0;
	if(request.getParameter("num") != null) number = Integer.parseInt(request.getParameter("num"));
	
	int total = pdao.getPollCount(number);
	//투표번호에 해당하는 총 투표횟수를 얻는다.
	Vector<PollItemVO> itemList = pdao.getViewList(number);
	//투표번호에 해당하는 투표항목(아이템)과 투표횟수를 얻는다.
	PollListVO pvo = pdao.getPoll(number);
	//투표번호에 해당하는 투표질문을 얻는다.
	String question = pvo.getQuestion();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표 결과</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/sub-style.css">
</head>
<body>
	<div class="pollviewcontainer">
	<h2>투표 결과</h2>
	<table class="pv-question">
		<tr>
			<td>총투표수</td>
			<td><%=total %></td>
		</tr>
		<tr>
			<td>투표질문</td>
			<td><%=question %></td>
		</tr>
	</table>
	<table class="pv-item">
		<tr>
			<td>번호</td>
			<td>투표 항목</td>
			<td></td>
			<td>투표수</td>
		</tr>
<%
	for(int i=0; i<itemList.size(); i++){
		PollItemVO ivo = itemList.get(i);
		//Vector에 VO를 추가할 때 add(VO)를 사용하고 Vector에서 VO를 얻을 때 get(index)를 사용한다.
		String[] item = ivo.getItem(); //items 문자열 배열은 item을 여러 개 저장한다.
		int count = ivo.getCount();
		int ratio = new Double(Math.ceil((double) count / total * 100)).intValue();
		//(double) count / total * 100 : 투표수의 단위를 %로 바꾼다.
		//Math.ceil()는 실수를 올림처리하며, 반환형이 double형이다.
		//new Double()는 실수형 객체를 생성한다. Double 클래스의 있는 intValue()로 값을 정수형으로 변환한다.		
%>
		<tr>
			<td><%=i+1 %></td>
			<td><%=item[0] %></td>
			<td>
				<table width="<%=ratio %>%">
					<tr><td class="ratio"><%=ratio %>%</td></tr>
				</table>
			</td>
			<td><%=count %></td>
		</tr>
<%
	}
%>
	</table>
	<div class="flex"><a href="javascript:window.close()" class="btn btn-danger close-btn">닫기</a>	</div>
	</div><!-- pollviewcontainer close -->
</body>
</html>









