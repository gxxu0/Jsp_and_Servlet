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
    StringBuffer SQL = new StringBuffer("insert into timetable_detail (tt_id, time, contin, day, tname, room) "); 
    SQL.append("values (?, ?, ?, ?, ?, ?)");

    


	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql26";
    
    Class.forName(driverName);
    con = DriverManager.getConnection(dbURL, "root", "kbc0924");


    int tt_id=(Integer)session.getAttribute("tt_id");
    int start       =Integer.parseInt(request.getParameter("time"));
    int contin      =Integer.parseInt(request.getParameter("continuity"));
    int day = Integer.parseInt(request.getParameter("day"));
    String name     =request.getParameter("tname");
    String room     =request.getParameter("room");

    if(room==null){room="";}




    pstmt = con.prepareStatement("select * from timetable_detail where tt_id = ?");
    pstmt.setInt(1, tt_id);
    ResultSet result = pstmt.executeQuery();


    int tt4[][] = new int[10][6];
    int c = 0;
    int r = 0;
    int cont = 0;

    for(int i=0; i< 10; i++){
        for(int j=0; j< 6; j++){
            tt4[i][j]=0;
        }
    }

    while (result.next()) {
        r = Integer.parseInt(result.getString("time"));
        c = Integer.parseInt(result.getString("day"));
        cont = Integer.parseInt(result.getString("contin"));
        if(cont>1){
            for(int k=r+1; k< r+cont; k++){
                tt4[k][c] = 9;
            }
        }
        
        tt4[r][c] = cont;
      }
      result.close(); 

    
   

    try {

        if(contin > 1 ){
            for(int i=start;i < start+contin; i++){
                if(tt4[i][day]!=0){
                    out.println("<script>alert('시간표가 겹칩니다!');</script>");
                    out.println("<script>history.back();</script>");  
                    if( true ) return ;
                }
            }
        }
        else{
            if(tt4[start][day]!=0){
                out.println("<script>alert('시간표가 겹칩니다!');</script>");
                out.println("<script>history.back();</script>");  
                if( true ) return ;
            }
        }
    
        pstmt = con.prepareStatement(SQL.toString());
        
        //삽입할 학생 레코드 데이터 입력
        pstmt.setInt(1, tt_id);
        pstmt.setInt(2, start);
        pstmt.setInt(3, contin);
        pstmt.setInt(4, day);
        pstmt.setString(5, name);
        pstmt.setString(6, room);

        int rowCount = pstmt.executeUpdate();        
        if (rowCount == 1){ 
            
            out.println("<script>alert('시간표 추가에 성공했습니다.');</script>"); 
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