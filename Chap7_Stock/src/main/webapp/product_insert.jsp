<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<html>

<head>
<style>
body {
	background: #FFFF9;
	font-family: Arial, sans-serif;
}

.container {
	max-width: 800px;
	margin: 0 auto;
	padding: 20px;
}

table {
	border-collapse: collapse;
	width: 800px;
	margin: 20px auto;
	background: #fff;
	border: 1px solid #ddd; /* Update border color to a lighter shade */
}

th {
	background: #FFCD28;
	color: #fff;
	padding: 5px;
}

td {
	padding: 5px;
	border: 1px solid #ddd; /* Update border color to a lighter shade */
}

tr:nth-child(even) {
	background-color: #FDF5E6;
}

button {
	float: right;
	background-color: #FF9100;
	color: #fff;
	border: none;
	border-radius: 10px;
	padding: 8px 16px;
	cursor: pointer;
	font-size: 14px;
	font-weight: bold;
}

.button-container {
	text-align: right;
	margin-top: 20px;
}

textarea {
	width: 500px;
	height: 250px;
}
</style>
<script language="JavaScript">
	function submitForm(mode) { // mode 인자로 받아 submitForm 함수 정의
		fm.action = "product_write.jsp?key=INSERT"; // 폼의 action 속성을 설정하여 product_write.jsp 페이지로 이동 쿼리 문자열에 key=INSERT를 추가
		fm.submit(); // form 제출
	}

	function insertData() { // 예외처리 함수 정의
		const form = document.getElementById('inputForm1'); // ID가 inputForm1인 폼 엘리먼트를 가져옴
		const id = form.elements.id.value; // id 입력 필드 값 가져옴
		const name = form.elements.name.value; // name 입력 필드 값 가져옴
		const stockNum = form.elements.stockNum.value; // stockNum 입력 필드 값 가져옴
		const content = form.elements.content.value; // content 입력 필드 값 가져옴
		const pattern1 = /^[a-zA-Z0-9\p{P}\p{S}가-힣\s]+$/u; // 한글 또는 영어만 입력 가능한 패턴1
		const pattern2 = /^(?:0|[1-9]\d{0,4}|100000)$/; // 0 이상의 정수만 입력 가능한 패턴2
		const pattern3 = /^[a-zA-Z0-9]*$/; // 알파벳과 숫자만 입력가능한 패턴3
		
		if (id.trim() === '' || name.trim() === '' || stockNum.trim() === '' || content.trim() === '') { // 상품번호, 상품명, 재고수, 상품 내용에 공백이 입력되면
			alert("데이터를 모두 입력해주세요."); // 해당 메세지 출력
			return; // 함수 실행 종료
		}
		if (id.length > 20) { // 상품번호에 20자리 이상 정수가 입력되면
		    alert("상품번호는 20자리 이하만 영문/숫자만 입력 가능합니다."); // 해당 메세지 출력
		    return; // 함수 실행 종료
		}
		if (!pattern3.test(id)) { // 이름에 유효한 한글 또는 영어가 입력되지 않으면
			alert("상품번호는 20자리 이하만 영문/숫자만 입력 가능합니다."); // 해당 메세지 출력
			return; // 함수 실행 종료
		}
		if (!pattern1.test(name)) { // 이름에 유효한 한글 또는 영어가 입력되지 않으면
			alert("상품명은 정확한 한글 또는 영어만 입력 가능합니다."); // 해당 메세지 출력
			return; // 함수 실행 종료
		}
		if (!pattern2.test(stockNum)) { // 재고수량이 0부터 100000사이의 값이 아니면
			alert("재고 수량은 0 이상 100000 이하 정수만 입력 가능합니다."); // 해당 메세지 출력
			return; // 함수 실행 종료
		}
		if (confirm("상품을 등록하시겠습니까?")) { // 상품 등록 여부를 확인하는 알림창
			form.action = "product_write.jsp?key=INSERT"; // 확인 누르면 입력 실행 페이지로 이동
			form.submit(); // form 제출
		}
	}
	function showPreview(event) { // event를 매개변수로 받는 함수 선언
		var file = event.target.files[0]; // 선택한 파일 객체를 가져옵니다.
        var fileName = file.name; // 파일의 이름을 가져옵니다.
        var fileExtension = fileName.split('.').pop().toLowerCase(); // 파일의 확장자를 가져옵니다.
        
        var allowedExtensions = ['jpg', 'jpeg', 'png', 'gif']; // 허용할 이미지 파일 확장자 목록       
        
        if (!allowedExtensions.includes(fileExtension)) { // 허용된 확장자인지 확인
            alert('이미지 파일만 업로드할 수 있습니다.'); // 해당 메세지 출력
            event.target.value = ''; // 파일 선택 창 초기화
            return; // 함수 실행 종료
        }
	      var reader = new FileReader(); // FileReader 객체 생성 (파일 내용 읽음)
	      reader.onload = function() { // 이벤트 핸들러 정의 (파일 읽기 완료시 실행)
	        var imgElement = document.getElementById('preview'); // preview id를 가진 이미지 엘리먼트 가져옴
	        imgElement.src = reader.result; // 파일 내용 읽어온 후 이미지엘리먼트 src에 설정
	      };
	      reader.readAsDataURL(event.target.files[0]); // 선택한 파일을 data url 형식으로 읽어옴
	    }
