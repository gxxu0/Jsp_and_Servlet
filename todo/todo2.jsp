<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./todo.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/29c4d2b017.js" crossorigin="anonymous"></script>
    <script>
        window.onload = function() {
     
        function onClick1() {
            document.querySelector('.modal_wrap').style.display ='block';
            document.querySelector('.black_bg').style.display ='block';
        }   
        function offClick1() {
            document.querySelector('.modal_wrap').style.display ='none';
            document.querySelector('.black_bg').style.display ='none';
        }
        document.getElementById('modal_btn1').addEventListener('click', onClick1);
        document.querySelector('.modal_close').addEventListener('click', offClick1);
 
 };
    </script>
    <style>
        *{
            font-family: 'Nanum Gothic', sans-serif;
        }
        .done{
            text-decoration: line-through;
        }
        i{
            color: green;
        }
        .question{
            padding: 3px 8px;
            font-size: 13px;
            font-weight: bold;
        }
        .question:hover{
            cursor: pointer;
        }
        
    </style>
</head>
<body>
    <!--<script>
        const rowCnt = 1;
        const columnCnt = 2;

        document.write('<table border="1">');
        for (let i = 0; i < rowCnt; i++) {
            document.write('<tr>');
            for (let j = 0; j < columnCnt; j++)  {
                document.write('<td>');
                document.write(i);
                document.write('</td>');
            }
        document.write('</tr>')
        }
        document.write('</table>');
    </script>-->

    <%
        Connection con = null;
        PreparedStatement pstmt = null;
	    Statement stmt = null;
        ResultSet rs = null;

        String encoding    = "UTF-8";

        String driverName = "org.gjt.mm.mysql.Driver";
        String dbURL = "jdbc:mysql://localhost:3306/mysql26";
        String UID = (String)session.getAttribute("id");
        Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
        pstmt = con.prepareStatement("select * from todo where u_id=? order by date1");
        pstmt.setString(1,UID);
        rs = pstmt.executeQuery();
        String date = null;
        String rpeat = null;
        String title = null;
        String content = null;
        int status = -1;
        int count=0;

    %>
    <header>
        <div class="header">
            <a href="../main/main.jsp">
                <h1>Your Schedule</h1>
            </a> 
        </div>
    </header>
    <main id="main">
           
        <div class="black_bg"></div>
        <div class="modal_wrap" style="border-radius: 15px;">
            <div class="modal_close">
                <img src="./../img/close.png" alt="remove">
            </div>
            <form id="form_add" action="todoAdd.jsp" accept-charset="utf-8" name="add_modal_time" method="post">
                <p style="font-size: 18px;">할 일 추가</p>
                <div>
                    <input type="text" name="title" placeholder=" 제목을 입력하세요!" style="width: 100%; height: 20px;" required><br>
                    <textarea name="content" placeholder=" 내용을 입력하세요!" id="text_content" rows="5"></textarea>
                </div>
                <div id="period1">
                    <div style="position: relative; float: left; margin-top: 10px; font-weight: bold;">
                        날짜 설정
                    </div>
                    <div class="wrapper" id="wrapper_open">
                        <input type="checkbox" id="switch" name="switch" onclick="openCloseToc()">
                        <label for="switch" class="switch_label">
                            <span class="onoff"></span>
                        </label>
                    </div>
                </div>
                <script>
                    var elday = document.getElementsByClassName('persel');

                    function openCloseToc(){
                        if(document.getElementById('period').style.display === 'block'){
                            //document.querySelector('input[name="switch2"]').checked = true;
                            document.getElementById('period').style.display = 'none';
                            document.getElementById("hz").value=null;
                            //document.getElementById('period_select2').style.display = 'block';
    
                        }
                        else{
                            document.querySelector('input[name="switch2"]').checked = false;
                            for(var i=0; i<elday.length; i++){	elday[i].checked = false;}
                            document.getElementById('period').style.display = 'block';
                            document.getElementById('period_select2').style.display = 'none';
                        }
                    }
                </script>
                <div id="period" style="display: none;">
                    <input type="date" class="date_select2" name="date1" id="hz" value=null>
                </div>

                <div id="period2">
                    <div style="position: absolute; bottom: 25%; float:left; font-weight: bold;">
                        반복 설정
                    </div>
                    <div class="wrapper2" id="wrapper_open2">
                        <input type="checkbox" id="switch2" name="switch2" onclick="openCloseToc2()">
                        <label for="switch2" class="switch_label2">
                            <span class="onoff2"></span>
                        </label>
                    </div>
                </div>
                <script>
                    var elday = document.getElementsByClassName('persel');
                    //for(var i=0; i<el.length; i++){	el[i].checked = false;}

                    function openCloseToc2(){
                        if(document.getElementById('period_select2').style.display === 'block'){
                            //document.querySelector('input[name="switch"]').checked = true;
                            document.getElementById('period_select2').style.display = 'none';
                            for(var i=0; i<elday.length; i++){	elday[i].checked = false;}
                            //document.getElementById('period').style.display = 'block';  
                        }
                        else{
                            document.getElementById("hz").value=null;
                            document.querySelector('input[name="switch"]').checked = false;
                            document.getElementById('period_select2').style.display = 'block';
                            document.getElementById('period').style.display = 'none';
                        }
                    }
                </script>

                <div id="period_select2" style="display: none;">
                    <div class="period_select_radio">
                        <input class="persel" type="checkbox" id="mon" value="mon" name="period"><label for="mon">월</label>
                        <input class="persel" type="checkbox" id="tue" value="tue" name="period"><label for="tue">화</label>
                        <input class="persel" type="checkbox" id="wed" value="wed" name="period"><label for="wed">수</label>
                        <input class="persel" type="checkbox" id="thu" value="thu" name="period"><label for="thu">목</label>
                        <input class="persel" type="checkbox" id="fri" value="fri" name="period"><label for="fri">금</label>
                        <input class="persel" type="checkbox" id="sat" value="sat" name="period"><label for="sat">토</label>
                        <input class="persel" type="checkbox" id="sun" value="sun" name="period"><label for="sun">일</label>
                    </div>
                    
                </div>
                <button type="submit" id="button_input" style="width: 100%; height: 35px;">입력</button>
            </form>
        </div>

        <div style="margin: 50px 0;"></div>
        <div class="container-box">
            <div class="container-left">
                <form action="#" id="form_add" accept-charset="utf-8" name="add_modal_time" method="get">
                    <div id="modal_btn1">
                        <img src="../img/menu.png" alt="add" width="25px">
                    </div>
                </form>
                <div class="container_input">
                    
                    <h3 style="text-align: center;">할 일 목록</h3>
                    <ul id="list"></ul>
                    <!--🔻🔺🔘⚫⚪🔽🔼⭕❌-->
                    <%
                        while(rs.next()){
                            content=rs.getString("content");
                            title=rs.getString("title");
                            rpeat=rs.getString("rpeat");
                            status=rs.getInt("status");
                            date=rs.getString("date1");
                            count++;
                    %>
                    
                        <div class="list-item">
                            <button id="que-<%=count%>" class="question"><li id="que-<%=count%>"><span id="que-<%=count%>-toggle"><i class="fa-solid fa-circle-chevron-down"></i>&nbsp;&nbsp;</span><span><%=title%></span></li></button>
                            <div class="answer" id="ans-<%=count%>" style="display: none;" >
                                <ul type="none"><li><input type="checkbox" id="data-id"><%=content%></li></ul>
                            </div>
                        </div>
                    <%}%>
                    </ul>
                </div>
            </div>
            <div class="container-right">
                <form action="#" id="form_add" accept-charset="utf-8" name="add_modal_time" method="get">
                    <div id="modal_btn1">
                        <img src="../img/menu.png" alt="add" width="25px">
                    </div>
                </form>
                <div class="container_input">
                    
                    <h3 style="text-align: center;">오늘의 할 일</h3>
                    <ul id="list"></ul>
                    <!--🔻🔺🔘⚫⚪🔽🔼⭕❌-->
                    <%
                        while(rs.next()){
                            content=rs.getString("content");
                            title=rs.getString("title");
                            rpeat=rs.getString("rpeat");
                            status=rs.getInt("status");
                            date=rs.getString("date1");
                            count++;
                    %>
                    
                        <div class="list-item">
                            <button id="que-<%=count%>" class="question"><li id="que-<%=count%>"><span id="que-<%=count%>-toggle">🔽</span><span><%=title%></span></li></button>
                            <div class="answer" id="ans-<%=count%>" style="display: none;" >
                                <ul>
                                    <li>
                                        <%=content%>
                                    </li>
                                </ul>
                            </div>
                            
                        </div>
                    <%}%>
                    </ul>
                </div>
            </div>
            
        </div>
    </main>
    <footer> 
        <div>
            <img src="../img/yourschedule_logo.png">
            <p style="font-size: 15px; font-weight: 500;">Your Schedule</p>
            <p style="font-size: 12px; font-weight: 400;">phone : +82)1-234-5678&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;팩스번호 : +82)1-234-5678</p>
            <p style="font-size: 15px; font-weight: 500;">Copyright © Your Schedule All right reserved</p>
        </div>
    </footer>
</body>
        <script>
            const items = document.querySelectorAll('.question'); 
  
            function openCloseAnswer() 
            {
            const answerId = this.id.replace('que', 'ans');
      
            if(document.getElementById(answerId).style.display === 'none') {

                document.getElementById(answerId).style.display = 'block';
                //document.getElementById(this.id + '-toggle').textContent = '🔼';
                document.getElementById(this.id + '-toggle').innerHTML = '<i class="fa-solid fa-circle-chevron-up"></i>&nbsp;';
                
            } else {
                document.getElementById(answerId).style.display = 'none';
                document.getElementById(this.id + '-toggle').innerHTML = '<i class="fa-solid fa-circle-chevron-down"></i>&nbsp;';
            }
            }
            items.forEach(item => item.addEventListener('click', openCloseAnswer));
        </script>
</html>