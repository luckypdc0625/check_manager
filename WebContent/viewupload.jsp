<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="chat.*" %>
<%@ page import="file.*" %>
<%@ page import="clipboard.*" %>
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
	FileDAO fileDAO = FileDAO.getInstance();
	ClipboardDAO clipboardDAO = ClipboardDAO.getInstance();
	String userName = (String) session.getAttribute("userName");

	String cbname = request.getParameter("cbname");
	int cbid = Integer.parseInt(request.getParameter("cbid"));
	String manager = clipboardDAO.getManager(cbid);
	String cbidString = null;
	if(cbid >= 1 && cbid<=9) {
		cbidString = "000"+cbid;
	} else 	if(cbid >= 10 && cbid<=99) {
		cbidString = "00"+cbid;
	} else 	if(cbid >= 100 && cbid<=999) {
		cbidString = "0"+cbid;
	}
	ArrayList<File> files = fileDAO.loadAll(cbid);
%>
<table border="solid">
<td width="50px">닉네임</td><td>파일 이름</td><td width="87px">업로드 일시</td><td>삭제</td>
<%
	for(int i=0; i<files.size(); i++) {
		File file = files.get(i);
		
%>
<tr>
<td><%=file.getUsername() %></td><td><a href="uploadFolder/cbid<%=cbidString+file.getContent()%>" download="<%=file.getContent()%>"><%=file.getContent() %></a></td><td><%=file.getDate() %></td>
<%
		if(file.getUsername().equals(userName) || manager.equals(userName)) {
%>
<td>
<form>
<input type="hidden" id="<%=file.getFileid()%>filecontent" value="<%=file.getContent()%>">
<input type="hidden" id="<%=file.getFileid()%>fileid" value="<%=file.getFileid()%>">
<input type="hidden" id="<%=file.getFileid()%>filepath" value="<%=file.getPath()%>">
<input type="hidden" id="<%=file.getFileid()%>cbname" value="<%=cbname%>">
<input type="hidden" id="<%=file.getFileid()%>cbid" value="<%=cbid%>">
<input type="button" value="" name="<%=file.getFileid()%>" style="width:20px; height:20px; background-image: url('img/deleteCL.png'); background-size:100%; background-repeat: no-repeat;" onclick="deleteFileFunc(this)">
</form>
</td>
<%
		}
%>
</tr>
<%
	}
%>
</table>
<script>
function deleteFileFunc(btn) {
	var xmlhttp= false;
	if (window.XMLHttpRequest) {
		xmlhttp= new XMLHttpRequest( );
		xmlhttp.overrideMimeType('text/xml');
	} else if (window.ActiveXObject) {
		xmlhttp= new ActiveXObject("Microsoft.XMLHTTP");
	}
	var fileid = btn.name;
	var filecontent = $('#'+fileid+'filecontent').val();
	var filepath = $('#'+fileid+'filepath').val();
	var cbname = $('#'+fileid+'cbname').val();
	var cbid = $('#'+fileid+'cbid').val();
	if(confirm(filecontent + " 파일을 삭제하시겠습니까?")) {
		var qry= 'fileid='+ fileid + "&filepath=" + filepath + "&cbname=" + cbname + "&cbid=" + cbid;
		var url= 'deleteFile.jsp?';
		xmlhttp.open('POST', url, true);
		xmlhttp.onreadystatechange= function() {
			window.location.reload();
		};
		xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xmlhttp.send(qry);
	} else {
		
	}

}
</script>
<footer>
<form action="fileUpload.jsp" method="post" enctype="Multipart/form-data">
파일명 : <input style="width:300px;" type="file" value="파일 선택" name="file" accept="*"/>
<input type="hidden" name="userName" value="<%=userName %>">
<input type="hidden" name="cbname" value="<%=cbname %>">
<input type="hidden" name="cbid" value="<%=cbid %>">
<input type="submit" value="업로드"/>
</form>
</footer>

</body>
</html>