package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

	 public boolean registerUser(String username, String password, String email, 
             String dob, String mobile, String address, String dataValue) {
boolean status = false;
try  {
	Connection con = DBUtil.getConnection();
	String sql = "INSERT INTO users (username, password, email, dob, mobile, address, data_value)   VALUES (?,?,?,?,?,?,?)";
PreparedStatement ps = con.prepareStatement(sql);
ps.setString(1, username);
ps.setString(2, password); // already hashed before calling
ps.setString(3, email);
ps.setString(4, dob);
ps.setString(5, mobile);
ps.setString(6, address);
ps.setString(7, dataValue);

status = ps.executeUpdate() > 0;
} catch (Exception e) {
e.printStackTrace();
}
return status;
}

// Retrieve sensor types dynamically (from file_tokens table if you want)
public List<String> getSensorTypes() {
List<String> sensors = new ArrayList<>();
try (Connection con = DBUtil.getConnection()) {
String sql = "SELECT DISTINCT data_value FROM file_tokens WHERE data_value IS NOT NULL";
PreparedStatement ps = con.prepareStatement(sql);
ResultSet rs = ps.executeQuery();
while (rs.next()) {
sensors.add(rs.getString("data_value"));
}
} catch (Exception e) {
e.printStackTrace();
}
return sensors;
}
}
