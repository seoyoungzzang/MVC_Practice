<%@page import="dao.GongjiDao"%>
<%@page import="dao.GongjiDaoImpl"%>
<%@ page contentType="text/html; charset=utf-8"%> <%-- 페이지의 콘텐츠 타입과 문자 인코딩 설정 --%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*"%> <%-- jsp파일에 java 클래스, java sql import --%>

<html> <!-- html 열기 -->

<head> <!-- head 열기 -->
</head> <!-- head 닫기 -->

<body> <!-- body 열기 -->
	<%
	GongjiDao gongjiDao = new GongjiDaoImpl(); // 객체 생성
	int result = gongjiDao.makeData(); // createTable 메소드 호출
	out.println(result); // 결과값 리턴
	%>
</body> <!-- body 닫기 -->

</html> <!-- html 닫기 -->