<%@ include file="db_open.jsp" %>
<%@ include file="session_check.jsp" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import="org.json.simple.*"%>
<%@ page import="java.util.ArrayList"%>
<%  
    
    String start = request.getParameter("start");
    String end = request.getParameter("end");
    String name = request.getParameter("name");
    String dow = request.getParameter("dow");
    System.out.println(name); 
    String qry= "select start, end from schedule where user_id= ? and name= ? and dow= ?";
    PreparedStatement pstmt;
    pstmt = con.prepareStatement(qry);
    pstmt.setString(1, user_id);
    pstmt.setString(2, name);
    pstmt.setString(3, dow);
    int exist_start, exist_end, cur_start, cur_end; 
    ResultSet rs= pstmt.executeQuery();
    Boolean check= true; 
    cur_start= Integer.parseInt(start);
    cur_end= Integer.parseInt(end);  
    while(rs.next()){
        exist_start= Integer.parseInt(rs.getString(1)); 
        exist_end= Integer.parseInt(rs.getString(2)); 
        if (exist_start <= cur_start && cur_start <= exist_end){
            check= false; 
            break; 
        }
        if (exist_start <= cur_end && cur_end <= exist_end){
            check= false; 
            break; 
        }
    }
    JSONArray arr = new JSONArray();
    JSONObject obj = new JSONObject();
    if (check == false){
        obj.put("res", "f"); 
        System.out.println("insert fail"); 
        arr.add(obj);
    } else {
        obj.put("res", "t");
        arr.add(obj);
        qry= "insert into schedule(user_id, name, start, end, dow) values(?, ?, ?, ?, ?)";
        pstmt = con.prepareStatement(qry);
        pstmt.setString(1, user_id);
        pstmt.setString(2, name);
        pstmt.setString(3, start);
        pstmt.setString(4, end);
        pstmt.setString(5, dow); 
        pstmt.executeUpdate();
        qry= "select code from schedule where user_id= ? and name= ? and dow= ? and start= ? and end= ?";
        pstmt = con.prepareStatement(qry);
        pstmt.setString(1, user_id);
        pstmt.setString(2, name);
        pstmt.setString(3, dow);
        pstmt.setString(4, start);
        pstmt.setString(5, end);
        rs= pstmt.executeQuery();
        System.out.println("schedule inserted");
        JSONObject o = new JSONObject();
        while(rs.next()){
            String cd= rs.getString(1);  
            System.out.println(cd); 
            o.put("code", cd);
        }
        o.put("name", name);
        o.put("start", start);
        o.put("end", end);
        o.put("dow", dow);
        arr.add(o);
    }
    out.print(arr); 
%>
<%@ include file="db_close.jsp" %>