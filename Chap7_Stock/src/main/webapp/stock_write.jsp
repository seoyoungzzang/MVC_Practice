<%@page import="domain.Stock"%>
<%@page import="dao.StockDaoImpl"%>
<%@page import="dao.StockDao"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>

<html>

<head>
<%
StockDao stockDao = new StockDaoImpl();
Stock stock = new Stock();

request.setCharacterEncoding("UTF-8"); // utf-8로 인코딩 설정

String key = request.getParameter("key");
int id = Integer.parseInt(request.getParameter("id"));
int stockNum = Integer.parseInt(request.getParameter("stockNum"));
String stockDate = request.getParameter("stockDate");

int c = 0;

if (key.equals("UPDATE")) {
	
	stock.setId(id);
	stock.setStockNum(stockNum);
	stock.setStockDate(stockDate);

	c = stockDao.currentPage(id, 20); // currentPage 메소드 호출해서 pageNum에 저장
	stockDao.updateStock(stock);
}
%>
</head>

<body>
	<script language="JavaScript">
		window.onload = function() {
			var key = "<%=key%>"; // key 값을 JavaScript 변수에 할당합니다.
			
			if (key === "UPDATE") { // UPDATE인 경우
				if (confirm("상품 정보가 수정되었습니다. 확인을 누르면 목록으로 이동합니다.")) {
					location.href = "stock_list.jsp?page=<%=c%>";
				} else {
					location.href = "stock_view.jsp?key=<%=id%>";
				}
			}
		};
	</script>
</body>

</html>