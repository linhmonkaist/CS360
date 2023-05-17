<%@ include file="db_open.jsp" %>
<%@ include file="session_check.jsp" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import="org.json.simple.*"%>
<%@ page import="java.util.ArrayList"%>
<%
    String code = request.getParameter("code");
    System.out.println("code: " + code);
    JSONArray return_arr = new JSONArray();
    JSONObject x = new JSONObject();
    x.put("code", code);
    return_arr.add(x);
    String qry= "delete from schedule where code= ?";
    PreparedStatement pstmt;
    pstmt = con.prepareStatement(qry);
    pstmt.setString(1, code);
    pstmt.executeUpdate();
    System.out.println("sned back");
    out.print(return_arr);
%>
<%@ include file="footer.jsp" %>