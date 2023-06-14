<%@page import="domain.Stock"%>
<%@page import="dao.StockDao"%>
<%@page import="dao.StockDaoImpl"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>

<%
request.setCharacterEncoding("UTF-8"); // utf-8로 인코딩 설정

String id = request.getParameter("key"); // key 값 받아서 id에 저장

Stock stock = new Stock(); // 객세 생성
StockDao stockDao = new StockDaoImpl(); // 객체 생성

int c = stockDao.currentPage(id, 20); // currentPage 메소드 호출해서 pageNum에 저장

stockDao.deleteProduct(id); // delete 메소드 호출하여 데이터 삭제
%>

<html>

<head>
</head>

<body>
	<script language="JavaScript">
		window.onload = function() { // 페이지 로드되면 실행되는 함수 정의
			confirm("상품이 삭제되었습니다.") // 대화상자 표시
			location.href = "stock_list.jsp?page=<%=c%>";
}; // 페이지 매개변수 받아 목록 페이지로 이동
	</script>

</body>

</html>
