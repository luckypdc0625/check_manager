<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="chat.*" %>
<%@ page import="java.util.ArrayList"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<style>
footer { position: fixed; bottom: 10px; width: 100%; }
</style>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	ChatDAO chatDAO = ChatDAO.getInstance();
	String userName = (String) session.getAttribute("userName");

	String cbname = request.getParameter("cbname");
	int cbid = Integer.parseInt(request.getParameter("cbid"));
	ArrayList<Chat> chats = chatDAO.loadAll(cbid);
%>
<%
	out.print("<table width='300px' border='1px' bordercolor='white' id=\"chattable\" style=\"color:white; font-size:16;\">");
	out.print("<td width='50px'>닉네임</td><td>채팅 내용</td><td width='87px'>작성일</td>");
%>
<%
	for(int i=0; i<chats.size(); i++) {
		Chat chat = chats.get(i);
		out.print("<tr><td>"+chat.getUsername()+"</td><td>"+chat.getContent()+"</td><td>"+chat.getDate()+"</td></tr>");
		
%>
<%
	}
	out.print("</table>");
%>

</body>
</html>