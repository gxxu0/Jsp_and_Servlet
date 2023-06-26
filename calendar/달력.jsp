<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./달력.css">
    <script>
        console.log(new Date());

        var date = new Date();
        var utc = date.getTime() + (date.getTimezoneoffset() * 60 * 1000);
        var kstGap = 9 * 60 * 60 * 1000;
        var today = new Date(utc + kstGap);

        var startDay = new Date(currentYear, currentMonth, 0);
        var prevDate = startDay.getDate();
        var prevDay = startDay.getDay();

        var endDay = new Dat(currentYear, currentMonth + 1, 0);
        var nextDate = endDay.getDate();
        var nextDay = endDay.getDay();

        calendar = document.querySelector('.dates')
        calendar.innerHTML = '';

        for(var i = prevDate + 1; i <= prevDate; i++) {
            calendar.innerHTML = calendar.innerHTML + '<div class="day prev disavle">' + i + '</div>'
        }

        for(var i = 1; i <= nextDate; i++) {
            calendar.innerHTML = calendar.innerHTML + '<div class="day current">' + i + '</div>'
        }

        for(var i = 1; i <= (7 - nextDate == 7 ? 0 : 7 - nextDay); i++) {
            calendar.innerHTML = calendar.innerHTML + '<div class="day next disable">' + i + '</div>'
        }

        currentYear = thisMonth.getFullYear();
        currentMonth = thisMonth.getMonth();
        currentDate = thisMonth.getDate();

        $('.year-month').text(currentYear + '.' + (currentMonth + 1));

        if(today.getMonth() == currentMonth) {
            todayDate = today.getDate();
            var currentMonthDate = document.qurySelectorAll('.dates .current');
            currentMonthDate[todayDate -1].classList.add('today');
        }

        $('.go-prev').on('click', function() {
            thisMonth = new Date(currentYear, currentMonth - 1, 1);
            fenderCalender(thisMonth);
        });

        $('.go-next').on('click', function() {
            thisMonth = new Date(currentYear, currentMonth + 1, 1);
            renderCalender(thisMonth);
        });
    </script>
</head>
<body>
    <header>
        <h1>달력</h1>
    </header>
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