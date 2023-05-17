<%@ include file="header.jsp" %>
<%
    String user_id = request.getParameter("id");
    String userPassword = request.getParameter("password");

    String qr= "select * from user where user_id= ? and user_password= SHA1(?)";
    PreparedStatement pstmt;
    pstmt = con.prepareStatement(qr);
    pstmt.setString(1, user_id);
    pstmt.setString(2, userPassword);
    ResultSet rs= pstmt.executeQuery();
    int c= 0; 
    while(rs.next()){
        c= c + 1;
    }
    if (c == 1){
        System.out.println("login sucess"); 
        session.setAttribute("id", user_id);
        response.sendRedirect("/index.jsp");
    } else {
        System.out.println("login fail"); 
        response.sendRedirect("/login.jsp");
    }
%>
<%@ include file="footer.jsp" %>