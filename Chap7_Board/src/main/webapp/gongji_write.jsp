<%@page import="domain.Gongji"%>
<%@page import="dao.GongjiDaoImpl"%>
<%@page import="dao.GongjiDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*"%>

<html>

<head>
<%
GongjiDao gongjiDao = new GongjiDaoImpl(); // 객체 생성
Gongji gongji = new Gongji(); // 객체 생성

request.setCharacterEncoding("UTF-8"); // utf-8로 인코딩 설정

String key = request.getParameter("key"); // key 받아오기
String title = request.getParameter("title"); // title 받아오기
String content = request.getParameter("content"); // content 받아오기

int id = 0; // 정수형 변수 선언 및 초기화
int c = 0; // 정수형 변수 선언 및 초기화

if (key.equals("INSERT")) { // key가 INSERT면
	gongji.setTitle(title); // title 저장
	gongji.setContent(content); // content 저장

	id = gongjiDao.insertGongji(gongji); // id 리턴하여 저장
}

if(key.equals("UPDATE")){ // key가 UPDATE면
	id = Integer.parseInt(request.getParameter("id")); // id 받아서 정수 변환
	gongji.setId(id); // id 저장
	gongji.setTitle(title); // title 저장
	gongji.setContent(content); // content 저장
	
	c = gongjiDao.currentPage(id, 10); // currentPage 메소드 호출해서 pageNum에 저장
	gongjiDao.updateGongji(gongji); // 저장된 gongjii 수정
}
%>
</head>

<body>
	<script language="JavaScript">
		window.onload = function() {
			var key = "<%=key%>"; // key 값을 JavaScript 변수에 할당
			
			if (key === "INSERT") { // INSERT인 경우
				if (confirm("게시글이 작성되었습니다. 확인을 누르면 목록으로 이동합니다.")) { // 알림창 출력
					location.href = "gongji_list.jsp"; // list 페이지로 이동
				} else { // 아니면
					location.href = "gongji_view.jsp?key=<%=id%>"; 
				} // 상세 페이지 이동
			} else if (key === "UPDATE") { // UPDATE인 경우
				if (confirm("게시글이 수정되었습니다. 확인을 누르면 목록으로 이동합니다.")) { // 알림창 출력 후 list 페이지 이동
					location.href = "gongji_list.jsp?page=<%=c%>"; 
				} else { // 아니면
					location.href = "gongji_view.jsp?key=<%=id%>";
				} // 상세 페이지 이동
			}
		};
	</script>
</body>

</html>