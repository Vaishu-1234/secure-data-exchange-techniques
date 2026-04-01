<%@page import="com.dao.DBUtil"%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Registration</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f4f7f8;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .container {
      width: 450px;
      background: #fff;
      padding: 25px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.2);
    }
    h2 {
      text-align: center;
      margin-bottom: 20px;
    }
    label {
      font-weight: bold;
      display: block;
      margin-top: 10px;
    }
    input, select, textarea {
      width: 100%;
      padding: 8px;
      margin-top: 5px;
      border-radius: 6px;
      border: 1px solid #ccc;
    }
    button {
      margin-top: 20px;
      width: 100%;
      padding: 10px;
      background: #28a745;
      color: #fff;
      font-size: 16px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }
    button:hover {
      background: #218838;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>User Registration</h2>
  <form action="UserRegister" method="post">
    <label>Full Name</label>
    <input type="text" name="fullname" required />

<label>Email</label>
    <input type="email" name="email" required />

    <label>Password</label>
    <input type="password" name="password" required />
    <label>Date of Birth</label>
    <input type="date" name="dob" required />

    <label>Address</label>
    <textarea name="address" rows="3" required></textarea>

    <label>Mobile Number</label>
    <input type="text" name="mobile" pattern="[0-9]{10}" required />

    

    <label>Data Value</label>
    <select name="data_value" required>
      <option value="">-- Select Machines --</option>
      <%
        // Fetch dropdown values from DB
        try {
           Connection conn=DBUtil.getConnection();
            // Assuming you have a table `data_values` with column `value_name`
            PreparedStatement ps = conn.prepareStatement("SELECT distinct data_value FROM file_tokens WHERE data_value <> 'sno'");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                String val = rs.getString("data_value");
      %>
                <option value="<%=val%>"><%=val%></option>
      <%
            }
            rs.close();
            ps.close();
            conn.close();
        } catch(Exception e){
            out.println("<option disabled>Error loading values</option>");
            e.printStackTrace();
        }
      %>
    </select>

    <button type="submit">Register</button>
  </form>
</div>
</body>
</html>
