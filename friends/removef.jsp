<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
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

    String fid=request.getParameter("fid");

    try{
        pstmt=con.prepareStatement("update f_add set fstatus=-1 where fid=?");
        pstmt.setString(1,fid);
        int rowCount=pstmt.executeUpdate();
        if(rowCount==1){
            out.println("<script>alert('친구를 삭제했습니다.');</script>");
            out.println("<script>location.href='./friends.jsp'</script>");
        }else out.println("실패하였습니다.");
        out.println(fid);
    }
    catch(Exception e) {
    	out.println("MySql 데이터베이스 문제가 있습니다. <hr>");
        out.println(e.toString());
        e.printStackTrace();
    }
    finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
    %>


</body>
</html>