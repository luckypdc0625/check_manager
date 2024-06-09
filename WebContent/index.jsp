<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="clipboard.ClipboardDAO"  %>
<%@ page import="clipboard.Clipboard"  %>
<%@ page import="checklist.ChecklistDAO"  %>
<%@ page import="checklist.Checklist"  %>
<%@ page import="java.util.ArrayList"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>체크 매니저</title>
<link rel="stylesheet" href="style.css">
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
</head>
<body bgcolor="#ECF1F5" onload="progressOnload()">

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
        <a href="logout.jsp"><img src="img/로그아웃.png" title="logo" width="111" height="40" ></a>
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
    <input type="hidden" id="chatcbname" value="">
    <input type="hidden" id="chatusername" value="">
    <input type="hidden" id="chatcbid" value="">
    <%
    if(userName != null) {
		ClipboardDAO clipboardDAO = ClipboardDAO.getInstance();
		ChecklistDAO checklistDAO = ChecklistDAO.getInstance();
		ArrayList<Clipboard> cbs = clipboardDAO.loadAll((String) session.getAttribute("userName"));
		boolean exist = false;
	%>
	<%
	
		if(cbs.size() == 0) {
		} else {
			for(int i=0; i<cbs.size(); i++) {
				String involved = cbs.get(i).getCbInvolved();
				String[] involvedUsers = involved.split(",");
				for(int j=0; j<involvedUsers.length; j++) {
					if(involvedUsers[j].equals((String) session.getAttribute("userName"))) {
						exist = true;
    %>
<div style="float:left; width:350px; height:300px; background-image: url('img/클립보드.png'); background-size:100% 100%; background-repeat: no-repeat; padding-top:15px; padding-left:10px;" >
<table width="340">
<tr>
<td style="text-align:center; font-size:20px; width:180px;"><%=cbs.get(i).getCbName() %></td>
<td>
<script type="text/javascript">
function viewchat(event, btn) {
	var xmlhttp= false;
	if (window.XMLHttpRequest) {
		xmlhttp= new XMLHttpRequest( );
		xmlhttp.overrideMimeType('text/xml');
	} else if (window.ActiveXObject) {
		xmlhttp= new ActiveXObject("Microsoft.XMLHTTP");
	}
	var cbname = btn.name;
	var userName = btn.id;
	var cbid = btn.className;
	$('#chatcbname').val(cbname);
	$('#chatusername').val(userName);
	$('#chatcbid').val(cbid);
	var qry= 'cbname='+cbname+'&cbid='+cbid;
	var url= 'viewChat.jsp?';
	xmlhttp.open('POST', url, true);
	xmlhttp.onreadystatechange= function() {
		if(xmlhttp.readyState== 4 && xmlhttp.status== 200) {
			var result = xmlhttp.responseText;
			var htmlele = document.createElement("html");
			htmlele.innerHTML = result;
			var bodytag = htmlele.getElementsByTagName("body");
			

			var innerhtml = bodytag[0].innerHTML;
			//var realprint = innerhtml.substring(1, innerhtml.length-2);
			var chatchat = $('#chatchat');
			chatchat.html("<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style=\"color:white;\">"+cbname+"<font><br><br><br><br>");
			var chatchatcontext = $('#chatchatcontext');
			chatchatcontext.html(innerhtml);
		} else {
		}
	};
	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlhttp.send(qry);
}
function insertChat() {
	if($('#chattext').val()=="") {
		alert("채팅 내용을 입력해주세요.");
		return;
	}
	var xmlhttp= false;
	if (window.XMLHttpRequest) {
		xmlhttp= new XMLHttpRequest( );
		xmlhttp.overrideMimeType('text/xml');
	} else if (window.ActiveXObject) {
		xmlhttp= new ActiveXObject("Microsoft.XMLHTTP");
	}
	var chattext = $("#chattext").val();
	var cbname = $("#chatcbname").val();
	var userName = $("#chatusername").val();
	var cbid = $("#chatcbid").val();
	var qry= 'chattext='+chattext+'&cbname='+cbname+'&userName='+ userName+'&cbid='+cbid;
	var url= 'insertChat.jsp?';
	xmlhttp.open('POST', url, true);
	xmlhttp.onreadystatechange= function() {
		if(xmlhttp.readyState== 4 && xmlhttp.status== 200) {
			var result = xmlhttp.responseText;
			var htmlele = document.createElement("html");
			htmlele.innerHTML = result;
			var bodytag = htmlele.getElementsByTagName("body");
			var innerhtml = bodytag[0].innerHTML;
			var realprint = innerhtml.substring(1, innerhtml.length-2);
			
			var ab = $('#chattable').html();
			var bc = "<tr><td>"+userName+"</td><td>"+chattext+"</td><td>"+realprint+"</td><tr>"
			$('#chattable').html(ab+bc);
			$('#chattext').val("");
		} else {
		}
	};
	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlhttp.send(qry);
}
</script>
	<%
						if(cbs.get(i).getCbManager().equals((String) session.getAttribute("userName"))) {
	%>
<form action="delegateManagerCB.jsp" method="POST" style="float:left">
<input type="hidden" name="cbid" value="<%=cbs.get(i).getCbId()%>">
<input type="submit" value="" style="width:30px; height:30px; background-image: url('img/crown.png'); background-size:100%; background-repeat: no-repeat;">
</form>
	<%
						}
	%>
<form style="float:left">
<input type="hidden" name="cbname" value="<%=cbs.get(i).getCbName()%>">
<input type="button" class="<%=cbs.get(i).getCbId()%>" id="<%=(String) session.getAttribute("userName") %>" name="<%=cbs.get(i).getCbName()%>" value="" style="width:30px; height:30px; background-image: url('img/chat.png'); background-size:100%; background-repeat: no-repeat;" onclick="viewchat(event, this)">
</form>
<form style="float:left">
<input type="button" value="" style="width:30px; height:30px; background-image: url('img/파일저장.png'); background-size:100%; background-repeat: no-repeat;" onclick="window.open('viewupload.jsp?cbname=<%=cbs.get(i).getCbName() %>&cbid=<%=cbs.get(i).getCbId() %>','viewupload','width=480,height=500,location=no,status=no,scrollbars=yes');">
</form>
<form action="inviteCB.jsp" method="POST" style="float:left">
<input type="hidden" name="cbid" value="<%=cbs.get(i).getCbId()%>">
<input type="submit" value="" style="width:30px; height:30px; background-image: url('img/invite.png'); background-size:100%; background-repeat: no-repeat;">
</form>
<form action="exitCB.jsp" method="POST" style="float:left">
<input type="hidden" name="cbid" value="<%=cbs.get(i).getCbId()%>">
<input type="submit" value="" style="width:30px; height:30px; background-image: url('img/exit.png'); background-size:100%; background-repeat: no-repeat;">
</form>
</td>
</tr>	
<tr>
<td colspan="2">&nbsp;</td>
</tr>
<tr>
<td colspan="2">[매니저] <%=cbs.get(i).getCbManager() %></td>
</tr>
<tr>
<td colspan="2">[참가자] <%=involved %></td>
</tr>
<tr>
<td colspan="2">

<progress id="progress<%=cbs.get(i).getCbId()%>" value="<%=checklistDAO.progressById(cbs.get(i).getCbId())%>" style="width:210px;height:23px;float:left"></progress><span id="span<%=cbs.get(i).getCbId()%>" style="float:left;">&nbsp;<%=Math.round(checklistDAO.progressById(cbs.get(i).getCbId())*100)%>%</span><input type="text" style="width:10px;height:10px;float:left;background:none;border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;">
	<%
						if(cbs.get(i).getCbManager().equals((String) session.getAttribute("userName"))) {
	%>
<form action="createCL.jsp" style="float:left">
<input type="hidden" name="cbid" value="<%=cbs.get(i).getCbId()%>">
<input type="submit" value="" style="width:30px; height:30px; background-image: url('img/chadd.png'); background-size:100%; background-repeat: no-repeat;">
</form>
	<%
						}
	%>

</td>
</tr>
</table>
<div style="width:330px; height:140px;overflow:auto;">
<table>
	<%
						int clsize = 0;
						ArrayList<Checklist> cls = checklistDAO.loadAll();
						if(cls.size() == 0) {
						} else {
							for(int k=0; k<cls.size(); k++) {
								int cbid = cls.get(k).getCbid();
								if(cbid == cbs.get(i).getCbId()) {
									clsize++;
	%>

<tr>
<td colspan="2">
<input type="checkbox" id="<%=cls.get(k).getCbid()%>" name="<%=cls.get(k).getClDate()%>" value="<%=cls.get(k).getClContent() %>" onclick="checkedChanged(event, this)"><font id="content<%=cls.get(k).getClDate()%>"><%=cls.get(k).getClContent() + " - " + cls.get(k).getUserName() + " (~ " + cls.get(k).getDue() + ")" %></font>
	<%
									if(cbs.get(i).getCbManager().equals((String) session.getAttribute("userName"))) {
	%>

<input type="button" value="" id="<%=cls.get(k).getClDate()%>" name="<%=cls.get(k).getClContent()%>" style="width:20px; height:20px; background-image: url('img/deleteCL.png'); background-size:100%; background-repeat: no-repeat;" onclick="deleteCL(this)">
	<%
									}
	%>
</td>
</tr>
	<%
								if(cls.get(k).getClIsChecked() == 0) {
	%>
<script type="text/javascript">
var checkbox = document.getElementsByName(<%=cls.get(k).getClDate()%>);
checkbox[0].checked = false;
var nn = "content"+"<%=cls.get(k).getClDate()%>";
var content = document.getElementById(nn);
content.style.textDecoration = "none";
</script>
	<%
								} else if (cls.get(k).getClIsChecked() == 1) {
	%>
<script type="text/javascript">
var checkbox = document.getElementsByName(<%=cls.get(k).getClDate()%>);
checkbox[0].checked = true;
var nn = "content"+"<%=cls.get(k).getClDate()%>";
var content = document.getElementById(nn);
content.style.textDecoration = "line-through";
</script>
	<%
								}
	%>
<script type="text/javascript">
function progressOnload() {
	
}
function checkedChanged(event, check) {
	var xmlhttp= false;
	if (window.XMLHttpRequest) {
		xmlhttp= new XMLHttpRequest( );
		xmlhttp.overrideMimeType('text/xml');
	} else if (window.ActiveXObject) {
		xmlhttp= new ActiveXObject("Microsoft.XMLHTTP");
	}
	var checkstatue = check.checked;
	event.preventDefault();
	var cbid = check.id;
	var date = check.name;
	var qry= 'cbid='+cbid+'&date='+ date;
	var url= 'checkedChanged.jsp?';
	xmlhttp.open('POST', url, true);
	xmlhttp.onreadystatechange= function() {
		if(xmlhttp.readyState== 4 && xmlhttp.status== 200) {
			var result = xmlhttp.responseText;
			var htmlele = document.createElement("html");
			htmlele.innerHTML = result;
			var bodytag = htmlele.getElementsByTagName("body");
			var innerhtml = bodytag[0].innerHTML;
			var realprint = innerhtml.substring(1, innerhtml.length-2);

			if(realprint=="notmanager") {
				alert("매니저가 아닙니다.");
			} else {
				check.checked = checkstatue;
				if (check.checked == true) {
					var nn = "content"+date;
					var content = document.getElementById(nn);
					content.style.textDecoration = "line-through";
				} else {
					var nn = "content"+date;
					var content = document.getElementById(nn);
					content.style.textDecoration = "none";
				}
				var all = realprint.substring(0, 4);
				var checked = realprint.substring(4, 8);
				if(all == "0000") {
					document.getElementById("progress"+cbid).value = 0;
					var progressSpan = document.getElementById("span"+cbid);
					progressSpan.innerHTML = "&nbsp;"+0+"%";
				} else {
					var calculation = checked/all;
					document.getElementById("progress"+cbid).value = calculation;
					var progressSpan = document.getElementById("span"+cbid);
					progressSpan.innerHTML = "&nbsp;" + Math.round(calculation*100) + "%";
				}
			}
		} else {
		}
	};
	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlhttp.send(qry);
}
function deleteCL(check) {
	var xmlhttp= false;
	if (window.XMLHttpRequest) {
		xmlhttp= new XMLHttpRequest( );
		xmlhttp.overrideMimeType('text/xml');
	} else if (window.ActiveXObject) {
		xmlhttp= new ActiveXObject("Microsoft.XMLHTTP");
	}
	if(confirm(check.name + " 항목을 삭제하시겠습니까?")) {
		var date = check.id;
		var qry= 'date='+ date;
		var url= 'deleteCL.jsp?';
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

	<%
								}
							}
						}
						if(clsize <= 4) {
							for(int l = 0; l < 5-clsize; l++) {		
	%>
<tr>
<td>&nbsp;</td>
</tr>
	<%
							}
						}
	%>
</table>
</div>
</div>
	<%
					}
				}
			}
		}
		if(!exist) {
	%>
	<div class="context">
참가중인 클립보드가 없습니다.
</div>
	<%
		}
	%>

	<%
	} else {
		%>
		<div class="context" style="width:170px; height:80px; background-image: url('img/먼저-로그인해.png'); background-size:100%; background-repeat: no-repeat;"></div>
		<%
	}
	%>
    
    

        
        
        
    </section>
    
    <aside>
    <div id = "chatFrame" style="float:left; width:350px; height:530px; background-image: url('img/알림창.png'); background-size:100% 100%; background-repeat: no-repeat; padding-top:15px; padding-left:10px;">
    <div id = "chatchat" style="float:left; width:350px; height:100px;">
    </div>
    
    <div id ="chatchatcontext" style="float:left; width:320px; height:380px; overflow:auto;padding-left:10px;">
    
    </div>
    </div>
    <div style="position:absolute;top:680px;left:1185px;"><input id="chattext" type="text" style="width:230px; height:20px"> <input type="button" value="전송" style="width:50px; height:30px" onclick="insertChat()">
            
    </div>
    
        <box4 id="box4" class="box4">
            
            <box9 class="box9">
                <p7 id="call" onclick="change2()">
                <br>
                    <img src="img/코멘트.png"title="logo" width="57" height="57" >
                </p7>
                
            </box9>
            
            
            
            
        </box4>
        

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