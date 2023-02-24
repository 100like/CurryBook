<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.curry.member.ZipcodeVO" %>
    
<%
    request.setCharacterEncoding("utf-8");
    %>
<jsp:useBean id="dao" class="com.curry.member.MemberDAO" />

<%
	String check = request.getParameter("check");
	String area3 = null;
	Vector<ZipcodeVO> vlist = null;
	//객체(Object)를 여러 개 저장할 때 자료구조 클래스인 'ArrayList'와 'Vector' 클래스를 사용한다.
	//tblZipcode 테이블에는 42625개의 주소지가 입력되어 있으므로 42625개의 ZipcodeVO로 데이터를 저장한다.
	//따라서 모든 테이블의 주소지를 가져올려면 42625번의 프로세스를 수행해야 한다.
	//이는 '서버 과부하의 원인'이 되므로 Vector 클래스를 사용하여 한번에 42625개의 주소지를 가져온다.
	//Vertor<자료형> 변수명 = new Vector<자료형>( );

	if(check.equals("n")) { //사용자가 동/면을 입력하고 검색 버튼을 누르면 동/면 값으로 주소지를 검색한다.
		area3 = request.getParameter("area3");
		vlist = dao.zipcodeRead(area3);
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우편번호 검색(주소지 검색으로 우편번호 설정)</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<style>
	a {color:#333; text-decoration:none;}
</style>
<script>
	function sendAdd(zipcode, area1, area2, area3, area4) {
		address = area1+" "+area2+" "+area3+" "+area4;
		//우편번호 입력폼에 zipcode 값을 설정하고 주소 입력폼에 addr 값을 설정한다.
		//자식 페이지(zipCheck.jsp)에서 부모 페이지(memberForm.jsp)로 값을 전달할 때는 opener(부모 페이지를 참조)를 사용한다.
		window.opener.updateFrm.zipcode.value = zipcode;
		window.opener.updateFrm.addr.value = address;
		self.close();
	}
</script>
</head>
<body>
	<div class="container">
		<form name="zipFrm" action="admin-zipCheck.jsp" method="post">
			<input type="hidden" name="check" value="n">
			<%//검색 버튼을 누르면 check 변수에 'n' 값을 저장한 후 전달한다. %>
			<table class="table">
				<tr>
					<td>
						동/면 이름 입력: <input type="text" name="area3" autofocus required>
						<input type="submit" value="검색">
					</td>
				</tr>
<%
	if(check.equals("n")) { //동/면 을 입력하고 검색 버튼을 누르면
		if(vlist.isEmpty()) { //vlist에 ZipcodeVO 객체가 없으면(주소가 없으면)
%>
				<tr><td>검색된 결과가 없습니다.</td></tr>
<%
		}else{ //검색된 결과가 있으면(주소가 있으면)
%>
				<tr><td>※ 아래 우편번호를 클릭하면 주소지가 자동으로 입력됩니다.</td></tr>
<%
			//Vector 클래스는 객체(zvo)에 인덱스 번호를 지정하여 관리한다.
			for(int i=0; i<vlist.size(); i++) { //Vector 클래스는 size()로 크기를 얻는다.
				ZipcodeVO zvo = vlist.get(i);
				//Vector에 있는 ZipcodeVO의 객체를 인덱스 번호로 하나씩 순차적으로 얻어온다.
				String dZipcode = zvo.getZipcode();
				String dArea1 = zvo.getArea1();
				String dArea2 = zvo.getArea2();
				String dArea3 = zvo.getArea3();
				String dArea4 = zvo.getArea4();
%>
				<tr>
					<td>
						<a href="#" onClick="javascript:sendAdd('<%=dZipcode %>', '<%=dArea1 %>', '<%=dArea2 %>', '<%=dArea3 %>', '<%=dArea4 %>')">
						<%=dZipcode %> <%=dArea1 %> <%=dArea2 %> <%=dArea3 %> <%=dArea4 %>
						</a>
					</td>
				</tr>
<%
			} //for-end
		} //else-end
	} //if-end
%>
				<tr><td><a href="#" onClick="self.close()" class="btn btn-danger">닫기</a></td></tr>
			</table>
		</form>
	</div>
</body>
</html>









