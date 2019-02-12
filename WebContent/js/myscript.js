/* myscript.js */

function bbsCheck(f) {
	// 작성자, 제목, 내용, 비번 글자갯수 확인
	// 1) 작성자
	var wname = f.wname.value;
	wname = wname.trim();
	if (wname.length == 0) {
		alert("작성자 입력해주세요");
		f.wname.focus();
		return false;
	}

	// 2) 제목
	var subject = f.subject.value;
	subject = subject.trim();
	if (subject.length == 0) {
		alert("제목을 입력해주세요");
		f.subject.focus();
		return false;
	}

	// 3) 내용
	var content = f.content.value;
	content = content.trim();
	if (content.length == 0) {
		alert("내용을 입력해주세요");
		f.content.focus();
		return false;
	}
	// 4) 비번
	var passwd = f.passwd.value;
	passwd = passwd.trim();
	if (passwd.length < 4) {
		alert("비밀번호는 4글자 이상 입력해주세요");
		f.passwd.focus();
		return false;
	}
	return true;

}// bbsCheck() end

function pwCheck(f) {
	var passwd = f.passwd.value;
	passwd = passwd.trim();
	if (passwd.length < 4) {
		alert("비밀번호는 4글자 이상 입력해주세요");
		f.passwd.focus();
		return false;
	}

	var msg = "삭제하시겠습니까?";
	if (confirm(msg)) {
		return true;
	} else {
		return false;
	}
}// pwCheck end

function upCheck(f) {
	var passwd = f.passwd.value;
	passwd = passwd.trim();
	if (passwd.length < 4) {
		alert("비밀번호는 4글자 이상 입력해주세요");
		f.passwd.focus();
		return false;
	}

	var msg = "수정하시겠습니까?";
	if (confirm(msg)) {
		return true;
	} else {
		return false;
	}
}// pwCheck end

function searchCheck() {
	var word = f.word.value;
	word = word.trim();
	if (word.length == 0) {
		alert("검색어를 입력하세요");
		return false;
	}
	return true;
}// searchCheck end

function idCheck() {
	// 아이디 중복확인

	// 새창 만들기
	// window.open("파일명", "창이름", "옵션");
	window.open("idCheckForm.jsp", "idwin", "width=400, height=350");

	// 새창이 출력되는 위치지정
	var sx = parseInt(screen.width);
	var sy = parseInt(screen.heith);
	var x = (sx / 2) + 50;
	var y = (sy / 2) - 25;

	// 화면이동
	win.moveTo(x, y);

}// idCheck end

function emailCheck() {
	// 이메일 중복확인

	// 새창 만들기
	// window.open("파일명", "창이름", "옵션");
	window.open("emailCheckForm.jsp", "emailwin", "width=400, height=350");

	// 새창이 출력되는 위치지정
	var sx = parseInt(screen.width);
	var sy = parseInt(screen.heith);
	var x = (sx / 2) + 50;
	var y = (sy / 2) - 25;

	// 화면이동
	win.moveTo(x, y);

}// emailCheck end

function memberCheck(f) {
	// 회원가입 유효성 검사
	var r1 = /^[A-Za-z0-9]{5,10}$/; // 아이디 영문, 숫자만 체크
	var r2 = /^.*(?=^.{5,10}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/; // 비밀번호
	var r3 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일
	// 정규식

	// 1) 아이디 5~10글자 이내
	var id = $("input[id='id']").val();
	if (id.match(r1) == null) {
		alert("아이디는 5~10자의 영문과 숫자로만 입력해주세요");
		return false;
	}
	// 2) 비밀번호 5~10글자 이내 특수문자 포함
	var passwd = $("input[id='passwd']").val();
	if (passwd.match(r2) == null) {
		alert("비밀번호는 영문, 숫자, 특수문자를 포함하여 5~10글자 이내로 입력해주세요");
		return false;
	}

	// 5) 비번과 비번확인이 서로 일치하는지?
	var repasswd = f.repasswd.value;
	repasswd = repasswd.trim();
	if (repasswd != passwd) {
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}

	// 6) 이름 2~20글자 이내
	var mname = f.mname.value;
	mname = mname.trim();
	if (mname == 0) {
		alert("이름을 입력해주세요");
		return false;
	}

	if (mname.length < 2 || mname.length > 20) {
		alert("이름은 2~20글자 이내로 입력해주세요");
		return false;
	}

	// 7) 이메일에 @문자 있는지
	var email = $("input[id='email']").val();
	if (email.match(r3) == null) {
		alert("이메일 형식이 맞지 않습니다.");
		return false;
	}

	// 8) 직업을 선택했는지?
	var job = f.job.value;
	if (job == "0") {
		alert("직업을 선택해주세요");
		return false;
	}// if end

	return true; // 유효성 검사를 통과했으므로
	// memberProc.jsp로 전송

}// memberCheck end

function loginCheck(f) {
	// 로그인 유효성 검사
	// 1) 아이디 5~10글자 이내
	var id = f.id.value;
	id = id.trim();
	if (id.length == 0) {
		alert("아이디를 입력해주세요");
		return false;
	}// if end
	// 2) 비밀번호 5~10글자 이내 특수문자 포함
	var passwd = f.passwd.value;
	passwd = passwd.trim();
	if (passwd.length == 0) {
		alert("비밀번호를 입력해주세요.");
		return false;
	}// if end
	return true;
	
}// logincheck end

function pdsCheck(f) {
	//포토갤러리 유효성 검사
	//1) 이름
	
	//2) 제목
	
	//3) 비밀번호
	
	//4) 첨부파일
	//문) 첨부한 파일의 확장명을 출력하시오
	var filename = f.filename.value;
	filename = filename.trim();
	if (filename.length <5) {
		alert("첨부 파일을 선택하세요");
		return false;
	}// if end
	//alert(filename);
	//alert(filename.lastIndexOf("."));
	//alert(filename.substr(filename.lastIndexOf(".")));
	var ext = filename.substr(filename.lastIndexOf(".")+1);
	ext = ext.toLowerCase(); //전부 소문자
	if(!(ext=="png" || ext=="jpg" || ext=="gif")){
		alert("이미지 파일만 가능합니다");
		return false;
	}//if end
	return true;
}//pdsCheck end

	