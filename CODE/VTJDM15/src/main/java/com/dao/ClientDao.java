package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ClientDao {

	
	public boolean validateClient(String username, String password) {
        String sql = "SELECT * FROM clients WHERE username=? AND password=?";
        try  {
        	Class.forName("com.mysql.jdbc.Driver");
    		Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/vtjdm15_25?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC","root","root");
    		
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            return rs.next();  // true if match found
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
