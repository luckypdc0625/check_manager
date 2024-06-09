<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="file.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String cbname = request.getParameter("cbname");
int cbid = Integer.parseInt(request.getParameter("cbid"));
%>
<%
FileDAO fileDAO = FileDAO.getInstance();
String path = request.getParameter("filepath");
int fileid = Integer.parseInt(request.getParameter("fileid"));
File file = new File(path);
System.out.println(path);

file.delete(); // 파일명 변경
fileDAO.delete(fileid);
%>
</body>
</html>