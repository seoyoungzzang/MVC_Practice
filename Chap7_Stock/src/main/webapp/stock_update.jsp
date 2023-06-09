<%@page import="domain.Stock"%>
<%@page import="dao.StockDao"%>
<%@page import="dao.StockDaoImpl"%>
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
	border: 1px solid #ddd; /* Update border color to a lighter shade */
}

th {
	background: #FFCD28;
	color: #fff;
	padding: 5px;
}

td {
	padding: 5px;
	border: 1px solid #ddd; /* Update border color to a lighter shade */
}

tr:nth-child(even) {
	background-color: #FDF5E6;
}

button {
	float: right;
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

textarea {
	width: 500px;
	height: 250px;
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
		const form = document.getElementById('inputForm1');
		const stockNum = form.elements.stockNum.value;
		const pattern2 = /^(?:0|[1-9]\d{0,4}|100000)$/; // 0 이상의 정수만 입력 가능한 패턴2

		if (mode == "write") {
			if (stockNum.trim() === '') {
				alert("재고 수량을 입력해주세요.");
				return;
			}
			if (!pattern2.test(stockNum)) {
				alert("재고 수량은 0 이상 100000 이하 정수만 입력 가능합니다.");
				return;
			}
			form.action = "stock_write.jsp?key=UPDATE";
		}
		form.submit();
	}
</script>
</head>

<body>
	<div class="container">
		<h1>(주)서영 재고 현황 - 재고 수정</h1>
		<form method="post" name="fm" id="inputForm1">
			<table>
				<tr>
					<th>상품번호</th>
					<td><input type="text" name="id" value="<%=stock.getId()%>"
						readonly></td>
				</tr>
				<tr>
					<th>상품명</th>
					<td><input type="text" name="name" size="70" maxlength="70"
						value="<%=stock.getName()%>" readonly></td>
				</tr>
				<tr>
					<th>재고현황</th>
					<td><input type="number" name="stockNum" size="10"
						value="<%=stock.getStockNum()%>"></td>
				</tr>
				<tr>
					<th>상품등록일</th>
					<td><%=stock.getRegDate()%></td>
				</tr>
				<tr>
					<th>재고등록일</th>
					<td><%=stock.getStockDate()%></td>
				</tr>
				<tr>
					<th>상품설명</th>
					<td><textarea name="content" cols="70" rows="600" readonly><%=stock.getContent()%></textarea></td>
				</tr>
				<tr>
					<th>상품사진</th>
					<td><img src="<%=stock.getImage()%>"
						style="width: 200px; height: 200px;"></td>
				</tr>
				<tr>
					<td colspan="2" class="button-container">
						<button type="button" onclick="location.href='stock_list.jsp'">취소</button>
						<button type="button" onclick="submitForm('write')">수정</button>
					</td>
				</tr>
				<input type="hidden" name="key" value="UPDATE">
			</table>
		</form>
	</div>
</body>

</html>

