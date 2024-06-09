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
	int cbid = Integer.parseInt(request.getParameter("formCbid"));	
	String cbname = clipboardDAO.getName(cbid);
	String nominee = request.getParameter("nominee");
	
	String involved = clipboardDAO.getInvolvedExceptMe(cbid, userName);
	String[] involvedArray = involved.split(",");
	
	boolean cbexist = false;
	boolean myname = false;
	
	for(int j=0; j<involvedArray.length; j++) {
		if( nominee.equals(userName)){
			myname = true;
			break;
		} else if(nominee.equals(involvedArray[j])) {
			cbexist = true;
			break;
		}
	}

	
	if(nominee.equals("")) {
	%>
	<div class="context">
	매니저를 위임할 사용자 닉네임을 입력해주세요.<br/>
	<a href="javascript:window.history.back()"><img src="img/이전으로.png"title="logo" width="160" height="40" ></a>
	</div>
	<%
	} else if (myname) {
	%>
	<div class="context">
	본인에게 양도할 수 없습니다.<br/>
	다시 입력해주세요.<br/>
	<a href="javascript:window.history.back()"><img src="img/이전으로.png"title="logo" width="160" height="40" ></a>
	</div>
	<%
	} else if (!cbexist && !myname) {
	%>

	<div class="context">
	<%=nominee %> 사용자는 클립보드에 참여중이지 않습니다.<br/>
	클립보드에 참여중인 사용자의 닉네임을 입력해주세요.<br/>
	<a href="javascript:window.history.back()"><img src="img/이전으로.png"title="logo" width="160" height="40" ></a>
	</div>
	<%
	} else {
	clipboardDAO.changeManager(cbid, nominee);
	%>
    <div class="context">
    <%=nominee %> 님께 <%=cbname%> 클립보드  매니저를 위임하였습니다.<br/>
    <a href="index.jsp"><img src="img/메인으로.png"title="logo" width="160" height="40" ></a>
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