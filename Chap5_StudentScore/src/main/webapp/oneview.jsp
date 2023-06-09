<%@page import="kr.ac.kopo.ctc.kopo34.dao.StudentScoreDao"%>
<%@page import="kr.ac.kopo.ctc.kopo34.dao.StudentScoreDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo34.domain.StudentScore"%>
<%@page import="java.util.List"%>
<%@page import="kr.ac.kopo.ctc.kopo34.dto.Pagination"%>
<%@page import="kr.ac.kopo.ctc.kopo34.service.StudentScoreService"%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
a:link { /* 방문하지 않은 링크 스타일 */
	color: blue; /* 링크 색상 */
}

a:visited { /* 방문한 링크 스타일 */
	color: black; /* 링크 색상 */
}

.current_page { /* 현재 페이지 스타일 클래스 */
	font-weight: bold; /* 글자 굵기 */
	font-size: 30px; /* 글자 크기 */
	text-decoration: underline; /* 밑줄 추가 */
}

table, th, td { /* 테이블 및 테이블 헤드, td 스타일 */
	border: 1px solid black; /* 테이블 셀 경계 선 스타일 */
	padding: 5px; /* 셀 안의 여백 설정 */
}

table { /* 테이블 스타일 */
	cellspacing: 1;
	width: 600;
	border: 1;
}
</style>
</head>

<body>
	<%
	String ckey = request.getParameter("key"); // Allview 페이지에서 전달된 파라미터 key 값 받아옴

	StudentScoreDao studentScoreDao = new StudentScoreDaoImpl(); // studentScoreDao 객체 생성
	StudentScore studentScore = studentScoreDao.selectOne(ckey); // key값을 기준으로 값 조회
	%>
	<form method="get"> <!-- get 형식 form 열기 -->
		<input type="button" value="뒤로가기" onclick="location.href='AllviewDB.jsp'"> <!-- button 생성 및 클릭하면 inputForm1.html로 이동 -->
	</form>
	<h1>
		[<%=ckey%>]조회
	</h1>
	<table>
		<tr>
			<td width=80><p align=center>이름</p></td> <!-- table head -->
			<td width=70><p align=center>학번</p></td> <!-- table head -->
			<td width=50><p align=center>국어</p></td> <!-- table head -->
			<td width=50><p align=center>영어</p></td> <!-- table head -->
			<td width=50><p align=center>수학</p></td> <!-- table head -->
			<td width=50><p align=center>합계</p></td> <!-- table head -->
			<td width=80><p align=center>평균</p></td> <!-- table head -->
			<td width=50><p align=center>등수</p></td> <!-- table head -->
		</tr>
		<%
		out.println("<tr>");
		out.println("<td width=50><p align=center>" + studentScore.getName() + "</p></td>"); // 국어 점수 데이터 표시
		out.println("<td width=50><p align=center>" + studentScore.getStudentid() + "</p></td>"); // 국어 점수 데이터 표시
		out.println("<td width=50><p align=center>" + studentScore.getKor() + "</p></td>"); // 영어 점수 데이터 표시
		out.println("<td width=50><p align=center>" + studentScore.getEng() + "</p></td>"); // 수학 점수 데이터 표시
		out.println("<td width=50><p align=center>" + studentScore.getMat() + "</p></td>"); // 합계 점수 데이터 표시
		out.println("<td width=50><p align=center>" + studentScore.getSum() + "</p></td>"); // 여섯 번째 열 값 출력
		out.println("<td width=50><p align=center>" + studentScore.getAvg() + "</p></td>"); // 여섯 번째 열 값 출력
		out.println("<td width=50><p align=center>" + studentScore.getRank() + "</p></td>"); // 여섯 번째 열 값 출력
		out.println("</tr>");
		%>
	</table>
</body>

</html>

