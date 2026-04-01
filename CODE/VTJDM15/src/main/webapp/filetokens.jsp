<%-- <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.dao.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Pending Requests</title>
<style>
    body {
        font-family: 'Poppins', sans-serif;
        margin: 0;
        padding: 0;
        background: linear-gradient(135deg, #1d2b64, #f8cdda);
        min-height: 100vh;
        color: #fff;
    }

    header {
        background: rgba(0,0,0,0.6);
        padding: 15px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0px 2px 6px rgba(0,0,0,0.3);
    }

    header h1 {
        margin: 0;
        font-size: 22px;
        letter-spacing: 1px;
        color: #f1f1f1;
    }

    nav a {
        color: #fff;
        margin-left: 20px;
        text-decoration: none;
        font-weight: 500;
        transition: 0.3s;
    }

    nav a:hover {
        color: #ffda79;
        text-decoration: underline;
    }

    .container {
        padding: 40px;
    }

    h2 {
        text-align: center;
        margin-bottom: 25px;
        font-size: 26px;
        color: #fff;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        background: rgba(255,255,255,0.1);
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0px 6px 16px rgba(0,0,0,0.3);
    }

    thead {
        background: rgba(0,0,0,0.6);
    }

    thead th {
        padding: 15px;
        font-size: 14px;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    tbody td {
        padding: 12px;
        text-align: center;
        border-bottom: 1px solid rgba(255,255,255,0.1);
    }

    tbody tr:hover {
        background: rgba(255,255,255,0.2);
        transition: 0.3s;
    }

    .approve-btn {
        background: #28a745;
        color: #fff;
        padding: 8px 16px;
        border-radius: 6px;
        font-size: 14px;
        font-weight: bold;
        text-decoration: none;
        transition: 0.3s;
    }

    .approve-btn:hover {
        background: #218838;
        box-shadow: 0px 4px 12px rgba(0,0,0,0.4);
    }

    .no-data {
        text-align: center;
        padding: 20px;
        font-size: 18px;
        color: #ffdddd;
    }
</style>
</head>
<body>

<header>
    <h1> Admin Dashboard</h1>
    <nav>
        <a href="viewpending.jsp">Get Request</a>
        <a href="clients.jsp">Clients</a>
        <a href="filetokens.jsp">Data</a>
        <a href="Admin.jsp">Logout</a>
    </nav>
</header>

<div class="container">
    <h2> Pending Requests</h2>

    <table>
        <thead>
            <tr>
                <th>Batch Id</th>
                <th>Token Index</th>
                <th>Encrypted Value</th>
                <th>Time Stamp</th>
                <th>User Id</th>
               
            </tr>
        </thead>
        <tbody>
        <%
            Connection con=DBUtil.getConnection();
            String sql="select * from file_tokens ";
            PreparedStatement ps=con.prepareStatement(sql);
            ResultSet rs1=ps.executeQuery();
            
            boolean hasData = false;
            while(rs1.next()) {
                hasData = true;
        %>
            <tr>
                <td><%=rs1.getString(2) %></td>
                <td><%=rs1.getInt(3) %></td>
                <td><%=rs1.getString(5) %></td>
                <td><%=rs1.getString(6) %></td>
                
                
            </tr>
        <%
            }
            if(!hasData) {
        %>
            <tr><td colspan="6" class="no-data"> No pending requests found</td></tr>
        <% } %>
        </tbody>
    </table>
</div>

</body>
</html>
 --%>
 
 <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.dao.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Token Data</title>

<style>
body {
    font-family: Arial;
    background: linear-gradient(135deg,#1d2b64,#f8cdda);
    color: white;
}
.container { padding:40px; }

table {
    width:100%;
    border-collapse:collapse;
    background:rgba(255,255,255,0.1);
}

th,td {
    padding:12px;
    text-align:center;
    border-bottom:1px solid rgba(255,255,255,0.2);
}

th { background:rgba(0,0,0,0.6); }

td.encrypted {
    max-width:420px;
    word-break:break-all;
}
</style>
</head>

<body>

<div class="container">
<h2 align="center">Stored Token Data</h2>

<table>
<tr>
<th>Batch ID</th>
<th>Token Index</th>
<th>Encrypted Value</th>
<th>Timestamp</th>
<!-- <th>User ID</th> -->
</tr>

<%
Connection con = DBUtil.getConnection();

/* ✅ CORRECT QUERY (JOIN BOTH TABLES) */
String sql =
"SELECT f.batch_id, f.token_index, f.encrypted_value, f.created_at, g.userid " +
"FROM file_tokens f LEFT JOIN getvalue g " +
"ON f.batch_id = g.Batch_id AND f.token_index = g.Token_index " +
"ORDER BY f.batch_id, f.token_index";

PreparedStatement ps = con.prepareStatement(sql);
ResultSet rs = ps.executeQuery();

boolean data=false;

while(rs.next()){
data=true;
%>

<tr>
<td><%=rs.getString("batch_id")%></td>

<td><%=rs.getInt("token_index")%></td>

<td class="encrypted">
<%=rs.getString("encrypted_value")%>
</td>

<td>
<%=rs.getTimestamp("created_at")%>
</td>

<%-- <td>
<%=rs.getString("userid")==null?"N/A":rs.getString("userid")%>
</td> --%>
</tr>

<% } %>

<% if(!data){ %>
<tr><td colspan="5">No Data Found</td></tr>
<% } %>

</table>
</div>

</body>
</html>
