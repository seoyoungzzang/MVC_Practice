<%@page import="domain.Stock"%>
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
	border-collapse: collapse;
	width: 800px;
	margin: 20px auto;
	background: #fff;
	border: 1px solid #ccc;
}

th {
	background: #FFCD28;
	color: #fff;
	padding: 10px;
	height: 50px;
}

td {
	padding: 10px;
	border: 1px solid #ccc;
}

tr:nth-child(even) {
	background-color: #FDF5E6;
}

button {
	background-color: #FF9100;
	color: #fff;
	border: none;
	border-radius: 10px;
	padding: 8px 16px;
	cursor: pointer;
	font-size: 14px;
	font-weight: bold;
}

.button-container {
	text-align: right;
	margin-top: 20px;
}
</style>
<%
int id = Integer.parseInt(request.getParameter("key"));

StockDao stockDao = new StockDaoImpl();
Stock stock = new Stock();

stock = stockDao.selectOne(id);
%>
<script language="JavaScript">
	function submitForm(mode) {
		if (mode == "update") {
			fm.action = "stock_update.jsp?key=<%=id%>";
			fm.submit();
		} else if (mode == "delete") {
			if (confirm("해당 상품을 정말 삭제하시겠습니까?")) {
			fm.action = "product_delete.jsp?key=<%=id%>";
				fm.submit();
			}
		}
	}
</script>
</head>

<body>
	<div class="container">
		<h1>(주)서영 재고 현황 - 전체 현황</h1>
		<form method="post" name="fm">
			<table>
				<tr>
					<th>상품번호</th>
					<td><%=stock.getId()%></td>
				</tr>
				<tr>
					<th>상품명</th>
					<td><%=stock.getName()%></td>
				</tr>
				<tr>
					<th>재고 현황</th>
					<td><%=stock.getStockNum()%></td>
				</tr>
				<tr>
					<th>상품등록일</th>
					<td><%=stock.getRegDate()%></td>
				</tr>
				<tr>
					<th>재고파악일</th>
					<td><%=stock.getStockDate()%></td>
				</tr>
				<tr>
					<th>상품설명</th>
					<td><%=stock.getContent()%></td>
				</tr>
				<tr>
					<th>상품사진</th>
					<td><img src="<%=stock.getImage()%>" style="width: 200px; height: 200px;"></td>
				</tr>

				<tr>
					<td colspan="2" class="button-container">
						<button type="button" onclick="submitForm('delete')">상품삭제</button>
						<button type="button" onclick="submitForm('update')">재고수정</button>
						<button type="button" onclick="location.href='stock_list.jsp'">목록</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>