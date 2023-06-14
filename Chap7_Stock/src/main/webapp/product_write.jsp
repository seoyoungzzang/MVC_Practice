<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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

//서버에서 저장할 localhost 뒤에 붙는 위치
String path = "./image/"; // 서버에 저장할 로컬 경로
String realPath = request.getServletContext().getRealPath(path); // 실제 서버 상의 실제 경로 가져오기
System.out.println("write.jsp - realPath : " + realPath); // 서버 경로 출력
int size = 10 * 1024 * 1024; // 파일 업로드 크기 10MB로 제한

//실제적으로 파일 업로드 하는 처리문
// MultipartRequest 객체 생성 (요청, 실제 경로, 업로드 크기 제한, 인코딩 방식, 중복 정책 지정)
MultipartRequest multi = new MultipartRequest(request, realPath, size, "utf-8", new DefaultFileRenamePolicy()); 

String key = multi.getParameter("key"); // key 요청 파라미터 가져옴
String id = multi.getParameter("id"); // id 요청 파라미터 가져옴
String name = multi.getParameter("name"); // name 요청 파라미터 가져옴
int stockNum = Integer.parseInt(multi.getParameter("stockNum")); // stockNum 요청 파라미터 가져옴
String stockDate = multi.getParameter("stockDate"); // stockDate 요청 파라미터 가져옴
String content = multi.getParameter("content"); // content 요청 파라미터 가져옴
String image = multi.getFilesystemName("image"); // image 요청 파라미터 가져옴

if (key.equals("INSERT")) { // key값이 INSERT면
	if (stockDao.isIdExist(id)) { // 상품 번호가 이미 존재하는지 확인
		// 상품 번호가 이미 존재하면 알림창을 띄우고 이전 페이지로 이동
		out.println("<script>alert('존재하는 상품 번호입니다. 다시 입력하세요.'); history.back();</script>");
	} else { // 상품 번호가 존재하지 않으면
		stock.setId(id); // 상품 번호 설정
		stock.setName(name); // 상품명 설정
		stock.setStockNum(stockNum); // 재고 수량 설정
		stock.setContent(content); // 상품 설명 설정
		stock.setImage(path + image); // 이미지 경로 설정

		stockDao.insertProduct(stock); // 상품 추가
%>
<script language="JavaScript">
		window.onload = function() { // 이벤트 핸들러 함수 실행
			var key = "<%=key%>"; // key 값을 JavaScript 변수에 할당합니다.
			
			if (key === "INSERT") { // INSERT인 경우
				if (confirm("상품 등록이 완료되었습니다. \n확인을 누르면 목록으로, 취소를 누르면 상세페이지로 이동합니다.")) {
					location.href = "stock_list.jsp"; // 확인 누르면 목록 페이지로 이동
				} else { // 아니면
					location.href = "stock_view.jsp?key=<%=id%>"; 
			} // 취소 누르면 상세페이지로 이동
		}
	};
</script>
</head>

<body>
<%
	}
}
%>
</body>

</html>