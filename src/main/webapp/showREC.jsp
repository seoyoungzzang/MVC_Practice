<%@page import="kr.ac.kopo.ctc.kopo34.domain.StudentScore"%>
<%@page import="kr.ac.kopo.ctc.kopo34.dao.StudentScoreDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo34.dao.StudentScoreDao"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- html 한글처리 -->
<%@ page contentType="text/html; charset=utf-8"%>
<%-- 페이지의 콘텐츠 타입과 문자 인코딩 설정 --%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>
<%-- jsp파일에 java 클래스, java sql import --%>

<html> <!-- html 열기 -->

<head>
<%
try {
	String name = ""; // 문자열 변수 선언 및 초기화
	String studentid = ""; // 문자열 변수 선언 및 초기화
	String kor = ""; // 문자열 변수 선언 및 초기화
	String eng = ""; // 문자열 변수 선언 및 초기화
	String mat = ""; // 문자열 변수 선언 및 초기화

	String ctmp = request.getParameter("searchid"); // searchid 값 가져와서 ctmp에 저장
	if (ctmp.length() == 0) { //ctmp 길이가 0이면 (검색할 학번 값이 없는 경우)
		ctmp = "0"; // ctmp 변수에 0 할당 (기본 값으로 0 설정)
	}

	StudentScoreDao studentScoreDao = new StudentScoreDaoImpl(); // studentScoreDao 객체 생성
	StudentScore studentScore = new StudentScore(); // studentScore 객체 생성

	try {
		studentScore = studentScoreDao.selectOne(ctmp); // 검색한 아이디를 기준으로 조회
	} catch (Exception e) {
		e.printStackTrace();
	}

	if (studentScore.getName() == null) { // 해당 이름이 비어있으면
		studentid = "해당학번없음"; // 해당 학번 없음
	} else { // 아니면
		name = studentScore.getName(); // 이름 불러오기
		studentid = studentScore.getStudentid(); // 학번 불러오기
		kor = Integer.toString(studentScore.getKor()); // 국어 점수 불러오기
		eng = Integer.toString(studentScore.getEng()); // 영어 점수 불러오기
		mat = Integer.toString(studentScore.getMat()); // 수학 점수 불러오기
	}
%>
<script LANGUAGE="javaScript">
	function selectButton(mode) { // selectButton 함수 생성
		const form = document.getElementById('updateData'); // id가 inputForm1인 요소 가져오기
		if (mode == "update") { // mode가 update면
			const name = form.elements.name.value; // 이름 필드 값 가져오기
			const kor = form.elements.kor.value; // 국어 점수 필드 값 가져오기
			const eng = form.elements.eng.value; // 영어 점수 필드 값 가져오기
			const mat = form.elements.mat.value; // 수학점수 필드 값 가져오기
			const pattern1 = /^([a-zA-Z가-힣]+|[a-zA-Z0-9가-힣]+)$/; // 한글 또는 영어만 입력 가능한 패턴1, 한글, 영어, 숫자 조합도 입력 가능
			const pattern2 = /^(?:100|[1-9]?[0-9])$/; // 0부터 100 사이의 정수만 입력 가능한 패턴2

			if (name.trim() === '' || kor.trim() === '' || eng.trim() === ''
					|| mat.trim() === '') { // 입력 창이 비어있으면
				alert("데이터를 모두 입력해주세요."); // 해당 메세지 출력
				return; // 함수 실행 종료
			}
			if (!pattern1.test(name)) { // 이름에 유효한 한글 또는 영어가 입력되지 않으면
				alert("이름은 정확한 한글 또는 영어만 입력 가능합니다."); // 해당 메세지 출력
				return; // 함수 실행 종료
			}
			if (!pattern2.test(kor) || !pattern2.test(eng)
					|| !pattern2.test(mat)) { // 점수가 0부터 100사이의 값이 아니면
				alert("국어, 영어, 수학 점수는 0부터 100 사이의 정수만 입력 가능합니다."); // 해당 메세지 출력
				return; // 함수 실행 종료
			}
			if (name.length > 20) { // 이름이 20자 이상이면
				alert("이름은 20자 이하만 입력 가능합니다."); // 해당 메세지 출력
				return; // 함수 실행 종료
			}
			if (kor.includes('.') || eng.includes('.') || mat.includes('.')) { // 점수에 .이 포함되어 있으면
				alert("소수점을 입력할 수 없습니다."); // 해당 메세지 출력
				return; // 함수 실행 종료
			}
			myform.action = "updateDB.jsp"; // updateDB.jsp 파일 실행
			myform.submit(); // form 제출
		} else if (mode == "delete") { // mode가 delete면
			myform.action = "deleteDB.jsp"; // deleteDB.jsp 파일 실행
			myform.submit(); // form 제출
		}
	}
	function showData() {
		const form = document.getElementById('showRec');
		const studentid = form.elements.searchid.value; // 숫자로 변환하지 않고 그대로 가져옴
		const pattern1 = /^\d+$/;
		const pattern2 = /^.+$/;
		const pattern3 = /^[^.]*$/;
		if (!pattern1.test(studentid) || !pattern2.test(studentid)
				|| !pattern3.test(studentid)) {
			alert("유효한 값을 입력하세요");
		} else {
			form.action = "showREC.jsp";
			form.submit();
		}
	}
</script>
</head>

<body>
	<h1>성적 조회 후 정정/삭제</h1>
	<form method="get"> <!-- get 형식 form 열기 -->
		<input type="button" value="뒤로가기" onclick="location.href='inputForm2.html'"> <!-- button 생성 및 클릭하면 inputForm1.html로 이동 -->
	</form>
	<form method='get' id='showRec'> <!-- post 형식 id를 showRec로 설정-->
		<table cellspacing=1 width=400 border=0> <!-- table 열기 및 스타일 지정 -->
			<tr> <!-- tr 열기 -->
				<td width=100><p align=center>조회할 학번</p></td> <!-- p에 내용 입력 -->
				<td width=200><p align=center><input type='text' name='searchid' value=''></p></td> <!-- 학번 입력 받는 셀 생성 -->
				<td width=100><input type="button" value="조회" onclick="showData()"></td> <!-- button 클릭하면 함수 호출됨 -->
			</tr> <!-- tr 닫기 -->
		</table> <!-- table 닫기 -->
	</form> <!-- form 닫기 -->

	<form method='get' name='myform' id="updateData"> <!-- post 형식, name = myform, id=updateData 속성을 통해 form에 이름 부여 -->
		<table cellspacing=1 width=400 border=1> <!-- table 열기 및 스타일 지정 -->
			<tr> <!-- tr 열기 -->
				<td width=100><p align=center>이름</p></td> <!-- 첫 번째 열: 이름 -->
				<td width=300><p align=center><input type='text' name='name' value='<%=name%>'></p></td> <!-- 두 번째 열 : 이름 값 가져옴 -->
			</tr> <!-- tr 닫기 -->
			<tr> <!-- tr 열기 -->
				<td width=100><p align=center>학번</p></td> <!-- 첫 번째 열: 학번 -->
				<td width=300><p align=center><input type='text' name='studentid' value='<%=studentid%>'readonly></p></td> <!-- 두 번째 열 : 학번 값 가져옴, 수정 불가 -->
			</tr> <!-- tr 닫기 -->
			<tr> <!-- tr 열기 -->
				<td width=100><p align=center>국어</p></td> <!-- 첫 번째 열: 국어 점수 -->
				<td width=300><p align=center><input type='text' name='kor' value='<%=kor%>'></p></td> <!-- 두 번째 열 : 국어 점수 값 가져옴 -->
			</tr> <!-- tr 닫기 -->
			<tr> <!-- tr 열기 -->
				<td width=100><p align=center>영어</p></td> <!-- 첫 번째 열: 영어 점수 -->
				<td width=300><p align=center><input type='text' name='eng' value='<%=eng%>'></p></td> <!-- 두 번째 열 : 영어 점수 값 가져옴 -->
			</tr> <!-- tr 닫기 -->
			<tr> <!-- tr 열기 -->
				<td width=100><p align=center>수학</p></td> <!-- 첫 번째 열: 수학 점수 -->
				<td width=300><p align=center><input type='text' name='mat' value='<%=mat%>'></p></td> <!-- 두 번째 열 : 수학 점수 값 가져옴 -->
			</tr> <!-- tr 닫기 -->
		</table> <!-- table 닫기 -->
		<%
		if (studentid.length() != 0) { // 학번의 길이가 0이 아니면
			out.println("<table cellspacing=1 width=400 border=0>"); // table 열기 및 스타일 지정
			out.println("<tr>"); // tr 열기
			out.println("<td width=200></td>"); // 빈 셀 생성
			out.println(
			"<td width=100><p align=center><input type = button value=\"수정\" onclick=\"selectButton('update')\"</p></td>"); // selectButton 함수 호출
			out.println(
			"<td width=100><p align=center><input type = button value=\"삭제\" onclick=\"selectButton('delete')\"</p></td>"); // selectButton 함수 호출
			out.println("</tr>"); // tr 닫기
			out.println("</table>"); // table 닫기
		}
		%>
	</form>
	<!-- form 닫기 -->
	<%
	} catch (Exception e) {
	e.toString();
	out.println("Error: The table 'examtable' does not exist.");
	}
	%>
</body>

</html>