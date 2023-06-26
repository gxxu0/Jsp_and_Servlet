<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시간표 등록</title>
</head>
<body>
<%
Connection con = null;
PreparedStatement pstmt = null;
Statement stmt = null;

String driverName = "org.gjt.mm.mysql.Driver";
String dbURL = "jdbc:mysql://localhost:3306/mysql26";

Class.forName(driverName);
con = DriverManager.getConnection(dbURL, "root", "kbc0924");


int tt_id=(Integer)session.getAttribute("tt_id");
String ttd_id=(String)session.getAttribute("ttd_id");
int start       =Integer.parseInt(request.getParameter("times"));
int contin      =Integer.parseInt(request.getParameter("contins"));
int day = Integer.parseInt(request.getParameter("day"));
String name     =request.getParameter("tname");
String room     =request.getParameter("room");

if(room==null){room="";}

pstmt = con.prepareStatement("UPDATE timetable_detail SET time=?, contin=?, day=?, tname=?, room=? WHERE ttd_id=?");
pstmt.setInt(1, start);
pstmt.setInt(2, contin);
pstmt.setInt(3, day);
pstmt.setString(4, name);
pstmt.setString(5, room);
pstmt.setString(6, ttd_id);
int rowCount = pstmt.executeUpdate();  

if (rowCount == 1){ 
            
    out.println("<script>alert('시간표 수정에 성공했습니다.');</script>"); 
    session.removeAttribute("ttd_id");
    out.println("<script>location.href='./schedule.jsp'</script>");
    
}
else out.println("시간표 수정에 문제가 있습니다.");
%>
    
</body>
</html>