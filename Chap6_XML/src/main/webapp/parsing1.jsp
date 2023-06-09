<?xml version="1.0" encoding="utf-8" ?>
<%@ page contentType="text/xml; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<%
    Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc드라이버 로드하여 데이터 베이스와 연결
    Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:33060/kopo34","root","kopo34"); // 데이터베이스에 연결
    Statement stmt = conn.createStatement(); // sql문을 데이터베이스로 보내고 실행

    ResultSet rset = stmt.executeQuery("select * from examtable");
    out.println("<datas>");
    while(rset.next()){
        out.println("<data>");

        out.println("<name>" + rset.getString(1)+"</name>");
        out.println("<studentid>"+Integer.toString(rset.getInt(2))+"</studentid>");
        out.println("<kor>" + rset.getString(3)+"</kor>");
        out.println("<eng>" + rset.getString(4)+"</eng>");
        out.println("<mat>" + rset.getString(5)+"</mat>");

        out.println("</data>");
    }
    out.println("</datas>");
    stmt.close();
    conn.close();
%>