<%@page import="domain.Gongji"%>
<%@page import="dao.GongjiDaoImpl"%>
<%@page import="dao.GongjiDao"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>
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
int id = Integer.parseInt(request.getParameter("key"));

GongjiDao gongjiDao = new GongjiDaoImpl();
Gongji gongji = new Gongji();

gongji = gongjiDao.selectOne(id);
%>
<script language="JavaScript">
	function submitForm(mode) {
		const form = document.getElementById('inputForm1');
		const title = form.elements.title.value;
		const content = form.elements.content.value;

		if (mode == "write") {
			if (title.trim() === '' || content.trim() === '') {
				alert("데이터를 모두 입력해주세요.");
				return;
			}
			if (title.length > 50) { // 이름이 20자 이상이면
				alert("제목은 50자 이하만 입력 가능합니다."); // 해당 메세지 출력
				return; // 함수 실행 종료
			}
	        if (content.length > 3000) { // 이름이 20자 이상이면
	            alert("내용은 3000자 이하만 입력 가능합니다."); // 해당 메세지 출력
	            return; // 함수 실행 종료
	        } 
			fm.action = "gongji_write.jsp?key=UPDATE";
		} else if (mode == "delete") {
			fm.action = "gongji_delete.jsp?key=<%=id%>";
		}
		form.submit();
	}
</script>
</head>

<body>
	<form method="post" name="fm" id="inputForm1">
		<table>
			<tr>
				<th>번호</th>
				<td><input type="text" name="id" size="70" value="<%=id%>"
					readonly></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" size="70" maxlength="70"
					value="<%=gongji.getTitle()%>"></td>
			</tr>
			<tr>
				<th>일자</th>
				<td><%=gongji.getDate()%></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content" cols="70" rows="600"><%=gongji.getContent()%></textarea></td>
			</tr>
			<tr>
				<td colspan="2" class="button-container">
					<button type="button" onclick="location.href='gongji_list.jsp'">취소</button>
					<button type="button" onclick="submitForm('write')">수정</button>
					<button type="button" onclick="submitForm('delete')">삭제</button>
				</td>
			</tr>
			<input type="hidden" name="key" value="UPDATE">
		</table>
	</form>
</body>

</html>

