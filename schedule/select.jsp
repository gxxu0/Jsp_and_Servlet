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
<title>학기 선택</title>
</head>
<body>


<%
    Connection con = null;
    PreparedStatement pstmt = null;
	Statement stmt = null;
    ResultSet rs = null;

    StringBuffer checkt = new StringBuffer("SELECT * FROM timetable WHERE u_id=? AND year=? AND semester=?"); 

	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql26";

    if (session == null || session.getAttribute("id") == null || session.getAttribute("id").equals("")){
        out.println("<script>alert('로그인 후 이용가능합니다.');</script>");
        out.println("<script>location.href='../login/login.html'</script>");
    }

    String ID = (String)session.getAttribute("id");
   
    try {
		String encoding    = "UTF-8";
		int sizeLimit = 10 * 1024 * 1024; 
		//ServletContext context = getServletContext();
        //MultipartRequest multi = new MultipartRequest(request, sizeLimit, encoding);
        int year       =Integer.parseInt(request.getParameter("year"));
        int semester      =Integer.parseInt(request.getParameter("sem"));

		Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");

        pstmt = con.prepareStatement(checkt.toString());
        
        pstmt.setString(1, ID);
        pstmt.setInt(2, year);
        pstmt.setInt(3, semester);

        rs = pstmt.executeQuery();

        if(rs.next()){
            session.setAttribute("tt_id",rs.getInt("tt_id"));
            out.println("<script>location.href='./schedule.jsp'</script>");
        }
        else{
            pstmt = con.prepareStatement("insert into timetable (u_id, year, semester) values (?, ?, ?)");
            pstmt.setString(1,ID);
            pstmt.setInt(2,year);
            pstmt.setInt(3,semester);
            int rowCount = pstmt.executeUpdate();  
            if(rowCount!=1){
                out.println("<script>alert('오류가일어났습니다!');</script>");
            }else{
                pstmt = con.prepareStatement(checkt.toString());
        
                pstmt.setString(1, ID);
                pstmt.setInt(2, year);
                pstmt.setInt(3, semester);

                rs = pstmt.executeQuery();

                if(rs.next()){
                    session.setAttribute("tt_id",rs.getInt("tt_id"));
                    out.println("<script>location.href='./schedule.jsp'</script>");
                }
            }
            
        }



    }
    catch(Exception e) {
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