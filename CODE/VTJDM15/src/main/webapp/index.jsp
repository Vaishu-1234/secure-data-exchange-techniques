<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Upload & Ingest</title>
<style>
/* GLOBAL STYLING */
body {
  margin: 0;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background: linear-gradient(135deg, #0f172a, #1e293b, #111827);
  color: #f1f5f9;
  display: flex;
  min-height: 100vh;
}

/* SIDEBAR */
.sidebar {
  width: 240px;
  background: #1e293b;
  padding: 30px 20px;
  display: flex;
  flex-direction: column;
  box-shadow: 4px 0 15px rgba(0,0,0,0.3);
  border-right: 1px solid #334155;
  position: fixed;
  top: 0;
  left: 0;
  bottom: 0;
}
.sidebar h2 {
  color: #22c55e;
  font-size: 22px;
  margin-bottom: 25px;
  font-weight: 700;
  text-align: center;
}
.sidebar a {
  color: #e2e8f0;
  text-decoration: none;
  padding: 12px 15px;
  border-radius: 8px;
  margin: 8px 0;
  font-weight: 500;
  transition: all 0.3s;
}
.sidebar a:hover {
  background: #22c55e;
  color: #0f172a;
  font-weight: 600;
}

/* MAIN CONTENT */
.main {
  margin-left: 260px;
  padding: 50px;
  flex: 1;
}
.wrap {
  max-width: 850px;
  margin: auto;
  padding: 40px;
  background: rgba(17, 24, 39, 0.9);
  border-radius: 18px;
  box-shadow: 0 10px 40px rgba(0,0,0,.5);
  backdrop-filter: blur(8px);
  animation: fadeIn 1s ease-in-out;
}
h1 {
  margin-top: 0;
  font-size: 28px;
  font-weight: 700;
  background: linear-gradient(to right, #22c55e, #3b82f6);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
p {
  color: #cbd5e1;
  margin-bottom: 25px;
}

/* CARD */
.card {
  background: #0b1220;
  border: 1px solid #1f2937;
  border-radius: 14px;
  padding: 25px;
  transition: transform .3s ease, box-shadow .3s ease;
}
.card:hover {
  transform: translateY(-6px);
  box-shadow: 0 12px 30px rgba(0,0,0,.5);
}

/* FORM */
label {
  display: block;
  margin-bottom: 10px;
  font-weight: 600;
  color: #e2e8f0;
}
input[type=file] {
  display: block;
  margin: 15px 0 20px;
  background: #1e293b;
  color: #f8fafc;
  border: 1px solid #334155;
  border-radius: 10px;
  padding: 10px;
  cursor: pointer;
}
input[type=file]::-webkit-file-upload-button {
  background: #22c55e;
  border: none;
  color: #0f172a;
  font-weight: 600;
  border-radius: 8px;
  padding: 8px 12px;
  margin-right: 10px;
  cursor: pointer;
  transition: background 0.3s;
}
input[type=file]::-webkit-file-upload-button:hover {
  background: #16a34a;
}

/* BUTTON */
button {
  padding: 12px 20px;
  border: none;
  border-radius: 10px;
  background: linear-gradient(135deg, #22c55e, #16a34a);
  color: #0f172a;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.3s;
}
button:hover {
  transform: scale(1.05);
  background: linear-gradient(135deg, #16a34a, #22c55e);
  box-shadow: 0 8px 20px rgba(34,197,94,0.4);
}

/* ANIMATIONS */
@keyframes fadeIn {
  from {opacity: 0; transform: translateY(20px);}
  to {opacity: 1; transform: translateY(0);}
}
</style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
  <h2>Client Panel</h2>
  <a href="index.jsp"> Upload</a>
  <a href="plc.jsp"> PLC</a>
  <a href="client.jsp"> Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="main">
<%
  String client = (String) session.getAttribute("clientUser");
  if (client == null) {
      response.sendRedirect("login.jsp");
      return;
  }
%>
<div class="wrap">
  <h1>File Split & Secure Storage</h1>
  <p>Upload a <b>.txt</b> or <b>.csv</b> file. Each comma-separated value will be processed and stored in both original and encrypted form.</p>

  <div class="card">
    <form action="upload" method="post" enctype="multipart/form-data">
      <label for="file">Choose your file:</label>
      <input type="file" id="file" name="file" accept=".txt,.csv" required>
      <button type="submit"> Upload & Process</button>
    </form>
  </div>
</div>
</div>

</body>
</html>
