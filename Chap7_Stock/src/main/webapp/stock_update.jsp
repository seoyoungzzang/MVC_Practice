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
String id = request.getParameter("key"); // key 값 받아서 id 에 저장

StockDao stockDao = new StockDaoImpl(); // 객체 생성
Stock stock = new Stock(); // 객체 생성

stock = stockDao.selectOne(id); // id 값 받아서 특정 데이터 조회
%>
<script language="JavaScript">
	function submitForm(mode) { // 예외처리 및 form 제출 함수 정의
		const form = document.getElementById('inputForm1'); // ID가 inputForm1인 폼 엘리먼트를 가져옴
		const stockNum = form.elements.stockNum.value; // stockNum 입력 필드 값 가져옴
		const pattern2 = /^(?:0|[1-9]\d{0,4}|100000)$/; // 0 이상의 정수만 입력 가능한 패턴2

		if (mode == "write") { // mode가 write이면
			if (stockNum.trim() === '') { // 재고수량이 공백이 입력되면
				alert("재고 수량은 0 이상 100000 이하 정수만 입력 가능합니다."); // 해당 메세지 출력
				return; // 함수 실행 종료
			}
			if (!pattern2.test(stockNum)) { // 재고수량이 0부터 100000사이의 값이 아니면
				alert("재고 수량은 0 이상 100000 이하 정수만 입력 가능합니다."); // 해당 메세지 출력
				return; // 함수 실행 종료
			}
			form.action = "stock_write.jsp?key=UPDATE"; // 확인 누르면 입력 실행 페이지로 이동
		}
		form.submit(); // form 제출
	}
</script>
</head>

<body>
	<div class="container">
		<h1>(주)서영 재고 현황 - 재고 수정</h1> <!-- h1 입력 -->
		<form method="post" name="fm" id="inputForm1"> <!-- post 형식, id를 inputForm1, stock_view.jsp 페이지로 내용 제출-->
			<table>
				<tr>
					<th>상품번호</th> <!-- th 입력 -->
					<td><input type="text" name="id" value="<%=stock.getId()%>" readonly></td> <!-- 상품 번호 출력 -->
				</tr>
				<tr>
					<th>상품명</th> <!-- th 입력 -->
					<td><input type="text" name="name" size="70" maxlength="70" value="<%=stock.getName()%>" readonly></td> <!-- 상품명 출력 -->
				</tr>
				<tr>
					<th>재고현황</th> <!-- th 입력 -->
					<td><input type="number" name="stockNum" size="10" value="<%=stock.getStockNum()%>"></td> <!-- 재고 현황 출력 및 입력 -->
				</tr>
				<tr>
					<th>상품등록일</th> <!-- th 입력 -->
					<td><%=stock.getRegDate()%></td> <!-- 상품등록일 출력 -->
				</tr>
				<tr>
					<th>재고등록일</th> <!-- th 입력 -->
					<td><%=stock.getStockDate()%></td> <!-- 재고등록일 출력 -->
				</tr>
				<tr>
					<th>상품설명</th> <!-- th 입력 -->
					<td><textarea name="content" cols="70" rows="600" readonly style="resize: none; overflow: auto;"><%=stock.getContent()%></textarea></td> <!-- 상품 설명 출력 -->
				</tr>
				<tr>
					<th>상품사진</th> <!-- th 입력 -->
					 <% if (stock.getImage() == null || stock.getImage().equals("./image/null")) { %> <!-- 이미지가 없거나, null이면 -->
					  <td><img src="./image/no_image.jpg" style="width: 200px; height: 200px;"></td> <!-- no_image.jpg가져오기 -->
					  <% } else { %>
					<td><img src="<%=stock.getImage()%>" style="width: 200px; height: 200px;"></td> <!-- 상품 사진 가져오기 -->
					 <% } %>
				</tr>		
				
				<tr>
					<td colspan="2" class="button-container">
						<button type="button" onclick="history.back()">취소</button> <!-- 버튼 누르면 목록 페이지로 이동 -->
						<button type="button" onclick="submitForm('write')">수정</button> <!-- 수정 누르면 함수 호출하여 수정 실행 페이지로 이동 -->
					</td>
				</tr>
				<input type="hidden" name="key" value="UPDATE"> <!-- 업데이트 키 hidden으로 설정 -->
			</table>
		</form>
	</div>
</body>

</html>

