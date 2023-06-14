<%@page import="domain.Gongji"%>
<%@page import="dao.GongjiDaoImpl"%>
<%@page import="dao.GongjiDao"%>
<%@ page contentType="text/html; charset=utf-8" language="java" %>

<html>
<body>
<%
	request.setCharacterEncoding("UTF-8"); // utf-8로 인코딩 설정
	
	GongjiDao gongjiDao = new GongjiDaoImpl(); // DAO 객체 생성

	Gongji gongji = new Gongji(); // 공지 객체 생성
	
	String key = request.getParameter("key"); // key 값 받아오기

	if (key.equals("INSERT")) { // key 값이 INSERT일 경우
		
		String title = request.getParameter("title"); // title 값 받아오기
		String date = request.getParameter("date"); // date 값 받아오기
		String content = request.getParameter("content"); // content 값 받아오기
		int rootid = Integer.parseInt(request.getParameter("rootid")); // rootid 값 받아오기
		int relevel = Integer.parseInt(request.getParameter("relevel")); // relevel 값 받아오기
		int recnt = Integer.parseInt(request.getParameter("recnt")); // recnt 값 받아오기
		
		// 제목, 날짜, 본문, rootid, relevel, recnt, viewcnt 세팅 진행
		gongji.setTitle(title);
		gongji.setDate(date);
		gongji.setContent(content);
		gongji.setRootid(rootid);
		gongji.setRelevel(relevel);
		gongji.setRecnt(recnt);
		gongji.setViewcnt(0);
		
		
		int insert = gongjiDao.insertGongji(gongji); // 세팅한 공지 정보를 DB에 삽입
		
		if (insert == -1) { // 함수 실행 결과로 리턴된 값이 -1일 경우
			out.println("오류가 발생하여 글이 게시되지 않았습니다."); // 오류가 발생하였다는 안내문 출력
		} else { // 그 외에는
			%>
			<script language="JavaScript"> // 스크립트 작성 시작
			alert('게시되었습니다.'); // 게시되었다는 안내문 출력
			location.href='gongji_view.jsp?key=<%=insert%>'; // 추가된 해당 공지사항의 view 화면으로 이동
			</script>
			<%
		}
	}
	
	if (key.equals("UPDATE")) { // key 값이 UPDATE일 경우
	int id = Integer.parseInt(request.getParameter("id")); // 파라미터에서 id 값 받아옴
	
	String title = request.getParameter("title"); // title 받아옴
	String content = request.getParameter("content"); // content 받아옴
	String date = request.getParameter("date"); // date 받아옴
	
	gongji.setId(id); // id값 세팅
	gongji.setTitle(title); // 공지사항 제목 세팅
	gongji.setContent(content); // 본문 내용 세팅
	
	int update = gongjiDao.updateGongji(gongji); // 세팅한 값으로 업데이트 진행
	
	if (update == -1) { // 함수 호출 후 리턴된 값이 -1일 경우
		out.println("오류가 발생하여 수정사항이 적용되지 않았습니다."); // 오류 메시지 출력
	}
	if (update != -1) {
// alert 띄운 후 gongji_view로 연결
%>
<script language="JavaScript"> // 스크립트 작성 시작
alert('수정되었습니다.'); // 수정되었다는 안내문 출력
location.href='gongji_view.jsp?key=<%=id%>'; // 해당 id의 정보 페이지로 이동
</script>
<%}}%>
</body>

</html>