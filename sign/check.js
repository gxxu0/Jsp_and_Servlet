function formcheck()
{
        if(document.sign.uname.value==""){
            alert("닉네임을 입력해주세요")
            document.sign.name.select();
            return false;
        }
        else if(document.sign.uid.value==""){
            alert("아이디를 입력해주세요")
            document.sign.uid.select();
            return false;
        }
        else if(document.sign.upw.value==""){
            alert("비밀번호를 입력해주세요")
            document.sign.upw.select();
            return false;
        }

        return true;
}