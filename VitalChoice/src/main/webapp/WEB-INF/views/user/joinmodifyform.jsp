<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

  <script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="//code.jauery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <meta charset="UTF-8">
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <script type="text/javascript">
        function sample6_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수
                    var extraAddr = ''; // 참고항목 변수

                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if (data.userSelectedType === 'R') {
                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                        if (data.bname !== '' &&
                            /[동|로|가]$/g.test(data.bname)) {
                            extraAddr += data.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if (data.buildingName !== '' &&
                            data.apartment === 'Y') {
                            extraAddr += (extraAddr !== '' ? ', ' +
                                data.buildingName :
                                data.buildingName);
                        }
                        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if (extraAddr !== '') {
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        // 조합된 참고항목을 해당 필드에 넣는다.
                        document.getElementById("user_address4").value = extraAddr;

                    } else {
                        document.getElementById("user_address4").value = '';
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('user_address1').value = data.zonecode;
                    document.getElementById('user_address2').value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById('user_address3').focus();

                }
            }).open();
        }
    </script>
    <script type="text/javascript">
    $(function() {
        $("#check").click(function() {
            //패스워드 입력
            
            
            var pw = $("#user_pwd").val();
            var vpw = /^[a-zA-Z0-9?=.*\W]{8,15}$/;
            if (pw == "") {
                alert("비밀번호 항목은 필수 입력값입니다.");
                $("#user_pwd").focus();
                return;
            }
           
            if (!vpw.test(pw)) {
                alert("비밀번호는 띄어쓰기 없는 8~15자의 영문 대/소문자, 숫자 또는 특수문자 조합으로 입력하셔야 합니다.");
                $("#user_pwd").focus();
                return;
            }
            //패스워드 재확인
            var pw2 = $("#user_pwd2").val();
            var vpw2 = /^[a-zA-Z0-9?=.*\W]{8,15}$/;
            if (pw2 == "") {
                alert("비밀번호를 입력하세요.");
                $("#user_pwd2").focus();
                return;
            }
            if (!vpw.test(pw2)) {
                alert("비밀번호는 띄어쓰기 없는 8~15자의 영문 대/소문자, 숫자 또는 특수문자 조합으로 입력하셔야 합니다.");
                $("#user_pwd2").focus();
                return;
            }
            if (pw != pw2) {
                alert("비밀번호가 다르니 다시 입력하세요");
                $("#user_pwd").val('');
                $("#user_pwd2").val('');
                $("#user_pwd").focus();
                return;
            }
     
            //주소입력
            var address = $("#user_address3").val();
            if (address == "") {
                alert("상세주소를 입력해주세요.");
                $("#user_address3").focus();
                return;
            }
            

            $("#form1").submit();
        });
});
    
    
    </script>
 
<title>Insert title here</title>
</head>
<body>
<h3 align="center">회원정보</h3>
	<form action="joinmodifysave" method="post" id="form1" name="form1" >
		<table border="1" align="center">
			<tr>
			

				<th>아이디</th>
	     <td><input type="text" name="user_id" id="user_id" value="${dto1.user_id}"  readonly style="background:#EBEBE4"  >
	     </td>	        
			</tr>
			<tr>
				<th>비밀번호</th>

				 <td><input type="password" name="user_pwd" id="user_pwd"   placeholder="띄어쓰기 없이8~15 영문대/소문자 또는 특수문자" maxlength="15" >
			        </td>
			</tr>
			<tr>
                <th>비밀번호 재확인</th>
                <td><input type="password" name="user_pwd2" id="user_pwd2" placeholder="비밀번호 재확인" maxlength="15" ></td>
            </tr>
		
            <tr>
                <th>이름</th>
                <td><input type="text" name="user_name" id="user_name" placeholder="이름을 입력하세요." maxlength="8" value="${dto1.user_name}" readonly   style="background:#EBEBE4" ></td>
            </tr>
		
            <tr>
                <th>전화번호</th>
                <td><input type="text" name="user_phone" id="user_phone" placeholder=" -없이 숫자만입력" maxlength="11" value="${dto1.user_phone}"></td>
            </tr>
              <tr>
                <th>주소</th>
                <td><input type="text" name="user_address1" id="user_address1" placeholder="우편번호" readonly value="${dto1.user_address1}" style="background:#EBEBE4" >
                    <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"> <br>
                    <input type="text" name="user_address2" id="user_address2" placeholder="주소 " readonly  value="${dto1.user_address2}" style="background:#EBEBE4" > 
                    <input type="text" name="user_address3" id="user_address3" placeholder="상세주소 " value="${dto1.user_address3}" > <br>
                    <input type="text" name="user_address4" id="user_address4" placeholder="참고항목 " readonly value=""  style="background:#EBEBE4" ></td>
            </tr>

              <tr class="email">
                <th>
                    <label for="useremail">이메일</label>
                </th>
                <td>

                    <input id="user_email" type="text" name="user_email" placeholder="이메일 주소를 입력해주세요." value="${dto1.user_email}" readonly style="background:#EBEBE4">
            
                </td>
            </tr>
            
             <tr>
                <th>생년월일</th>
                <td><input type="text" name="user_birthday" id="user_birthday" placeholder="ex) 19990415" maxlength="8" value="${dto1.user_birthday}" readonly style="background:#EBEBE4"></td>
            </tr>
            
               <tr>
                <th>성별</th>
                <td><input type="radio" name="user_gender" id="user_gender" value="남자"  checked="${dto1.user_gender}" >남자
                    <input type="radio" name="user_gender" id="user_gender" value="여자"  >여자
                    <input type="radio" name="user_gender" id="user_gender" value="선택안함" >선택안함
                </td>
            </tr>
            
            <tr>
                <th>닉네임</th>
                <td><input type="text" name="user_nickname" id="user_nickname" placeholder="닉네임을 입력하세요." maxlength="10" value="${dto1.user_nickname}" readonly  style="background:#EBEBE4"></td>
            </tr>
             <tr>
                <th>이메일 수신여부</th>
                <td><input type="radio" name="email_check" id="email_check" value="Y" checked="${dto1.email_check}" >수신
                    <input type="radio" name="email_check" id="email_check" value="N" >비수신

                </td>
            </tr>
			<tr>
				<td colspan="2" align="center">
				        <button type="button" id="check">수정</button>
					<input type="reset" value="초기화">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>