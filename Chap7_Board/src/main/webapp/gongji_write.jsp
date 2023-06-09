<%@page import="service.GongjiServiceImpl"%>
<%@page import="service.GongjiService"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="domain.Gongji"%>
<%@page import="dao.GongjiDao"%>
<%@page import="dao.GongjiDaoImpl"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>

<html>

<head>
<%
GongjiDao gongjiDao = new GongjiDaoImpl();
Gongji gongji = new Gongji();

request.setCharacterEncoding("UTF-8"); // utf-8로 인코딩 설정

String key = request.getParameter("key");
String title = request.getParameter("title");
String content = request.getParameter("content");

int id = 0;
int c = 0;

if (key.equals("INSERT")) {
	gongji.setTitle(title);
	gongji.setContent(content);

	id = gongjiDao.insertGongji(gongji);
}

if(key.equals("UPDATE")){
	id = Integer.parseInt(request.getParameter("id"));
	gongji.setId(id);
	gongji.setTitle(title);
	gongji.setContent(content);
	
	c = gongjiDao.currentPage(id, 10); // currentPage 메소드 호출해서 pageNum에 저장
	gongjiDao.updateGongji(gongji);
}
%>
</head>

<body>
	<script language="JavaScript">
		window.onload = function() {
			var key = "<%=key%>"; // key 값을 JavaScript 변수에 할당합니다.
			
			if (key === "INSERT") { // INSERT인 경우
				if (confirm("게시글이 작성되었습니다. 확인을 누르면 목록으로 이동합니다.")) {
					location.href = "gongji_list.jsp";
				} else {
					location.href = "gongji_view.jsp?key=<%=id%>";
				}
			} else if (key === "UPDATE") { // UPDATE인 경우
				if (confirm("게시글이 수정되었습니다. 확인을 누르면 목록으로 이동합니다.")) {
					location.href = "gongji_list.jsp?page=<%=c%>";
				} else {
					location.href = "gongji_view.jsp?key=<%=id%>";
				}
			}
		};
	</script>
</body>

</html>