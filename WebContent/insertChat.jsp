<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="chat.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	ChatDAO chatDAO = ChatDAO.getInstance();
	String userName = request.getParameter("userName");
	String cbname = request.getParameter("cbname");
	int cbid = Integer.parseInt(request.getParameter("cbid"));
	String content = request.getParameter("chattext");
	Date today = new Date();
	String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(today);
	chatDAO.insert(userName, cbid, content, date);
	out.print(date);
%>
</body>
</html>