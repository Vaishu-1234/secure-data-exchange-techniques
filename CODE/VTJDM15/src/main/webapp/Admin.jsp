<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Admin | Sensor Data Portal</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />

  <!-- Google Font -->
  <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Poppins:wght@400;600&display=swap" rel="stylesheet">

  <!-- Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body, html { height: 100%; font-family: 'Poppins', sans-serif; color: #f0f4ff; }

    /* Background image with overlay */
    body {
      background: url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=1600&q=80') no-repeat center center fixed;
      background-size: cover;
      display: flex; flex-direction: column;
      position: relative;
    }
    body::after {
      content: ""; position: absolute; top: 0; left: 0; right: 0; bottom: 0;
      background: rgba(10, 14, 30, 0.8);
      backdrop-filter: blur(6px);
      z-index: -1;
    }

    /* Header */
    header {
      padding: 20px 40px;
      background: rgba(0,0,0,0.6);
      display: flex; justify-content: space-between; align-items: center;
      border-bottom: 1px solid rgba(255,255,255,0.1);
    }
    header .brand {
      font-family: 'Orbitron', sans-serif;
      font-size: 22px; font-weight: 700;
      color: #5ac8fa; display: flex; align-items: center; gap: 8px;
    }
    header nav ul { list-style: none; display: flex; gap: 20px; }
    header nav a {
      color: #ddd; text-decoration: none; font-weight: 500; transition: 0.3s;
    }
    header nav a:hover { color: #5ac8fa; }

    /* Main split layout */
    .main {
      flex: 1; display: flex; align-items: center; justify-content: space-between;
      padding: 60px 80px; gap: 40px;
    }
    .hero {
      flex: 1;
    }
    .hero h1 {
      font-family: 'Orbitron', sans-serif;
      font-size: 38px; line-height: 1.3; margin-bottom: 20px; color: #fff;
    }
    .hero p { color: #a8b3c7; font-size: 16px; max-width: 500px; }

    /* Glass Login Panel */
    .login-panel {
      width: 400px; padding: 30px;
      background: rgba(255,255,255,0.08);
      border-radius: 20px; border: 1px solid rgba(255,255,255,0.2);
      box-shadow: 0 0 30px rgba(90,200,250,0.2);
      animation: float 6s ease-in-out infinite;
    }
    @keyframes float {
      0%, 100% { transform: translateY(0); }
      50% { transform: translateY(-10px); }
    }
    .login-panel h2 {
      text-align: center; font-size: 24px; margin-bottom: 8px;
    }
    .login-panel .subtitle {
      text-align: center; color: #bbb; font-size: 14px; margin-bottom: 25px;
    }
    .field { margin-bottom: 18px; }
    .field label { display: block; font-size: 13px; margin-bottom: 6px; color: #a8b3c7; }
    .field input {
      width: 100%; padding: 12px 14px;
      border: none; border-radius: 10px;
      background: rgba(255,255,255,0.15);
      color: #fff; font-size: 14px;
      outline: none; transition: 0.3s;
    }
    .field input:focus {
      background: rgba(255,255,255,0.25);
      box-shadow: 0 0 6px #5ac8fa;
    }
    .actions {
      display: flex; justify-content: space-between; align-items: center; margin-top: 4px;
      font-size: 13px;
    }
    .actions label { color: #aaa; display: flex; align-items: center; gap: 6px; }
    .actions a { color: #5ac8fa; text-decoration: none; }
    .actions a:hover { text-decoration: underline; }

    .btn {
      width: 100%; padding: 12px; margin-top: 20px;
      border: none; border-radius: 12px;
      background: linear-gradient(135deg, #5ac8fa, #7b2cbf);
      color: #fff; font-weight: 600; cursor: pointer;
      transition: 0.3s;
    }
    .btn:hover { transform: scale(1.03); }

    .error {
      margin-top: 15px; padding: 10px;
      border-radius: 10px; background: rgba(255,50,50,0.2);
      color: #ffcccc; text-align: center;
    }

    /* Footer */
    footer {
      padding: 18px 40px; background: linear-gradient(to right, #0b132b, #1c2541);
      display: flex; justify-content: space-between; align-items: center;
      font-size: 13px; color: #aaa;
    }
    footer .social a {
      margin-left: 14px; color: #aaa; font-size: 16px; transition: 0.3s;
    }
    footer .social a:hover { color: #5ac8fa; }
  </style>
</head>
<body>
  <!-- Header -->
  <header>
    <div class="brand"><i class="fa-solid fa-microchip"></i> SensorData Admin</div>
    <nav>
      <ul>
       <!--  <li><a href="index.jsp">Home</a></li> -->
        <li><a href="ulogin.jsp">User</a></li>
        <li><a href="client.jsp">Client</a></li>
        <li><a href="admin_login.jsp">Admin</a></li>
      </ul>
    </nav>
  </header>

  <!-- Main -->
  <section class="main">
    <div class="hero">
      <h1>Welcome to Sensor Data <br> Admin Control Panel</h1>
      <p>Manage users, analyze IoT data, and secure your environment. This portal is designed for administrators to oversee all operations efficiently.</p>
    </div>

    <div class="login-panel">
      <h2><i class="fa-solid fa-user-shield"></i> Admin Login</h2>
      <p class="subtitle">Sign in to access the secure dashboard</p>

      <form action="AdminLogin" method="post" autocomplete="off">
        <div class="field">
          <label for="username">Username</label>
          <input id="username" name="username" type="text" placeholder="Enter admin username" required />
        </div>
        <div class="field">
          <label for="password">Password</label>
          <input id="password" name="password" type="password" placeholder="Enter password" required />
        </div>
        <div class="actions">
          <label><input type="checkbox" name="remember"> Remember me</label>
          <a href="#">Forgot password?</a>
        </div>
        <button type="submit" class="btn"><i class="fa-solid fa-right-to-bracket"></i> Sign In</button>

        <% String err = request.getParameter("error");
           if (err != null) { %>
          <div class="error"><i class="fa-solid fa-triangle-exclamation"></i> Invalid username or password.</div>
        <% } %>
      </form>
    </div>
  </section>

  <!-- Footer -->
  <footer>
    <div>© 2025 Sensor Data Portal — Admin Console</div>
    <div class="social">
      <a href="#"><i class="fab fa-twitter"></i></a>
      <a href="#"><i class="fab fa-github"></i></a>
      <a href="#"><i class="fab fa-linkedin"></i></a>
    </div>
  </footer>
</body>
</html>
