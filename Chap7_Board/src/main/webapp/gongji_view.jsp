<%@page import="java.util.List"%>
<%@page import="domain.Gongji"%>
<%@page import="dao.GongjiDao"%>
<%@page import="dao.GongjiDaoImpl"%>
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
<script language="JavaScript">
	function submitForm(mode) {
		if (mode == "write") {
			fm.action = "gongji_write.jsp";
		} else if (mode == "delete") {
			fm.action = "gongji_delete.jsp";
		}
		fm.submit();
	}
</script>
</head>

<%
int id = Integer.parseInt(request.getParameter("key"));

GongjiDao gongjiDao = new GongjiDaoImpl();
Gongji gongji = new Gongji();

gongji = gongjiDao.selectOne(id);
%>

<body>
	<form method="post" name="fm">
		<table>
			<tr>
				<th>번호</th>
				<td><%=gongji.getId()%></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><%=gongji.getTitle()%></td>
			</tr>
			<tr>
				<th>일자</th>
				<td><%=gongji.getDate()%></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><%=gongji.getContent()%></td>
			</tr>
			<tr>
				<td colspan="2" class="button-container">
					<button type="button" onclick="location.href='gongji_list.jsp'">목록</button>
					<button type="button" onclick="location.href='gongji_update.jsp?key=<%=id%>'">수정</button>
				</td>
			</tr>
		</table>
	</form>
</body>

</html>
