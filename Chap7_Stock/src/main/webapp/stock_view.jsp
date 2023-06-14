<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
String id = request.getParameter("key"); // key값 받아서 id에 저장

StockDao stockDao = new StockDaoImpl(); // 객체 생성
Stock stock = new Stock(); // 객체 생성

int c = stockDao.currentPage(id, 20); // currentPage 메소드 호출해서 pageNum에 저장

stock = stockDao.selectOne(id); // id 값 받아서 특정 데이터 조회

if (stock == null || stock.getName() == null) { // 조회한 id가 DB에 없으면
    out.println("<script>alert('등록되지 않은 상품입니다.'); window.location.href='stock_list.jsp';</script>"); // 알림창 띄우고 목록 페이지로 이동
} else {
%>
<script language="JavaScript">
	function submitForm(mode) { // mode에 따른 제출 함수 선언
		if (mode == "update") { // mode가 update면
			fm.action = "stock_update.jsp?key=<%=id%>"; 
			fm.submit(); // id 값 받아서 수정 페이지로 이동
		} else if (mode == "delete") { // mode가 delete면
			if (confirm("해당 상품을 정말 삭제하시겠습니까?")) { // 확인 알림창 띄우고
			fm.action = "product_delete.jsp?key=<%=id%>";
				fm.submit();
			} // id 값 받아서 삭제 페이지로 이동
		}
	}
</script>
</head>

<body>
	<div class="container">
	out.println())
		<h1>(주)서영 재고 현황 - 전체 현황</h1> <!-- h1 입력 -->
		<form method="post" name="fm"> <!-- post 형식, name이 fm인 form -->
			<table>
				<tr>
					<th>상품번호</th> <!-- th 입력 -->
					<td><%=stock.getId()%></td> <!-- 상품 번호 가져오기 -->
				</tr>
				<tr>
					<th>상품명</th> <!-- th 입력 -->
					<td><%=stock.getName().replaceAll("<", "&lt;").replaceAll(">", "&gt;")%></td> <!-- 상품명 가져오기 -->
				</tr>
				<tr>
					<th>재고 수량</th> <!-- th 입력 -->
					<td><%=stock.getStockNum()%></td> <!-- 재고 수량 가져오기 -->
				</tr>
				<tr>
					<th>상품등록일</th> <!-- th 입력 -->
					<td><%=stock.getRegDate()%></td> <!-- 상품등록일 가져오기 -->
				</tr>
				<tr>
					<th>재고파악일</th> <!-- th 입력 -->
					<td><%=stock.getStockDate()%></td> <!-- 재고파악일 가져오기 -->
				</tr>
				<tr>
					<th>상품설명</th> <!-- th 입력 -->
					<td style="max-width: 300px; word-wrap: break-word;">
					<textarea name="content" cols="30" rows="10" style="width: 500px; resize: none; overflow: auto;" readonly><%=stock.getContent()%></textarea>
					</td> <!-- 상품설명 가져오기 -->
				</tr>
				<tr>
				  <th>상품사진</th> <!-- 테이블 헤더 셀 (th) -->
				  <% if (stock.getImage() == null || stock.getImage().equals("./image/null")) { %> <!-- 이미지가 없거나, null이면 -->
				    <td><img src="./image/no_image.jpg" style="width: 200px; height: 200px;"></td> <!-- no_image.jpg가져오기 -->
				  <% } else { %>
				    <td><img src="<%=stock.getImage()%>" style="width: 200px; height: 200px;"></td> <!-- 상품사진 가져오기 -->
				  <% } %>
				</tr>

				<tr>
					<td colspan="2" class="button-container">
						<button type="button" onclick="location.href='stock_list.jsp?page=<%=c%>'">목록</button> <!-- 버튼 누르면 목록 페이지로 이동 -->
						<button type="button" onclick="submitForm('delete')">상품삭제</button> <!-- 버튼 누르면 함수 호출하여 상품 삭제 페이지로 이동 -->
						<button type="button" onclick="submitForm('update')">재고수정</button> <!-- 버튼 누르면 함수 호출하여 재고 수정 페이지로 이동 -->
					</td>
				</tr>
			</table>
		</form>
	</div>
	<%
	}
	%>
</body>
</html>