<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
 
<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
 
<head>
<meta http-equiv="Content-Type" content="text/html; c harset=UTF-8">
<title>JSP BBS</title>
</head>
<body>
    <%
    String userID = null;
	if (session.getAttribute("userID") != null){
        userID = (String) session.getAttribute("userID");
	}
	if (userID != null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 로그인되었습니다.')");
        script.println("location.href = 'main.jsp'");    // 메인 페이지로 이동
        script.println("</script>");
	}
    if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null 
        || user.getUserGender() == null || user.getUserEmail() == null) {
        // 모든 문항을 입력하지 않은 경우 경고 메시지 출력 후 이전 페이지로 이동
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('모든 문항을 입력해주세요.')");
        script.println("history.back()");
        script.println("</script>");
    } else {
        UserDAO userDAO = new UserDAO();
        int result = userDAO.join(user);
        if (result == -1) {
            // 회원가입 실패 시 경고 메시지 출력 후 이전 페이지로 이동
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 존재하는 아이디입니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            // 회원가입 성공 시 메인 페이지로 이동
            session.setAttribute("userID", user.getUserID());
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href = 'main.jsp'");
            script.println("</script>");
        }
    }
%>
</body>
</html>