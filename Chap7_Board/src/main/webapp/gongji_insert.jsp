<%@page import="domain.Gongji"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<html>

<head>
<style>
table {
	border-collapse: collapse;
	width: 100%;
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

.container {
	max-width: 800px;
	margin: 0 auto;
	padding: 20px;
}
</style>
<script language="JavaScript">
	function submitForm(mode) { // 페이지 이동 함수 선언
		fm.action = "gongji_write.jsp?key=INSERT"; // INSERT 키 받아서 write 페이지로
		fm.submit(); // 해당 페이지로 이동
	}

	function insertGongji() { // 예외처리 함수 선언
		const form = document.getElementById('inputForm1'); // id가 inputForm1인 요소 가져오기
		const title = form.elements.title.value; // 제목 필드 값 가져오기
		const content = form.elements.content.value; // 내용 필드 값 가져오기

		if (title.trim() === '' || content.trim() === '') { // 입력창이 비어있으면
			alert("데이터를 모두 입력해주세요."); // 해당 메세지 출력
			return; // 함수 실행 종료
		}

		if (title.length > 200) { // 이름이 20자 이상이면
			alert("제목은 200자 이하만 입력 가능합니다."); // 해당 메세지 출력
			return; // 함수 실행 종료
		}

		form.action = "gongji_write.jsp?key=INSERT"; // form의 action 속성 설정
		form.submit(); // form 요소 제출
	}
</script>
</head>

<%
Date today = new Date(); // 현재 날짜와 시간을 가져오는 Date 객체 생성
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 포맷을 지정하기 위한 SimpleDateFormat 객체 생성
String date = dateFormat.format(today); // 현재 날짜를 "yyyy-MM-dd" 형식으로 변환하여 문자열로 저장
%>
<body>
	<div class="container">
		<h1>게시글 신규 등록</h1> <!-- h1 입력 -->
		<form method="post" name="fm" id="inputForm1"> <!-- post 형식 id를 inputForm1로 설정-->
			<table>
				<tr>
					<th>번호</th> <!-- th 입력 -->
					<td>신규(insert)<input type="hidden" name="id" value="INSERT"></td> <!-- 두번째 열 입력 -->
				</tr>
				<tr>
					<th>제목</th> <!-- th 입력 -->
					<td><input type="text" name="title" size="70"></td> <!-- 두번째 열 입력 -->
				</tr>
				<tr>
					<th>일자</th> <!-- th 입력 -->
					<td><%=date%></td> <!-- 두번째 열 date 출력 -->
				</tr>
				<tr>
					<th>내용</th> <!-- th 입력 -->
					<td><textarea name="content" cols="70" rows="600" style="resize: none; overflow: auto;"></textarea></td> <!-- 두번째 열 입력 -->
				</tr>
				<tr>
					<td colspan="2" class="button-container">
						<button type="button" onclick="history.back()">취소</button> <!-- 취소 버튼  -->
						<button type="button" onclick="insertGongji()">쓰기</button> <!-- 쓰기 버튼 -->
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>

</html>
