<%@page import="org.w3c.dom.*"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@ page contentType="text/html; charset=utf-8"%> <%-- 페이지의 콘텐츠 타입과 문자 인코딩 설정 --%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%> <%-- jsp파일에 java 클래스, java sql import --%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> <!-- html 한글처리 -->
</head>

<body>
<%
DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
Document doc = docBuilder.parse(new File("C:/Users/seoyoung/eclipse-workspace-web/Chap6_XML/src/main/webapp/xmlmake.jsp"));

Element root = doc.getDocumentElement();
NodeList tag_name = doc.getElementsByTagName("name");
NodeList tag_studentid = doc.getElementsByTagName("studentid");
NodeList tag_kor = doc.getElementsByTagName("kor");
NodeList tag_eng = doc.getElementsByTagName("eng");
NodeList tag_mat = doc.getElementsByTagName("mat");

out.println("<table cellspacing=1 width=500 border=1>");
out.println("<tr>");
out.println("<td width=100>이름</td>");
out.println("<td width=100>학번</td>");
out.println("<td width=100>국어</td>");
out.println("<td width=100>영어</td>");
out.println("<td width=100>수학</td>");
out.println("</tr>");

for(int i=0; i<tag_name.getLength();i++){
    out.println("<tr>");
out.println("<td width=100>"+tag_name.item(i).getFirstChild().getNodeValue()+"</td>");
out.println("<td width=100>"+tag_studentid.item(i).getFirstChild().getNodeValue()+"</td>");
out.println("<td width=100>"+tag_kor.item(i).getFirstChild().getNodeValue()+"</td>");
out.println("<td width=100>"+tag_eng.item(i).getFirstChild().getNodeValue()+"</td>");
out.println("<td width=100>"+tag_mat.item(i).getFirstChild().getNodeValue()+"</td>");
out.println("</tr>");
}

%>
</body>

</html>