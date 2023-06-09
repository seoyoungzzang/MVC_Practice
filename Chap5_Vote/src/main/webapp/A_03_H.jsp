<%@page import="domain.VoteProgram"%>
<%@page import="dao.VoteProgramDaoImpl"%>
<%@page import="dao.VoteProgramDao"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> <!-- html 한글처리 -->

<html>

<head>
<title>후보등록 A_03_H.jsp</title>
</head>

<%
request.setCharacterEncoding("UTF-8"); // utf-8로 인코딩 설정
String name = request.getParameter("name"); // name 값 가져와서 name에 저장

VoteProgramDao voteProgramDao = new VoteProgramDaoImpl(); // VoteProgramDaoImpl 객체 생성
voteProgramDao.insertHubo(name); // 후보 삽입 메소드 호출
%>

<body>
	<table cellspacing=3 width=600 border=1> <!-- table 스타일 지정 -->
		<tr>
			<td width=100 bgcolor="#CBB8EE" style="text-align:center;"><a href="A_01_H.jsp">후보등록</a></td> <!-- 스타일 지정 및 하이퍼링크 연결 --> 
			<td width=100 style="text-align:center;"><a href="B_01_H.jsp">투표</a></td> <!-- 스타일 지정 및 하이퍼링크 연결 --> 
			<td width=100 style="text-align:center;"><a href="C_01_H.jsp">개표결과</a></td> <!-- 스타일 지정 및 하이퍼링크 연결 --> 
		</tr>
	</table>
	<h1>후보등록 추가 완료</h1> <!-- 글자 입력 -->
</body>

</html>
