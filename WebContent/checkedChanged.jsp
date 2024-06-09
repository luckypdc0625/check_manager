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
ClipboardDAO clipboardDAO = ClipboardDAO.getInstance();
ChecklistDAO checklistDAO = ChecklistDAO.getInstance();
int cbid = Integer.parseInt(request.getParameter("cbid"));
String manager = clipboardDAO.getManager(cbid);
if(!manager.equals( ((String)session.getAttribute("userName")))) {
	out.print("notmanager");
} else {
	checklistDAO.checkedChanged(Long.parseLong(request.getParameter("date")));
	int all = checklistDAO.allById(cbid);
	int checked = checklistDAO.checkedById(cbid);
	String allprint = null;
	String checkedprint = null;
	if(all>=0&&all<=9) {
		allprint = "000"+all;
	} else if(all>=10&&all<=99) {
		allprint = "00"+all;
	} else if(all>=100&&all<=999){
		allprint = "0"+all;
	}
	if(checked>=0&&checked<=9) {
		checkedprint = "000"+checked;
	} else if(checked>=10&&checked<=99) {
		checkedprint = "00"+checked;
	} else if(checked>=100&&checked<=999){
		checkedprint = "0"+checked;
	}
	out.print(allprint+checkedprint);
}
%>
</body>
</html>