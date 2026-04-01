<%-- <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.dao.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%


String batchid=request.getParameter("BatchId");
int Token_Index =Integer.parseInt(request.getParameter("Token_Index").trim());
String EncryptedValue=request.getParameter("EncryptedValue");
String time=request.getParameter("TimeStamp");
String userid=request.getParameter("userId");
String sql="select unique_key from file_tokens where batch_id='"+batchid+"' and token_index='"+Token_Index+"' and encrypted_value='"+EncryptedValue+"'";
Connection con=DBUtil.getConnection();
PreparedStatement ps=con.prepareStatement(sql);
ResultSet rs=ps.executeQuery();
while(rs.next()){
	response.getWriter().write("Some thing not Went Wrong");
	String unique_key=rs.getString(1);
	
	
	sql="update getvalue set status='"+unique_key+"' where batch_id='"+batchid+"' and token_index='"+Token_Index+"' and Enc_value='"+EncryptedValue+"' and time_stamp='"+time+"' and userid='"+userid+"'";
	
	ps=con.prepareStatement(sql);
int i=	ps.executeUpdate();
	if(i>0){
		response.sendRedirect("viewpending.jsp");
	}else{
		response.getWriter().write("Some thing went Wrong");
	}
	%>
	
	
<% }

%>
</body>
</html> --%>


<%-- 
<%@page import="java.sql.*"%>
<%@page import="com.dao.DBUtil"%>

<%
String batchId = request.getParameter("BatchId");
String tokenIndex = request.getParameter("Token_Index");
String encValue = request.getParameter("EncValue");
String userId = request.getParameter("userId");

Connection con = null;
PreparedStatement ps = null;

try {

	String sql="select unique_key from file_tokens where batch_id='"+batchId+"' and token_index='"+tokenIndex+"' and encrypted_value='"+encValue+"'";
	 con=DBUtil.getConnection();
	 ps=con.prepareStatement(sql);
	ResultSet rs=ps.executeQuery();
	while(rs.next()){
		response.getWriter().write("Some thing not Went Wrong");
    	String unique_key=rs.getString(1);
	


    String sql1 =
        "UPDATE getvalue SET status='unique_key' " +
        "WHERE Batch_id=? AND Token_index=? AND userid=? " +
        "AND Enc_value=? AND status='pending'";

    ps = con.prepareStatement(sql1);

    ps.setString(1, batchId);
    ps.setInt(2, Integer.parseInt(tokenIndex));
    ps.setString(3, userId);
    ps.setString(4, encValue);

    int rows = ps.executeUpdate();

    if(rows > 0){
        response.sendRedirect("viewpending.jsp?msg=approved");
    } else {
        response.sendRedirect("viewpending.jsp?msg=notfound");
    }
    
	}
} catch(Exception e){
    e.printStackTrace();
    out.println("Error: " + e.getMessage());
}
finally{
    if(ps!=null) ps.close();
    if(con!=null) con.close();
}
%> --%>
<%@page import="java.sql.*"%>
<%@page import="com.dao.DBUtil"%>

<%
String batchId = request.getParameter("BatchId");
String tokenIndex = request.getParameter("Token_Index");
String userId = request.getParameter("userId");

Connection con = null;
PreparedStatement ps1 = null;
PreparedStatement ps2 = null;
ResultSet rs = null;

try {

    con = DBUtil.getConnection();

    /* STEP 1 : Get unique_key from file_tokens */
    String sql =
        "SELECT unique_key FROM file_tokens " +
        "WHERE batch_id=? AND token_index=?";

    ps1 = con.prepareStatement(sql);
    ps1.setString(1, batchId);
    ps1.setInt(2, Integer.parseInt(tokenIndex));

    rs = ps1.executeQuery();

    if(rs.next()) {

        String unique_key = rs.getString("unique_key");

        /* STEP 2 : Update getvalue table */
        String sql1 =
            "UPDATE getvalue SET status=? " +
            "WHERE Batch_id=? AND Token_index=? AND userid=? " +
            "AND status='pending'";

        ps2 = con.prepareStatement(sql1);

        ps2.setString(1, unique_key);   // ✅ actual value
        ps2.setString(2, batchId);
        ps2.setInt(3, Integer.parseInt(tokenIndex));
        ps2.setString(4, userId);

        int rows = ps2.executeUpdate();

        if(rows > 0){
            response.sendRedirect("viewpending.jsp?msg=approved");
        } else {
            response.sendRedirect("viewpending.jsp?msg=notfound");
        }

    } else {
        response.sendRedirect("viewpending.jsp?msg=nokey");
    }

} catch(Exception e){
    e.printStackTrace();
    out.println("Error: " + e.getMessage());
}
finally{
    if(rs!=null) rs.close();
    if(ps1!=null) ps1.close();
    if(ps2!=null) ps2.close();
    if(con!=null) con.close();
}
%>