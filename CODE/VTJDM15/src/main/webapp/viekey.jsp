<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.dao.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Encrypted Values Dashboard</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fc;
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background-color: #1f2937;
            padding: 15px 30px;
            color: white;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
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

        .dashboard-header {
            margin: 40px 0 20px;
            text-align: center;
        }

        .card-table {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.06);
            padding: 25px;
        }

        table {
            margin-bottom: 0;
        }

        thead {
            background-color: #e9ecef;
        }

        .table th {
            color: #343a40;
            font-weight: 600;
        }

        .btn-show {
            background-color: #0d6efd;
            color: white;
            border-radius: 6px;
            padding: 6px 12px;
            font-weight: 500;
            text-decoration: none;
        }

        .btn-show:hover {
            background-color: #0a58ca;
        }

        .no-data {
            padding: 20px;
            text-align: center;
            background: #ffe9e9;
            border: 1px solid #f5c2c7;
            color: #842029;
            font-weight: 500;
            border-radius: 8px;
        }

        .footer {
            text-align: center;
            margin-top: 40px;
            font-size: 14px;
            color: #6c757d;
        }

        @media (max-width: 768px) {
            .table-responsive {
                font-size: 14px;
            }

            .navbar a {
                margin-right: 10px;
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

<!-- Main Section -->
<div class="container">
    <div class="dashboard-header">
        <h2 class="fw-bold">Encrypted Token Values</h2>
        <p class="text-muted">Real-time token data fetched from your encrypted store.</p>
    </div>

    <div class="card-table table-responsive">
        <table class="table table-hover align-middle text-center">
            <thead>
                <tr>
                    <th>Batch ID</th>
                    <th>Token Index</th>
                    <th>Encrypted Value</th>
                    <th>Timestamp</th>
                    <th>User ID</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <%
                String userEmail = (String) session.getAttribute("userEmail");
                Connection con = DBUtil.getConnection();
                String sql = "SELECT * FROM getvalue WHERE userid=? AND status!='pending'";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, userEmail);
                ResultSet rs1 = ps.executeQuery();
                boolean hasData = false;

                while (rs1.next()) {
                    hasData = true;
            %>
                <tr>
                    <td><%= rs1.getString(1) %></td>
                    <td><%= rs1.getInt(3) %></td>
                    <td><%= rs1.getString(2) %></td>
                    <td><%= rs1.getString(4) %></td>
                    <td><%= rs1.getString(5) %></td>
                    <td><span class="badge bg-success"><%= rs1.getString(6) %></span></td>
                    <td>
                        <a class="btn-show" 
                           href="view.jsp?BatchId=<%=rs1.getString(1) %>&Token_Index=<%=rs1.getInt(3) %>&EncryptedValue=<%=rs1.getString(2) %>&TimeStamp=<%=rs1.getString(4)%>&userId=<%=rs1.getString(5)%>">
                            Show
                        </a>
                    </td>
                </tr>
            <% } %>

            <% if (!hasData) { %>
                <tr>
                    <td colspan="7">
                        <div class="no-data">
                            <i class="fas fa-exclamation-circle"></i> No encrypted values found for your account.
                        </div>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<div class="footer">
    &copy; <%= java.time.Year.now() %> SecureVault Inc. All rights reserved.
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
