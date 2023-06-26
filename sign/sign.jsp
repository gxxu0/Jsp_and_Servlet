<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입 페이지</title>
</head>
<body>

<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>



<%
    Connection con = null;
    PreparedStatement pstmt = null;
	Statement stmt = null;
    StringBuffer SQL = new StringBuffer("insert into users (u_id, u_pw, u_name) "); 
    SQL.append("values (?, ?, ?)");

	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql26";

    try {
		String encoding    = "UTF-8";
		int sizeLimit = 10 * 1024 * 1024; 
		//ServletContext context = getServletContext();
        //MultipartRequest multi = new MultipartRequest(request, sizeLimit, encoding);
        String uid             = request.getParameter("uid");
        String upw             = request.getParameter("upw");
		String uname           = request.getParameter("uname");
		Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");

        pstmt = con.prepareStatement(SQL.toString());
        
        //삽입할 학생 레코드 데이터 입력
        pstmt.setString(1, uid);
        pstmt.setString(2, upw);
        pstmt.setString(3, uname);

        int rowCount = pstmt.executeUpdate();        
        if (rowCount == 1){ 
            
            out.println("<script>alert('회원가입에 성공했습니다.');</script>"); 
            out.println("<script>location.href='../login/login.html'</script>");
            
        }
        else out.println("회원가입에 문제가 있습니다.");
        
        //다시 학생 조회
        stmt = con.createStatement();

    }
    catch(Exception e) {
    	out.println("MySql 데이터베이스 univdb의 users 조회에 문제가 있습니다. <hr>");
        out.println(e.toString());
        e.printStackTrace();
    }
    finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
    // out.println("<meta http-equiv='Refresh' content='1; URL=../login/login.html'>");
%>



</body>
</html>