<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../include/header.jsp" flush="false" />

	<div class="sub-bn sub-bn-bg-4">
		<h4>Poll Insert</h4>
	</div>
	
	<div class="poll-container pl-sm-container">
		<h5>설문 작성</h5>
		
		<form action="poll-insertPro.jsp" method="post">
			<table class="table">
				<tr>
					<td>질문</td>
					<td><input type="text" name="question" required autofocus class="form-control"></td>
				</tr>
<%
					//항목 입력폼을 8개 생성하는 반복문
					for(int i=1; i<=4; i++) {
						//out.println()는 웹브라우저로 매개변수로 전달하는 요소를 출력한다.
						out.println("<tr><td>항목"+(i*2-1)+"</td><td><input type='text' name='item' class='form-control'></td></tr>");
						out.println("<tr><td>항목"+(i*2)+"</td><td><input type='text' name='item' class='form-control'></td></tr>");
					}
%>			
				</tr>
				<tr>
					<td>시작일</td>
					<td>
						<select name="sdateY" class="form-select">
							<option value="2022">2022 년
							<option value="2023">2023 년
						</select>
						<select name="sdateM" class="form-select">
<%
						for(int i=1; i<=12; i++) {
							out.println("<option value='"+i+"'>"+i+"월");
						}
%>
						</select>
						<select name="sdateD" class="form-select">
<%
						for(int i=1; i<=31; i++) {
							out.println("<option value='"+i+"'>"+i+"일");
						}
%>
						</select>
					</td>
				</tr>
				<tr>
					<td>종료일</td>
					<td>
						<select name="edateY" class="form-select">
							<option value="2022">2022 년
							<option value="2023">2023 년
						</select>
						<select name="edateM" class="form-select">
<%
						for(int i=1; i<=12; i++) {
							out.println("<option value='"+i+"'>"+i+"월");
						}
%>
						</select>
						<select name="edateD" class="form-select">
<%
						for(int i=1; i<=31; i++) {
							out.println("<option value='"+i+"'>"+i+"일");
						}
%>
						</select>
					</td>
				</tr>
				<tr>
					<td>이중 답변</td>
					<td>
						<input type="radio" name="type" value="1" checked> 예(yes) &nbsp;&nbsp;
						<input type="radio" name="type" value="0"> 아니요(no)
					</td>
				</tr>
			</table>
			
			<div class="flex">
				<input type="submit" value="작성하기" class="btn btn-success">
				<input type="reset" value="다시쓰기" class="btn btn-dark">
				<a href="pollList.jsp" class="btn btn-warning">설문목록</a>
			</div>
		</form>
	</div>

<jsp:include page="../include/footer.jsp" flush="false" />









