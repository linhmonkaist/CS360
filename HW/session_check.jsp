<%
    String user_id= (String) session.getAttribute("id");
    
    if(user_id == null){
        System.out.println("null id");
        response.sendRedirect("/login.jsp");
    }
%>