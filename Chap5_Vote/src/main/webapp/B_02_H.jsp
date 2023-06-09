<%@page import="dao.VoteProgramDaoImpl"%>
<%@page import="dao.VoteProgramDao"%>
<%@ page contentType="text/html; charset=utf-8"%> <%-- 페이지의 콘텐츠 타입과 문자 인코딩 설정 --%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%> <%-- jsp파일에 java 클래스, java sql import --%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> <!-- html 한글처리 -->
<title>투표 B_02_H.jsp</title>
</head>

<%
try {
	request.setCharacterEncoding("UTF-8"); // utf-8로 인코딩 설정

	int id = Integer.parseInt(request.getParameter("id")); // id 값 가져와서 id에 저장
	int age = Integer.parseInt(request.getParameter("age")); // age 값 가져와서 age에 저장

	VoteProgramDao voteProgramDao = new VoteProgramDaoImpl(); // VoteProgramDaoImpl 객체 생성
	voteProgramDao.insertTupyo(id, age); // id, age를 인자로 갖는 투표 데이터 삽입 메소드 호출
} catch (Exception e) {
	out.println(e);
}
%>

<body>
	<table cellspacing=3 width=600 border=1> <!-- table 스타일 지정 -->
		<tr>
			<td width=100 style="text-align:center;"><a href="A_01_H.jsp">후보등록</a></td> <!-- 스타일 지정 및 하이퍼링크 연결 --> 
			<td width=100 bgcolor="#CBB8EE" style="text-align:center;"><a href="B_01_H.jsp">투표</a></td> <!-- 스타일 지정 및 하이퍼링크 연결 --> 
			<td width=100 style="text-align:center;"><a href="C_01_H.jsp">개표결과</a></td> <!-- 스타일 지정 및 하이퍼링크 연결 --> 
		</tr>
	</table>
	<h1>투표를 완료하였습니다.</h1> <!-- 글자 입력 -->
</body>

</html>
