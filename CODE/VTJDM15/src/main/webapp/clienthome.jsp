<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
    String client = (String) session.getAttribute("clientUser");
    if (client == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Client Dashboard</title>
<style>
    body {
        margin: 0;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #141e30, #243b55);
        color: #fff;
    }

    /* Sidebar */
    .sidebar {
        position: fixed;
        top: 0;
        left: 0;
        width: 220px;
        height: 100%;
        background: #1b1f2f;
        padding-top: 40px;
        box-shadow: 3px 0 8px rgba(0,0,0,0.4);
    }

    .sidebar h2 {
        text-align: center;
        margin-bottom: 30px;
        font-size: 22px;
        letter-spacing: 1px;
        color: #00c6ff;
    }

    .sidebar a {
        display: block;
        padding: 14px 20px;
        margin: 10px 15px;
        text-decoration: none;
        color: #ddd;
        border-radius: 8px;
        transition: all 0.3s ease;
    }

    .sidebar a:hover {
        background: #00c6ff;
        color: #fff;
        box-shadow: 0 4px 15px rgba(0,198,255,0.3);
        transform: translateX(5px);
    }

    /* Main content */
    .main-content {
        margin-left: 220px;
        padding: 30px;
    }

    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
    }

    .header h1 {
        font-size: 26px;
        font-weight: bold;
    }

    .card {
        background: #1e2a38;
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        margin-bottom: 20px;
        transition: transform 0.2s ease;
    }

    .card:hover {
        transform: translateY(-5px);
    }

    .btn-logout {
        background: #ff4757;
        padding: 10px 18px;
        border-radius: 6px;
        color: #fff;
        text-decoration: none;
        transition: 0.3s;
    }

    .btn-logout:hover {
        background: #e84118;
    }
</style>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <h2>Client Panel</h2>
        <a href="index.jsp"> Upload</a>
        <a href="plc.jsp"> PLC</a>
        <a href="chart.jsp">Analytics</a>
        <a href="client.jsp"> Logout</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="header">
            <h1>Welcome, <%= client %> </h1>
            <a href="client.jsp" class="btn-logout">Logout</a>
        </div>

        <div class="card">
            <h2> File Upload</h2>
            <p>Upload your files securely and manage them from here.</p>
        </div>

        <div class="card">
            <h2> PLC Control</h2>
            <p>Manage your PLC configurations and monitor data easily.</p>
        </div>

        <div class="card">
            <h2> Analytics</h2>
            <p>Get real-time insights on your uploaded files and PLC data.</p>
        </div>
    </div>

</body>
</html>
