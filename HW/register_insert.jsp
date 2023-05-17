<%@ include file="header.jsp" %>
<%
    String user_id = request.getParameter("id");
    String user_password = request.getParameter("password");

    String qry= "select * from user where user_id= ?";
    PreparedStatement pstmt;
    pstmt = con.prepareStatement(qry);
    pstmt.setString(1, user_id);
    ResultSet rs= pstmt.executeQuery();
    int c= 0; 
    while(rs.next()){
        c= c + 1;
    }
    System.out.println(c); 
    
    rs.close(); 
    pstmt.close(); 
 
    if (c == 1)
        response.sendRedirect("/register.jsp");
    else
    {
        qry= "insert into user values(?, SHA1(?))";
        pstmt = con.prepareStatement(qry);
        pstmt.setString(1, user_id);
        pstmt.setString(2, user_password);
        pstmt.executeUpdate();
        response.sendRedirect("/login.jsp");
    }
    qry= "select * from user";
    pstmt = con.prepareStatement(qry);
    rs= pstmt.executeQuery();
    String pw, us; 
    while(rs.next()){
        us= rs.getString(1);
        pw= rs.getString(2);
        System.out.println( us + " pw: " + pw); 
    }
%>
<%@ include file="footer.jsp" %>

