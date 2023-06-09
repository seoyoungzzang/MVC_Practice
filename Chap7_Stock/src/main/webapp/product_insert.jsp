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
	function submitForm(mode) {
		fm.action = "product_write.jsp?key=INSERT";
		fm.submit();
	}

	function insertData() {
		const form = document.getElementById('inputForm1');
		const id = form.elements.id.value;
		const name = form.elements.name.value;
		const stockNum = form.elements.stockNum.value;
		const content = form.elements.content.value;
		const pattern1 = /^[a-zA-Z0-9\p{P}\p{S}가-힣\s]+$/u; // 한글 또는 영어만 입력 가능한 패턴1
		const pattern2 = /^(?:0|[1-9]\d{0,4}|100000)$/; // 0 이상의 정수만 입력 가능한 패턴2

		if (id.trim() === '' || name.trim() === '' || stockNum.trim() === ''
				|| content.trim() === '') {
			alert("데이터를 모두 입력해주세요.");
			return;
		}
		if (id < 100000 || id > 999999) {
		    alert("상품번호는 6자리 정수만 입력 가능합니다.");
		    return;
		}
		if (!pattern1.test(name)) { // 이름에 유효한 한글 또는 영어가 입력되지 않으면
			alert("상품명은 정확한 한글 또는 영어만 입력 가능합니다."); // 해당 메세지 출력
			return; // 함수 실행 종료
		}
		if (!pattern2.test(stockNum)) { // 점수가 0부터 100사이의 값이 아니면
			alert("재고 수량은 0 이상 100000 이하 정수만 입력 가능합니다."); // 해당 메세지 출력
			return; // 함수 실행 종료
		}
		if (confirm("상품을 등록하시겠습니까?")) { // 상품 등록 여부를 확인하는 알림창
			form.action = "product_write.jsp?key=INSERT";
			form.submit();
		}
	}
	function showPreview(event) {
	      var reader = new FileReader();
	      reader.onload = function() {
	        var imgElement = document.getElementById('preview');
	        imgElement.src = reader.result;
	      };
	      reader.readAsDataURL(event.target.files[0]);
	    }
</script>
</head>

<%
Date today = new Date();
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
String regDate = dateFormat.format(today);
String stockDate = dateFormat.format(today);
%>

<body>
	<div class="container">
		<h1>(주)서영 재고 현황 - 상품 등록</h1>
		<form method="post" name="fm" id="inputForm1" enctype="multipart/form-data">
			<table>
				<tr>
					<th>상품번호</th>
					<td><input type="text" name="id"></td>
				</tr>
				<tr>
					<th>상품명</th>
					<td><input type="text" name="name" size="70" maxlength="70"></td>
				</tr>
				<tr>
					<th>재고현황</th>
					<td><input type="number" name="stockNum" size="10"></td>
				</tr>
				<tr>
					<th>상품등록일</th>
					<td><%=regDate%></td>
				</tr>
				<tr>
					<th>재고등록일</th>
					<td><%=stockDate%></td>
				</tr>
				<tr>
					<th>상품설명</th>
					<td><textarea name="content" cols="70" rows="600"></textarea></td>
				</tr>
				<tr>
					<th>상품사진</th>
					<td><input type="file" name="image"
						onchange="showPreview(event)"> <img id="preview" src="#"
						alt="" style="max-width: 300px;"></td>
				</tr>

				<tr>
					<td colspan="2" class="button-container">
						<button type="button" onclick="location.href='stock_list.jsp'">취소</button>
						<button type="button" onclick="insertData()">추가완료</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>

</html>