</script>
</head>

<%
Date today = new Date(); // 현재 날짜와 시간을 가져오는 Date 객체 생성
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 포맷을 지정하기 위한 SimpleDateFormat 객체 생성
String regDate = dateFormat.format(today); // 현재 날짜를 "yyyy-MM-dd" 형식으로 변환하여 문자열로 저장
String stockDate = dateFormat.format(today); // 현재 날짜를 "yyyy-MM-dd" 형식으로 변환하여 문자열로 저장
%>

<body>
	<div class="container">
		<h1>(주)서영 재고 현황 - 상품 등록</h1> <!-- h1 입력 -->
		<form method="post" name="fm" id="inputForm1" enctype="multipart/form-data"> <!-- post 형식 id를 inputForm1, enctype을 multipart/form-data으로 설정-->
			<table>
				<tr>
					<th>상품번호</th> <!-- 첫번째 열 입력 -->
					<td><input type="text" name="id"></td> <!-- 두번째 열 입력 -->
				</tr>
				<tr>
					<th>상품명</th> <!-- 첫번째 열 입력 -->
					<td><input type="text" name="name" size="70" maxlength="70"></td> <!-- 두번째 열 입력 -->
				</tr>
				<tr>
					<th>재고현황</th> <!-- 첫번째 열 입력 -->
					<td><input type="number" name="stockNum" size="10"></td> <!-- 두번째 열 입력 -->
				</tr>
				<tr>
					<th>상품등록일</th> <!-- 첫번째 열 입력 -->
					<td><%=regDate%></td> <!-- 상품등록일 가져오기 -->
				</tr>
				<tr>
					<th>재고등록일</th> <!-- 첫번째 열 입력 -->
					<td><%=stockDate%></td> <!-- 재고등록일 가져오기 -->
				</tr>
				<tr>
					<th>상품설명</th> <!-- 첫번째 열 입력 -->
					<td><textarea name="content" cols="70" rows="600" style="resize: none; overflow: auto;"></textarea></td> <!-- 두번째 열 입력 -->
				</tr>
				<tr>
					<th>상품사진</th> <!-- 첫번째 열 입력 -->
					<td><input type="file" name="image" onchange="showPreview(event)"> <!-- 파일 선택 버튼 -->
					<br>
					<img id="preview" src="#" alt="" style="max-width: 300px;"></td> <!-- 상품 이미지 출력 -->
				</tr>

				<tr>
					<td colspan="2" class="button-container">
						<button type="button" onclick="history.back()">취소</button> <!-- 버튼 누르면 목록 페이지로 이동 -->
						<button type="button" onclick="insertData()">추가완료</button> <!-- 버튼 누르면 write 페이지로 이동 -->
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>

</html>
