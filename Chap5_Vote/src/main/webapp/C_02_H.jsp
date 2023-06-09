<%@page import="java.util.List"%>
<%@page import="dao.VoteProgramDao"%>
<%@page import="dao.VoteProgramDaoImpl"%>
<%@page import="domain.VoteProgram"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=utf-8"%> <%-- 페이지의 콘텐츠 타입과 문자 인코딩 설정 --%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%> <%-- jsp파일에 java 클래스, java sql import --%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> <!-- html 한글처리 -->
<title>개표결과 C_02_H.jsp</title>
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
String name = request.getParameter("name"); // name 값 가져와서 name에 저장
String ckey = request.getParameter("key"); // key 값 가져와서 ckey에 저장
%>

<h1>[<%=ckey%>번 <%=name%>] 후보 득표 성향 </h1> <!-- name 변수 값 가져와서 삽입 -->
<table cellspacing=3 width=600 border=1> <!-- table 스타일 지정 -->
	<tr>
		<td width=75><p align=center>연령대</p></td> <!-- 이름 필드명 출력 -->
		<td width=500><p align=center>인기도</p></td> <!-- 인기도 필드명 출력 -->
	</tr>
	
    <%
	int id = Integer.parseInt(ckey); // ckey 정수로 변환하여 id에 저장

	VoteProgramDao voteProgramDao = new VoteProgramDaoImpl(); // VoteProgramDaoImpl 객체 생성
	List<VoteProgram> votePrograms = voteProgramDao.selectOne(id); // 모든 VoteProgram 객체 리스트를 가져와서 메소드 실행

	int idCount = voteProgramDao.countVotes(id); // 기호별 득표수 
	
    for (int age = 1; age <= 9; age++) { // age는 1부터 9까지 루프
		int ageCount = 0; // 연령대별 득표수 변수 선언 및 초기화
		
        for (int i = 0; i < votePrograms.size(); i++) { // 리스트 크기만큼 반복문 실행
			VoteProgram voteProgram1 = votePrograms.get(i); // voteProgram1에 리스트 요소 할당
			
            if (voteProgram1.getAge() == age) { // age가 age 변수와 같으면
		        ageCount = voteProgram1.getCount(); // 기호별 연령대별 득표수에 할당당
		        break; // 루프 종료
			}
		}

		int voteRate = idCount > 0 ? (int) ((double) ageCount / idCount * 100) : 0; // 기호별 연령대별 득표율

		int barLength = (int) (voteRate * 4); // bar 길이

		out.println("<tr>");
		out.println("<td width=75><p align=center>" + (age * 10) + "대" + "</p></td>"); // 연령대 출력
		out.println("<td width=500><p align=center>"); // td 스타일 지정
		out.println("<div>");
		out.println("<span><img src='bar.jpg' style='width: " + barLength
		+ "px; height: 20px; display: inline-block;'></span>"); // bar 길이 설정
		out.println("<span>" + ageCount + " (" + voteRate + "%)</span>"); // 득표수 및 득표율 출력
		out.println("</div>");
		out.println("</td>");
		out.println("</tr>");
	}
	%>
</table>
</body>

</html>