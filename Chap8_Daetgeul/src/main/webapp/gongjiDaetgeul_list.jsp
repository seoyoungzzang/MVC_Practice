<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="service.GongjiService"%>
<%@page import="service.GongjiServiceImpl"%>
<%@page import="domain.Gongji"%>
<%@page import="dao.GongjiDaoImpl"%>
<%@page import="dao.GongjiDao"%>
<%@page import="dto.Pagination"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*"%>
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
</head>

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
	int countPerPage = 10; // countPerPage 변수 선언 및 초기화
	if (countPerPageValue != null) { // countPerPageValue 값이 null이 아닌 경우
		countPerPage = Integer.parseInt(countPerPageValue); // 받아온 파라미터 값을 countPerPage에 저장
		if (countPerPage < 1) { // 1보다 작으면
			countPerPage = 10; // 20으로 설정
		}
	}

    GongjiDao gongjiDao = new GongjiDaoImpl(); // 객체 생성
    Gongji gongji = new Gongji(); // 객체 생성
    List<Gongji> gongjis = gongjiDao.selectList(pageNum, countPerPage); // 리스트 객체 생성하여 전체 조회 메소드 호출

    GongjiService gongjiService = new GongjiServiceImpl(); // 객체 생성
    Pagination pagination = gongjiService.getPagination(pageNum, countPerPage); // 페이지네이션
    
	int c = pagination.getC(); // 현재 페이지 번호
	int s = pagination.getS(); // 시작 페이지 번호
	int e = pagination.getE(); // 끝 페이지 번호
	int p = pagination.getP(); // 이전 페이지 번호
	int pp = pagination.getPp(); // 이전의 이전 페이지 번호
	int n = pagination.getN(); // 다음 페이지 번호
	int nn = pagination.getNn(); // 다음의 다음 페이지 번호();
%>
<%
Date today = new Date(); // 현재 날짜와 시간을 가져오는 Date 객체 생성
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 포맷을 지정하기 위한 SimpleDateFormat 객체 생성
String date = dateFormat.format(today); // 현재 날짜를 "yyyy-MM-dd" 형식으로 변환하여 문자열로 저장
%>
<body>
    <div class="container">
        <table>
            <tr>
				<th width="10%">번호</th> <!-- th 입력 -->
				<th width="60%">제목</th> <!-- th 입력 -->
				<th width="10%">조회수</th> <!-- th 입력 -->
				<th width="20%">등록일</th> <!-- th 입력 -->
			</tr>
            <%
            for (int i = 0; i < gongjis.size(); i++) { // gongjis 크기만큼 루프
            	Gongji gongji1 = gongjis.get(i); // i번째 데이터를 gongji1에 할당 	
            %>
            <tr>
                <td><p><%= gongji1.getId() %></p></td> <!-- id 가져옴 -->
                <% 
                if(date.equals(gongji1.getDate())){ //오늘 작성된 글인지 확인
                
                int relevel = gongji1.getRelevel();
                if(relevel == 0){ // 원글
                %>
                <td><p><a href='gongjiDaetgeul_view.jsp?key=<%= gongji1.getId() %>'><%= gongji1.getTitle()%> [NEW]</a></p></td> <!-- 제목 가져옴 -->
                <%
                
                } else{ // 댓글 
                %>
                <td><p><a href='gongjiDaetgeul_view.jsp?key=<%= gongji1.getId()%>'>
                <%
                for(int j = 0; j < gongji1.getRelevel(); j++){
				out.println("-");
                }
                %>
                >[Re] <%= gongji1.getTitle() %> [NEW]</a></p></td> <!-- 제목 가져옴 -->
                <%
                }
                } else{
                    int relevel = gongji1.getRelevel();
                    if(relevel == 0){ // 원글
                    %>
                    <td><p><a href='gongjiDaetgeul_view.jsp?key=<%= gongji1.getId() %>'><%= gongji1.getTitle()%></a></p></td> <!-- 제목 가져옴 -->
                    <%
                    
                    } else{ // 댓글 
                    %>
                    <td><p><a href='gongjiDaetgeul_view.jsp?key=<%= gongji1.getId()%>'>
                    <%
                    for(int j = 0; j < gongji1.getRelevel(); j++){
    				out.println("-");
                    }
                    %>
                    >[Re] <%= gongji1.getTitle() %></a></p></td> <!-- 제목 가져옴 -->
                    <%
                    }
                }
                %>
                <td><p><%= gongji1.getViewcnt()%></p></td> <!-- 조회수 가져옴 -->
                <td><p><%= gongji1.getDate()%></p></td> <!-- 날짜 가져옴 -->
            </tr>
            <% } %>             
            <tr>
                <td colspan="4">
                    <button class="new-button" onclick="window.location='gongjiDaetgeul_insert.jsp'">신규</button> <!-- 신규버튼 생성 -->
                </td>
            </tr>
        </table>

        <div class="pagination">
			<%
			if (10 < c) { // 현재페이지가 10보다 크면 밑에 버튼 출력
			%>
			<a href="gongjiDaetgeul_list.jsp?page=<%=pp%>">⇐</a>
			<!-- 첫 페이지로 이동 -->
			<a href="gongjiDaetgeul_list.jsp?page=<%=p%>">←</a>
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
			<a href="gongjiDaetgeul_list.jsp?page=<%=i%>" class="current_page"><%=i%></a>
			<!-- 현재 페이지 그룹 스타일 지정 -->
			<%
			} else { // 현재 페이지가 아니면 밑에 버튼 출력
			%>
			<a href="gongjiDaetgeul_list.jsp?page=<%=i%>"><%=i%></a>
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
			<a href="gongjiDaetgeul_list.jsp?page=<%=n%>">→</a>
			<!-- 다음 페이지 그룹으로 이동 -->
			<a href="gongjiDaetgeul_list.jsp?page=<%=nn%>">⇒</a>
			<!-- 마지막 페이지로 이동 -->
			<%
		}
		%>
        </div>
    </div>
<%
} catch (Exception e) {
    e.toString();
    out.println("Error: The table 'gongji2' does not exist.");
}
%>
</body>

</html>
