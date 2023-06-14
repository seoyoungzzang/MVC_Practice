<%@page import="dao.GongjiDaoImpl"%>
<%@page import="dao.GongjiDao"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@ page contentType="text/html; charset=utf-8" language="java"%>

<html>

<head>
<style>
table {
	border-collapse: collapse;
	width: 650px;
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
<script>
	// 스크립트 작성 시작
	function submitForm() { // 제출 버튼 눌렀을 때 호출되는 함수

		const title = fm.elements.title.value; // 제목 불러옴
		const content = fm.elements.content.value; // 본문 내용 불러옴

		let str = ""; // 오류 안내문 담을 string 변수

		if (title.trim() == "" || content.trim() == "" // 제목과 본문이 비었을 경우
				|| title.length > 200 // 제목 길이가 200자를 넘길 경우
				|| content.length > 10000) { // 본문 길이가 1000자를 넘길 경우
			if (title.trim() == "" || content.trim() == "") { // 공백이 있을 경우
				str = str + "데이터를 모두 입력해주세요.\n"; // 안내문 추가
			}
			if (title.length > 200) { // 제목 길이가 200자를 넘길 경우
				str = str + "제목은 200자 이하만 입력 가능합니다.\n"; // 안내문 추가
			}
			alert(str); // 안내문 출력
		} else { // 에러 발생하지 않았을 경우
			var result = confirm('해당 글을 게시하시겠습니까?'); // 게시할 것인지 물어봄

			if (result) { // 게시를 선택한 경우
				fm.action = "gongji_write.jsp"; // 폼 경로 설정
				fm.submit(); // 폼 제출
			}
		}
	}
</script>
</head>

<body>
	<%
	LocalDate now = LocalDate.now();
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd"); // 날짜 포맷 정의
	String formatedNow = now.format(formatter); // 날짜 포맷 적용
	%>
	<form method=post name='fm'>
		<table>
			<tr>
				<th><b>번호</b></th>
				<td>신규(insert)<input type=hidden name=key value='INSERT'></td>
			</tr>
			<tr>
				<th><b>제목</b></th>
				<td><input type=text name=title size=70 maxlength=200></td>
			</tr>
			<tr>
				<th><b>일자</b></th>
				<td><%=formatedNow%></td>
				<input type=hidden name=date value='<%=formatedNow%>'>

			</tr>
			<tr>
				<th><b>내용</b></th>
				<td><textarea style='width: 500px; height: 250px;' name=content cols=70 row=600></textarea></td>
				<%
				GongjiDao gongjiDao = new GongjiDaoImpl(); // DAO 객체 생성
				int rootid = gongjiDao.getNewId(); // rootid 받아오기
				int recnt = 0; // recnt 지정
				%>
				<input type=hidden name=rootid value='<%=rootid%>'>
				<input type=hidden name=relevel value='<%=0%>'>
				<input type=hidden name=recnt value='<%=recnt%>'>
			</tr>
		</table>

		<table width=600>
			<tr>
				<td colspan="2" class="button-container">
					<button type="button" onclick="history.back()">취소</button> <!-- 취소 버튼  -->
					<button type="button" onclick="submitForm()">저장</button> <!-- 쓰기 버튼 -->
				</td>
			</tr>
		</table>
	</form>
</body>

</html>