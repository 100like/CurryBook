<%/*
※ 투표 프로그램의 개요와 기능, 플로어 차트(사용자의 웹 애플리케이션 사용 흐름)

※ 투표 프로그램 데이터베이스 모델링 작업으로 테이블 생성
tblPollList(투표 목록 테이블)
투표번호(X)		num	INT	AUTO_INCREMENT	PK(투표번호를 저장한다.)
투표질문(O)			question	VARCHAR(100)	NOT NULL(투표질문을 저장한다.)
투표시작일(O)		sdate	DATE(투표 시작일을 저장한다.)
투표종료일(O)		edate	DATE(투표 종료일을 저장한다.)
투표작성일(X)		wdate	DATE(투표 작성일을 저장한다.)
투표이중답변(O)	type		INT	NOT NULL(투표 이중 답변 여부를 저장한다.)
투표활성화(X)			active	INT	DEFAULT 1(투표 활성화 여부를 저장한다.)

tblPollItem(투표 항목(아이템) 테이블)
투표번호(X)			listnum	INT	PK(tblPollList의 num컬럼의 최대값을 얻어와 저장한다. 투표목록에 아이템들을 그룹화하기 위해 같은 투표 번호를 저장한다.)
투표항목(아이템)번호(X)	itemnum		INT	PK(투표 항목(아이템)에 각각 번호를 저장한다.)
투표항목(아이템)(O)			item		VARCHAR(30)	NOT NULL(투표할 아이템을 저장한다.)
투표횟수(X)	count	INT DEFAULT 0(투표 횟수를 저장한다. UPDATE문으로 투표 횟수를 변경한다.)

※ 투표 프로그램 화면 구현
- pollForm.jsp: 투표 항목(아이템)을 체크하여 투표하고 결과를 확인한다.
- pollList.jsp: 투표 목록을 보여준다. 투표 질문을 클릭하면 해당되는 투표 항목을 보여준다.
- poll-insert.jsp: 투표 목록을 등록하는 입력폼 화면을 제공한다.
- pollView.jsp: 투표 결과를 윈도우 창으로 보여준다.

1. 투표 입력폼(pollForm.jsp, 인크루드 액션태그)
	2-1. 투표 항목(아이템) 번호
	2-2. 투표 항목(아이템)
	[투표 제출] 버튼, [투표 결과] 버튼

2. 투표 리스트(pollList.jsp)
	2-1. 투표 질문
	2-2. 투표 시작일
	2-3. 투표 종료일
	[투표 작성] 버튼
	
3. 투표 리스트 등록(poll-insert.jsp)
	3-1. 투표 질문 입력
	3-2. 투표 항목(아이템) 입력
	3-3. 투표 시작일 입력
	3-4. 투표 종료일 입력
	3-5. 투표 이중답변 입력
	[투표등록] 버튼, [다시쓰기] 버튼, [투표목록] 버튼
	
4. 투표 결과(윈도우 창, pollView.jsp)
	4-1. 총 투표 수
	4-2. 투표 항목(아이템)
	4-3. 투표 항목(아이템)에 대한 투표 수
	[닫기] 버튼
*/%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.curry.poll.PollListVO" %>

<jsp:useBean id="pdao" class="com.curry.poll.PollDAO" />

<%
	String id = (String) session.getAttribute("idKey");
	Vector<PollListVO> plist = pdao.getPollList();
%>

<jsp:include page="../include/header.jsp" flush="false" />

	<div class="sub-bn sub-bn-bg-4">
		<h4>Poll List</h4>
	</div>
	
	<div class="poll-container pl-container">
		<h5>설문 투표</h5>
		<jsp:include page="pollForm.jsp" flush="false" />
		
		<h5 class="pl-list">투표 목록</h5>
		<table class="table">
			<tr class="table-success">
				<th>투표 질문</th>
				<th>시작일 ~ 종료일<th>
			</tr>
<%
	if(plist.isEmpty()) {
%>
		<tr><td align="center" colspan="2">등록된 투표 목록이 없습니다.</td></tr>
<%
	}else{
		for(int i=0; i<plist.size(); i++) {
			PollListVO pvo = plist.get(i); //Vector에 있는 pvo를 순번에 맞게 순차적으로 얻는다.
			int num = pvo.getNum();
			String question = pvo.getQuestion();
			String sdate = pvo.getSdate();
			String edate = pvo.getEdate();
			int active = pvo.getActive();
			
			if(active == 1) { //투표 활성화 컬럼의 값이 1(true)이면 브라우저에 출력한다.
				out.println("<tr><td><a href='pollList.jsp?num="+num+"'>"+question+"</a></td>");
				out.println("<td>"+sdate+" ~ "+edate+"</td></tr>");
			}
		}
	}
%>
		</table>

		<div class="flex">
<%
		if(id != null) {
			if(id.equals("admin")) {
%>
			<a href="poll-insert.jsp" class="btn btn-dark">투표작성</a>
<%
			}
		}
%>
		</div>
	</div>

<jsp:include page="../include/footer.jsp" flush="false" />









