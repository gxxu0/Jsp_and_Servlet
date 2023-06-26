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
    <link rel="stylesheet" href="./todo_remove.css">
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

        String encoding    = "UTF-8";

        String driverName = "org.gjt.mm.mysql.Driver";
        String dbURL = "jdbc:mysql://localhost:3306/mysql26";
        String UID = (String)session.getAttribute("id");
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
        String value=request.getParameter("value");
        session.setAttribute("todo_id",value);

        pstmt = con.prepareStatement("select * from todo where todo_id=?");
        pstmt.setString(1,value);
    
        rs = pstmt.executeQuery();
        rs.next();
    
        title=rs.getString("title");
        content=rs.getString("content");
        date=rs.getString("date1");
        rpeat=rs.getString("rpeat");
    %>
    

    <div class="black_bg"></div>

    <div class="modal_wrap" style="border-radius: 15px;">
        <div class="modal_close">
            <a href="./todo.jsp"><img src="../img/close.png" alt="remove"></a>
        </div>
        <form id="form_update" action="update.jsp" accept-charset="utf-8" name="add_modal_time" method="post">
            <p>기존 할 일 수정</p>
            <div class="input_text"> <!--할 일 제목 수정-->
                할 일 제목&nbsp;&nbsp;&nbsp;
                <input type="text" size="25" name="title" value="<%=title%>" required>
            </div>
            <div class="input_text"><!--할 일 내용 수정-->
                <div>할 일 내용</div>
                <div>
                    <textarea name="content" id="text_content" rows="3" cols="43"><%=content%></textarea>
                </div>
            </div>
            <div id="period1"> <!--날짜 수정-->
                <div style="position: absolute;  margin-top: 10px; font-weight: bold;">
                    날짜 수정
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

            <div id="period2"> <!--반복 수정-->
                <div style="position: absolute; bottom: 10%; float:left; font-weight: bold;">
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
                    <input class="persel" type="checkbox" id="mon" value="0" name="period"><label for="mon">월</label>
                    <input class="persel" type="checkbox" id="tue" value="1" name="period"><label for="tue">화</label>
                    <input class="persel" type="checkbox" id="wed" value="2" name="period"><label for="wed">수</label>
                    <input class="persel" type="checkbox" id="thu" value="3" name="period"><label for="thu">목</label>
                    <input class="persel" type="checkbox" id="fri" value="4" name="period"><label for="fri">금</label>
                    <input class="persel" type="checkbox" id="sat" value="5" name="period"><label for="sat">토</label>
                    <input class="persel" type="checkbox" id="sun" value="6" name="period"><label for="sun">일</label>
                </div>
                
            </div>
            <div id="button-list">
                <button>수정</button>
                <button type="submit" formaction="remove.jsp" formmethod="post">삭제</button>
            </div>
            
        </form>
    </div>

    <script>
        var date = "<%=date%>";
        if(date==null||date=="null"){}else{
            document.getElementById('period').style.display = 'block';
            document.getElementById("hz").value="<%=date%>";
            document.querySelector('input[name="switch"]').checked = true;
        }
        var rpeat = "<%=rpeat%>";
        var arrayRpeat = rpeat.split(' ');
        var elday = document.getElementsByClassName('persel');
        if(rpeat==''||rpeat==' '){}else{
            document.querySelector('input[name="switch2"]').checked = true;
            document.getElementById('period_select2').style.display = 'block';
            for(var i=0; i<arrayRpeat.length; i++){	elday[arrayRpeat[i]].checked = true;}
        }
    </script>


</body>
</html>