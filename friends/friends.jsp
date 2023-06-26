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
    <link rel="stylesheet" href="./friends.css">
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
</head>
<body>
    <%

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    Statement stmt = null;

    String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql26";
    String encoding    = "UTF-8";
    Class.forName(driverName);
    con = DriverManager.getConnection(dbURL, "root", "kbc0924");

    String ID=(String)session.getAttribute("id");
    String name=(String)session.getAttribute("name");

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
        <div class="modal_wrap">
            <div class="modal_close">
                <img src="./../img/close.png" alt="remove">
            </div>
            <form id="form_add" id="form_add" action="addf.jsp" accept-charset="utf-8" name="add_modal_time" method="post">
                <p style="font-size: 18px;">친구 추가</p>
                <br>
                <div class="form_add_nic">
                    <label for="fname">친구 닉네임&nbsp;</label>
                    <input type="text" name="fname" style="width: 40%; height: 20px;">
                    <button type="submit" id="button-search">친구 추가하기</button>
                </div>
                
            </form>
        </div>
        <div style="margin: 50px 0;"></div>
        <div id="container-box">
            <div class="container-left">
                <form action="#" id="form_add" accept-charset="utf-8" name="add_modal_time" method="get">
                    <div id="modal_btn1">
                        <img src="../img/menu.png" alt="add" width="25px">
                    </div>
                </form>
                <div class="container_input">
                    <h3 style="text-align: center;">친구 목록</h3>
                    <ul id="list">
                        <%
                        pstmt=con.prepareStatement("select * from f_add as A JOIN users as B on A.u2=B.u_name where A.u1=? and A.fstatus=1");
                        pstmt.setString(1, name);
                        rs=pstmt.executeQuery();
                        String u2=null;
                        String fid=null;
                        String fuid=null;
                        while(rs.next()){
                            u2=rs.getString("u2");
                            fid=rs.getString("fid");
                            fuid=rs.getString("u_id");
                            %>
                            <form>
                                <li class="list-item"><i class="fa-solid fa-user-large"></i>&nbsp;&nbsp;<%=u2%>
                                <button type="submit" formaction="./todof.jsp" formmethod="post" value="<%=fuid%>" name="fuid">할 일 보기</button>
                                <button type="submit" formaction="./removef.jsp" formmethod="post" value="<%=fid%>" name="fid">친구 삭제</button> </li>
                            </form>
                        <%}
                        pstmt=con.prepareStatement("select * from f_add as A JOIN users as B on A.u1=B.u_name where A.u2=? and A.fstatus=1");
                        pstmt.setString(1, name);
                        rs=pstmt.executeQuery();
                        String u1=null;
                        fid=null;
                        while(rs.next()){
                            u1=rs.getString("u1");
                            fid=rs.getString("fid");
                            fuid=rs.getString("u_id");
                            %>
                            <form>
                                <li class="list-item"><i class="fa-solid fa-user-large"></i>&nbsp;&nbsp;<%=u1%>
                                <button type="submit" formaction="./todof.jsp" formmethod="post" value="<%=fuid%>" name="fuid">할 일 보기</button>
                                <button type="submit" formaction="./removef.jsp" formmethod="post" value="<%=fid%>" name="fid">친구 삭제</button> </li>
                            </form>
                        <%}
                        %>
                    </ul>
                </div>
            </div>
            <div class="container-right">
                <div class="container_input">
                    <!-- (수락,거절)-->
                    <h3 style="text-align: center;">친구 관리</h3>
                    <ul id="list">
                        <li class="list-item2">
                            <div>
                            <%
                            pstmt=con.prepareStatement("select * from f_add where u2=? and fstatus=0");
                            pstmt.setString(1, name);
                            rs=pstmt.executeQuery();
                            while(rs.next()){
                                fid=rs.getString("fid");
                                u1=rs.getString("u1");%>
                                    <form >
                                        <li class="list-item"><i class="fa-solid fa-user-large"></i>&nbsp;&nbsp;<%=u1%>
                                        <input hidden value="<%=fid%>" name="fid">
                                        <button type="submit" formaction="./acceptf.jsp" formmethod="post">수락</button>
                                        <button type="submit" formaction="./rejectf.jsp" formmethod="post">거절</button>    
                                        </li>
                                        
                                    </form>    
                                <%
                            }
                            %>


                            </div>
                        </li>
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
</html>