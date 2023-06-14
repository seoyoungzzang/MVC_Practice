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
	width: 100%;
	margin: 20px auto;
	background: #fff;
	border: 1px solid #ccc;
}

th {
	background: #FFCD28;
	color: #fff;
	padding: 5px;
}

td {
	padding: 5px;
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

.container {
	max-width: 800px;
	margin: 0 auto;
	padding: 20px;
}
</style>
</head>

<%
int id = Integer.parseInt(request.getParameter("key")); // key 받아서 정수 변환

GongjiDao gongjiDao = new GongjiDaoImpl(); // 객체 생성
Gongji gongji = new Gongji(); // 객체 생성

int c = gongjiDao.currentPage(id, 10); // currentPage 메소드 호출해서 c에 저장

gongji = gongjiDao.selectOne(id); // selectOne 메소드 호출
%>

<body>
	<div class="container">
		<h1>게시글 상세 조회</h1> <!-- h1 입력 -->
		<form method="post" name="fm"> <!-- form 요소 설정 -->
			<table>
				<tr>
					<th>번호</th> <!-- th 입력 -->
					<td><%=gongji.getId()%></td> <!-- 두번째 열 입력 -->
				</tr>
				<tr>
					<th>제목</th> <!-- th 입력 -->
					<td><%=gongji.getTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;")%></td> <!-- 두번째 열 입력 -->
				</tr>
				<tr>
					<th>일자</th> <!-- th 입력 -->
					<td><%=gongji.getDate()%></td> <!-- 두번째 열 입력 -->
				</tr>
				<tr>
					<th>내용</th> <!-- th 입력 -->
					<td style="max-width: 300px; word-wrap: break-word;">
					<textarea name="content" cols="30" rows="10" style="width: 500px; resize: none; overflow: auto;" readonly><%=gongji.getContent()%></textarea>
					</td> <!-- 두번째 열 입력, 띄어쓰기 설정-->
				</tr>
				<tr>
					<td colspan="2" class="button-container">
						<button type="button" onclick="location.href='gongji_list.jsp?page=<%=c%>'">목록</button> <!-- list 페이지로 이동 -->
						<button type="button" onclick="location.href='gongji_update.jsp?key=<%=id%>'">수정</button> <!-- 해당 id를 가진 update 페이지 이동 -->
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>

</html>
