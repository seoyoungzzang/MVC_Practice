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
<%
int id = Integer.parseInt(request.getParameter("key")); // id 받아서 정수 변환

GongjiDao gongjiDao = new GongjiDaoImpl(); // 객체 생성
Gongji gongji = new Gongji(); // 객체 생성

gongji = gongjiDao.selectOne(id); // selectOne 메소드 호출
int rootid = gongji.getRootid();
int relevel = gongji.getRelevel();
int recnt = gongji.getRecnt();
%>
<script language="JavaScript">
	function submitForm(mode) { // 버튼 종류에 따라 넘어가는 페이지 달라지는 메소드
		const form = document.getElementById('inputForm1'); // id가 inputForm1인 요소 가져오기
		const title = form.elements.title.value; // 제목 필드 값 가져오기
		const content = form.elements.content.value; // 내용 필드 값 가져오기

		if (mode == "write") { // mode가 write면
			if (title.trim() === '' || content.trim() === '') { // 입력창이 비어있으면
				alert("데이터를 모두 입력해주세요."); // 해당 메세지 출력
				return; // 함수 실행 종료
			} 
			if (title.length > 50) { // 이름이 20자 이상이면
				alert("제목은 50자 이하만 입력 가능합니다."); // 해당 메세지 출력
				return; // 함수 실행 종료
			}
	        if (content.length > 10000) { // 이름이 20자 이상이면
	            alert("내용은 10,000자 이하만 입력 가능합니다."); // 해당 메세지 출력
	            return; // 함수 실행 종료
	        } 
			fm.action = "gongjiDaetgeul_write.jsp?key=UPDATE"; // UPDATE 키 값으로 받아 페이지 이동
		} else if (mode == "delete") { // mode가 delete면
			fm.action = "gongjiDaetgeul_delete.jsp?key=<%=id%>"; 
		} // id 키 값으로 받아 페이지 이동
		form.submit(); // form 제출
	}
</script>
</head>

<body>
	<form method="post" name="fm" id="inputForm1"> <!-- post 형식 id를 inputForm1로 설정-->
		<table>
			<tr>
				<th>번호</th>
				<td><input type="text" name="id" size="70" value="<%=id%>"
					readonly></td> <!-- 두번째 열 입력 -->
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" size="70" maxlength="70"
					value="<%=gongji.getTitle()%>"></td> <!-- 두번째 열 입력 -->
			</tr>
			<tr>
				<th>일자</th>
				<td><%=gongji.getDate()%></td> <!-- 두번째 열 입력 -->
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content" cols="70" rows="600"><%=gongji.getContent()%></textarea></td> <!-- 두번째 열 입력 -->
			</tr>
			<tr>
				<td colspan="2" class="button-container">
					<button type="button" onclick="location.href='gongjiDaetgeul_list.jsp'">취소</button> <!-- list 페이지로 이동 -->
					<button type="button" onclick="submitForm('write')">수정</button> <!-- 수정 파일로 이동 -->
					<button type="button" onclick="submitForm('delete')">삭제</button> <!-- 삭제 파일로 이동 -->
				</td>
			</tr>
			<input type="hidden" name="key" value="UPDATE"> <!-- 숨겨진 UPDATE 키 -->
			<input type="hidden" name="rootid" value=<%=rootid%>>
			<input type="hidden" name="relevel" value=<%=relevel%>>
			<input type="hidden" name="recnt" value=<%=recnt%>>
			
		</table>
	</form>
</body>

</html>

