<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@page session="true"%>



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인 페이지</title>
</head>
<body>

<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
    Connection con = null;
    PreparedStatement pstmt = null;
	Statement stmt = null;
    ResultSet rs = null;

	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql26";

    try {
		String encoding    = "UTF-8";
		int sizeLimit = 10 * 1024 * 1024; 
		//ServletContext context = getServletContext();
        //MultipartRequest multi = new MultipartRequest(request, sizeLimit, encoding);
        
        String uid             = request.getParameter("uid");
        String upw             = request.getParameter("upw");
		//String uname           = request.getParameter("uname");
	
        Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");

        pstmt = con.prepareStatement("SELECT u_id,u_pw,u_name FROM users WHERE u_id=? COLLATE utf8_bin;");
        pstmt.setString(1, uid);
        rs = pstmt.executeQuery();
        
        //RequestDispatcher
        //session_start();

        if(rs.next()){
            if(upw.equals(rs.getString("u_pw"))){
                out.println("<script>alert('로그인에 성공했습니다.');</script>"); 
                session.setAttribute("id",rs.getString("u_id"));
                session.setAttribute("name",rs.getString("u_name"));
                out.println("<script>location.href='../main/main.jsp'</script>");
            }
            else{
                out.println("<script>alert('id 또는 비밀번호를 잘못 입력했습니다.');</script>");
                out.println("<script>location.href='./login.html'</script>");
            }
        }else{
            out.println("<script>alert('id 또는 비밀번호를 잘못 입력했습니다.');</script>");
            out.println("<script>location.href='./login.html'</script>");
        }

        int rowCount = pstmt.executeUpdate();        
        if (rowCount == 1){ 
            //out.println("<hr> [" + uname+ "] 님의 회원가입을 환영합니다..<hr>");
        }
        else out.println("회원가입에 문제가 있습니다.");
        
        //다시 학생 조회
        stmt = con.createStatement();

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
    //out.println("<meta http-equiv='Refresh' content='1; URL=../login/login.html'>");
%>
