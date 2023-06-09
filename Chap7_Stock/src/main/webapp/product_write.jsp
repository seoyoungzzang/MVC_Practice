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
StockDao stockDao = new StockDaoImpl();
Stock stock = new Stock();

request.setCharacterEncoding("UTF-8"); // utf-8로 인코딩 설정

//서버에서 저장할 localhost 뒤에 붙는 위치
String path = "./image/";
String realPath = request.getServletContext().getRealPath(path);
System.out.println("write.jsp - realPath : " + realPath);
int size = 10 * 1024 * 1024; // 10M

//실제적으로 파일 업로드 하는 처리문
MultipartRequest multi = new MultipartRequest(request, realPath, size, "utf-8", new DefaultFileRenamePolicy());

String key = multi.getParameter("key");

int id = Integer.parseInt(multi.getParameter("id"));
String name = multi.getParameter("name");
int stockNum = Integer.parseInt(multi.getParameter("stockNum"));
String stockDate = multi.getParameter("stockDate");
String content = multi.getParameter("content");

String image = multi.getFilesystemName("image");

if (key.equals("INSERT")) {
	stock.setId(id);
	stock.setName(name);
	stock.setStockNum(stockNum);
	stock.setContent(content);
	stock.setImage(path + image);

	stockDao.insertProduct(stock);
}
%>
<script language="JavaScript">
		window.onload = function() {
			var key = "<%=key%>"; // key 값을 JavaScript 변수에 할당합니다.
			
			if (key === "INSERT") { // INSERT인 경우
				if (confirm("상품 등록이 완료되었습니다. \n확인을 누르면 목록으로, 취소를 누르면 상세페이지로 이동합니다.")) {
					location.href = "stock_list.jsp";
				} else {
					location.href = "stock_view.jsp?key=<%=id%>";
			}
		}
	};
</script>
</head>

<body>

</body>

</html>