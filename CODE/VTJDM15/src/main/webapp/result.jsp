<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.FileTokenDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Upload Result</title>
<style>
body{font-family:system-ui,Segoe UI,Roboto,Arial,sans-serif;background:#0f172a;color:#e2e8f0;margin:0}
.wrap{max-width:1000px;margin:40px auto;padding:24px}
table{width:100%;border-collapse:collapse;background:#0b1220;border-radius:12px;overflow:hidden}
th,td{padding:12px 10px;border-bottom:1px solid #1f2937;text-align:left}
th{background:#111827}
.pill{display:inline-block;padding:4px 8px;border-radius:999px;background:#1f2937}
a{color:#93c5fd}
</style>
</head>
<body>
<div class="wrap">
<h2>Stored Records</h2>
<p>Batch: <span class="pill"><%= request.getAttribute("batchId") %></span></p>


<table>
<thead>
<tr>
<th>#</th>
<th>Original</th>
<th>Encrypted (Base64 iv:cipher)</th>
</tr>
</thead>
<tbody>
<%
String batchId = (String) request.getAttribute("batchId");
if (batchId != null) {
FileTokenDAO dao = new FileTokenDAO();
List<Map<String,Object>> rows = dao.fetchByBatch(batchId);
for (Map<String,Object> r : rows) {
%>
<tr>
<td><%= r.get("token_index") %></td>
<td><%= r.get("original_value") %></td>
<td style="word-break:break-all"><%= r.get("encrypted_value") %></td>
</tr>
<%
}
}
%>
</tbody>
</table>


<p style="margin-top:18px"><a href="index.jsp"> Upload another file</a></p>
</div>

</body>
</html>