<%@page import="domain.Stock"%>
<%@page import="dao.StockDao"%>
<%@page import="dao.StockDaoImpl"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>

<%
request.setCharacterEncoding("UTF-8"); // utf-8로 인코딩 설정

int id = Integer.parseInt(request.getParameter("key"));

out.println(id);
Stock stock = new Stock();
StockDao stockDao = new StockDaoImpl();

int c = stockDao.currentPage(id, 20); // currentPage 메소드 호출해서 pageNum에 저장

stockDao.deleteProduct(id);
%>

<html>

<head>
</head>

<body>
	<script language="JavaScript">
		window.onload = function() {
			confirm("상품이 삭제되었습니다.")
			location.href = "stock_list.jsp?page=<%=c%>";
};
	</script>

</body>

</html>
