<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.text.SimpleDateFormat"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>할 일 등록</title>
</head>
<body>





<%
    Connection con = null;
    PreparedStatement pstmt = null;
	Statement stmt = null;
    StringBuffer SQL = new StringBuffer("insert into todo (u_id, date1, rpeat, title, content) "); 
    SQL.append("values (?, ?, ?, ?, ?)");

    


	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql26";
    
    Class.forName(driverName);
    con = DriverManager.getConnection(dbURL, "root", "kbc0924");

    pstmt = con.prepareStatement(SQL.toString());

    String id=(String)session.getAttribute("id");
    if(id==null||id==""||id=="null"){
        out.println("<script>alert('로그인 후 이용가능합니다.');</script>");
        out.println("<script>location.href='../login/login.html'</script>");
        if( true ) return;
    }
    
    String date1  = request.getParameter("date1");
    if(date1==null||date1==""||date1=="null"){
        pstmt.setString(2,null);
    }else{
        java.sql.Date sqd = java.sql.Date.valueOf(date1);
        pstmt.setDate(2,sqd);
    }
    
    
    String[] rpeat = request.getParameterValues("period");
    String sumday="";
    if(rpeat==null){

    }else{
        for(int i=0; i< rpeat.length; i++){
            if(rpeat[i]==null){
            }else{
                sumday+=rpeat[i]+" ";
            }
        }
    }
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    

    pstmt.setString(1, id);
    
    pstmt.setString(3,sumday);
    pstmt.setString(4,title);
    pstmt.setString(5,content);
    int rowcount = pstmt.executeUpdate();

    

    
   

    try {

       
        

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
    out.println("<script>location.href='../todo/todo.jsp'</script>");
%>



</body>
</html>