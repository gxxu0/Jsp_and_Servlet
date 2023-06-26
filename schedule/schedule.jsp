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
    <title>Your Schedule</title>
    <link rel="stylesheet" href="./schedule.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
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
            function onClick2() {
                document.querySelector('.modal_wrap2').style.display ='block';
                document.querySelector('.black_bg2').style.display ='block';
            }   
            function offClick2() {
                document.querySelector('.modal_wrap2').style.display ='none';
                document.querySelector('.black_bg2').style.display ='none';
            }
        
            document.getElementById('modal_btn1').addEventListener('click', onClick1);
            document.querySelector('.modal_close').addEventListener('click', offClick1);
            document.getElementById('modal_btn2').addEventListener('click', onClick2);
            document.querySelector('.modal_close2').addEventListener('click', offClick2);
        
        };

    </script>
</head>
<body>
<% 

    int tt_id=(Integer)session.getAttribute("tt_id");

    Connection con = null;
    PreparedStatement pstmt = null;
    String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql26";
    String sql = "select * from timetable_detail where tt_id = '" + tt_id + "'";
    int rowCount = 0;
    int tt1[][] = new int[10][6];
    int c = 0;
    int r = 0;
    int cont = 0;
    String tt2[][] = new String[10][6];
    String tt3[][] = new String[10][6];
    String ttds[][] = new String[10][6];
    int count=0;
    
    for(int i=0; i< 10; i++){
        for(int j=0; j< 6; j++){
            tt1[i][j] = 1;
            tt2[i][j] = "";
            tt3[i][j] = "";
            ttds[i][j] = "";
        }
    }

    try {
        Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
        pstmt = con.prepareStatement(sql);
        ResultSet result = pstmt.executeQuery();

		while (result.next()){

		    r = Integer.parseInt(result.getString("time"));
		    c = Integer.parseInt(result.getString("day"));
		    cont = Integer.parseInt(result.getString("contin"));
		    if(cont>1){

			    for(int k=r+1; k< r+cont; k++){
                    tt1[k][c] = 9;
                }
            }
		    tt1[r][c] = cont;
		    tt2[r][c] = result.getString("tname");
		    tt3[r][c] = result.getString("room");
            ttds[r][c] = result.getString("ttd_id");
		    rowCount++;
        }
        result.close();       
	}
    catch(Exception e) {
    	//out.println("MySql 데이터베이스 univdb의 student 조회에 문제가 있습니다. <hr>");
        out.println(e.toString());
        e.printStackTrace();
    }
    finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    
    }
%>
 <header>
 <div class="header">
     <a href="../main/main.jsp">
         <h1>Your Schedule</h1>
     </a> 
 </div>
</header>    
<div id="modal_btn1">
 <img src="../img/menu.png" alt="add" width="37px">
</div>
 


<div>
    <table id="table" style="width:800px;">
        <thead>
            <tr style="background-color: black; color: white; height: 35px;"> 
                <th></th>
                <th>월</th>
                <th>화</th>
                <th>수</th>
                <th>목</th>
                <th>금</th>
            </tr>
        </thead>
        <%
            for(int i=1; i< 10; i++)
            {
                %>
                <tr>
                    <td align="center"> <%=i%> 교시</td>
                    <%
                for(int j=1; j< 6; j++)
                {
                    if(tt1[i][j]!=9){
                        %>
                        <td style="font-weight: bold;" align="center" rowspan="<%=tt1[i][j]%>" onclick="location.href='./schedule_remove.jsp?value=<%=ttds[i][j]%>'">
                            <%=tt2[i][j]%> <br> <%=tt3[i][j]%>
                        </td>
                        <%
                    }
                        
                }%>
                </tr>
                <%
            }
%>
 </table>
</div>

<div class="black_bg"></div>

<div class="modal_wrap" style="border-radius: 15px;">
 <div class="modal_close">
     <img src="../img/close.png" alt="remove">
 </div>
 <form id="form_add" action="add.jsp" accept-charset="utf-8" name="add_modal_time" method="post">
            <p>새 수업 추가</p>
            <div class="input_text"> <!--과목명-->
                과 목 명&nbsp;&nbsp;&nbsp;
                <input type="text" name="tname" size="25" id="class" required><br>
            </div>
            <div> <!--요일 선택-->
                요   일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="day" value=1 required>월
                <input type="radio" name="day" value=2 required>화
                <input type="radio" name="day" value=3 required>수
                <input type="radio" name="day" value=4 required>목
                <input type="radio" name="day" value=5 required>금<br>
            </div>
            <div> <!--시작시간 및 연속시간 선택-->
                <label for="time">시작 시간&nbsp;</label>
                <select name="time" id="time">
                    <option value=1>오전 9시</option>
                    <option value=2>오전 10시</option>
                    <option value=3>오전 11시</option>
                    <option value=4>오후 12시</option>
                    <option value=5>오후 1시</option>
                    <option value=6>오후 2시</option>
                    <option value=7>오후 3시</option>
                    <option value=8>오후 4시</option>
                    <option value=9>오후 5시</option>
                </select>
                <label for="continuity">&nbsp;연속 시간</label>
                <select name="continuity" id="continuity">
                    <option value=1>1</option>
                    <option value=2>2</option>
                    <option value=3>3</option>
                    <option value=4>4</option>
                </select><br>
            </div>
            <div>강 의 실&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" size="25" name="room"></div>
            <button id="button_input">입력</button>
        </form>
</div>
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