<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    String adminUser = (session != null) ? (String) session.getAttribute("adminUser") : null;
    if (adminUser == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <style>
    body {
      margin: 0;
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #141E30, #243B55);
      color: #fff;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    header {
      background: rgba(0, 0, 0, 0.4);
      padding: 20px 40px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 2px 10px rgba(0,0,0,0.5);
    }

    header h1 {
      font-size: 24px;
      margin: 0;
      color: #00c6ff;
    }

    .welcome {
      font-size: 18px;
      font-weight: 400;
    }

    nav {
      display: flex;
      gap: 15px;
    }

    nav a {
      text-decoration: none;
      color: #fff;
      background: #00c6ff;
      padding: 10px 20px;
      border-radius: 25px;
      font-weight: 500;
      transition: 0.3s ease;
    }

    nav a:hover {
      background: #0072ff;
      transform: scale(1.05);
    }

    main {
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: center;
      text-align: center;
      padding: 40px;
    }

    .dashboard-card {
      background: rgba(255, 255, 255, 0.05);
      padding: 40px;
      border-radius: 20px;
      box-shadow: 0 8px 20px rgba(0,0,0,0.3);
      max-width: 500px;
      width: 100%;
      animation: fadeIn 1s ease-in-out;
    }

    .dashboard-card h2 {
      margin-bottom: 15px;
      color: #00c6ff;
    }

    .dashboard-card p {
      margin-bottom: 25px;
      font-size: 16px;
    }

    @keyframes fadeIn {
      from {opacity: 0; transform: translateY(20px);}
      to {opacity: 1; transform: translateY(0);}
    }
  </style>
</head>
<body>
  <header>
    <h1>Admin Dashboard</h1>
    <span class="welcome">Welcome, <%= adminUser %> 👋</span>
    <nav>
      <a href="viewpending.jsp">Get Request</a>
      <a href="clients.jsp">Users</a>
      <a href="filetokens.jsp">Data</a>
      <a href="Admin.jsp">Logout</a>
    </nav>
  </header>

  <main>
    <div class="dashboard-card">
      <h2>Hello, <%= adminUser %>!</h2>
      <p>You are logged in as <strong>Admin</strong>.</p>
      <p>Use the navigation above to manage requests or log out securely.</p>
    </div>
  </main>
</body>
</html>
