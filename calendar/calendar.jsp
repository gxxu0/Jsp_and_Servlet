<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");

	Calendar cal = Calendar.getInstance();
	
	// 시스템 오늘날짜
	int ty = cal.get(Calendar.YEAR);
	int tm = cal.get(Calendar.MONTH)+1;
	int td = cal.get(Calendar.DATE);
	
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH)+1;
	
	// 파라미터 받기
	String sy = request.getParameter("year");
	String sm = request.getParameter("month");
	
	if(sy!=null) { // 넘어온 파라미터가 있으면
		year = Integer.parseInt(sy);
	}
	if(sm!=null) {
		month = Integer.parseInt(sm);
	}
	
	cal.set(year, month-1, 1);
	year = cal.get(Calendar.YEAR);
	month = cal.get(Calendar.MONTH)+1;
	
	int week = cal.get(Calendar.DAY_OF_WEEK); // 1(일)~7(토)
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>calendar</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="../calendar/calendar.css">

<script type="text/javascript">
function change() {
	var f = document.frm;
	//f.action="calendar2.jsp";
	f.submit();
}
</script>
</head>
<body>
    <header>
        <div class="header">
            <div>
                <a href="../main/main.jsp">
                    <h1>Your Schedule</h1>
                </a> 
            </div>
        </div>
    </header>

    <div class="calendar">
        <div class="title">
            <form name="frm" method="post">
                <select name="year" class="selectField" onchange="change()">
                    <% for(int i=year-5; i<=year+5; i++){ %>
                        <option value="<%=i%>" <%=year==i?"selected='selected'":"" %>><%=i%>년</option>
                    <%} %>
                </select>
                <select name="month" class="selectField" onchange="change()">
                    <% for(int i=1; i<=12; i++){ %>
                        <option value="<%=i%>" <%=month==i?"selected='selected'":"" %>><%=i%>월</option>
                    <%} %>
                </select>
            </form>
        </div>
        
        <table>
            <thead>
                <tr>
                    <td>일</td>
                    <td>월</td>
                    <td>화</td>
                    <td>수</td>
                    <td>목</td>
                    <td>금</td>
                    <td>토</td>
                </tr>
            </thead>
            <tbody>
    <%
                // 1일 앞 달
                Calendar preCal = (Calendar)cal.clone();
                preCal.add(Calendar.DATE, -(week-1));
                int preDate = preCal.get(Calendar.DATE);
                
                out.print("<tr>");
                // 1일 앞 부분
                for(int i=1; i<week; i++) {
                    //out.print("<td>&nbsp;</td>");
                    out.print("<td class='gray'>"+(preDate++)+"</td>");
                }
                
                // 1일부터 말일까지 출력
                int lastDay = cal.getActualMaximum(Calendar.DATE);
                String cls;
                for(int i=1; i<=lastDay; i++) {
                    cls = year==ty && month==tm && i==td ? "today":"";
                    
                    out.print("<td class='"+cls+"'>"+i+"</td>");
                    if(lastDay != i && (++week)%7 == 1) {
                        out.print("</tr><tr>");
                    }
                }
                
                // 마지막 주 마지막 일자 다음 처리
                int n = 1;
                for(int i = (week-1)%7; i<6; i++) {
                    // out.print("<td>&nbsp;</td>");
                    out.print("<td class='gray'>"+(n++)+"</td>");
                }
                out.print("</tr>");
    %>		
            </tbody>
        </table>
        

    </div>
    
<footer> 
    <div>
        <img src="../img/yourschedule_logo.png">
        <p style="font-size: 15px; font-weight: 500;">Your Schedule</p>
        <p style="font-size: 12px; font-weight: 400;">phone : +82)1-234-5678&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;팩스번호 : +82)1-234-5678</p>
        <p style="font-size: 15px; font-weight: 500;">Copyright © Your Schedule All right reserved</p>
    </div>
</footer>

</body>
</html>