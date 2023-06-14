<%@page import="domain.Stock"%>
<%@page import="dao.StockDaoImpl"%>
<%@page import="dao.StockDao"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>

<html>

<head>
<%
StockDao stockDao = new StockDaoImpl(); // 객체 생성
Stock stock = new Stock(); // 객체 생성

request.setCharacterEncoding("UTF-8"); // utf-8로 인코딩 설정

String key = request.getParameter("key"); // key 값 받아서 저장
String id = request.getParameter("id"); // id 값 받아서 저장
int stockNum = Integer.parseInt(request.getParameter("stockNum")); // stockNum 값 받아서 정수 변환 후 저장
String stockDate = request.getParameter("stockDate"); // stockDate 값 받아서 저장

int c = 0; //  현재페이지 변수 선언 및 초기화

if (key.equals("UPDATE")) { // key가 UPDATE면
	
	stock.setId(id); // 상품 번호 설정
	stock.setStockNum(stockNum); // 재고수량 설정
	stock.setStockDate(stockDate); // 재고확인일 설정

	c = stockDao.currentPage(id, 20); // currentPage 메소드 호출해서 pageNum에 저장
	stockDao.updateStock(stock); // 재고수량 업데이트
}
%>
</head>

<body>
	<script language="JavaScript">
		window.onload = function() { // 이벤트 핸들러 함수 실행
			var key = "<%=key%>"; // key 값을 JavaScript 변수에 할당합니다.
			
			if (key === "UPDATE") { // UPDATE인 경우
				if (confirm("상품 정보가 수정되었습니다. \n확인을 누르면 목록으로 이동합니다.")) { // 확인 누르면 목록 페이지로 이동
					location.href = "stock_list.jsp?page=<%=c%>"; 
				} else {
					location.href = "stock_view.jsp?key=<%=id%>";
				} // 취소 누르면 상세페이지로 이동
			}
		};
	</script>
</body>

</html>