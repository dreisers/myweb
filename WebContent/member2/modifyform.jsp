<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- 본문 시작 memberForm.jsp-->
* 회/원/정/보/수/정 *<br><br>
<c:choose>
<c:when test="${dto==null }">
비밀번호 틀림<br>
<a href='javascript:history.back();'>[다시시도]</a>
</c:when>
<c:otherwise>
<form name="regForm" method="post" action="modifyPro.do" onsubmit="return memberCheck(this)">
<input type="hidden" name="id" value="${id }">
<span style="text-align:right; color:red; font-weight:bold">* 필수입력</span>
<br>
<table class="membertable">


<tr>
	<th class="th1"> 아이디</th>
	<td>${id }</td>
</tr>
<tr>
	<th class="th1">* 변경 비밀번호</th>
	<td class="td1"><input type="password" name="passwd" id="passwd" size="10" class="membertext">* 영어/숫자/특수문자 포함 5~10글자 이내</td>
</tr>
<tr>
	<th class="th1">* 변경 비밀번호 확인</th>
	<td class="td1"><input type="password" name="repasswd" id="repasswd" size="10" class="membertext"></td>
</tr>
<tr>
	<th class="th1">* 이름</th>
	<td class="td1"><input type="text" name="mname" id="mname" size="10" value="${dto.mname }" required class="membertext"></td>
</tr>
<tr>
	<th class="th1">* 이메일</th>
	<td class="td1">
      <input type="text" name="email" id="email" size="20" value="${dto.email }" readonly class="membertext">
      <input type="button" value="Email 중복확인" onclick="emailCheck()" class="button1">	
	</td>
</tr>
<tr>
	<th class="th1">* 전화번호</th>
	<td class="td1"><input type="text" name="tel" id="tel" size="13" value="${dto.tel }" required class="membertext"></td>
</tr>
<tr>
	<th class="th2">우편번호</th>
	<td class="td1">
      <input type="text" name="zipcode" id="zipcode" size="7" value="${dto.zipcode }" readonly class="membertext">
      <input type="button" value="주소찾기"  onclick="DaumPostcode()" class="button1">	
	</td>
</tr>
<tr>  
  <th class="th2">주소</th>
  <td class="td1"><input type="text" name="address1" id="address1" size="25" value="${dto.address1 }" readonly class="membertext"></td>
</tr>
<tr>  
  <th class="th2">나머지주소</th>
  <td class="td1"><input type="text" name="address2" id="address2" size="30" value="${dto.address2 }" class="membertext"></td>
</tr>
<tr>  
  <th class="th2">직업</th>
  <td class="td1"><select name="job"  id="job" class="membertext">
          <option value="0">선택하세요.</option>
          <option value="A01" <c:if test="${dto.job=='A01'}"> selected </c:if>>회사원</option>
          <option value="A02" <c:if test="${dto.job=='A02'}"> selected </c:if>>전산관련직</option>
		  <option value="A03" <c:if test="${dto.job=='A03'}"> selected </c:if>>학생</option>
		  <option value="A04" <c:if test="${dto.job=='A04'}"> selected </c:if>>주부</option>
		  <option value="A05" <c:if test="${dto.job=='A05'}"> selected </c:if>>기타</option>
        </select>
  </td>
</tr>




<tr>
	<td colspan="2" style="text-align:center">
		<input type="submit" value="수정완료" class="button2">
		<input type="button" class="button2" value="취소" onclick="javascript:history.back();">
	</td>
</tr>
</table>

<!-- ----- DAUM 우편번호 API 시작 ----- -->
<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 110px;position:relative">
  <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function DaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('address1').value = fullAddr;

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
                
                $('#address2').focus();
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
    
</script>
<!-- ----- DAUM 우편번호 API 종료----- -->

</form>
</c:otherwise>
</c:choose>

<script>

	function emailCheck() {
		// 이메일 중복확인

		// 새창 만들기
		// window.open("파일명", "창이름", "옵션");
		window.open("emailcheckForm.do", "emailwin", "width=400, height=350");

		// 새창이 출력되는 위치지정
		var sx = parseInt(screen.width);
		var sy = parseInt(screen.heith);
		var x = (sx / 2) + 50;
		var y = (sy / 2) - 25;

		// 화면이동
		win.moveTo(x, y);

	}// emailCheck end
</script>


<!-- 본문 끝 -->			
<%@ include file="../footer.jsp"%>