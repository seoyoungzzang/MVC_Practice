<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/> <!-- html 한글처리 -->
<%@ page contentType="text/html; charset=utf-8" %> <%-- 페이지의 콘텐츠 타입과 문자 인코딩 설정 --%>
<%@ page import="java.io.*, java.net.*" %> <%-- jsp파일에 java 클래스, java.net import --%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/> <!-- html 한글처리 -->

<html> <!-- html 열기 -->

<head> <!-- head 열기 -->
</head> <!-- head 닫기 -->

<body> <!-- body 열기 -->
<h1>JSP Database 실습1</h1> <!-- main 내용 입력 -->
<%
    String data; // 문자열 변수 선언
    int cnt = 0; // 정수형 변수 선언 및 초기화

    FileReader f = new FileReader("C:/Users/seoyoung/eclipse-workspace-web/Chap5_StudentScore/src/main/webapp/cnt.txt"); // 파일 읽는 객체 생성 및 경로 지정
    StringBuffer sb = new StringBuffer(); // 문자열 처리 위한 객체 생성
    int ch = 0; // 정수형 변수 선언 및 초기화

    while((ch = f.read()) != -1){ // 파일을 처음부터 읽으면서 루프
        sb.append((char)ch); //읽어온 문자 추가
    }
    data = sb.toString().trim().replace("\n",""); // sb 내용을 문자열로 변환하고, 공백 및 개행문자 제거하여 data에 할당
    f.close(); // 파일 닫기

    cnt = Integer.parseInt(data); // data를 정수로 변환하여 cnt에 할당
    cnt++; // cnt 1씩 증가
    data = Integer.toString(cnt); // cnt를 문자열로 변환하여 data에 할당
    out.println("<br><br>현재 홈페이지 방문 조회수는 ["+data+"] 입니다.</br>"); // 방문자 수 표시하여 html에 출력

    FileWriter f12 = new FileWriter("C:/Users/seoyoung/eclipse-workspace-web/Chap5_StudentScore/src/main/webapp/cnt.txt", false); // 파일 쓰는 객체 생성 및 경로 지정, 파일 덮어씀
    f12.write(data); // data를 파일에 씀
    f12.close(); // 파일 닫기
%>
</body> <!-- body 닫기 -->

</html> <!-- html 닫기 -->

