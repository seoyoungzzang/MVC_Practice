<%@page import="domain.Stock"%>
<%@page import="service.StockServiceImpl"%>
<%@page import="service.StockService"%>
<%@page import="dto.Pagination"%>
<%@page import="java.util.List"%>
<%@page import="dao.StockDaoImpl"%>
<%@page import="dao.StockDao"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<html>
<head>
<style>
body {
	background: #FFFF9;
	font-family: Arial, sans-serif;
}

.container {
	max-width: 800px;
	margin: 0 auto;
	padding: 20px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	padding: 10px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

th {
	background-color: #FFCD28;
	color: #fff;
}

tr:nth-child(even) {
	background-color: #FDF5E6;
}

.pagination {
	text-align: center;
	margin-top: 20px;
}

.pagination a {
	display: inline-block;
	padding: 8px 16px;
	text-decoration: none;
	color: #000;
	background-color: #f2f2f2;
	border-radius: 4px;
	transition: background-color 0.3s;
}

.pagination a:hover {
	background-color: #ddd;
}

.pagination .current_page {
	background-color: #FFCD28;
	color: #fff;
	font-weight: bold;
}

.new-button {
	float: right;
	background-color: #FF9100;
	color: #fff;
	border: none;
	border-radius: 10px;
	padding: 10px 20px;
	font-size: 14px;
	cursor: pointer;
}
</style>
<%
try {
	String pageValue = request.getParameter("page");
	int pageNum = 1;
	if (pageValue != null) {
		pageNum = Integer.parseInt(pageValue);
		if (pageNum < 1) {
	pageNum = 1;
		}
	}

	String countPerPageValue = request.getParameter("countPerPage");
	int countPerPage = 20;
	if (countPerPageValue != null) {
		countPerPage = Integer.parseInt(countPerPageValue);
		if (countPerPage < 1) {
	countPerPage = 20;
		}
	}

	StockDao stockDao = new StockDaoImpl();
	Stock stock = new Stock();
	List<Stock> stocks = stockDao.selectAll(pageNum, countPerPage);

	StockService stockService = new StockServiceImpl();
	Pagination pagination = stockService.getPagination(pageNum, countPerPage);

	int c = pagination.getC();
	int s = pagination.getS();
	int e = pagination.getE();
	int p = pagination.getP();
	int pp = pagination.getPp();
	int n = pagination.getN();
	int nn = pagination.getNn();
%>
</head>
<body>
	<div class="container">
	<h1>(주)서영 재고 현황 - 전체 현황</h1>
		<table>
			<tr>
				<th>상품번호</th>
				<th>상품명</th>
				<th>현재 재고수</th>
				<th>재고파악일</th>
				<th>상품등록일</th>
			</tr>
			<%
			for (int i = 0; i < stocks.size(); i++) {
				Stock stock1 = stocks.get(i);
			%>
			<tr>
				<td><p>
						<a href='stock_view.jsp?key=<%=stock1.getId()%>'><%=stock1.getId()%></a>
					</p></td>
				<td><p>
						<a href='stock_view.jsp?key=<%=stock1.getId()%>'><%=stock1.getName()%></a>
					</p></td>
				<td><p><%=stock1.getStockNum()%></p></td>
				<td><p><%=stock1.getStockDate()%></p></td>
				<td><p><%=stock1.getRegDate()%></p></td>
			</tr>
			<%
			}
			%>
			<tr>
				<td colspan="5">
					<button class="new-button"
						onclick="window.location='product_insert.jsp'">신규등록</button>
				</td>
			</tr>
		</table>

		<div class="pagination">
			<%
			if (10 < c) {
			%>
			<a href="stock_list.jsp?page=<%=pp%>">⇐</a> <a
				href="stock_list.jsp?page=<%=p%>">←</a>
			<%
			}
			%>

			<%
			for (int i = s; i <= e; i++) {
			%>
			<%
			if (i == c) {
			%>
			<a href="stock_list.jsp?page=<%=i%>" class="current_page"><%=i%></a>
			<%
			} else {
			%>
			<a href="stock_list.jsp?page=<%=i%>"><%=i%></a>
			<%
			}
			%>
			<%
			}
			%>

			<%
			if (nn != -1) {
			%>
			<a href="stock_list.jsp?page=<%=n%>">→</a> <a
				href="stock_list.jsp?page=<%=nn%>">⇒</a>
			<%
			}
			%>
		</div>
	</div>
	<%
	} catch (Exception e) {
	e.toString();
	out.println("Error: The table 'scmtable' does not exist.");
	}
	%>
</body>
</html>