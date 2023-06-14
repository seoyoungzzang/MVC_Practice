<%@page import="domain.Gongji"%>
<%@page import="dao.GongjiDaoImpl"%>
<%@page import="dao.GongjiDao"%>
<%@ page contentType="text/html; charset=utf-8" language="java" %>

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
</head>

<body>
<%
	int id = Integer.parseInt(request.getParameter("key")); // 파라미터 값 가져와 id 변수에 지정

	GongjiDao gongjiDao = new GongjiDaoImpl(); // DAO 객체 생성

	gongjiDao.addViewCnt(id); // 조회수 1 추가
	Gongji gongji = gongjiDao.selectOneGongji(id); // id를 통해 공지 정보 하나를 가져옴
	
	String page1 = request.getParameter("page"); // 페이지 값 받아오기
	int pageNum = 0; // 페이지 담을 변수

	if (page1 != null) // null이 아니라면
	// 페이지값을 정수형으로 받아옴
	pageNum = Integer.parseInt(request.getParameter("page"));
	
%>
<script> // 스크립트 작성 시작
function submitForm(mode) { // 제출 버튼 눌렀을 때 호출되는 함수
	if(mode == "delete") { // mode 값이 delete일 경우
		var result = confirm("삭제한 글은 복구할 수 없습니다. 삭제하시겠습니까?"); // 삭제할 것인지 선택지 제공
		if(result) { // 예를 클릭했을 경우
			location.href='gongji_delete.jsp?id=<%=id%>&page=<%=pageNum%>' // 삭제 페이지로 이동
		}
	}
	if(mode == "daetgul") { // mode 값이 댓글일 경우
		 	// 댓글 작성 페이지로 이동
			location.href='gongji_reinsert.jsp?rootid=<%=gongji.getRootid()%>&level=<%=gongji.getRelevel()%>&recnt=<%=gongji.getRecnt()%>'
	}
}
</script>
<table>
<%

	if (gongji.getRelevel() == 0) { // relevel이 0일 경우

 		String content = gongji.getContent().replaceAll("&", "&amp;"); // &를 &amp;로 변경
		String content2 = content.replaceAll("<", "&lt;").replaceAll(">", "&gt;"); // <와 >를 각각 &lt;와 &gt;로 변경
		
		String title = gongji.getTitle().replaceAll("&", "&amp;"); // &를 &amp;로 변경
    	String title2 = title.replaceAll("<", "&lt;").replaceAll(">", "&gt;"); // <와 >를 각각 &lt;와 &gt;로 변경


		out.println("<form method=post name='fm'"); // 폼 생성
		out.println("<tr>"); // tr 태그 시작
		out.println("<th width= 70px><b>번호</b></th>"); // 번호 인덱스
		out.println("<td>"+gongji.getId()+"</td>"); // 번호 내용 출력
		out.println("</tr>"); // tr 태그 닫기
		out.println("<tr>"); // tr 태그 시작
		out.println("<th><b>제목</b></th>"); // 제목 인덱스
		out.println("<td>"+title2+"</td>"); // 제목 출력
		out.println("</tr>"); // tr 태그 닫기
		out.println("<tr>"); // tr 태그 시작
		out.println("<th><b>일자</b></th>"); // 일자 인덱스
		out.println("<td>"+gongji.getDate()+"</td>"); // 일자 출력
		out.println("</tr>"); // tr 태그 닫기
		out.println("<tr>"); // tr 태그 시작
		out.println("<th><b>조회수</b></th>"); // 조회수 인덱스
		out.println("<td>"+gongji.getViewcnt()+"</td>"); // 조회수 출력
		out.println("</tr>"); // tr 태그 닫기
		out.println("<tr>"); // tr 태그 시작
		out.println("<th><b>내용</b></th>"); // 본문 내용 인덱스
		// 본문 내용 출력
		out.println("<td><textarea readonly style=\"width: 500px; height: 250px;\">"+content+"</textarea></td>");
		out.println("</tr>"); // tr 태그 닫기
	}
	else { // 그 외에는
	out.println("<form method=post name='fm'"); // 폼 생성
	out.println("<tr>"); // tr 태그 시작
	out.println("<th width= 70px><b>번호</b></th>"); // 번호 인덱스
	out.println("<td>"+gongji.getId()+"</td>"); // 번호 내용 출력
	out.println("</tr>"); // tr 태그 닫기
	out.println("<tr>"); // tr 태그 시작
	String title = gongji.getTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;"); // &를 &amp;로 변경
 	String content = gongji.getContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;"); // <와 >를 각각 &lt;와 &gt;로 변경

	out.println("<th><b>제목</b></th>"); // 제목 인덱스
	out.println("<td>"+title+"</td>"); // 제목 출력
	out.println("</tr>"); // tr 태그 닫기
	out.println("<tr>"); // tr 태그 시작
	out.println("<th><b>일자</b></th>"); // 일자 인덱스
	out.println("<td>"+gongji.getDate()+"</td>"); // 일자 출력
	out.println("</tr>"); // tr 태그 닫기
	out.println("<tr>"); // tr 태그 시작
	out.println("<th><b>조회수</b></th>"); // 조회수
	out.println("<td>"+gongji.getViewcnt()+"</td>"); // 조회수 출력
	out.println("</tr>"); // tr 태그 닫기
	out.println("<tr>"); // tr 태그 시작
	out.println("<th><b>내용</b></th>");// 내용
	// 내용 출력
	out.println("<td><textarea readonly style=\"width: 500px; height: 250px;\">"+content+"</textarea></td>");
	out.println("</tr>"); // tr 태그 닫기
	out.println("<tr>"); // tr 태그 시작
	out.println("<th><b>원글</b></th>");//원글
	//원글 아이디 출력
	out.println("<td>"+gongji.getRootid()+"</td>");
	out.println("</tr>"); // tr 태그 닫기
	out.println("<tr>"); // tr 태그 시작
	out.println("<th><b>댓글수준</b></th>");//댓글 수준
	out.println("<td>"+gongji.getRelevel());// 댓글 수준 출력
	%>
	
	<span style="float: right; margin-right: 50px;">
    댓글 내 순서: <%=gongji.getRecnt()%>
  </span>
  
	<%
	out.println("</td>"); // td 닫기
	out.println("</tr>"); // tr 닫기
	} %>
				<tr>
				<td colspan="2" class="button-container">
					<button type="button" onclick="location.href='gongji_list.jsp?key=<%=id%>'">목록</button> <!-- list 페이지로 이동 -->
					<button type="button" onclick="location.href='gongji_update.jsp?key=<%=id%>'">수정</button> <!-- 수정 페이지로 이동 -->
					<button type="button" onclick="submitForm('delete')">삭제</button> <!-- 삭제 페이지로 이동 -->
					<button type="button" onclick="submitForm('daetgul')">댓글</button> <!-- 댓글 페이지로 이동 -->
				</td>
			</tr>
</table>
</body>

</html>