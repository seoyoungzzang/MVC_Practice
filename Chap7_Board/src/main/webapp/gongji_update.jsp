<%@page import="domain.Gongji"%>
<%@page import="dao.GongjiDaoImpl"%>
<%@page import="dao.GongjiDao"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*"%>
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
<%
int id = Integer.parseInt(request.getParameter("key")); // id 받아서 정수 변환

GongjiDao gongjiDao = new GongjiDaoImpl(); // 객체 생성
Gongji gongji = new Gongji(); // 객체 생성

int c = gongjiDao.currentPage(id, 10); // currentPage 메소드 호출해서 c에 저장

gongji = gongjiDao.selectOne(id); // selectOne 메소드 호출
%>
<script language="JavaScript">
	function submitForm(mode) { // 버튼 종류에 따라 넘어가는 페이지 달라지는 메소드
		const form = document.getElementById('inputForm1'); // id가 inputForm1인 요소 가져오기
		const title = form.elements.title.value; // 제목 필드 값 가져오기
		const content = form.elements.content.value; // 내용 필드 값 가져오기

		if (mode === "write") { // mode가 write면
			if (title.trim() === '' || content.trim() === '') { // 입력창이 비어있으면
				alert("데이터를 모두 입력해주세요."); // 해당 메세지 출력
				return; // 함수 실행 종료
			} 
			if (title.length > 200) { // 제목이 200자 이상이면
				alert("제목은 200자 이하만 입력 가능합니다."); // 해당 메세지 출력
				return; // 함수 실행 종료
			}
			form.action = "gongji_write.jsp?key=UPDATE"; // UPDATE 키 값으로 받아 페이지 이동
		} else if (mode === "delete") { // mode가 delete면
			var confirmDelete = confirm("정말 삭제하시겠습니까?"); // 해당 메세지 출력
			if (confirmDelete) { // '예'를 선택한 경우의 동작
				form.action = "gongji_delete.jsp?key=<%=id%>";
			} else { // '아니오'를 선택한 경우의 동작
				return; // 함수 실행 종료
			}
		} // id 키 값으로 받아 페이지 이동
		form.submit(); // form 제출
	}
</script>
</head>

<body>
	<div class="container">
		<h1>게시글 수정</h1> <!-- h1 입력 -->
		<form method="post" name="fm" id="inputForm1"> <!-- post 형식 id를 inputForm1로 설정-->
			<table>
				<tr>
					<th>번호</th> <!-- th 입력 -->
					<td><input type="text" name="id" size="70" value="<%=id%>" readonly></td> <!-- 두번째 열 입력 -->
				</tr>
				<tr>
					<th>제목</th> <!-- th 입력 -->
					<td><input type="text" name="title" size="70" value="<%=gongji.getTitle()%>"></td> <!-- 두번째 열 입력 -->
				</tr>
				<tr>
					<th>일자</th> <!-- th 입력 -->
					<td><%=gongji.getDate()%></td> <!-- 두번째 열 입력 -->
				</tr>
				<tr>
					<th>내용</th> <!-- th 입력 -->
					<td><textarea name="content" cols="70" rows="10" style="resize: none; overflow: auto;"><%=gongji.getContent()%></textarea></td> <!-- 두번째 열 입력 -->
				</tr>
				<tr>
					<td colspan="2" class="button-container">
						<button type="button" onclick="location.href='gongji_list.jsp?page=<%=c%>'">취소</button> <!-- list 페이지로 이동 -->
						<button type="button" onclick="submitForm('write')">수정</button> <!-- 수정 파일로 이동 -->
						<button type="button" onclick="submitForm('delete')">삭제</button> <!-- 삭제 파일로 이동 -->
					</td>
				</tr>
				<input type="hidden" name="key" value="UPDATE"> <!-- 숨겨진 UPDATE 키 -->
			</table>
		</form>
	</div>
</body>

</html>

