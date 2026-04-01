<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
   String userEmail = (String) session.getAttribute("userEmail");
   if (userEmail == null) {
       response.sendRedirect("login.jsp");
   }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="ISO-8859-1">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>User Dashboard - SentinelSense</title>

  <!-- Fonts & Icons -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>

  <!-- Chart.js for live chart -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

  <style>
    /* ---------------- Global ---------------- */
    :root{
      --bg-1: #071021;
      --bg-2: #0f2338;
      --glass: rgba(255,255,255,0.04);
      --accent: #42f5d9;
      --accent-2: #5aa9ff;
      --muted: #9fb4c8;
      --card-radius: 14px;
      --shadow: 0 18px 50px rgba(2,10,30,0.6);
    }
    *{box-sizing:border-box}
    html,body{height:100%; margin:0; font-family:'Poppins',sans-serif; color:#e9f5ff; background:linear-gradient(180deg,var(--bg-1),var(--bg-2)); -webkit-font-smoothing:antialiased}
    a{color:inherit; text-decoration:none}

    /* ---------------- Particles BG ---------------- */
    #fx { position: fixed; inset:0; z-index:0; pointer-events:none; opacity:.22; }
    .bg-overlay { position: fixed; inset:0; background: linear-gradient(180deg, rgba(3,10,22,0.55), rgba(3,10,22,0.7)); z-index:0; }

    /* ---------------- Header ---------------- */
    header {
      position: sticky; top:0; z-index:40;
      backdrop-filter: blur(8px);
      background: linear-gradient(90deg, rgba(6,12,28,0.55), rgba(6,12,28,0.45));
      border-bottom: 1px solid rgba(255,255,255,0.04);
    }
    .nav {
      max-width:1200px; margin:0 auto; padding:14px 20px; display:flex; align-items:center; justify-content:space-between; gap:12px;
    }
    .brand { display:flex; align-items:center; gap:12px }
    .logo {
      width:40px; height:40px; border-radius:10px; display:grid; place-items:center; color:#03101a;
      background: linear-gradient(135deg,var(--accent),var(--accent-2)); font-weight:800;
      box-shadow:0 8px 30px rgba(66,245,217,0.12);
    }
    .brand h1 { font-size:18px; letter-spacing:0.6px; margin:0; font-weight:700; color:#eafcff; }
    .nav-links { display:flex; gap:14px; align-items:center; }
    .nav-links a { color:var(--muted); font-weight:600; padding:8px 10px; border-radius:8px; transition:all .18s }
    .nav-links a:hover { background: rgba(255,255,255,0.02); color:#fff }

    /* ---------------- Layout ---------------- */
    .layout { display:grid; grid-template-columns: 260px 1fr; gap:24px; max-width:1200px; margin:28px auto; padding: 0 20px; z-index:10; position:relative; }
    @media (max-width:900px){ .layout { grid-template-columns: 1fr; } .sidebar { order:2 } .main { order:1 } }

    /* ---------------- Sidebar ---------------- */
    .sidebar {
      background: var(--glass);
      border: 1px solid rgba(255,255,255,0.04);
      border-radius: var(--card-radius);
      padding:18px; box-shadow: var(--shadow);
      min-height: 420px;
      backdrop-filter: blur(8px);
    }
    .userbox { display:flex; align-items:center; gap:12px; margin-bottom:18px }
    .avatar { width:56px; height:56px; border-radius:12px; background:linear-gradient(135deg,var(--accent-2),var(--accent)); display:grid; place-items:center; color:#05121a; font-weight:800; font-size:18px }
    .usermeta { font-size:14px }
    .usermeta .name { font-weight:700; color:#e8fbff }
    .usermeta .sub { color:var(--muted); font-size:13px; margin-top:4px }
    .side-nav { margin-top:14px; display:flex; flex-direction:column; gap:8px }
    .side-nav a { padding:10px 12px; border-radius:10px; color:var(--muted); display:flex; align-items:center; gap:10px; font-weight:600 }
    .side-nav a:hover { background: linear-gradient(90deg, rgba(66,245,217,0.06), rgba(90,160,255,0.04)); color:#fff; transform:translateX(6px) }
    .small-note { margin-top:18px; font-size:13px; color:var(--muted) }

    /* ---------------- Main ---------------- */
    .main {
      display:flex; flex-direction:column; gap:18px;
    }

    /* welcome card */
    .hero-card {
      background: linear-gradient(180deg, rgba(255,255,255,0.03), rgba(255,255,255,0.02));
      border: 1px solid rgba(255,255,255,0.04);
      border-radius: 14px; padding:20px;
      display:flex; align-items:center; justify-content:space-between; gap:16px;
      box-shadow: 0 14px 40px rgba(2,10,30,0.55);
      overflow:visible;
    }
    .hero-left { max-width:66%; }
    .hero-left h2 { margin:0 0 8px; font-size:22px; color:#eafcff; }
    .hero-left p { margin:0; color:var(--muted); font-size:14px }
    .hero-actions { display:flex; gap:10px; margin-top:12px }
    .btn { background: linear-gradient(90deg,var(--accent),var(--accent-2)); color:#03101a; padding:10px 14px; border-radius:10px; font-weight:800; border:none; cursor:pointer; transition: transform .12s }
    .btn:hover { transform: translateY(-3px) }
    .hero-right { width:320px; height:110px; display:grid; place-items:center; position:relative }

    /* small KPI cards row */
    .kpi-row { display:flex; gap:12px; flex-wrap:wrap }
    .kpi { flex:1; min-width:160px; background:rgba(255,255,255,0.02); border-radius:12px; padding:12px; border:1px solid rgba(255,255,255,0.03) }
    .kpi small { color:var(--muted); }
    .kpi .big { font-weight:800; font-size:18px; margin-top:6px;color:#eafcff }

    /* chart & stream */
    .panel { background:var(--glass); padding:16px; border-radius:12px; border:1px solid rgba(255,255,255,0.04); box-shadow: 0 12px 30px rgba(2,10,30,0.5) }
    .panel h3 { margin:0 0 8px; font-size:16px; color:#fff }

    .stream-table { width:100%; border-collapse:collapse; font-size:13px; color:var(--muted) }
    .stream-table thead th { text-align:left; padding:10px; border-bottom:1px solid rgba(255,255,255,0.03); color:var(--muted); font-weight:700 }
    .stream-table tbody td { padding:10px; border-bottom:1px dashed rgba(255,255,255,0.03) }

    /* footer */
    footer { max-width:1200px; margin:18px auto; padding:10px 20px; color:var(--muted); text-align:center; z-index:10 }

    /* responsive small screens */
    @media (max-width:900px){
      .hero-right { display:none }
      .kpi-row { gap:8px }
    }
  </style>
</head>
<body>
  <!-- animated particles canvas -->
  <canvas id="fx"></canvas>
  <div class="bg-overlay"></div>

  <!-- header -->
  <header>
    <div class="nav">
      <div class="brand">
        <div class="logo"><i class="fa-solid fa-wave-square"></i></div>
        <div>
          <h1>SentinelSense</h1>
          <div style="font-size:12px; color:var(--muted)">Real-time Sensor Security</div>
        </div>
      </div>

      <div class="nav-links">
        <a href="welcome.jsp"><i class="fa-solid fa-house"></i>&nbsp; Home</a>
        <a href="getdata.jsp"><i class="fa-solid fa-database"></i>&nbsp; Values</a>
        <a href="viekey.jsp"><i class="fa-solid fa-key"></i>&nbsp; Keys</a>
        <a href="LogoutServlet" style="color:#ffb3b3"><i class="fa-solid fa-right-from-bracket"></i>&nbsp; Logout</a>
      </div>
    </div>
  </header>

  <!-- layout: sidebar + main -->
  <div class="layout" role="main">
    <!-- sidebar -->
    <aside class="sidebar" aria-label="sidebar">
      <div class="userbox">
        <div class="avatar"><%= userEmail != null && userEmail.length() > 0 ? Character.toUpperCase(userEmail.charAt(0)) : "U" %></div>
        <div class="usermeta">
          <div class="name"><%= userEmail %></div>
          <div class="sub">Client account</div>
        </div>
      </div>

      <nav class="side-nav" aria-label="side navigation">
        <a href="getdata.jsp"><i class="fa-solid fa-chart-line"></i> View Values</a>
        <a href="viekey.jsp"><i class="fa-solid fa-key"></i> View Key</a>
        <a href="LogoutServlet"><i class="fa-solid fa-sign-out-alt"></i> Logout</a>
        <a href="welcome.jsp"><i class="fa-solid fa-user"></i> Profile</a>
        <a href="#support"><i class="fa-solid fa-headset"></i> Support</a>
      </nav>

      <div class="small-note">
        <strong>Batch:</strong> last upload: <span style="color:#cfefff">- none -</span><br>
        <small style="color:var(--muted)">Tip: Upload CSV or raw text to ingest sensor values.</small>
      </div>
    </aside>

    <!-- main content -->
    <section class="main">
      <!-- hero card -->
      <div class="hero-card">
        <div class="hero-left">
          <small style="color:var(--muted)">Welcome back</small>
          <h2>Hello, <%= userEmail %> </h2>
          <p>Monitor your sensor data in real time. Each value is stored with an original and AES-encrypted copy, and every row has a unique key for auditability.</p>

          <div class="hero-actions">
            <button onclick="location.href='getdata.jsp'" class="btn"><i class="fa-solid fa-database"></i>&nbsp;&nbsp;View Values</button>
            <button onclick="location.href='viekey.jsp'" class="btn" style="background:linear-gradient(90deg,#ffd36b,#ff7aa2)"><i class="fa-solid fa-key"></i>&nbsp;&nbsp;View Keys</button>
          </div>
        </div>

        <div class="hero-right">
          <!-- small KPIs -->
          <div style="width:100%; display:grid; gap:8px">
            <div style="display:flex; gap:8px" class="kpi-row">
              <div class="kpi">
                <small>Live Sensors</small>
                <div class="big" id="kpiSensors">-</div>
              </div>
              <div class="kpi">
                <small>Encrypted Rows</small>
                <div class="big" id="kpiEncrypted">-</div>
              </div>
            </div>
            <div style="display:flex; gap:8px; margin-top:6px">
              <div class="kpi">
                <small>Alerts</small>
                <div class="big" id="kpiAlerts">-</div>
              </div>
              <div class="kpi">
                <small>Uptime</small>
                <div class="big" id="kpiUptime">99.99%</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- chart + table row -->
      <div style="display:grid; grid-template-columns: 1fr 420px; gap:18px; margin-top:8px;">
        <!-- left: chart -->
        <div class="panel">
          <h3>Live Temperature (simulated)</h3>
          <canvas id="liveChart" style="width:100%; height:220px"></canvas>
        </div>

        <!-- right: recent stream -->
        <div class="panel">
          <h3>Recent Stream</h3>
          <table class="stream-table" aria-live="polite">
            <thead>
              <tr><th>Time</th><th>Batch</th><th>Index</th><th>Data</th></tr>
            </thead>
            <tbody id="streamBody">
              <!-- JS will prepend rows -->
            </tbody>
          </table>
        </div>
      </div>

      <!-- actions / quick controls -->
      <div style="display:flex; gap:12px; margin-top:12px; flex-wrap:wrap">
        <!-- <button class="btn" onclick="location.href='upload.jsp'"><i class="fa-solid fa-file-arrow-up"></i> Upload Data</button> -->
        <button class="btn" onclick="location.href='#search'"><i class="fa-solid fa-magnifying-glass"></i> Query Batches</button>
        <button class="btn" onclick="alert('This will open security settings (not implemented)')"><i class="fa-solid fa-shield-halved"></i> Security</button>
      </div>
    </section>
  </div>

  <!-- footer -->
  <footer>
    © <%= java.time.LocalDate.now().getYear() %> SentinelSense - Secure Sensor Platform · contact: support@example.com
  </footer>

  <!-- ---------------- Scripts: particles + chart + stream simulation ---------------- -->
  <script>
    // ---------- FX Particles/wiring (canvas) ----------
    (function(){
      const c = document.getElementById('fx');
      const ctx = c.getContext('2d');
      let w = c.width = innerWidth, h = c.height = innerHeight;
      window.addEventListener('resize', ()=>{ w = c.width = innerWidth; h = c.height = innerHeight; });
      const nodes = Array.from({length: 80}).map(()=>({ x: Math.random()*w, y: Math.random()*h, vx: (Math.random()-.5)*.3, vy:(Math.random()-.5)*.3 }));
      function tick(){
        ctx.clearRect(0,0,w,h);
        for(let i=0;i<nodes.length;i++){
          const a = nodes[i];
          a.x+=a.vx; a.y+=a.vy;
          if(a.x<0||a.x>w) a.vx *= -1;
          if(a.y<0||a.y>h) a.vy *= -1;
          ctx.fillStyle = 'rgba(66,185,255,0.9)';
          ctx.beginPath(); ctx.arc(a.x, a.y, 1.4, 0, Math.PI*2); ctx.fill();
          for(let j=i+1;j<nodes.length;j++){
            const b = nodes[j];
            const dx = a.x - b.x, dy = a.y - b.y;
            const d = Math.hypot(dx, dy);
            if(d < 120){
              ctx.strokeStyle = 'rgba(90,160,255,' + (0.18 - (d/170)*0.16) + ')';
              ctx.lineWidth = 1;
              ctx.beginPath(); ctx.moveTo(a.x,a.y); ctx.lineTo(b.x,b.y); ctx.stroke();
            }
          }
        }
        requestAnimationFrame(tick);
      }
      tick();
    })();

    // ---------- Live Chart (simulated) ----------
    const ctx = document.getElementById('liveChart').getContext('2d');
    let labels = Array.from({length:30}, (_,i)=>'');
    const chart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: labels,
        datasets: [{ label:'Temperature (°C)', data: Array.from({length:30}, ()=>20 + Math.random()*6), borderColor:'#42f5d9', backgroundColor:'rgba(66,245,217,0.06)', fill:true, tension:0.35 }]
      },
      options: {
        responsive:true,
        plugins:{ legend:{ display:false } },
        scales:{ x:{ display:false }, y:{ ticks:{ color:'#cfefff' }, grid:{ color:'rgba(255,255,255,0.03)'} } }
      }
    });

    // update chart with new simulated point every 2s
    setInterval(()=>{
      const v = 20 + Math.random()*6; // simulate temperature
      chart.data.datasets[0].data.push(v);
      if(chart.data.datasets[0].data.length>60) chart.data.datasets[0].data.shift();
      chart.update();
      // update KPIs
      document.getElementById('kpiSensors').textContent = Math.floor(10 + Math.random()*30);
      document.getElementById('kpiEncrypted').textContent = (12000 + Math.floor(Math.random()*4000)).toLocaleString();
      document.getElementById('kpiAlerts').textContent = Math.floor(Math.random()*6);
      // add to stream
      addStreamRow(v);
    }, 2000);

    // ---------- Stream rows ----------
    const streamBody = document.getElementById('streamBody');
    function addStreamRow(value){
      const now = new Date().toLocaleTimeString();
      const batch = 'B-'+Math.random().toString(36).slice(2,8).toUpperCase();
      const idx = Math.floor(Math.random()*99)+1;
      const tr = document.createElement('tr');
      tr.innerHTML = '<td style="white-space:nowrap">'+now+'</td><td>'+batch+'</td><td>'+idx+'</td><td>'+ (value.toFixed(2)) +'</td>';
      streamBody.insertBefore(tr, streamBody.firstChild);
      // keep 8 rows
      while(streamBody.children.length>8) streamBody.removeChild(streamBody.lastChild);
    }

    // pre-populate some rows
    for(let i=0;i<6;i++) addStreamRow(20 + Math.random()*6);

  </script>
</body>
</html>
