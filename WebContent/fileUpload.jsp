<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="file.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://malsup.github.com/jquery.form.js"></script>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
    // request.getRealPath("상대경로") 를 통해 파일을 저장할 절대 경로를 구해온다.
    // 운영체제 및 프로젝트가 위치할 환경에 따라 경로가 다르기 때문에 아래처럼 구해오는게 좋음
    String uploadPath = "D:\\webProgrammingEE\\indiv_pro\\WebContent\\uploadFolder";
    //String uploadPath = request.getRealPath("/uploadFolder");
    //String uploadPath = request.getSession().getServletContext().getRealPath("/");
    //out.println("절대경로 : " + uploadPath +"<br/>");
     
    int maxSize =1024 *1024 *1000;
    String name ="";
    String subject ="";
     
    String fileName1 ="";// 중복처리된 이름
    String originalName1 ="";// 중복 처리전 실제 원본 이름
    long fileSize =0;// 파일 사이즈
    String fileType ="";// 파일 타입
     
    MultipartRequest multi =null;
     
    try{
    	
        multi =new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());
        
        Enumeration files = multi.getFileNames();

        String file1 = (String)files.nextElement();// 파일 input에 지정한 이름을 가져옴
        fileName1 = multi.getFilesystemName(file1);
        
    }catch(Exception e){
        e.printStackTrace();
    }
	String cbname = multi.getParameter("cbname");
	int cbid = Integer.parseInt(multi.getParameter("cbid"));
    
    if(fileName1!=null){
    	FileDAO fileDAO = FileDAO.getInstance();
    	String userName = multi.getParameter("userName");

        
    	String newFileName = null;
    	if(cbid>=1 && cbid<=9) {
    		newFileName = "cbid000"+cbid+fileName1;
    	} else if(cbid>=10 && cbid<=99) {
    		newFileName = "cbid00"+cbid+fileName1;
    	} else if(cbid>=100 && cbid<=999) {
    		newFileName = "cbid0"+cbid+fileName1;
    	}
    	
        File oldFile = new File(uploadPath + "\\" + fileName1);
        File newFile = new File(uploadPath + "\\" + newFileName);
       
        oldFile.renameTo(newFile); // 파일명 변경
        
    	String content = fileName1;
    	String path = uploadPath+ "\\" + newFileName;
    	Date today = new Date();
    	String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(today);
    	fileDAO.insert(userName, cbid, content, path, date);
    }
    
%>
<script>
location.href="viewupload.jsp?cbname=<%=cbname%>&cbid=<%=cbid%>";
</script>
</body>
</html>