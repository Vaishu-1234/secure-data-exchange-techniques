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

String userEmail = (String) session.getAttribute("userEmail");
String batchid=request.getParameter("BatchId");
int Token_Index =Integer.parseInt(request.getParameter("Token_Index").trim());
String EncryptedValue=request.getParameter("EncryptedValue");
String time=request.getParameter("TimeStamp");



Connection con=DBUtil.getConnection();
String sql="insert into getvalue values(?,?,?,?,?,?)";
PreparedStatement ps=con.prepareStatement(sql);
ps.setString(1, batchid);
ps.setString(2, EncryptedValue);
ps.setInt(3, Token_Index);
ps.setString(4, time);
ps.setString(5, userEmail);
ps.setString(6, "pending");

int i=ps.executeUpdate();
if (i > 0) {
    out.println("<script type='text/javascript'>");
    out.println("alert('Request sent. Required key for access!');");
    out.println("window.location='getdata.jsp';");
    out.println("</script>");
} else {
    out.println("<script type='text/javascript'>");
    out.println("alert('Request sent. Required key for access!');");
    out.println("window.location='getdata.jsp';");
    out.println("</script>");
}

%>

</body>
</html>