<%@page import="domain.Gongji"%>
<%@page import="dao.GongjiDaoImpl"%>
<%@page import="dao.GongjiDao"%>
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

<%
int id = Integer.parseInt(request.getParameter("key")); // 파라미터에서 받아온 값을 id 변수에 지정

GongjiDao gongjiDao = new GongjiDaoImpl(); // DAO 객체 생성
Gongji gongji = gongjiDao.selectOneGongji(id); // id를 기반으로 공지 하나 검색하여 정보 불러오기
%>
<script language="JavaScript">
	function submitForm(mode) { // 제출 버튼을 눌렀을 때 호출되는 함수
		if (mode == "write") { // mode가 write일 경우

			const title = fm.elements.title.value; // 폼에서 읽어온 제목 값
			const content = fm.elements.content.value; // 폼에서 읽어온 본문 내용 값

			let str = ""; // 안내문을 담을 string 변수

			if (title.trim() == "" || content.trim() == "" // 제목 또는 본문 내용이 공백일 경우
					|| title.length > 200 // 제목의 길이가 200자를 초과할 경우
					|| content.length > 10000) { // 본문의 길이가 10000자를 초과할 경우
				if (title.trim() == "" || content.trim() == "") {
					str = str + "데이터를 모두 입력해주세요.\n"; // 안내문 출력
				}
				if (title.length > 200) { // 제목의 길이가 200자를 초과할 경우
					str = str + "제목은 200자 이하만 입력 가능합니다.\n"; // 안내문 출력
				}

				alert(str); // 안내문 출력
			} else { // 에러가 발생하지 않았을 경우
				var result = confirm("글을 수정하시겠습니까?"); // 글을 수정하겠냐는 선택지 출력
				if (result) { // 예를 클릭했을 경우
					fm.action = "gongji_write.jsp"; // 폼의 경로 설정
					fm.submit(); // 폼 제출
				}
			}
		} else if (mode == "delete") { // mode가 delete일 경우
			var result = confirm("삭제한 글은 복구할 수 없습니다. 삭제하시겠습니까?"); // 삭제하겠냐는 물음과 함꼐 선택지 출력
			if (result) { // 예를 클릭했을 경우
				fm.action = "gongji_delete.jsp"; // 폼의 경로 설정				
				fm.submit(); // 폼 제출
			}
		}
	}
</script>
</head>

<body>
	<form method=post name='fm'>
		<table>
			<%
			out.println("<tr>"); // tr 태그 시작
			out.println("<th><b>번호</b></th>"); // 번호 인덱스
			// 읽어온 id값 출력
			out.println("<td><input type=text name=id size=70 maxlength=70 value=" + id + " readonly></td>");
			out.println("</tr>"); // tr 태그 닫기
			out.println("<tr>"); // tr 태그 시작
			out.println("<th><b>제목</b></th>"); // 제목 인덱스
			// 제목 &, <, > 처리하기
			String title = gongji.getTitle().replaceAll("&", "&amp;");
			String title2 = title.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			// 본문 내용 &, <, > 처리하기
			String content = gongji.getContent().replaceAll("&", "&amp;");
			String content2 = content.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			//읽어온 제목 내용값 출력
			out.println("<td><input type=text name=title size=70 maxlength=200 value=\"" + title2 + "\"></td>");
			out.println("</tr>"); // tr 태그 닫기
			out.println("<tr>"); // tr 태그 시작
			out.println("<th><b>일자</b></th>"); // 일자 인덱스
			out.println("<td>" + gongji.getDate() + "</td>"); // 일자 출력
			out.println("</tr>"); // tr 태그 닫기
			out.println("<tr>"); // tr 태그 시작
			out.println("<th><b>내용</b></th>"); // 내용 인덱스
			// 내용 출력하기
			out.println("<td><textarea style='width:527px; height:250px;' name=content cols=70 row=600>" + content2
					+ "</textarea></td>");
			out.println("</tr>"); // tr 태그 닫기
			%>
			<input type="hidden" name="key" value="UPDATE" style="display: none;">
			</form>
		</table>
		<table width=600>
			<tr>
				<td colspan="2" class="button-container">
					<button type="button"
						onclick="location.href='gongji_list.jsp?key=<%=id%>'">취소</button>
					<!-- list 페이지로 이동 -->
					<button type="button" onclick="submitForm('write')">수정</button> <!-- 수정 파일로 이동 -->
				</td>
			</tr>
		</table>
</body>

</html>