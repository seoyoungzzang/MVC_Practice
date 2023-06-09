<%@page import="kr.ac.kopo.ctc.kopo34.domain.StudentScore"%>
<%@page import="kr.ac.kopo.ctc.kopo34.dao.StudentScoreDao"%>
<%@page import="kr.ac.kopo.ctc.kopo34.dao.StudentScoreDaoImpl"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>

<%
String name = request.getParameter("name"); // 이름 전달받기
String studentid = ""; // 학번 선언 및 초기화
String kor = request.getParameter("kor"); // 국어 점수 전달받기
String eng = request.getParameter("eng"); // 영어 점수 전달받기
String mat = request.getParameter("mat"); // 수학 점수 전달받기
%>

<%
try {
	StudentScoreDao studentScoreDao = new StudentScoreDaoImpl(); // studentScoreDao 객체 생성
	StudentScore studentScore = new StudentScore(); // studentScore 객체 생성
	studentScore.setName(name); // 이름 저장
	studentScore.setKor(Integer.parseInt(kor)); // 국어 점수 저장
	studentScore.setEng(Integer.parseInt(eng)); // 영어 점수 저장
	studentScore.setMat(Integer.parseInt(mat)); // 수학 점수 저장
	StudentScore printResult = studentScoreDao.create(studentScore); // 데이터 삽입
	studentid = printResult.getStudentid(); // 학번 불러오기
%>

<html>

<head>
</head>

<body>
	<h1>성적입력추가완료</h1> <!-- h1 내용 입력 -->
	<form method="get"> <!-- get 형식 form 열기 -->
		<input type="button" value="뒤로가기" onclick="location.href='inputForm1.html'"> <!-- button 생성 및 클릭하면 inputForm1.html로 이동 -->
	</form> <!-- form 닫기 -->
	<table collspacing=1 width=600 border=1> <!-- table 열기 및 스타일 지정 -->
		<tr> <!-- tr 열기 -->
			<td width=50><p align=center>이름</p></td> <!-- 첫 번째 열: 이름 -->
			<td width=50><p align=center><%=name%></p></td> <!-- 두 번째 열 : 이름 입력 값 가져옴 -->
		</tr> <!-- tr 닫기 -->
		<tr> <!-- tr 열기 -->
			<td width=50><p align=center>학번</p></td> <!-- 첫 번째 열: 학번 -->
			<td width=50><p align=center><%=studentid%></p></td> <!-- 두 번째 열 : 학번 저장 값 가져옴 -->
		</tr> <!-- tr 닫기 -->
		<tr> <!-- tr 열기 -->
			<td width=50><p align=center>국어</p></td> <!-- 첫 번째 열: 국어 점수 -->
			<td width=50><p align=center><%=kor%></p></td> <!-- 두 번째 열 : 국어 점수 입력 값 가져옴 -->
		</tr> <!-- tr 닫기 -->
		<tr> <!-- tr 열기 -->
			<td width=50><p align=center>영어</p></td> <!-- 첫 번째 열: 영어 점수 -->
			<td width=50><p align=center><%=eng%></p></td> <!-- 두 번째 열 : 영어 점수 입력 값 가져옴 -->
		</tr> <!-- tr 닫기 -->
		<tr> <!-- tr 열기 -->
			<td width=50><p align=center>수학</p></td> <!-- 첫 번째 열: 수학 점수 -->
			<td width=50><p align=center><%=mat%></p></td> <!-- 두 번째 열 : 수학 점수 입력 값 가져옴 -->
		</tr> <!-- tr 닫기 -->
	</table> <!-- table 닫기 -->
	<%
	} catch (Exception e) {
	e.toString();
	}
	%>
</body>

</html>