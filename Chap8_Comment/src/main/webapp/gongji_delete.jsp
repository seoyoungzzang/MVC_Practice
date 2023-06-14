<%@page import="dao.GongjiDao"%>
<%@page import="dao.GongjiDaoImpl"%>
<%@ page contentType="text/html; charset=utf-8" language="java" %>

<html>

<body>
<%
int id = Integer.parseInt(request.getParameter("id")); // id 값 받아오기

GongjiDao gongjiDao = new GongjiDaoImpl(); // DAO 객체 생성

gongjiDao.deleteOneGongji(id); // 해당 id의 공지 DB에서 삭제

int pageValue = Integer.parseInt(request.getParameter("page")); // 페이지 값 받아옴
%>
<script> // 스크립트 작성 시작
alert('정상적으로 삭제되었습니다.'); // 삭제되었다는 안내문 출력
window.location='gongji_list.jsp?key=<%=id%>&page=<%=pageValue%>'; // 리스트에서 해당 id가 존재하는 페이지로 이동
</script>
</body>

</html>