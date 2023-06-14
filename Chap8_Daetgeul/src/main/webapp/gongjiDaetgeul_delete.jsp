<%@page import="dao.GongjiDaoImpl"%>
<%@page import="dao.GongjiDao"%>
<%@page import="domain.Gongji"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*"%>

<%
request.setCharacterEncoding("UTF-8"); // utf-8로 인코딩 설정

int id = Integer.parseInt(request.getParameter("key")); // id 받아서 정수 변환

GongjiDao gongjiDao = new GongjiDaoImpl(); // 객체 생성

int c = gongjiDao.currentPage(id,10); // currentPage 메소드 호출해서 c에 저장

gongjiDao.deleteOneGongji(id); // id 받아서 delete메소드 호출
%>

<html>

<head>
</head>

<body>
	<script language="JavaScript">
		window.onload = function() { 
			confirm("게시글이 삭제되었습니다.") // 삭제되었음을 확인하는 알림 대화상자 표시
			location.href = "gongjiDaetgeul_list.jsp?page=<%=c%>"; 
		}; // 리스트 페이지 이동
	</script>
</body>

</html>
