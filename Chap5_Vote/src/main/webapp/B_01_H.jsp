<%@page import="domain.VoteProgram"%>
<%@page import="java.util.List"%>
<%@page import="dao.VoteProgramDao"%>
<%@page import="dao.VoteProgramDaoImpl"%>
<%@ page contentType="text/html; charset=utf-8"%> <%-- 페이지의 콘텐츠 타입과 문자 인코딩 설정 --%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%> <%-- jsp파일에 java 클래스, java sql import --%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> <!-- html 한글처리 -->
<title>투표 B_01_H.jsp</title>
</head>

<body>
	<table cellspaing=3 width=600 border=1> <!-- table 스타일 지정 -->
		<tr>
			<td width=100 style="text-align:center;"><a href="A_01_H.jsp">후보등록</a></td> <!-- 스타일 지정 및 하이퍼링크 연결 --> 
			<td width=100 bgcolor="#CBB8EE" style="text-align:center;"><a href="B_01_H.jsp">투표</a></td> <!-- 스타일 지정 및 하이퍼링크 연결 --> 
			<td width=100 style="text-align:center;"><a href="C_01_H.jsp">개표결과</a></td> <!-- 스타일 지정 및 하이퍼링크 연결 --> 
		</tr>
	</table>
	
    <%
	VoteProgramDao voteProgramDao = new VoteProgramDaoImpl(); // voteProgramDao 객체 생성
	VoteProgram voteProgram = new VoteProgram(); // voteProgram 객체 생성
	List<VoteProgram> votePrograms = voteProgramDao.selectAll(); // 모든 VoteProgram 객체 리스트를 가져와서 메소드 실행

	if (votePrograms.size() == 0) { // 리스트가 비어있으면
		out.println("후보가 없습니다."); // 해당 문구 출력
	} else { // 아니면
	%>

	<h1>투표하기</h1>
	<table cellspacing=3 width=600 border=1> <!-- table 스타일 지정 -->
		<tr>
			<form method="post" action="B_02_H.jsp"> <!-- 투표 삽입하는 페이지로 넘어감 -->
				<td width=200><p align=center><select name="id"> <!-- name 속성이 id인 select 요소 생성 -->
							<%
							for (int i = 0; i < votePrograms.size(); i++) { // 리스트 크기만큼 반복문 실행
								VoteProgram voteProgram1 = votePrograms.get(i); // voteProgram1에 리스트 요소 할당
								out.println("<option value=" + voteProgram1.getId() + ">" + voteProgram1.getId() + "번 " + voteProgram1.getName()
								+ "</option>"); // 선택 옵션 생성
							}
							%>
						</select></p></td>
				<td width=200 class="tupyo"><p align=center><select name="age"> <!-- name 속성이 age인 select 요소 생성 -->
							<option value=1>10대</option> <!--  옵션 생성 -->
							<option value=2>20대</option> <!--  옵션 생성 -->
							<option value=3>30대</option> <!--  옵션 생성 -->
							<option value=4>40대</option> <!--  옵션 생성 -->
							<option value=5>50대</option> <!--  옵션 생성 -->
							<option value=6>60대</option> <!--  옵션 생성 -->
							<option value=7>70대</option> <!--  옵션 생성 -->
							<option value=8>80대</option> <!--  옵션 생성 -->
							<option value=9>90대</option> <!--  옵션 생성 -->
						</select></p></td>
				<td><input type=submit value="투표하기"></td> <!-- 글자 입력 -->
			</form>
		</tr>
	</table>
	<%
	}
	%>
</body>
</html>