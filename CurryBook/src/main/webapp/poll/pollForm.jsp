<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.curry.poll.*" %>

<jsp:useBean id="pdao" class="com.curry.poll.PollDAO" />
<jsp:useBean id="pvo" class="com.curry.poll.PollListVO" />
<jsp:useBean id="ivo" class="com.curry.poll.PollItemVO" />
    
<%
	String id = (String) session.getAttribute("idKey");

	int num = 0;
	//num 값이 없거나 null이면 num 값을 얻지않는다.(유효성 검증 작업)
	if(!(request.getParameter("num") == null || request.getParameter("num").equals(""))) {
		num = Integer.parseInt(request.getParameter("num"));
		//Integer.parseInt()는 문자열 값을 숫자형으로 변환한다.
	}
	
	pvo = pdao.getPoll(num); //투표번호에 해당하는 투표목록 하나(한행)를 얻는다.
	Vector<String> vlist = pdao.getItem(num); //투표번호에 해당하는 투표항목(아이템)들을 얻는다.
	
	String question = pvo.getQuestion(); //질문
	int type = pvo.getType(); //이중답변 유무
	int active = pvo.getActive(); //활성화 유무
%>

<form action="pollFormPro.jsp" method="post">
	<input type="hidden" name="num" value="<%=num %>">
	<%//pollFormPro.jsp로 num(투표번호)을 전달한다. %>
	<table class="pf-insert">
		<tr>
			<td>투표 질문</td>
			<td><%=question %></td>
		</tr>
		<tr>
			<td colspan="2" class="pf-item">
<%
	if(vlist.isEmpty()) {
%>
				아이템 항목이 없습니다.
<%		
	}else{
		for(int i=0; i<vlist.size(); i++) {
			String item = vlist.get(i); //Vector에 있는 아이템(투표항목)을 순번(itemnum)에 맞게 순차적으로 얻는다.
			if(type == 1) { //이중답변 이면
				out.println("<input type='checkbox' name='itemnum' value='"+i+"'>");
			}else{ //이중답변이 아니면
				out.println("<input type='radio' name='itemnum' value='"+i+"'>");
			}
			out.println("&nbsp;"+item+"&nbsp;&nbsp;");
		}
	}
%>		
			</td>
		</tr>
	</table>
	
	<div class="flex">
<%
	if(id != null) {
%>
		<input type="submit" value="투표제출" class="btn btn-success">
		<button onClick="javascript:window.open('pollView.jsp?num=<%=num %>', 'PollView', 'width=450, height=420')" class="btn btn-warning">투표결과</button>
<%
	}
%>
	</div>
</form>







