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
<title>시간표 삭제</title>
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

    if(session.getAttribute("tt_id")==null||session.getAttribute("tt_id")==""){
        out.println("<script>alert('다시 로그인 해주세요.');</script>"); 
        out.println("<script>location.href='.//login/login.html'</script>");
        if(true) return;
    }
    int tt_id=(Integer)session.getAttribute("tt_id");



    String ttd_id = (String)session.getAttribute("ttd_id");

    pstmt = con.prepareStatement("delete from timetable_detail where ttd_id = ?");
    pstmt.setString(1, ttd_id);
    int rowCount = pstmt.executeUpdate();



    try {

    
        if (rowCount == 1){ 
            
            out.println("<script>alert('시간표 삭제에 성공했습니다.');</script>"); 
            session.removeAttribute("ttd_id");
            out.println("<script>location.href='./schedule.jsp'</script>");
            
        }
        else out.println("시간표 추가에 문제가 있습니다.");
        

    }
    catch(Exception e) {
    	//out.println("MySql 데이터베이스 univdb의 users 조회에 문제가 있습니다. <hr>");
        out.println(e.toString());
        e.printStackTrace();
    }
    finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
    // out.println("<meta http-equiv='Refresh' content='1; URL=./schedule.jsp'>");
%>



</body>
</html>