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
    <link rel="stylesheet" href="./schedule_remove.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script>
        window.onload = function() {
 
            function offClick1() {
                document.querySelector('.modal_wrap').style.display ='none';
                document.querySelector('.black_bg').style.display ='none';
            }
            document.querySelector('.modal_close').addEventListener('click', offClick1);
        };

    </script>
</head>
<body>
    <%
    Connection con = null;
    PreparedStatement pstmt = null;
	Statement stmt = null;
    ResultSet rs = null;
    //StringBuffer SQL = new StringBuffer("select * from timetable_detail where ttd_id=? "); 
    //SQL.append("values (?, ?, ?, ?, ?, ?)");

    
    String value=request.getParameter("value");

    if(value==""||value==null){
        out.println("<script>location.href='./schedule.jsp'</script>");
        if( true ) return;
    }
    session.setAttribute("ttd_id",value);
	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql26";
    
    Class.forName(driverName);
    con = DriverManager.getConnection(dbURL, "root", "kbc0924");

    pstmt = con.prepareStatement("select * from timetable_detail where ttd_id=? ");
    pstmt.setString(1,value);

    rs = pstmt.executeQuery();
    rs.next();

    int tt_id=(Integer)session.getAttribute("tt_id");
    int start       =rs.getInt("time");
    int contin      =rs.getInt("contin");
    int day = rs.getInt("day");
    String name     =rs.getString("tname");
    String room     =rs.getString("room");

    if(room==null){room="";}
    %>

<script type="text/javascript">
    $(function(){
        $(":radio[name='day'][value='<%=day%>']").attr('checked', true);
        $("#times").val("<%=start%>"); 
        $("#contins").val("<%=contin%>"); 
    });
</script>

    <div class="black_bg"></div>

    <div class="modal_wrap" style="border-radius: 15px;">
        <div class="modal_close">
            <a href="./schedule.jsp"><img src="../img/close.png" alt="remove"></a>
        </div>
        <form id="form_update" action="update.jsp" accept-charset="utf-8" name="add_modal_time" method="post">
            <p>기존 수업 수정 / 삭제</p>
            <div class="input_text"> <!--과목명-->
                과 목 명&nbsp;&nbsp;&nbsp;
                <input type="text" value="<%=name%>" name="tname" size="25"><br>
            </div>
            <div> <!--요일-->
                요   일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" id="d1" name="day" value=1 required>월
                <input type="radio" id="d2" name="day" value=2 required>화
                <input type="radio" id="d3" name="day" value=3 required>수
                <input type="radio" id="d4" name="day" value=4 required>목
                <input type="radio" id="d5" name="day" value=5 required>금<br>
            </div>
            <div> <!--시작 시간 및 연속시간-->
                <label for="time">시작 시간&nbsp;</label>

                <select name="times" id="times">
                    <option value="1">오전 9시</option>
                    <option value="2">오전 10시</option>
                    <option value="3">오전 11시</option>
                    <option value="4">오후 12시</option>
                    <option value="5">오후 1시</option>
                    <option value="6">오후 2시</option>
                    <option value="7">오후 3시</option>
                    <option value="8">오후 4시</option>
                    <option value="9">오후 5시</option>
                </select>
                <label for="continuity">&nbsp;연속 시간</label>

                <select name="contins" id="contins">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                </select><br>
            </div>
            <div>강 의 실&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" value="<%=room%>" name="room" size="25"></div>
            <div id="button-list">
                <button>수정</button>
                <button type="submit" formaction="remove.jsp" formmethod="post">삭제</button>
            </div>
            
        </form>
    </div>
</body>
</html>