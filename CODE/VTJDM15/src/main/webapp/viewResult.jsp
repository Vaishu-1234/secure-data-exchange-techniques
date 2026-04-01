<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>View Token Result</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; padding: 20px; }
        .container { background: #fff; padding: 20px; border-radius: 10px; width: 50%; margin: auto; box-shadow: 0px 2px 10px rgba(0,0,0,0.1);}
        h2 { text-align: center; color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        table, th, td { border: 1px solid #ccc; }
        th, td { padding: 12px; text-align: left; }
        th { background: #007BFF; color: white; }
        .error { color: red; font-weight: bold; text-align: center; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Token Details</h2>

        <%
            String error = (String) request.getAttribute("errorMessage");
            if (error != null) {
        %>
            <p class="error"><%= error %></p>
        <%
            } else {
                String originalValue = (String) request.getAttribute("originalValue");
                String dataValue = (String) request.getAttribute("dataValue");
                String timeStamp = (String) request.getAttribute("timeStamp");
        %>
            <table>
                <tr>
                    <th>Original Value</th>
                    <td><%= originalValue %></td>
                </tr>
                <tr>
                    <th>Data Value</th>
                    <td><%= dataValue %></td>
                </tr>
                <tr>
                    <th>Timestamp</th>
                    <td><%= timeStamp %></td>
                </tr>
            </table>
        <%
            }
        %>
    </div>
</body>
</html>
