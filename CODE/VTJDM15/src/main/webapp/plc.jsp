<%@page import="com.dao.DBUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String selectedValue = request.getParameter("data_value");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Data Value Records</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f0f4f8, #dbeafe);
            margin: 0;
            padding: 0;
            display: flex;
        }

        /* Sidebar */
        .sidebar {
            width: 230px;
            background: #1e293b;
            color: #fff;
            padding: 25px 15px;
            min-height: 100vh;
            position: fixed;
            top: 0; left: 0;
            display: flex;
            flex-direction: column;
            box-shadow: 4px 0 15px rgba(0,0,0,0.2);
        }
        .sidebar h2 {
            font-size: 22px;
            text-align: center;
            margin-bottom: 30px;
            color: #38bdf8;
        }
        .sidebar a {
            text-decoration: none;
            color: #cbd5e1;
            padding: 12px 16px;
            border-radius: 8px;
            margin: 6px 0;
            font-weight: 500;
            transition: 0.3s;
        }
        .sidebar a:hover {
            background: #38bdf8;
            color: #0f172a;
            font-weight: 600;
        }

        /* Main container */
        .container {
            flex: 1;
            margin-left: 250px;
            padding: 40px;
        }
        .content-box {
            background: #fff;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            animation: fadeIn 0.8s ease-in-out;
        }
        h2 {
            text-align: center;
            font-weight: 600;
            margin-bottom: 25px;
            color: #1e293b;
        }

        /* Form */
        form {
            text-align: center;
            margin-bottom: 30px;
        }
        select, button {
            padding: 12px 16px;
            font-size: 15px;
            border-radius: 10px;
            border: 1px solid #ccc;
            margin: 0 5px;
            transition: 0.3s;
        }
        select:focus {
            border-color: #38bdf8;
            outline: none;
            box-shadow: 0 0 6px #38bdf8;
        }
        button {
            background: linear-gradient(135deg, #38bdf8, #3b82f6);
            color: #fff;
            border: none;
            cursor: pointer;
            font-weight: 600;
        }
        button:hover {
            transform: scale(1.05);
            background: linear-gradient(135deg, #2563eb, #38bdf8);
            box-shadow: 0 6px 15px rgba(56,189,248,0.4);
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }
        table th, table td {
            padding: 14px;
            text-align: center;
            font-size: 14px;
        }
        table th {
            background: #3b82f6;
            color: #fff;
            font-weight: 600;
        }
        table tr:nth-child(even) {
            background: #f9fafb;
        }
        table tr:hover {
            background: #e0f2fe;
            transition: 0.3s;
        }

        .no-data {
            text-align: center;
            font-size: 16px;
            color: #666;
            margin-top: 20px;
            font-style: italic;
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
  <h2>Client Panel</h2>
  <a href="index.jsp">📂 Upload</a>
  <a href="plc.jsp">📊 PLC</a>
   <a href="chart.jsp">Analytics</a>
  <a href="client.jsp">🚪 Logout</a>
</div>

<!-- Main content -->
<div class="container">
  <div class="content-box">
    <h2>🔍 View Records by Data Value</h2>

    <form method="get" action="plc.jsp">
        <select name="data_value" required>
            <option value="">-- Select Data Value --</option>
            <option value="Temperature" <%= "Temperature".equals(selectedValue) ? "selected" : "" %>>🌡 Temperature</option>
            <option value="Humidity" <%= "Humidity".equals(selectedValue) ? "selected" : "" %>>💧 Humidity</option>
            <option value="Pressure" <%= "Pressure".equals(selectedValue) ? "selected" : "" %>>⚡ Pressure</option>
            <option value="Light" <%= "Light".equals(selectedValue) ? "selected" : "" %>>🍃 Light</option>
        </select>
        <button type="submit">Fetch Records</button>
    </form>

    <%
        if (selectedValue != null && !selectedValue.isEmpty()) {
            try {
                conn=DBUtil.getConnection();
                String sql = "SELECT * FROM file_tokens WHERE data_value=?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, selectedValue);
                rs = ps.executeQuery();

                boolean hasData = false;
    %>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Batch ID</th>
                        <th>Token Index</th>
                        <th>Original Value</th>
                        <th>Encrypted Value</th>
                        <th>Created At</th>
                        <th>Data Value</th>
                        <th>Unique Key</th>
                    </tr>
    <%
                while (rs.next()) {
                    hasData = true;
    %>
                    <tr>
                        <td><%= rs.getLong("id") %></td>
                        <td><%= rs.getString("batch_id") %></td>
                        <td><%= rs.getInt("token_index") %></td>
                        <td><%= rs.getString("original_value") %></td>
                        <td><%= rs.getString("encrypted_value") %></td>
                        <td><%= rs.getTimestamp("created_at") %></td>
                        <td><%= rs.getString("data_value") %></td>
                        <td><%= rs.getString("unique_key") %></td>
                    </tr>
    <%
                }
    %>
                </table>
    <%
                if (!hasData) {
    %>
                <p class="no-data">No records found for <strong><%= selectedValue %></strong>.</p>
    <%
                }
            } catch (Exception e) {
                out.println("<p style='color:red; text-align:center;'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            }
        }
    %>
  </div>
</div>

</body>
</html>
