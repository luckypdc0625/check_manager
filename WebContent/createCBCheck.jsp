<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="clipboard.*"  %>
<%@ page import="checklist.*"  %>
<%@ page import="chat.*"%>
<%@ page import="user.*"  %>
<%@ page import="java.util.ArrayList"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>체크 매니저</title>
<link rel="stylesheet" href="style.css">
</head>
<body bgcolor="#ECF1F5">
    <header style="background-color:#5F5E5E">
        <image1 class="image1">
            <a href="index.jsp"><img src="img/체크매니저_로고.png" title="logo" width="185" height="45" ></a>
        </image1>
    <%
	request.setCharacterEncoding("utf-8");
	String userName = (String) session.getAttribute("userName");
	if(userName == null) {
	%>
        <login class="login">
        <a href="login.jsp"><img src="img/로그인.png" title="logo" width="70" height="25" ></a>
        <a href="signup.jsp"><img src="img/회원가입.png" title="logo" width="70" height="25" ></a>
        </login>
	<%
	} else {
	%>
	    <login class="login">
        <a href="logout.jsp"><img src="img/로그아웃.png" title="logo" width="110" height="40" ></a>
        </login>
    <%
	}
    %>
    </header>
    <nav>
    <%
	if(userName != null) {
	%>
	<a href="createCB.jsp"  style="color:white"><img src="img/클립보드생성.png" title="logo" width="170" height="50" ></a>    
	<font style="font-size:21px; position:absolute; top:135px;">&nbsp;&nbsp;&nbsp;&nbsp;환영합니다. <%=(String) session.getAttribute("userName") %>님.</font>
	<%
	}
	%>
    </nav>
    <section>

	<%
	ClipboardDAO clipboardDAO = ClipboardDAO.getInstance();
	UserDAO userDAO = UserDAO.getInstance();
	String involvedWithoutMe = request.getParameter("involvedWithoutMe");
	String me = (String) session.getAttribute("userName");
	String involved = me;
	
	boolean exist = false;
	boolean myname = false;
	String notexistname = "";
	if(!involvedWithoutMe.equals("")) {
		involved = involved + "," + involvedWithoutMe;
		String[] iWMarray = involvedWithoutMe.split(",");
		for(int i=0; i<iWMarray.length; i++) {
			if(userDAO.nameCheck(iWMarray[i])==1 && !userName.equals(iWMarray[i])){
				exist = true;
			} else if(userDAO.nameCheck(iWMarray[i])==0){
				exist = false;
				notexistname = iWMarray[i];
				break;
			} else if(userName.equals(iWMarray[i])) {
				myname = true;
				break;
			}
		}
	}
	
	if(involvedWithoutMe.equals("") || (exist == true && myname == false) ) {
	clipboardDAO.create(request.getParameter("cbName"), involved, me);
	%>
	<div class="context">
	<%=request.getParameter("cbName") %> 클립보드 생성이 완료되었습니다.<br/>
	<a href="index.jsp"><img src="img/메인으로.png"title="logo" width="160" height="40" ></a>
	</div>
	<%
	} else if (exist == false && myname == false){
	%>
	<div class="context">
	<%=notexistname %>이 닉네임인 사용자는 존재하지 않습니다.<br/>정확한 닉네임을 입력해주세요.<br/>
	<a href="javascript:window.history.back()"><img src="img/이전으로.png"title="logo" width="160" height="40" ></a>
	</div>
	<%
	} else if (myname == true) {
	%>
	<div class="context">
	초대할 사람에 본인의 닉네임은 제외해주세요.<br/>
	<a href="javascript:window.history.back()"><img src="img/이전으로.png"title="logo" width="160" height="40" ></a>
	</div>
	<%
	}
	%>

        
    </section>
    
    <aside>


    </aside>

<footer class="footer">
    <fot1 class="fot1">
        <img src="img/키보드.png"title="logo" width="80" height="80" ><br><br/>
    </fot1>
        <p1><img src="img/박동철.png"title="logo" width="70" height="38">&nbsp;&nbsp;&nbsp;<img src="img/동철학번.png"title="logo" width="110" height="38"></p1>
    
    <fot2 class="fot2">
        <img src="img/모니터.png"title="logo" width="80" height="80" ><br>
    </fot2>
        <p2><img src="img/박민영.png"title="logo" width="70" height="38" >&nbsp;&nbsp;&nbsp;<img src="img/민영학번.png"title="logo" width="110" height="38" ></p2>
    
    <fot3 class="fot3">
        <img src="img/스마트폰.png"title="logo" width="80" height="80" ><br>
    </fot3>
        <p3><img src="img/서범수.png"title="logo" width="70" height="38" >&nbsp;&nbsp;&nbsp;<img src="img/서범수학번.png"title="logo" width="110" height="38" ></p3>
    
</footer>


    


</body>

</html>