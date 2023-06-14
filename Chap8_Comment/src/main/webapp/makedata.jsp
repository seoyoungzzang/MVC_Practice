<%@page import="dao.GongjiDaoImpl"%>
<%@page import="dao.GongjiDao"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*"%>

<html>

<head>
</head>

<body>
	<%
	GongjiDao gongjiDao = new GongjiDaoImpl(); // 객체 생성
	int result = gongjiDao.makeData(); // createTable 메소드 호출
	out.println(result); // 결과값 리턴
	%>
</body>

</html>