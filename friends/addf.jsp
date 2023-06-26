<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title></title>
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
    String uname=(String)session.getAttribute("name");
    String fname=request.getParameter("fname");

    if(fname==uname){
      out.println("<script>alert('본인을 친구추가할 수 없습니다!');</script>");
      out.println("<script>history.back();</script>");
      if(true)return;
    }

    pstmt=con.prepareStatement("select * from users where u_name=?");
    pstmt.setString(1, fname);
    rs=pstmt.executeQuery();
    if(rs.next()){

    }else{
      out.println("<script>alert('존재하지 않는 닉네임 입니다! 다시 입력해주세요.');</script>");
      out.println("<script>history.back();</script>");
      if(true)return;
    }

    pstmt=con.prepareStatement("select * from f_add where (u1=? and u2=?) or (u1=? and u2=?)");
    pstmt.setString(1,uname);
    pstmt.setString(2,fname);
    pstmt.setString(3,fname);
    pstmt.setString(4,uname);
    rs=pstmt.executeQuery();

    if(rs.next()){
      int status=-9;
      status=rs.getInt("fstatus");

      if(status==0){
        out.println("<script>alert('이미 친구 요청을 보낸 사용자입니다.');</script>");
        out.println("<script>history.back();</script>");
        if(true)return;
      }
      else if(status==1){
        out.println("<script>alert('이미 친구 추가한 사용자입니다.');</script>");
        out.println("<script>history.back();</script>");
        if(true)return;
      }else if(status==-1){
        int fid=0;
        fid=rs.getInt("fid");
        pstmt=con.prepareStatement("update f_add set fstatus=0, u1=?,u2=? where fid="+fid);
        pstmt.setString(1,uname);
        pstmt.setString(2,fname);
        int rowCount=pstmt.executeUpdate();
        if(rowCount==1){
          out.println("<script>alert('친구 요청을 보냈습니다.');</script>");
          out.println("<script>location.href='./friends.jsp'</script>");
        }else{
          out.println("<script>alert('친구 요청에 실패했습니다.');</script>");
          out.println("<script>location.href='./friends.jsp'</script>");
        }
      }

    }else{
      pstmt=con.prepareStatement("insert into f_add (u1,u2) values (?,?)");
      pstmt.setString(1,uname);
      pstmt.setString(2,fname);
      int rowCount=pstmt.executeUpdate();
      if(rowCount==1){
        out.println("<script>alert('친구 요청을 보냈습니다.');</script>");
        out.println("<script>location.href='./friends.jsp'</script>");
      }else{
        out.println("<script>alert('친구 요청에 실패했습니다.');</script>");
        out.println("<script>location.href='./friends.jsp'</script>");
      }
    }
    %>

  </body>
</html>
