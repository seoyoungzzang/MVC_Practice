<%@page import="service.GongjiServiceImpl"%>
<%@page import="service.GongjiService"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="domain.Gongji"%>
<%@page import="dao.GongjiDao"%>
<%@page import="dao.GongjiDaoImpl"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>

<%
request.setCharacterEncoding("UTF-8"); // utf-8로 인코딩 설정

int id = Integer.parseInt(request.getParameter("id"));

Gongji gongji = new Gongji();
GongjiDao gongjiDao = new GongjiDaoImpl();

int c = gongjiDao.currentPage(id,10); // currentPage 메소드 호출해서 pageNum에 저장

gongjiDao.deleteOneGongji(id);
%>

<html>

<head>
</head>

<body>
	<script language="JavaScript">
		window.onload = function() {
			confirm("게시글이 삭제되었습니다.")
			location.href = "gongji_list.jsp?page=<%=c%>";
		};
	</script>

</body>

</html>
