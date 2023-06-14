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
	String pageValue = request.getParameter("page"); // page 파라미터에서 값을 가져와 pageValue에 지정
	int pageNum = 1; // pageNum 변수 선언 및 초기화 
	if (pageValue != null) { // pageValue 값이 null이 아닌 경우
		pageNum = Integer.parseInt(pageValue); // 받아온 파라미터 값을 pageNum에 저장
		if (pageNum < 1) { // 1보다 작으면
			pageNum = 1; // 1로 설정
		}
	}

	String countPerPageValue = request.getParameter("countPerPage"); // countPerPage 파라미터에서 값을 가져와 countPerPageValue에 지정
	int countPerPage = 20; // countPerPage 변수 선언 및 초기화
	if (countPerPageValue != null) { // countPerPageValue 값이 null이 아닌 경우
		countPerPage = Integer.parseInt(countPerPageValue); // 받아온 파라미터 값을 countPerPage에 저장
		if (countPerPage < 1) { // 1보다 작으면
			countPerPage = 20; // 20으로 설정
		}
	}

	StockDao stockDao = new StockDaoImpl(); // 객체 생성
	Stock stock = new Stock(); // 객체 생성
	List<Stock> stocks = stockDao.selectAll(pageNum, countPerPage); // 리스트 객체 생성하여 전체 조회 메소드 호출

	StockService stockService = new StockServiceImpl(); // 객체 생성
	Pagination pagination = stockService.getPagination(pageNum, countPerPage); // 페이지네이션

	int c = pagination.getC(); // 현재 페이지 번호
	int s = pagination.getS(); // 시작 페이지 번호
	int e = pagination.getE(); // 끝 페이지 번호
	int p = pagination.getP(); // 이전 페이지 번호
	int pp = pagination.getPp(); // 이전의 이전 페이지 번호
	int n = pagination.getN(); // 다음 페이지 번호
	int nn = pagination.getNn(); // 다음의 다음 페이지 번호
%>
</head>
<script language="JavaScript">
	function searchId() { // 상품명 검색 예외처리 함수
		const form = document.getElementById('inputForm1'); // ID가 inputForm1인 폼 엘리먼트를 가져옴
		const id = form.elements.key.value; // id 입력 필드 값 가져옴
		const pattern3 = /^[a-zA-Z0-9]*$/; // 알파벳과 숫자만 입력가능한 패턴3

		if (id.trim() === '') { // 입력 창이 공백이면
			alert("상품 번호를 입력해주세요."); // 해당 메세지 출력
			return false; // form 제출 방지
		}
		if (id.length > 20) { // 상품번호에 20자리 이상 정수가 입력되면
		    alert("상품번호는 20자리 이하만 입력 가능합니다."); // 해당 메세지 출력
		    return; // 함수 실행 종료
		}
		if (!pattern3.test(id)) { // 이름에 유효한 한글 또는 영어가 입력되지 않으면
			alert("상품번호는 20자리 이하만 영문/숫자만 입력 가능합니다."); // 해당 메세지 출력
			return; // 함수 실행 종료
		}
		form.action = "stock_view.jsp?key=" + id; // 해당 key 값을 가진 상세페이지로 이동
		return true; // form 제출
	}
</script>
<body>
	<div class="container">
		<h1>(주)서영 재고 현황 - 전체 현황</h1> <!-- h1 입력 -->
		<div style="text-align: right">
			<form action="stock_view.jsp" method="post" id="inputForm1"> <!-- post 형식, id를 inputForm1, stock_view.jsp 페이지로 내용 제출-->
				<input type="text" name="key" placeholder="상품 번호 입력" autofocus>  <!-- 상품 번호 입력 받는 검색창 -->
				<input type="submit" value="검색" onclick="return searchId();"> <!-- 검색 버튼 누르면 searchId() 메소드 호출 -->
			</form>
		</div>
		<br>
		<table>
			<tr>
				<th>상품번호</th> <!-- th 입력 -->
				<th>상품명</th> <!-- th 입력 -->
				<th>현재 재고수</th> <!-- th 입력 -->
				<th>재고파악일</th> <!-- th 입력 -->
				<th>상품등록일</th> <!-- th 입력 -->
			</tr>
			<%
			for (int i = 0; i < stocks.size(); i++) { // stocks 크기만큼 루프
				Stock stock1 = stocks.get(i); // i번째 데이터를 stock에 할당
			%>
			<tr>
				<td><p>
						<a href='stock_view.jsp?key=<%=stock1.getId()%>'><%=stock1.getId()%></a> <!-- 상품번호 누르면 상세페이지 이동 -->
					</p></td>
				<td><p>
						<a href='stock_view.jsp?key=<%=stock1.getId()%>'><%=stock1.getName().replaceAll("<", "&lt;").replaceAll(">", "&gt;")%></a> <!-- 상품명 누르면 상세페이지 이동 -->
					</p></td>
				<td><p><%=stock1.getStockNum()%></p></td> <!-- 재고수량 표시 -->
				<td><p><%=stock1.getStockDate()%></p></td> <!-- 재고확인일 표시 -->
				<td><p><%=stock1.getRegDate()%></p></td> <!-- 상품등록일 표시 -->
			</tr>
			<%
			}
			%>
			<tr>
				<td colspan="5">
					<button class="new-button" onclick="window.location='product_insert.jsp'">신규등록</button> <!-- 신규등록 버튼 -->
				</td>
			</tr>
		</table>

		<div class="pagination">
			<%
			if (10 < c) { // 현재페이지가 10보다 크면 밑에 버튼 출력
			%>
			<a href="stock_list.jsp?page=<%=pp%>">⇐</a>
			<!-- 첫 페이지로 이동 -->
			<a href="stock_list.jsp?page=<%=p%>">←</a>
			<!-- 이전 페이지 그룹으로 이동 -->
			<%
			}
			%>

			<%
			for (int i = s; i <= e; i++) { // 그룹 시작 페이지부터 그룹 마지막 페이지까지 루프
			%>
			<%
			if (i == c) { // 현재 페이지면 밑에 버튼 출력
			%>
			<a href="stock_list.jsp?page=<%=i%>" class="current_page"><%=i%></a>
			<!-- 현재 페이지 그룹 스타일 지정 -->
			<%
			} else { // 현재 페이지가 아니면 밑에 버튼 출력
			%>
			<a href="stock_list.jsp?page=<%=i%>"><%=i%></a>
			<!-- 스타일 없는 현재 페이지 그룹 -->
			<%
			}
			%>
			<%
			}
			%>
			<%
			if (nn != -1) { // 마지막 페이지가 -1이 아니면 밑에 버튼 출력
			%>
			<a href="stock_list.jsp?page=<%=n%>">→</a>
			<!-- 다음 페이지 그룹으로 이동 -->
			<a href="stock_list.jsp?page=<%=nn%>">⇒</a>
			<!-- 마지막 페이지로 이동 -->
			<%
		}
		%>
		</div>
	</div>
	<%
	} catch (Exception e) {
	e.toString();
	}
	%>
</body>
</html>