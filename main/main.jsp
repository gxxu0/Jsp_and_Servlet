<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8"%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Schedule</title>
    <link rel="stylesheet" href="./main.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
    <% 
    String ID = (String)session.getAttribute("id");
    String name = (String)session.getAttribute("name");
    %>

    <header>

        <div class="header">
            <a href="./main.jsp">
                <h1>Your Schedule</h1>
            </a> 
        </div>
    </header>
    <section class="main">
        <div class="timetable">
            <a href="../schedule/schedule_select.jsp"><img src="../img/timetable.png"></a>
        </div>
        <div class="todo">
            <a href="../todo/todo.jsp"><img src="../img/list.png"></a>
        </div>
        <div class="friend">
            <a href="../friends/friends.jsp"><img src="../img/friends.png"></a>
        </div>
        <div class="login">
            <%
            if(ID==null){%>
                <a href="../login/login.html"><img src="../img/login.png" alt="login"></a></a>
            <%}
            else{%>
                <a href="./logout.jsp" class="logout">logout</a>
                <div id="login-ing">
                    <img src="../img/user.png" alt="user-login" id="user-login">
                    
                    <a id="login-ing-p"><%=name%>님 로그인 중</a>
  
                </div>
                
            <%}
            %>
        </div>
    </section>
    <footer> 
        <div>
            <img src="../img/yourschedule_logo.png">
            <p style="font-size: 15px; font-weight: 500;">Your Schedule</p>
            <p style="font-size: 12px; font-weight: 400;">phone : +82)1-234-5678&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;팩스번호 : +82)1-234-5678</p>
            <p style="font-size: 15px; font-weight: 500;">Copyright © Your Schedule All right reserved</p>
        </div>
    </footer>
</body>
</html>