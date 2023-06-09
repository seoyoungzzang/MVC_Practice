<%@page import="domain.VoteProgram"%>
<%@page import="dao.VoteProgramDaoImpl"%>
<%@page import="dao.VoteProgramDao"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=utf-8"%> <%-- 페이지의 콘텐츠 타입과 문자 인코딩 설정 --%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%> <%-- jsp파일에 java 클래스, java sql import --%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> <!-- html 한글처리 -->
<title>개표결과 C_01_H.jsp</title>
</head>

<body>
<table cellspacing=3 width=600 border=1> <!-- table 스타일 지정 -->
	<tr>
		<td width=100 style="text-align:center;"><a href="A_01_H.jsp">후보등록</a></td> <!-- 스타일 지정 및 하이퍼링크 연결 --> 
		<td width=100 style="text-align:center;"><a href="B_01_H.jsp">투표</a></td> <!-- 스타일 지정 및 하이퍼링크 연결 --> 
		<td width=100 bgcolor="#CBB8EE" style="text-align:center;"><a href="C_01_H.jsp">개표결과</a></td> <!-- 스타일 지정 및 하이퍼링크 연결 --> 
	<tr>
</table>

<%
VoteProgramDao voteProgramDao = new VoteProgramDaoImpl(); // VoteProgramDaoImpl 객체 생성
List<VoteProgram> votePrograms = voteProgramDao.selectAll(); // 모든 VoteProgram 객체 리스트를 가져와서 메소드 실행

if (votePrograms.size() == 0) { // 리스트가 비어있으면
	out.println("후보가 없습니다."); // 해당 문구 출력
} else { // 아니면
%>

<h1>후보별 득표 결과</h1> <!-- 글자 입력 -->
<table cellspacing=3 width=600 border=1> <!-- table 스타일 지정 -->
	<tr>
		<td width=75><p align=center>이름</p></td> <!-- 이름 필드명 출력 -->
		<td width=500><p align=center>인기도</p></td> <!-- 인기도 필드명 출력 -->
	</tr>

	<%
	int totalCount = voteProgramDao.countAll(); // 총 투표수 가져옴

	for (int i = 0; i < votePrograms.size(); i++) { // 리스트 크기만큼 반복문 실행
		VoteProgram voteProgram1 = votePrograms.get(i); // voteProgram1에 리스트 요소 할당

		int idCount = voteProgramDao.countVotes(voteProgram1.getId()); // 기호별 득표수 
		int voteRate = (int) ((double) idCount / totalCount * 100); // 기호별 득표율

		int barLength = (int) (voteRate * 4); // bar 길이

		out.println("<tr>");
		out.println("<td width=75><a href='C_02_H.jsp?key=" + voteProgram1.getId() + "&name=" + voteProgram1.getName()
		+ "'><p align=center>" + voteProgram1.getId() + " " + voteProgram1.getName() + "</p></a></td>"); // name에 하이퍼링크 연결
		out.println("<td width=500>"); // td 스타일 지정
		out.println("<div>");
		out.println("<span><img src='bar.jpg' style='width: " + barLength
		+ "px; height: 20px; display: inline-block;'></span>"); // bar 길이 설정
		out.println("<span>" + idCount + " (" + voteRate + "%)</span>"); // 득표수 및 득표율 출력
		out.println("</div>");
		out.println("</td>");
		out.println("</tr>");
	}
	%>
</table>
<%
}
%>
</body>

</html>