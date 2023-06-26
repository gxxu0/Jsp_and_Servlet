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
<title>할 일 수정</title>
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

    pstmt = con.prepareStatement("UPDATE todo SET rpeat=?, date1=?, title=?, content=? WHERE todo_id=?");

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

    

    
    pstmt.setString(1,sumday);
    pstmt.setString(3,title);
    pstmt.setString(4,content);
    String todo_id = (String)session.getAttribute("todo_id");
    pstmt.setString(5,todo_id);
    int rowcount = pstmt.executeUpdate();

    

if (rowcount == 1){ 
            
    out.println("<script>alert('할 일 수정에 성공했습니다.');</script>"); 
    session.removeAttribute("ttd_id");
    out.println("<script>location.href='./todo.jsp'</script>");
    
}
else out.println("할 일 수정에 문제가 있습니다.");
%>
    
</body>
</html>