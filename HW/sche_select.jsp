<%@ include file="db_open.jsp" %>
<%@ include file="session_check.jsp" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import="org.json.simple.*"%>
<%@ page import="java.util.ArrayList"%>
<%
    String search = request.getParameter("search");
    System.out.println(search);
    PreparedStatement pstmt;
    String qry;
    JSONArray arr = new JSONArray();
    if (search == null || search ==""){
        qry= "select code, name, start, end, dow from schedule where user_id= ? order by code";
        pstmt = con.prepareStatement(qry);
        pstmt.setString(1, user_id);
        ResultSet rs= pstmt.executeQuery();
        while(rs.next()){
            JSONObject o = new JSONObject();
            o.put("code", rs.getString(1));
            o.put("name", rs.getString(2));
            o.put("start", rs.getString(3));
            o.put("end", rs.getString(4));
            o.put("dow", rs.getString(5));
            arr.add(o);
        }
    } else{
        qry= "select code, name, start, end, dow from schedule where user_id= ? and name like ? order by code";
        pstmt = con.prepareStatement(qry);
        pstmt.setString(1, user_id);
        pstmt.setString(2, search + "%");
        ResultSet rs= pstmt.executeQuery();
        while(rs.next()){
            JSONObject o = new JSONObject();
            o.put("code", rs.getString(1));
            o.put("name", rs.getString(2));
            o.put("start", rs.getString(3));
            o.put("end", rs.getString(4));
            o.put("dow", rs.getString(5));
            arr.add(o);
        }
    }
    out.print(arr);
%>
<%@ include file="db_close.jsp" %>