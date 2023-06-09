<%@page import="org.w3c.dom.*"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="org.w3c.dom.Element"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<style>
body {
	background: #FFF0F5;
	color: black;
}

table {
	width: 100%;
	border-collapse: collapse;
	text-align: center;
}

tr {
	background-color: #FAC6C6;
	height: 40px;
}

th {
	background-color: #CD4646;
	color: white;
	height: 40px;
}

table, th, td {
	border: 1px solid white;
}

.noBorder {
	border: none !important;
}
</style>
<%
String seq = ""; // 48시간 중 몇번째 인지
String hour = ""; // 동네 예보 3시간 단위
String day = ""; // 1번째 날 (0: 오늘, 1: 내일, 2: 모레)
String temp = ""; // 현재 시간온도
String tmx = ""; // 최고 온도
String tmn = ""; // 최저 온도
String sky = ""; // 하늘 상태코드 (1: 맑음, 2: 구름조금, 3: 구름많음, 4: 흐림)
String pty = ""; // 강수 상태코드 (0: 없음, 1: 비, 2: 비/눈, 3: 눈/비, 4:눈)
String wfKor = ""; // 날씨 한국어
String wfEn = ""; // 날씨 영어
String pop = ""; // 강수 확률 %
String r12 = ""; // 12시간 예상 강수량
String s12 = ""; // 12시간 예상 적설량
String ws = ""; // 풍속 (m/s)
String wd = ""; // 풍향 (0~7: 북, 북동, 동, 남동, 남, 남서, 서, 북서)
String wdKor = ""; // 풍향 한국어
String wdEn = ""; // 풍향 영어
String reh = ""; // 습도 %
String r06 = ""; // 6시간 예상 강수량
String s06 = ""; // 6시간 예상 적설량
%>
</head>
<body>
	<%
	DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
	Document doc = docBuilder.parse("http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=123");

	Element root = doc.getDocumentElement();
	NodeList tag_001 = doc.getElementsByTagName("data");
	%>
	<%
	out.println("<table>");
	out.println("<th>순서</th>");
	out.println("<th>시간</th>");
	out.println("<th>날짜</th>");
	out.println("<th>현재 시간 온도</th>");
	out.println("<th>최고 온도</th>");
	out.println("<th>최저 온도</th>");
	out.println("<th>하늘 상태</th>");
	out.println("<th>강수 상태</th>");
	out.println("<th>한국어 날씨</th>");
	out.println("<th>영어 날씨</th>");
	out.println("<th>강수 확률(%)</th>");
	out.println("<th>12시간 예상 강수량</th>");
	out.println("<th>12시간 예상 적설량</th>");
	out.println("<th>풍속(m/s)</th>");
	out.println("<th>풍향</th>");
	out.println("<th>한국어 풍향</th>");
	out.println("<th>영어 풍향</th>");
	out.println("<th>습도(%)</th>");
	out.println("<th>6시간 예상 강수량</th>");
	out.println("<th>6시간 예상 적설량</th>");
	%>
	<%
	for (int i = 0; i < tag_001.getLength(); i++) {
		Element elmt = (Element) tag_001.item(i);
		seq = tag_001.item(i).getAttributes().getNamedItem("seq").getNodeValue();
		hour = elmt.getElementsByTagName("hour").item(0).getFirstChild().getNodeValue();
		day = elmt.getElementsByTagName("day").item(0).getFirstChild().getNodeValue();
		if (day.equals("0")) {
			day = "오늘";
		} else if (day.equals("1")) {
			day = "내일";
		} else if (day.equals("2")) {
			day = "모레";
		}
		temp = elmt.getElementsByTagName("temp").item(0).getFirstChild().getNodeValue();
		tmx = elmt.getElementsByTagName("tmx").item(0).getFirstChild().getNodeValue();
		tmn = elmt.getElementsByTagName("tmn").item(0).getFirstChild().getNodeValue();
		sky = elmt.getElementsByTagName("sky").item(0).getFirstChild().getNodeValue();
		pty = elmt.getElementsByTagName("pty").item(0).getFirstChild().getNodeValue();
		wfKor = elmt.getElementsByTagName("wfKor").item(0).getFirstChild().getNodeValue();
		wfEn = elmt.getElementsByTagName("wfEn").item(0).getFirstChild().getNodeValue();
		pop = elmt.getElementsByTagName("pop").item(0).getFirstChild().getNodeValue();
		r12 = elmt.getElementsByTagName("r12").item(0).getFirstChild().getNodeValue();
		s12 = elmt.getElementsByTagName("s12").item(0).getFirstChild().getNodeValue();
		ws = elmt.getElementsByTagName("ws").item(0).getFirstChild().getNodeValue();
		wd = elmt.getElementsByTagName("wd").item(0).getFirstChild().getNodeValue();
		if (wd.equals("0")) {
			wd = "↓";
		} else if (wd.equals("1")) {
			wd = "↙";
		} else if (wd.equals("2")) {
			wd = "←";
		} else if (wd.equals("3")) {
			wd = "↖";
		} else if (wd.equals("4")) {
			wd = "↑";
		} else if (wd.equals("5")) {
			wd = "↗";
		} else if (wd.equals("6")) {
			wd = "→";
		} else if (wd.equals("7")) {
			wd = "↘";
		}
		wdKor = elmt.getElementsByTagName("wdKor").item(0).getFirstChild().getNodeValue();
		wdEn = elmt.getElementsByTagName("wdEn").item(0).getFirstChild().getNodeValue();
		reh = elmt.getElementsByTagName("reh").item(0).getFirstChild().getNodeValue();
		r06 = elmt.getElementsByTagName("r06").item(0).getFirstChild().getNodeValue();
		s06 = elmt.getElementsByTagName("s06").item(0).getFirstChild().getNodeValue();

		out.println("<tr>");
		out.println("<td>" + seq + "</td>");
		out.println("<td>" + hour + "</td>");
		out.println("<td>" + day + "</td>");
		out.println("<td>" + temp + "</td>");
		out.println("<td>" + tmx + "</td>");
		out.println("<td>" + tmn + "</td>");

		if (sky.equals("1")) {
			out.println("<td><img src='sky1.png'></td>");
		} else if (sky.equals("2")) {
			out.println("<td><img src='sky2.png'></td>");
		} else if (sky.equals("3")) {
			out.println("<td><img src='sky3.png'></td>");
		} else if (sky.equals("4")) {
			out.println("<td><img src='sky4.png'></td>");
		}

		if (pty.equals("0")) {
			out.println("<td><img src='pty0.png'></td>");
		} else if (pty.equals("1")) {
			out.println("<td><img src='pty1.png'></td>");
		} else if (pty.equals("2")) {
			out.println("<td><img src='pty2.png'></td>");
		} else if (pty.equals("3")) {
			out.println("<td><img src='pty3.png'></td>");
		} else if (pty.equals("4")) {
			out.println("<td><img src='pty4.png'></td>");
		}

		out.println("<td>" + wfKor + "</td>");
		out.println("<td>" + wfEn + "</td>");
		out.println("<td>" + pop + "</td>");
		out.println("<td>" + r12 + "</td>");
		out.println("<td>" + s12 + "</td>");
		out.println("<td>" + ws + "</td>");
		out.println("<td>" + wd + "</td>");
		out.println("<td>" + wdKor + "</td>");
		out.println("<td>" + wdEn + "</td>");
		out.println("<td>" + reh + "</td>");
		out.println("<td>" + r06 + "</td>");
		out.println("<td>" + s06 + "</td>");
		out.println("</tr>");
	}
	%>
</body>
</html>