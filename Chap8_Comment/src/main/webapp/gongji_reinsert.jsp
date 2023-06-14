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
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	String formatedNow = now.format(formatter);

	int rootid = Integer.parseInt(request.getParameter("rootid")); // rootid 받아옴
	int level = Integer.parseInt(request.getParameter("level")); // relevel 받아옴

	GongjiDao gongjiDao = new GongjiDaoImpl(); // DAO 객체 생성
	int cnt = Integer.parseInt(request.getParameter("recnt")); // recnt 받아옴

	int recnt = gongjiDao.getRecnt(rootid, level, cnt); // 모체의 레벨과 cnt
	%>
	<form method=get name='fm'>
		<table>
			<tr>
				<th><b>번호</b></th>
				<td>댓글(insert)<input type=hidden name=key value='INSERT'></td>
			</tr>
			<tr>
				<th><b>제목</b></th>
				<td><input type=text name=title size=70 maxlength=70></td>
			</tr>
			<tr>
				<th><b>일자</b></th>
				<td><%=formatedNow%></td>
				<input type=hidden name=date value='<%=formatedNow%>'>
			</tr>
			<tr>
				<th><b>내용</b></th>
				<td><textarea style='width: 500px; height: 250px;' name=content
						cols=70 row=600></textarea></td>
			</tr>
			<tr>
				<th><b>원글</b></th>
				<td><%=rootid%></td>
				<input type=hidden name=rootid value=<%=rootid%>>
			</tr>
			<tr>

				<th><b>댓글수준</b></th>

				<td><%=level + 1%><span style="float: right; margin-right: 50px;"> 
				댓글 내 순서: <%=recnt%>
					<input type=hidden name=relevel value=<%=level + 1%>>
					<input type=hidden name=recnt value=<%=recnt%>>
				</span></td>
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