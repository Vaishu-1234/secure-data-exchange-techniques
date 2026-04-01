<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Client Login | SentinelSense</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <!-- Google Font & Icons -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>

  <style>
    :root{
      --bg:#070b16;
      --bg-2:#0f1830;
      --glass: rgba(255,255,255,.06);
      --stroke: rgba(255,255,255,.18);
      --text:#eaf2ff;
      --muted:#97a7c2;
      --primary:#6cf0c2;
      --accent:#7aa7ff;
      --hot:#ff7aa2;
      --ok:#10e6a5;
      --shadow: 0 30px 80px rgba(0,0,0,.55);
      --radius: 20px;
    }

    *{box-sizing:border-box}
    html,body{height:100%; margin:0; font-family: Inter, system-ui, sans-serif; color: var(--text);}

    body{
      background: radial-gradient(1200px 800px at 15% -10%, #1b2a5d 0%, var(--bg) 50%) fixed;
      overflow-x:hidden;
    }

    /* NAV */
    header{
      position: sticky; top: 0; z-index: 50;
      backdrop-filter: blur(10px);
      background: rgba(7,11,22,.55);
      border-bottom: 1px solid var(--stroke);
    }
    .nav{max-width: 1200px; margin: 0 auto; padding: 14px 20px;
      display: flex; align-items: center; justify-content: space-between;}
    .brand{display:flex; align-items:center; gap:12px; font-weight:800;}
    .logo{width:38px; height:38px; border-radius:12px; display:grid; place-items:center; color:#081225;
      background: linear-gradient(135deg, var(--primary), var(--accent));}

    nav ul{display:flex; gap:18px; list-style:none; margin:0; padding:0}
    nav a{color: var(--muted); text-decoration:none; font-weight:600; font-size:14px; padding:8px 12px; border-radius:10px;}
    nav a:hover{color:var(--text); background:rgba(255,255,255,.07)}

    .pill{padding:10px 14px; border-radius:12px; font-weight:700; background: linear-gradient(135deg, var(--primary), var(--accent)); color:#06111f; border:none;}

    /* BACKGROUND EFFECTS */
    .bg-image{
      position: fixed; inset:0; z-index:-4;
      background: url('images/a4.webp') center/cover no-repeat;
      opacity:.25;
    }
    .circuit{
      position: fixed; inset:0; z-index:-3; opacity:.18;
      background:
        linear-gradient(transparent 23px, rgba(122,167,255,.12) 24px),
        linear-gradient(90deg, transparent 23px, rgba(122,167,255,.12) 24px);
      background-size: 24px 24px;
    }
    .scan::before{
      content:""; position: fixed; inset:0; z-index:-2;
      background: linear-gradient(115deg, transparent 40%, rgba(122,167,255,.15) 50%, transparent 60%);
      transform: translateX(-100%); animation: sweep 9s linear infinite;
    }
    @keyframes sweep{0%{ transform: translateX(-100%) }100%{ transform: translateX(100%) }}

    /* HERO / LOGIN */
    .wrap{max-width: 1200px; margin: 40px auto 120px; padding: 0 20px;
      display:grid; grid-template-columns: 1.1fr .9fr; gap: 36px; align-items:center;}
    @media (max-width: 980px){ .wrap{ grid-template-columns:1fr; } }

    .headline{ font-size: 44px; font-weight: 800; margin: 6px 0 12px; }
    .tag{display:inline-flex; gap:8px; align-items:center; padding:8px 12px; border-radius:999px; background: linear-gradient(135deg, var(--ok), var(--hot));}

    .login-shell{perspective: 900px;}
    .card{border: 1px solid var(--stroke); border-radius: var(--radius);
      background: rgba(255,255,255,.04); backdrop-filter: blur(14px);
      box-shadow: var(--shadow); padding: 28px;}

    form .input-group{margin: 14px 0;}
    form .input-group input{width: 100%; padding: 14px; border-radius: 12px; border: 1px solid var(--stroke); font-size: 14px;}

    .login-btn{width: 100%; padding: 12px; margin-top: 8px; border-radius: 12px;
      background: linear-gradient(135deg, var(--primary), var(--accent)); font-weight: 800; color:#06121f;}

    .actions{display:flex; justify-content:space-between; margin-top:8px;}
    .link{color: var(--accent); font-size: 13px;}

    .error{margin-top: 12px; padding: 10px; border-radius: 12px; background: rgba(255, 122, 162, .14); border:1px solid rgba(255,122,162,.35); color:#ffd8e6;}

    /* FOOTER fixed */
    footer{
      position: fixed; bottom: 0; width: 100%;
      border-top: 1px solid var(--stroke);
      background: rgba(7,11,22,.85);
      color: var(--muted);
    }
    .foot{
      max-width: 1200px; margin: 0 auto; padding: 14px 20px;
      display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap;
      font-size: 13px;
    }
    .foot .links a{margin-left:15px; color:var(--accent); text-decoration:none;}
    .foot .links a:hover{text-decoration:underline;}
  </style>
</head>
<body class="scan">
  <!-- backgrounds -->
  <div class="bg-image"></div>
  <div class="circuit"></div>

  <!-- NAV -->
  <header>
    <div class="nav">
      <div class="brand"><div class="logo"><i class="fa-solid fa-wave-square"></i></div><span>SentinelSense</span></div>
      <nav>
        <ul>
          <li><a href="#">Home</a></li>
          <li><a href="ulogin.jsp">User</a></li>
          <li><a href="client.jsp">Client</a></li>
          <li><a href="Admin.jsp">Admin</a></li>
        </ul>
      </nav>
<!--       <button class="pill" onclick="location.href='register.jsp'"><i class="fa-regular fa-address-card"></i> Register</button>
 -->    </div>
  </header>

  <!-- HERO -->
  <main class="wrap">
    <section>
      <span class="tag"><i class="fa-solid fa-shield-halved"></i> AES-Secured Sensor Access</span>
      <h1 class="headline">Login to your Real-Time Sensor Vault</h1>
      <p>Access encrypted readings from Temperature, Humidity, Pressure, and Air-Quality sensors with unique per-row keys.</p>
    </section>

    <section class="login-shell">
      <div class="card">
        <h2><i class="fa-solid fa-id-card-clip"></i> Client Login</h2>
        <form action="Client" method="post">
          <div class="input-group"><input type="text" name="username" placeholder="Enter Username" required></div>
          <div class="input-group"><input type="password" name="password" placeholder="Enter Password" required></div>
          <button type="submit" class="login-btn">Login</button>
        </form>

        <div class="actions">
          <label style="font-size:13px;"><input type="checkbox"> Remember me</label>
          <a class="link" href="#">Forgot password?</a>
        </div>

        <% Object err = request.getAttribute("error"); if (err != null) { %>
          <div class="error"><i class="fa-solid fa-triangle-exclamation"></i> <%= err %></div>
        <% } %>
      </div>
    </section>
  </main>

  <!-- FOOTER -->
  <footer>
    <div class="foot">
      <div>© <span id="yr"></span> SentinelSense — Real-Time Sensor Security Platform</div>
      <div class="links">
        <a href="privacy.jsp">Privacy</a>
        <a href="terms.jsp">Terms</a>
        <a href="status.jsp">Status</a>
        <a href="contact.jsp">Contact</a>
      </div>
    </div>
  </footer>

  <script>document.getElementById('yr').textContent = new Date().getFullYear();</script>
</body>
</html>
