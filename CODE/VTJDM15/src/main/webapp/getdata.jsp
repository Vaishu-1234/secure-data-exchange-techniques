<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.dao.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>User Data Dashboard</title>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	rel="stylesheet" />
<style>
body {
	font-family: 'Poppins', sans-serif;
	background: linear-gradient(135deg, #0f172a, #1e293b);
	color: #e2e8f0;
	margin: 0;
	padding: 0;
}

.navbar {
	display: flex;
	justify-content: flex-end;
	gap: 20px;
	padding: 15px 40px;
	background: #1e293b;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.4);
	position: sticky;
	top: 0;
	z-index: 1000;
}

.navbar a {
	color: #e2e8f0;
	text-decoration: none;
	font-weight: 500;
	transition: 0.3s;
}

.navbar a:hover {
	color: #38bdf8;
}

.container {
	padding: 40px;
}

h1 {
	text-align: center;
	font-size: 2rem;
	margin-bottom: 30px;
	color: #38bdf8;
	text-shadow: 0 2px 8px rgba(56, 189, 248, 0.4);
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
	border-radius: 12px;
	overflow: hidden;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
}

thead {
	background: #0ea5e9;
	color: #fff;
}

thead th {
	padding: 14px;
	text-align: left;
	font-size: 15px;
}

tbody tr {
	background: #1e293b;
	transition: 0.3s ease-in-out;
}

tbody tr:nth-child(even) {
	background: #273449;
}

tbody tr:hover {
	background: #334155;
	transform: scale(1.01);
}

td {
	padding: 14px;
	font-size: 14px;
}

.action-btn {
	padding: 6px 12px;
	background: #0ea5e9;
	color: white;
	border-radius: 6px;
	text-decoration: none;
	font-size: 13px;
	transition: background 0.3s;
}

.action-btn:hover {
	background: #0284c7;
}

.no-data {
	text-align: center;
	font-size: 1.2rem;
	color: #f87171;
	margin-top: 20px;
}
</style>
</head>
<body>

	<div class="navbar">
		<a href="getdata.jsp"><i class="fa-solid fa-chart-line"></i> View
			Values</a> <a href="viekey.jsp"><i class="fa-solid fa-key"></i> View
			Key</a> <a href="LogoutServlet"><i class="fa-solid fa-sign-out-alt"></i>
			Logout</a>
	</div>

	<div class="container">
		<h1>Encrypted Data Records</h1>
		<table>
			<thead>
				<tr>
					<th>Batch Id</th>
					<th>Token Index</th>
					<th>Encrypted Value</th>
					<th>Time Stamp</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<%
				String userEmail = (String) session.getAttribute("userEmail");
				/* String sql="select data_value from users where email='"+userEmail+"' "; */
				String sql = "select data_value from users where email=?";
				

				Connection con = DBUtil.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, userEmail);
				ResultSet rs = ps.executeQuery();

				boolean found = false;
				while (rs.next()) {
					String data_value = rs.getString(1);
					sql = "select * from file_tokens where data_value='" + data_value + "'";
					ps = con.prepareStatement(sql);
					ResultSet rs1 = ps.executeQuery();

					if (rs1.next()) {
						found = true;
				%>
				<tr>
					<td><%=rs1.getString(2)%></td>
					<td><%=rs1.getInt(3)%></td>
					<td><%=rs1.getString(5)%></td>
					<td><%=rs1.getString(6)%></td>
					<td><a class="action-btn"
						href="getValue.jsp?BatchId=<%=rs1.getString(2)%>&&Token_Index=<%=rs1.getInt(3)%>&&EncryptedValue=<%=rs1.getString(5)%>&&TimeStamp=<%=rs1.getString(6)%>">
							<i class="fa-solid fa-eye"></i> Get Value
					</a></td>
				</tr>
				<%
				}
				}
				if (!found) {
				%>
				<tr>
					<td colspan="5" class="no-data">No Data Found</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>

</body>
</html>
