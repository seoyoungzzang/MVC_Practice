<%@page import="dao.VoteProgramDao"%>
<%@page import="dao.VoteProgramDaoImpl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.VoteProgram"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<html>

<head>
<title>후보등록 A_01_H.jsp</title>
<script>
	function confirmDelete() { // 삭제 확인하는 함수 생성
		return confirm("정말 삭제하시겠습니까?"); // 해당 문구 띄움
	}

	function insertHubo() { // 후보 입력 규칙 함수 생성
		const form = document.getElementById('inputForm1'); // 해당 id를 가진 요소 반환
		const name = form.elements.name.value; // name 필드 값을  name에 저장

		const pattern = /^([a-zA-Z]|[가-힣])+$/; // 영어 대소문자 또는 한글로 이루어진 패턴

		if (name.trim() === '') { // 입력창이 비어있으면
			alert("데이터를 모두 입력해주세요."); // 해당 메세지 출력
			return; // 함수 실행 종료
		}
		if (!pattern.test(name)) { // 이름에 유효한 한글 또는 영어가 입력되지 않으면
			alert("이름은 정확한 한글 또는 영어만 입력 가능합니다."); // 해당 메세지 출력
			return; // 함수 실행 종료
		}
		if (name.length > 20) { // 이름이 20자 이상이면
			alert("이름은 20자 이하만 입력 가능합니다."); // 해당 메세지 출력
			return; // 함수 실행 종료
		}
		form.action = "A_03_H.jsp"; // form의 action 속성 설정
		form.submit(); // form 요소 제출
	}
</script>
</head>

<body>
	<table cellspacing=3 width=600 border=1>
		<tr>
			<td width=100 bgcolor="#CBB8EE" style="text-align:center;"><a href="A_01_H.jsp">후보등록</a></td> <!-- 스타일 지정 및 하이퍼링크 연결 --> 
			<td width=100 style="text-align:center;"><a href="B_01_H.jsp">투표</a></td> <!-- 스타일 지정 및 하이퍼링크 연결 -->
			<td width=100 style="text-align:center;"><a href="C_01_H.jsp">개표결과</a></td> <!-- 스타일 지정 및 하이퍼링크 연결 -->
		</tr>
	</table>

	<h1>후보등록</h1> <!-- 글자 입력 -->

	<table cellspacing=3 width=600 border=1> <!-- table 스타일 지정 -->
		<tr>
			<td><p align=center>후보명 입력</p></td> <!-- 해당 문자 입력 -->
		</tr>
		<%
		VoteProgramDao voteProgramDao = new VoteProgramDaoImpl(); // voteProgramDao 객체 생성
		List<VoteProgram> votePrograms = voteProgramDao.selectAll(); // 후보 프로그램 리스트 가져오기
		int id = voteProgramDao.CalcId(); // CalcId 메소드 호출해서 id 저장

		for (int i = 0; i < votePrograms.size(); i++) { // i는 0부터 리스트 사이즈만큼 루프
			VoteProgram voteProgram1 = votePrograms.get(i); // voteProgram1객체에 리스트 레코드 저장
			out.println("<tr>"); // tr 열기
			out.println("<td>"); // tr 열기 및 스타일 지정
			out.println("<form method='post' action='A_02_H.jsp' onsubmit='return confirmDelete()'>"); // 삭제 누르면 알림창 출력
			out.println("기호 : <input type='text' name='id' value='" + voteProgram1.getId() + "' readonly>"); // 기호 표시
			out.println("이름 : <input type='text' name='name' value='" + voteProgram1.getName() + "' readonly>"); // 이름 표시
			out.println("<input type='submit' value='삭제'>"); // 삭제 페이지로 이동
			out.println("</form>"); // form 닫기
			out.println("</td>"); // td 닫기
			out.println("</tr>"); // tr 닫기
		}
		out.println("<tr>"); // tr 열기
		out.println("<td>"); // td 열기
		out.println("<form method='post' id='inputForm1' action='A_03_H.jsp'>"); // 후보 추가하는 form
		out.println("기호 : <input type='text' name='id' value='" + id + "' readonly>"); // 다음 기호 표시
		out.println("이름 : <input type='text' name='name' value=''>"); // 이름 입력
		out.println("<input type='button' value='추가' onclick='insertHubo()'>"); // 추가 버튼
		out.println("</form>"); // form 닫기
		out.println("</td>"); // td 닫기
		out.println("</tr>"); // tr 닫기
		%>
	</table>
</body>

</html>
