package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.DBUtil;

/**
 * Servlet implementation class View
 */
@WebServlet("/View")
public class View extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public View() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String batchId = request.getParameter("BatchId");
        int tokenIndex = Integer.parseInt(request.getParameter("Token_Index").trim());
        String encryptedValue = request.getParameter("EncryptedValue");
        String timeStamp = request.getParameter("TimeStamp");
        String userId = request.getParameter("userId");
        String uniqueKey = request.getParameter("secretKey");
        
        
        try {
           Connection con=DBUtil.getConnection();
            // Insert into table
            String sql = "select original_value,data_value from file_tokens where batch_id ='"+batchId+"' and token_index='"+tokenIndex+"' and encrypted_value='"+encryptedValue+"' and unique_key='"+uniqueKey+"'";
            PreparedStatement ps = con.prepareStatement(sql);

           
System.out.println(sql);
           ResultSet rs=ps.executeQuery();
           
           if (rs.next()) {
        	   String originalValue = rs.getString("original_value");
               String dataValue = rs.getString("data_value");
System.out.println(originalValue+" "+dataValue);
               // Pass data to JSP
               request.setAttribute("originalValue", originalValue);
               request.setAttribute("dataValue", dataValue);
               request.setAttribute("timeStamp", timeStamp);

               request.getRequestDispatcher("viewResult.jsp").forward(request, response);
           } else {
               request.setAttribute("errorMessage", "No record found!");
               request.getRequestDispatcher("viewResult.jsp").forward(request, response);
           }

       } catch (Exception e) {
           e.printStackTrace();
           request.setAttribute("errorMessage", "Error: " + e.getMessage());
           request.getRequestDispatcher("viewResult.jsp").forward(request, response);
       }
	}

}
