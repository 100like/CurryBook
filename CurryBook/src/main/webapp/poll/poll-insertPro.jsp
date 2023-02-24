<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="pdao" class="com.curry.poll.PollDAO" />
<jsp:useBean id="pvo" class="com.curry.poll.PollListVO" />
<jsp:setProperty property="*" name="pvo"/>
<jsp:useBean id="ivo" class="com.curry.poll.PollItemVO" />
<jsp:setProperty property="*" name="ivo"/>

<%
	String sdate = request.getParameter("sdateY")+"-"+request.getParameter("sdateM")+"-"+request.getParameter("sdateD");
	String edate = request.getParameter("edateY")+"-"+request.getParameter("edateM")+"-"+request.getParameter("edateD");
	
	pvo.setSdate(sdate);
	pvo.setEdate(edate);
	
	boolean flag = pdao.insertPoll(pvo, ivo);
	
	String msg = null, url = null;
	if(flag) {
		msg = "설문이 추가 되었습니다.";
		url = "pollList.jsp";
	}else {
		msg = "설문 추가에 실패했습니다.";
		url = "poll-insert.jsp";
	}
%>
<script>
	alert("<%=msg %>");
	location.href="<%=url %>";
</script>











