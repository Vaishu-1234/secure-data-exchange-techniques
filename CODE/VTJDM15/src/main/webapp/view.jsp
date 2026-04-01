<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Token Detail Viewer</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f1f4f9;
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background-color: #1f2937;
            padding: 15px 30px;
            color: white;
        }

        .navbar a {
            color: #ffffff;
            margin-right: 20px;
            font-weight: 500;
            text-decoration: none;
        }

        .navbar a:hover {
            text-decoration: underline;
        }

        .container-form {
            max-width: 550px;
            margin: 60px auto;
            background-color: #ffffff;
            padding: 35px;
            border-radius: 15px;
            box-shadow: 0px 10px 25px rgba(0, 0, 0, 0.07);
            transition: all 0.3s ease-in-out;
        }

        .container-form h2 {
            text-align: center;
            font-weight: 600;
            margin-bottom: 25px;
            color: #1f2937;
        }

        label {
            font-weight: 600;
            margin-top: 15px;
            color: #374151;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px 14px;
            border-radius: 8px;
            border: 1px solid #ced4da;
            margin-top: 6px;
            transition: 0.3s;
        }

        input[type="text"]:focus {
            border-color: #0d6efd;
            outline: none;
            box-shadow: 0 0 0 3px rgba(13, 110, 253, 0.1);
        }

        .submit-btn {
            margin-top: 25px;
            background-color: #0d6efd;
            color: white;
            border: none;
            padding: 12px;
            font-size: 16px;
            width: 100%;
            border-radius: 8px;
            font-weight: 600;
            transition: background 0.3s ease-in-out;
        }

        .submit-btn:hover {
            background-color: #0a58ca;
        }

        .footer {
            text-align: center;
            margin-top: 40px;
            color: #6c757d;
            font-size: 14px;
        }

        @media (max-width: 576px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar d-flex justify-content-between align-items-center">
    <div>
        <a href="getdata.jsp"><i class="fas fa-database"></i> Encrypted Data</a>
        <a href="viekey.jsp"><i class="fas fa-key"></i> View Keys</a>
    </div>
    <div>
        <a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</div>

<!-- Fetch Request Parameters -->
<%
    String batchid = request.getParameter("BatchId");
    String tokenIndex = request.getParameter("Token_Index");
    String encryptedValue = request.getParameter("EncryptedValue");
    String time = request.getParameter("TimeStamp");
    String userid = request.getParameter("userId");
%>

<!-- Token Form -->
<div class="container-form">
    <h2>Token Details</h2>
    <form action="View" method="post">
        <label>Batch ID</label>
        <input type="text" name="BatchId" value="<%= batchid != null ? batchid : "" %>" readonly />

        <label>Token Index</label>
        <input type="text" name="Token_Index" value="<%= tokenIndex != null ? tokenIndex : "" %>" readonly />

        <label>Encrypted Value</label>
        <input type="text" name="EncryptedValue" value="<%= encryptedValue != null ? encryptedValue : "" %>" readonly />

        <label>Timestamp</label>
        <input type="text" name="TimeStamp" value="<%= time != null ? time : "" %>" readonly />

        <label>User ID</label>
        <input type="text" name="userId" value="<%= userid != null ? userid : "" %>" readonly />

        <label>Enter Key</label>
        <input type="text" name="secretKey" placeholder="Enter your decryption key" required />

        <button type="submit" class="submit-btn">Decrypt Token</button>
    </form>
</div>

<!-- Footer -->
<div class="footer">
    &copy; <%= java.time.Year.now() %> SecureVault Inc. | All rights reserved.
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
