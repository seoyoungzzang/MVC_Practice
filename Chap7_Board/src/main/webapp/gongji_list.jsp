<%@page import="dto.Pagination"%>
<%@page import="service.GongjiService"%>
<%@page import="service.GongjiServiceImpl"%>
<%@page import="java.util.List"%>
<%@page import="domain.Gongji"%>
<%@page import="dao.GongjiDaoImpl"%>
<%@page import="dao.GongjiDao"%>
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
</head>

<%
try {
    String pageValue = request.getParameter("page");
    int pageNum = 1;
    if (pageValue != null) {
        pageNum = Integer.parseInt(pageValue);
        if (pageNum < 1) {
            pageNum = 1;
        }
    }

    String countPerPageValue = request.getParameter("countPerPage");
    int countPerPage = 10;
    if (countPerPageValue != null) {
        countPerPage = Integer.parseInt(countPerPageValue);
        if (countPerPage < 1) {
            countPerPage = 10;
        }
    }

    GongjiDao gongjiDao = new GongjiDaoImpl();
    Gongji gongji = new Gongji();
    List<Gongji> gongjis = gongjiDao.selectAll(pageNum, countPerPage);
    
    GongjiService gongjiService = new GongjiServiceImpl();
    Pagination pagination = gongjiService.getPagination(pageNum, countPerPage);
    
    int c = pagination.getC();
    int s = pagination.getS();
    int e = pagination.getE();
    int p = pagination.getP();
    int pp = pagination.getPp();
    int n = pagination.getN();
    int nn = pagination.getNn();
%>

<body>
    <div class="container">
        <table>
            <tr>
                <th width="10%">번호</th>
                <th width="70%">제목</th>
                <th width="20%">등록일</th>
            </tr>
            <% for (int i = 0; i < gongjis.size(); i++) {
                Gongji gongji1 = gongjis.get(i);
            %>
            <tr>
                <td><p><%= gongji1.getId() %></p></td>
                <td><p><a href='gongji_view.jsp?key=<%= gongji1.getId() %>'><%= gongji1.getTitle() %></a></p></td>
                <td><p><%= gongji1.getDate() %></p></td>
            </tr>
            <% } %>
            <tr>
                <td colspan="3">
                    <button class="new-button" onclick="window.location='gongji_insert.jsp'">신규</button>
                </td>
            </tr>
        </table>

        <div class="pagination">
            <% if (10 < c) { %>
                <a href="gongji_list.jsp?page=<%= pp %>">⇐</a>
                <a href="gongji_list.jsp?page=<%= p %>">←</a>
            <% } %>

            <% for (int i = s; i <= e; i++) { %>
                <% if (i == c) { %>
                    <a href="gongji_list.jsp?page=<%= i %>" class="current_page"><%= i %></a>
                <% } else { %>
                    <a href="gongji_list.jsp?page=<%= i %>"><%= i %></a>
                <% } %>
            <% } %>

            <% if (nn != -1) { %>
                <a href="gongji_list.jsp?page=<%= n %>">→</a>
                <a href="gongji_list.jsp?page=<%= nn %>">⇒</a>
            <% } %>
        </div>
    </div>
<%
} catch (Exception e) {
    e.toString();
    out.println("Error: The table 'examtable' does not exist.");
}
%>
</body>

</html>
