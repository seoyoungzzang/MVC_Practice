<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="domain.Gongji"%>
<%@page import="dao.GongjiDao"%>
<%@page import="dao.GongjiDaoImpl"%>
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
<script language="JavaScript">
	function submitForm(mode) {
		fm.action = "gongji_write.jsp?key=INSERT";
		fm.submit();
	}

	function insertGongji() {
		const form = document.getElementById('inputForm1');
		const title = form.elements.title.value;
		const content = form.elements.content.value;

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

		form.action = "gongji_write.jsp?key=INSERT";
		form.submit();
	}
</script>
</head>

<%
Date today = new Date();
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
String date = dateFormat.format(today);
%>

<body>
	<form method="post" name="fm" id="inputForm1">
		<table>
			<tr>
				<th>번호</th>
				<td>신규(insert)<input type="hidden" name="id" value="INSERT"></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" size="70" maxlength="70"></td>
			</tr>
			<tr>
				<th>일자</th>
				<td><%=date%></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content" cols="70" rows="600"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" class="button-container">
					<button type="button" onclick="location.href='gongji_list.jsp'">취소</button>
					<button type="button" onclick="insertGongji()">쓰기</button>
				</td>
			</tr>
		</table>

	</form>
</body>

</html>
