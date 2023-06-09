<%@page import="kr.ac.kopo.ctc.kopo34.service.StudentScoreServiceImpl"%>
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
	cellspacing: 1; /* 셀 간격 설정 */
	width: 600; /* 너비 설정 */
	border: 1; /* 테두리 설정 */
}
</style>
</head>

<body>
	<%
	try{
	String pageValue = request.getParameter("page"); // page 파라미터에서 값을 가져와 pageValue에 지정
	int pageNum = 1; // pageNum 변수 선언 및 초기화 
	if (pageValue != null) { // pageValue 값이 null이 아닌 경우
		pageNum = Integer.parseInt(pageValue); // 받아온 파라미터 값을 pageNum에 저장
		if (pageNum < 1) { // 1보다 작으면
			pageNum = 1; // 1로 설정
		}
	}

	String countPerPageValue = request.getParameter("countPerPage"); // countPerPage 파라미터에서 값을 가져와 countPerPageValue에 지정
	int countPerPage = 10; // countPerPage 변수 선언 및 초기화
	if (countPerPageValue != null) { // countPerPageValue 값이 null이 아닌 경우
		countPerPage = Integer.parseInt(countPerPageValue); // 받아온 파라미터 값을 countPerPage에 저장
		if (countPerPage < 1) { // 1보다 작으면
			countPerPage = 10; // 10으로 설정
		}
	}

	StudentScoreDao studentScoreDao = new StudentScoreDaoImpl(); // 객체 생성
	List<StudentScore> studentScores = studentScoreDao.selectAll(pageNum, countPerPage); // studentScores 목록 가져옴

	StudentScoreService studentScoreService = new StudentScoreServiceImpl(); // 객체 생성
	Pagination pagination = studentScoreService.getPagination(pageNum, countPerPage); // pagination 식 가져옴

	int c = pagination.getC(); // 현재 페이지 번호
	int s = pagination.getS(); // 시작 페이지 번호
	int e = pagination.getE(); // 끝 페이지 번호
	int p = pagination.getP(); // 이전 페이지 번호
	int pp = pagination.getPp(); // 이전의 이전 페이지 번호
	int n = pagination.getN(); // 다음 페이지 번호
	int nn = pagination.getNn(); // 다음의 다음 페이지 번호
	%>
	<% if (studentScores != null && !studentScores.isEmpty()) { %> <!-- 비어있지 않으면 -->
	<h1>조회</h1>
	<table>
		<tr>
			<td width=80><p align=center>이름</p></td> <!-- 두 번째 열 제목 -->
			<td width=70><p align=center>학번</p></td> <!-- 세 번째 열 제목 -->
			<td width=50><p align=center>국어</p></td> <!-- 네 번째 열 제목 -->
			<td width=50><p align=center>영어</p></td> <!-- 다섯 번째 열 제목 -->
			<td width=50><p align=center>수학</p></td> <!-- 여섯 번째 열 제목 -->
			<td width=50><p align=center>합계</p></td> <!-- 일곱 번째 열 제목 -->
			<td width=80><p align=center>평균</p></td> <!-- 여덟 번째 열 제목 -->
			<td width=50><p align=center>등수</p></td> <!-- 아홉 번째 열 제목 -->
		</tr>
		<%
         }%>
		<%
		for (int i = 0; i < studentScores.size(); i++) { // i는 0부터 리스트 갯수만큼 루프
			StudentScore studentScore = studentScores.get(i); // 점수 가져옴

			out.println("<tr>");
			out.println("<td width=50><p align=center>" + studentScore.getName() + "</p></td>"); // 학생 이름 출력
			out.println("<td width=50><p align=center><a href='oneview.jsp?key=" + studentScore.getStudentid() + "'> "
			+ studentScore.getStudentid() + "</a></p></td>"); // 학번 출력 및 링크 추가
			out.println("<td width=50><p align=center>" + studentScore.getKor() + "</p></td>"); // 국어 점수 출력
			out.println("<td width=50><p align=center>" + studentScore.getEng() + "</p></td>"); // 영어 점수 출력
			out.println("<td width=50><p align=center>" + studentScore.getMat() + "</p></td>"); // 수학 점수 출력
			out.println("<td width=50><p align=center>" + studentScore.getSum() + "</p></td>"); // 합계 점수 출력
			out.println("<td width=50><p align=center>" + studentScore.getAvg() + "</p></td>"); // 평균 점수 출력
			out.println("<td width=50><p align=center>" + studentScore.getRank() + "</p></td>"); // 등수 출력
			out.println("</tr>");
		}
		%>
	</table>

	<div style="text-align: center; width: 600;">
		<%
		if (10 < c) { // 현재페이지가 10보다 크면 밑에 버튼 출력
		%>
		<a href="AllviewDB.jsp?page=<%=pp%>">⇐</a> <!-- 첫 페이지로 이동 -->
		<a href="AllviewDB.jsp?page=<%=p%>">←</a> <!-- 이전 페이지 그룹으로 이동 -->
		<%
		}
		%>

		<%
		for (int i = s; i <= e; i++) { // 그룹 시작 페이지부터 그룹 마지막 페이지까지 루프
		%>
		<%
		if (i == c) { // 현재 페이지면 밑에 버튼 출력
		%>
		<a href="AllviewDB.jsp?page=<%=i%>" class="current_page"><%=i%></a> <!-- 현재 페이지 그룹 스타일 지정 -->
		<%
		} else { // 현재 페이지가 아니면 밑에 버튼 출력
		%>
		<a href="AllviewDB.jsp?page=<%=i%>"><%=i%></a> <!-- 스타일 없는 현재 페이지 그룹 -->
		<%
		}
		%>
		<%
		}
		%>
		<%
		if (nn != -1) { // 마지막 페이지가 -1이 아니면 밑에 버튼 출력
		%>
		<a href="AllviewDB.jsp?page=<%=n%>">→</a> <!-- 다음 페이지 그룹으로 이동 -->
		<a href="AllviewDB.jsp?page=<%=nn%>">⇒</a> <!-- 마지막 페이지로 이동 -->
		<%
		}
		%>
	</div>
		<%
	} catch (Exception e) {
		e.toString();
		out.println("Error: The table 'examtable' does not exist."); // 테이블 없으면 에러 출력
	}
	%>
</body>

</html>

