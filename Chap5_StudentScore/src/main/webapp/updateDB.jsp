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

table {
	collspacing: 1;
	width: 600;
	border: 1;
}
</style>
</head>

<body>
	<%
	String name = ""; // 문자열 변수 선언 및 초기화
	String studentid = ""; // 문자열 변수 선언 및 초기화
	int kor = 0; // 문자열 변수 선언 및 초기화
	int eng = 0; // 문자열 변수 선언 및 초기화
	int mat = 0; // 문자열 변수 선언 및 초기화

	try {
		name = request.getParameter("name"); // 이름 받아오기
		studentid = request.getParameter("studentid"); // 학번 받아오기
		kor = Integer.parseInt(request.getParameter("kor")); // 국어 점수 받아오기
		eng = Integer.parseInt(request.getParameter("eng")); // 영어 점수 받아오기
		mat = Integer.parseInt(request.getParameter("mat")); // 수학 점수 받아오기
	} catch (Exception e) {
		out.println(e);
	}

	StudentScoreDao studentScoreDao = new StudentScoreDaoImpl(); // studentScoreDao 객체 생성
	StudentScore studentScore = new StudentScore(); // studentScore 객체 생성

	studentScore.setName(name); // 이름 저장
	studentScore.setStudentid(studentid); // 학번 저장
	studentScore.setKor(kor); // 국어 점수 저장
	studentScore.setEng(eng); // 영어 점수 저장
	studentScore.setMat(mat); // 수학 점수 저장
	studentScoreDao.update(studentid, studentScore); // 메소드 호출하여 레코드 수정

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

	pageNum = studentScoreDao.currentPage(studentid, countPerPage); // currentPage 메소드 호출해서 pageNum에 저장

	List<StudentScore> studentScores = studentScoreDao.selectAll(pageNum, countPerPage); // 리스트 객체 생성

	StudentScoreService studentScoreService = new StudentScoreServiceImpl(); // studentScoreService 객체 생성
	Pagination pagination = studentScoreService.getPagination(pageNum, countPerPage); // 페이지네이션 객체 생성

	int c = pagination.getC(); // 현재 페이지
	int s = pagination.getS(); // 시작 페이지
	int e = pagination.getE(); // 끝 페이지
	int p = pagination.getP(); // 이전 페이지 그룹
	int pp = pagination.getPp(); // 첫 페이지
	int n = pagination.getN(); // 다음 페이지 그룹
	int nn = pagination.getNn(); // 마지막 페이지
	%>
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
		for (int i = 0; i < studentScores.size(); i++) {
			StudentScore studentScore1 = studentScores.get(i);
			if (studentScore1.getStudentid().equals(studentid)) { // 받은 studentid가 두 번째 열의 값과 일치하면
				out.println("<tr bgcolor = '#ffff00' >"); // tr 열기 및 스타일 지정
				out.println("<td width=50><p align=center>" + studentScore1.getName() + "</p></td>"); // 두 번째 열 값 출력
				out.println("<td width=50><p align=center><a href='oneview.jsp?key=" + studentScore1.getStudentid() + "'> "
				+ studentScore1.getStudentid() + "</a></p></td>"); // 세 번째 열 값 출력 및 링크 추가
				out.println("<td width=50><p align=center>" + Integer.toString(studentScore1.getKor()) + "</p></td>"); // 네 번째 열 값 출력
				out.println("<td width=50><p align=center>" + Integer.toString(studentScore1.getEng()) + "</p></td>"); // 다섯 번째 열 값 출력
				out.println("<td width=50><p align=center>" + Integer.toString(studentScore1.getMat()) + "</p></td>"); // 여섯 번째 열 값 출력
				out.println("<td width=50><p align=center>" + Integer.toString(studentScore1.getSum()) + "</p></td>"); // 일곱 번째 열 값 출력
				out.println("<td width=50><p align=center>" + Double.toString(studentScore1.getAvg()) + "</p></td>"); // 여덟 번째 열 값 출력
				out.println("<td width=50><p align=center>" + Integer.toString(studentScore1.getRank()) + "</p></td>"); // 아홉 번째 열 값 출력
				out.println("</tr>"); // tr 닫기
			} else { // 일치하지 않으면
				out.println("<tr>"); // tr 열기
				out.println("<td width=50><p align=center>" + studentScore1.getName() + "</p></td>"); // 두 번째 열 값 출력
				out.println("<td width=50><p align=center><a href='oneview.jsp?key=" + studentScore1.getStudentid() + "'> "
				+ studentScore1.getStudentid() + "</a></p></td>"); // 세 번째 열 값 출력 및 링크 추가
				out.println("<td width=50><p align=center>" + Integer.toString(studentScore1.getKor()) + "</p></td>"); // 네 번째 열 값 출력
				out.println("<td width=50><p align=center>" + Integer.toString(studentScore1.getEng()) + "</p></td>"); // 다섯 번째 열 값 출력
				out.println("<td width=50><p align=center>" + Integer.toString(studentScore1.getMat()) + "</p></td>"); // 여섯 번째 열 값 출력
				out.println("<td width=50><p align=center>" + Integer.toString(studentScore1.getSum()) + "</p></td>"); // 일곱 번째 열 값 출력
				out.println("<td width=50><p align=center>" + Double.toString(studentScore1.getAvg()) + "</p></td>"); // 여덟 번째 열 값 출력
				out.println("<td width=50><p align=center>" + Integer.toString(studentScore1.getRank()) + "</p></td>"); // 아홉 번째 열 값 출력
				out.println("</tr>"); // tr 닫기
			}
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
</body>

</html>

