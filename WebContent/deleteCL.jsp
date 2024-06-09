<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="checklist.*"  %>
<%@ page import="clipboard.*"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
ChecklistDAO checklistDAO = ChecklistDAO.getInstance();
checklistDAO.delete(Long.parseLong(request.getParameter("date")));
%>
</body>
</html>