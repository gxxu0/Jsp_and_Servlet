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
    <link rel="stylesheet" href="../todo/todo.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/29c4d2b017.js" crossorigin="anonymous"></script>

    </script>
 
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
        String UID = request.getParameter("fuid");
        Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
        
        String date = null;
        String rpeat = null;
        String title = null;
        String content = null;
        int todo_id = 0;
        int status = -1;
        int count=0;
        String Today = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
        java.util.Date getday = new java.util.Date();
        int day = getday.getDay();
        if(day==0){
            day=6;
        }else if(day>0){
            day=day-1;
        }
        

    %>
    <header>
        <div class="header">
            <div class="calendar">
                <a href="../calendar/calendar.jsp" target="_blank">
                    <img src="../img/calendar.png">
                </a>
            </div>
            <div>
                <a href="../main/main.jsp">
                    <h1>Your Schedule</h1>
                </a> 
            </div>
            <div></div>
        </div>

    </header>
    <main id="main">
           

        <div style="margin: 50px 0;"></div>
        <div class="container-box">
            <div class="container-left">
                
                <div class="container_input">
                    
                    <h3 style="text-align: center;">기한 없는 할 일 목록</h3>
                    <ul id="list"></ul>
                    <!--🔻🔺🔘⚫⚪🔽🔼⭕❌-->
                    <%
                        pstmt = con.prepareStatement("select * from todo where u_id=? and rpeat='' and date1 is null");
                        pstmt.setString(1,UID);
                        rs = pstmt.executeQuery();

                        while(rs.next()){
                            content=rs.getString("content");
                            title=rs.getString("title");
                            rpeat=rs.getString("rpeat");
                            status=rs.getInt("status");
                            date=rs.getString("date1");
                            todo_id=rs.getInt("todo_id");
                            count++;

                    %>
                    
                        <div class="list-item">
                            <input type="checkbox" id="data-id">
                            <button id="que-<%=count%>" class="question"><li id="que-<%=count%>"><span id="que-<%=count%>-toggle"><i class="fa-solid fa-circle-chevron-down"></i></li></button>&nbsp;&nbsp;</span><span onclick="location.href='./todo_remove.jsp?value=<%=todo_id%>'"><%=title%></span>
                            <div class="answer" id="ans-<%=count%>" style="display: none;" >
                                <ul type="none"><li><%=content%></li></ul>
                            </div>
                        </div>
                    <%}%>
                    </ul>
                </div>
            </div>
            <div class="container-right">
                <div class="container_input">
                    
                    <h3 style="text-align: center;">오늘의 할 일</h3>
                    <ul id="list"></ul>

                    <!--🔻🔺🔘⚫⚪🔽🔼⭕❌-->
                    <%
                        pstmt = con.prepareStatement("select * from todo where u_id=? and (rpeat Like '%"+day+"%' or date1=?)");
                        pstmt.setString(1,UID);

                        pstmt.setString(2,Today);
                        rs = pstmt.executeQuery();

                        while(rs.next()){
                            content=rs.getString("content");
                            title=rs.getString("title");
                            rpeat=rs.getString("rpeat");
                            status=rs.getInt("status");
                            date=rs.getString("date1");
                            todo_id=rs.getInt("todo_id");
                            count++;

                    %>
                    
                        <div class="list-item">
                            <button id="que-<%=count%>" class="question"><li id="que-<%=count%>"><span id="que-<%=count%>-toggle"><i class="fa-solid fa-circle-chevron-down"></i></li></button>&nbsp;&nbsp;</span><span onclick="location.href='./todo_remove.jsp?value=<%=todo_id%>'"><%=title%></span>
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