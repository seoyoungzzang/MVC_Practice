<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="domain.Gongji"%>
<%@page import="java.util.List"%>
<%@page import="dto.Pagination"%>
<%@page import="service.GongjiServiceImpl"%>
<%@page import="service.GongjiService"%>
<%@page import="dao.GongjiDao"%>
<%@page import="dao.GongjiDaoImpl"%>
<%@ page contentType="text/html; charset=utf-8" language="java"%>

<html>

<head>
<style>
body {
	background: #FFFF9;
	font-family: Arial, sans-serif;
}

.container {
	max-width: 650px;
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
</head>

<body>
	<%
	GongjiDao gongjiDao = new GongjiDaoImpl(); // DAO 객체 생성

	String pageValue = request.getParameter("page"); // from이라는 파라미터에서 값을 가져와 새 변수에 지정
	String countValue = request.getParameter("count"); // cnt라는 파라미터에서 값을 가져와 새 변수에 지정
	String keyValue = request.getParameter("key"); // key라는 파라미터에서 값을 가져와 새 변수에 지정

	int pageNum = 1; // 페이지수 담을 변수 생성
	int countPerPage = 10; // 페이지당 항목 개수 담을 변수 생성

	if (pageValue != null && countValue != null) { // 파라미터에서 받아온 값들 둘 다 null이 아닐 경우
		pageNum = Integer.parseInt(pageValue); // 파라미터에서 받은 값을 page 번호 변수에 지정
		countPerPage = Integer.parseInt(countValue); // 파라미터에서 받은 값을 countPerPage 변수에 지정
	} else if (pageValue != null) { // keyValue가 존재할 경우
		pageNum = Integer.parseInt(pageValue); // id값으로 keyValue를 설정
	}

	if (keyValue != null && pageValue == null) { // keyValue만 존재할 경우
		int id = Integer.parseInt(keyValue); // id값으로 keyValue를 설정
		pageNum = gongjiDao.getPageById(id, countPerPage); // 받은 정보들을 통해 페이지수 계산
	}

	GongjiService gongjiService = new GongjiServiceImpl(); // GongjiService 객체 생성

	Pagination pagination = gongjiService.getPagination(pageNum, countPerPage); // 설정된 pageNum, countPerPage를 기반으로 페이지 번호들 계산

	pageNum = pagination.getC(); // 현재 페이지 불러와 변수에 지정

	List<Gongji> selectAll = gongjiDao.selectAll(pageNum, countPerPage); // 페이지에 띄울 학생들의 정보를 리스트로 가져옴

	if (selectAll == null) { // 데이터가 없는 경우
	%>
	<h3>조회할 게시글이 없습니다. 게시글을 등록해주세요.</h3>
	<div class="container">
	<table>
			<tr>
				<th width=50><p align=center>번호</p></th>
				<th width=500><p align=center>제목</p></th>
				<th width=100><p align=center>조회수</p></th>
				<th width=100><p align=center>등록일</p></th>
			</tr>
	</table>
	<table width=600>
		<tr>
			<td width=500></td>
			<td><input type=button class="new-button" value="신규" onclick="window.location='gongji_insert.jsp'"></td> <!-- 신규작성 버튼 -->
	</table>
	</div>
	<%
	} else { // 데이터가 있는 경우
	%>
	<div class="container">
	<table>
			<tr>
				<th width=50><p align=center>번호</p></th>
				<th width=500><p align=center>제목</p></th>
				<th width=100><p align=center>조회수</p></th>
				<th width=100><p align=center>등록일</p></th>
			</tr>
		<%
		LocalDate now = LocalDate.now(); 
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String formatedNow = now.format(formatter);

		for (int i = 0; i < selectAll.size(); i++) { // 리스트 사이즈만큼 루프
			Gongji gongji = selectAll.get(i); // 리스트의 i번째 값을 가져옴
			String str = ""; // str 변수 생성
			if (gongji.getDate().equals(formatedNow))
				str = " [NEW]"; // 새 게시물이면 new
			out.println("<tr>"); // tr 태그 열기
			out.println("<td width=50><p align=center>" + gongji.getId() + "</p></td>");
			if (gongji.getRelevel() == 0) { // relevel이 0이면
				String title = gongji.getTitle().replaceAll("&", "&amp;"); // &를 &amp로 변경
				String title2 = title.replaceAll("<", "&lt;").replaceAll(">", "&gt;"); // <와 >를 각각 &lt, &gt로 변경
				// 제목 가져와서 출력 및 하이퍼링크 설정
				out.println("<td width=50><p align=left><a class=\"a\" href='gongji_view.jsp?key=" + gongji.getId() + "&page="
				+ pageNum + "'>" + title2 + str + "</p></td>");
			} else { // 그 외에는
				// 제목 가져와서 출력 및 하이퍼링크 설정
				out.println("<td width=50><p align=left><a class=\"a\" href='gongji_view.jsp?key=" + gongji.getId() + "&page="
				+ pageNum + "'>");

				for (int j = 0; j < gongji.getRelevel(); j++) { // relevel만큼 화살표 출력
			out.print("↳ ");
				}
				out.print("[RE]"); // RE 붙이기

				String title = gongji.getTitle().replaceAll("&", "&amp;"); // &를 &amp로 변경
				String title2 = title.replaceAll("<", "&lt;").replaceAll(">", "&gt;"); // <와 >를 각각 &lt, &gt로 변경

				out.println(title2 + "" + str); // 댓글 출력
				out.println("</p></td>"); // td 닫기
			}
			out.println("<td width=50><p align=center>" + gongji.getViewcnt() + "</p></td>"); // 조회수 출력
			out.println("<td width=50><p align=center>" + gongji.getDate() + "</p></td>"); // 날짜 출력
			out.println("</tr>"); // tr 닫기

		}
		out.println("</table>"); // 테이블 닫기
		%>
		<table width=600>
			<tr>
				<td width=500></td>
				<td><input type=button class="new-button" value="신규등록" onclick="window.location='gongji_insert.jsp'"></td>
		</table>
		</div>
		 <div class="pagination">
			<%
			int s = pagination.getS(); // 현재 뜨는 페이지 번호 중 첫 번호
			int e = pagination.getE(); // 현재 뜨는 페이지 번호 중 마지막 번호
			int p = pagination.getP(); // -10으로 가는 페이지 번호
			int pp = pagination.getPp(); // 맨 첫 페이지 번호
			int n = pagination.getN(); // +10으로 가는 페이지 번호
			int nn = pagination.getNn(); // 맨 마지막 페이지 번호

			if (p != -1) { // p의 값이 -1이 아니라면
				// p에 해당하는 하이퍼링크 생성
				out.println("<a href=\"gongji_list.jsp?page=" + pp + "&count=" + countPerPage + "\"><<</a>");
			}
			if (pp != -1) { // pp의 값이 -1이 아니라면
				// pp에 해당하는 하이퍼링크 생성
				out.println("<a href=\"gongji_list.jsp?page=" + p + "&count=" + countPerPage + "\"><</a>");
			}

			for (int i = s; i <= e; i++) { // s에서 e까지 루프 진행
				if (i != -1) { // i가 -1이 아니라면
					if (i == pageNum) { // i가 현재 페이지 번호라면
				// 밑줄이 그어진 하이퍼링크 생성하여 페이지 번호 표시
				out.println("<a class=\"current_page\" href=\"gongji_list.jsp?page=" + i + "&count=" + countPerPage + "\">" + i
						+ "</a> ");
					} else { // 그 외에는
				// 평범한 하이퍼링크 생성하여 페이지 번호 표시
				out.println("<a href=\"gongji_list.jsp?page=" + i + "&count=" + countPerPage + "\">" + i
						+ "</a> ");
					}
				}
			}

			if (n != -1) { // n이 -1이 아니라면
				// n에 해당하는 하이퍼링크 생성
				out.println("<a href=\"gongji_list.jsp?page=" + n + "&count=" + countPerPage + "\">></a>"); // cnt와 from 값에 맞는 url 설정하여 하이퍼링크 생성    	
			}
			if (nn != -1) { // nn이 -1이 아니라면
				// nn에 해당하는 하이퍼링크 생성
				out.println("<a href=\"gongji_list.jsp?page=" + nn + "&count=" + countPerPage + "\">>></a>"); // cnt와 from 값에 맞는 url 설정하여 하이퍼링크 생성
			}
			}
			%>
		</div>
</body>
</html>