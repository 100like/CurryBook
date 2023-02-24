function idCheck(id) { //자바스크립트의 변수는 자료형이 없다.
	if(id == '') { //만약에 아이디 입력폼에 아이디를 입력하지 않고 아이디 중복 확인 버튼을 눌렀으면
		alert("아이디를 입력해 주세요.");
		document.regFrm.id.focus(); //아이디 입력폼으로 커서를 위치시킨다.
		return; //함수 종료
	}

	url = "idCheck.jsp?id="+id;
	//idCheck.jsp로 이동하면서 id변수에 사용자가 입력한 id 값을 저장하여 get 방식으로 전달한다.
	//window.open()는 윈도우 창을 띄운다.
	window.open(url, "IDCheck", "width=400, height=235");
}

function zipCheck() {
	url = "zipCheck.jsp?check=y";
	//zipCheck.jsp로 이동하면서 check변수에 y값을 저장하여 get 방식으로 전달한다.
	window.open(url, "ZipCodeCheck", "width=500, height=300, scrollbars=yes");
}

function submitCheck() {
	//<input>에 required 키워드를 적용한 경우 유효성 검증이 적용된다.
	//document(HTML 문서의 객체).regFrm(form 요소의 객체).id(id 입력폼 요소의 객체).value(value 속성으로 입력폼에 입력한 값을 얻는다.)
	if(document.regFrm.id.value=="") { //아이디 입력폼에 값이 없으면
		alert("아이디를 입력하세요."); //alert()로 경고창을 띄운다.
		document.regFrm.id.focus( ); //아이디 입력폼에 커서를 위치시킨다.
		return;
	}
	
	if(document.regFrm.pwd.value=="") { //비밀번호 입력폼에 값이 없으면
		alert("비밀번호를 입력하세요.");
		document.regFrm.pass.focus( );
		return;
	}
	
	if(document.regFrm.repwd.value=="") {
		alert("비밀번호 확인을 입력하세요.");
		document.regFrm.repass.focus( );
		return;
	}
	
	if(document.regFrm.pwd.value != document.regFrm.repwd.value) {
		// 비밀번호 입력폼에 입력한 값과 비밀번호 확인 입력폼에 입력한 값이 다르면
		alert("비밀번호가 일치하지 않습니다.");
		document.regFrm.repwd.value="";
		// 비밀번호 확인 입력폼의 값을 공백처리한다.
		document.regFrm.repwd.focus( );
		// 비밀번호 확인 입력폼에 커서를 위치시킨다.
		return;
	}
	
	if(document.regFrm.name.value=="") {
		alert("이름을 입력해 주세요.");
		document.regFrm.name.focus( );
		return;
	}
	
	if(document.regFrm.email.value=="") {
		alert("이메일을 입력해 주세요.");
		document.regFrm.email.focus( );
		return;
	}
	
    var str=document.regFrm.email.value;
	// email 입력폼에 입력한 값을 얻는다.
	// 문자열.indexOf(str)는 문자열에서 지정한 문자열(str)의 인덱스 값을 반환한다.
	// 문자열.lastIndexOf(str)는 문자열에서 지정한 문자열(str)이 여러개 존재할 경우 마지막 문자열에 해당하는 인덱스 값을 반환한다.
    var atPos = str.indexOf('@'); // 문자열에서 @의 인덱스 값을 얻는다.
    var atLastPos = str.lastIndexOf('@'); // 문자열에서 @가 여러개 존재할 때 마지막 @의 인덱스 값을 얻는다.
    var dotPos = str.indexOf('.'); // 문자열에서 . 의 인덱스 값을 얻는다.
    var spacePos = str.indexOf(' '); // 문자열에서 공백의 인덱스 값을 얻는다.
    var commaPos = str.indexOf(','); // 문자열에서 , 의 인덱스 값을 얻는다.
    var eMailSize = str.length; // 문자열의 크기를 얻는다.
	/*
	※ 이메일 작성 형식에 대한 유효성 검증
	atPos > 1 는 @ 앞에 문자열이 있다.
	atPos == atLastPos 는 @을 한번만 사용했다.
	dotPos > 3 는 .(dot)이 @ 뒤에 위치하며, .(dot) 앞에 문자열이 있다.
	spacePos == -1 는 공백이 없다.
	commaPos == -1 는 , 가 없다.
	atPos + 1 < dotPos 는 @ 과 . 사이에 문자열이 있다.
	dotPos + 1 < eMailSize 는 . 뒤에 문자열이 있다.
	*/
    if (atPos > 1 && atPos == atLastPos && 
	   dotPos > 3 && spacePos == -1 && commaPos == -1 
	   && atPos + 1 < dotPos && dotPos + 1 < eMailSize);
    else {
          alert('E-mail주소 형식이 잘못되었습니다.\n\r다시 입력해 주세요!');
	      document.regFrm.email.focus( );
		  return;
    }
	
	document.regFrm.submit( );
}