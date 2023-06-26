<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8"%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./schedule_select.css">
    <script>
        window.onload = function() {
     
        function onClick1() {
            document.querySelector('.modal_wrap').style.display ='block';
            document.querySelector('.black_bg').style.display ='block';
        }   
        function offClick1() {
            document.querySelector('.modal_wrap').style.display ='none';
            document.querySelector('.black_bg').style.display ='none';
        }
    
        document.getElementById('modal_btn1').addEventListener('click', onClick1);
        document.querySelector('.modal_close').addEventListener('click', offClick1);

 
 };
    </script>
</head>
<body>
    <div class="black_bg"></div>
    <div class="modal_wrap" style="border-radius: 15px;">
        <div class="modal_close">
            <a href="../main/main.jsp"><img src="../img/close.png" alt="remove"></a>
        </div>   
        <p style="font-size: 17px;">사용자가 보고자하는 년도와 학기</p>
        <form id="form_add" action="select.jsp" accept-charset="utf-8" name="add_modal_time" method="post">
            <div id="select">
                <select name="year" id="time">
                    <script>
                        var date = new Date();
                        var year = date.getFullYear();
                        var i = year-5;

                        for(i;year>=i;i++){
                            document.write("<option value="+i+">"+i+"</option>");
                        }
                    </script>
                </select>
                <label for="year">년도&nbsp;</label>
                <select name="sem" id="continuity">
                    <option value=1>1</option>
                    <option value=2>2</option>
                </select>
                <label for="semester">&nbsp;학기</label><br>
            </div>
            <div>
                <button id="button_input" style="width: 100%; height: 35px;">선택</button>
            </div>
        </form>
    </div>
</body>
</html>