<%@page import="domain.Gongji"%>
<%@page import="dao.GongjiDaoImpl"%>
<%@page import="dao.GongjiDao"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<html>

<head>
<style>
body {
	background: #FFFF9;
	font-family: Arial, sans-serif;
}

table {
	border-collapse: collapse;
	width: 600px;
	margin: 20px auto;
	background: #fff;
	border: 1px solid #ccc;
}

th {
	background: #FFCD28;
	color: #fff;
	padding: 10px;
}

td {
	padding: 10px;
	border: 1px solid #ccc;
}

tr:nth-child(even) {
	background-color: #FDF5E6;
}

button {
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
</style>

</head>

<%
int id = Integer.parseInt(request.getParameter("key")); // key 받아서 정수 변환

GongjiDao gongjiDao = new GongjiDaoImpl(); // 객체 생성

int viewcnt = gongjiDao.addViewCnt(id);
Gongji gongji = gongjiDao.selectOne(id); // id 값 받아서 특정 데이터 조회

int rootid = gongji.getRootid();
int relevel = gongji.getRelevel();
int recnt = gongji.getRecnt();
%>
<script>
function submitForm() {
       var confirmDelete = confirm("정말 삭제하시겠습니까?"); // 해당 메세지 출력
       if (confirmDelete) { // '예'를 선택한 경우의 동작
          fm.action = "gongjiDaetgeul_delete.jsp?key=<%=id%>"; // 삭제 액션으로 폼을 전송합니다.
		} else { // '아니오'를 선택한 경우의 동작
			retrun; // 함수 실행 종료
		}
		fm.submit();
	}
</script>

<body>
	<form method="post" name="fm">
		<table>
			<tr>
				<th>번호</th> <!-- th 입력 -->
				<td><%=gongji.getId()%>
				<input type="hidden" name="id" value="INSERT"></td> <!-- 두번째 열 입력 -->
			</tr>
			<tr>
				<th>제목</th> <!-- th 입력 -->
				<td><%=gongji.getTitle()%></td> <!-- 두번째 열 입력 -->
			</tr>
			<tr>
				<th>일자</th> <!-- th 입력 -->
				<td><%=gongji.getDate()%></td> <!-- 두번째 열 입력 -->
			</tr>
			<tr>
				<th>조회수</th> <!-- th 입력 -->
				<td><%=gongji.getViewcnt()%></td> <!-- 두번째 열 입력 -->
			</tr>
			<tr>
				<th>내용</th> <!-- th 입력 -->
				<td><%=gongji.getContent()%></td> <!-- 두번째 열 입력 -->
			</tr>
			<tr>
				<th>원글</th> <!-- th 입력 -->
				<td><%=gongji.getRootid()%></td> <!-- 두번째 열 입력 -->
			</tr>
			<tr>
				<th>댓글수준</th> <!-- th 입력 -->
				<td><%=gongji.getRelevel()%></td> <!-- 두번째 열 입력 -->
			</tr>
				<tr>
				<th>댓글내순서</th> <!-- th 입력 -->
				<td><%=recnt%></td> <!-- 두번째 열 입력 -->
			</tr>
			<tr>
				<td colspan="2" class="button-container">
					<button type="button" onclick="location.href='gongjiDaetgeul_list.jsp'">목록</button> <!-- list 페이지로 이동 -->
					<button type="button" onclick="location.href='gongjiDaetgeul_update.jsp?key=<%=id%>'">수정</button> <!-- 수정 페이지로 이동 -->
					<button type="button" onclick="submitForm()">삭제</button> <!-- 삭제 페이지로 이동 -->
					<button type="button" onclick="location.href='gongjiDaetgeul_reinsert.jsp?key=<%=id%>&rootid=<%=rootid%>&relevel=<%=relevel%>&recnt=<%=recnt%>'">댓글</button> <!-- 댓글 페이지로 이동 -->
				</td>
			</tr>
		</table>
	</form>
</body>

</html>
