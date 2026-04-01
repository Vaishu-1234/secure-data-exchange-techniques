package com.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.dao.DBUtil;
import com.dao.FileTokenDAO;
import com.service.AESUtil;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.*;

@WebServlet(name = "UploadServlet", urlPatterns = {"/upload"})
@MultipartConfig
public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadServlet() {
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
		
		try {
		    Part filePart = request.getPart("file");
		    if (filePart == null || filePart.getSize() == 0) {
		        throw new ServletException("No file uploaded");
		    }

		    List<String[]> rows = new ArrayList<>();
		    try (BufferedReader br = new BufferedReader(
		            new InputStreamReader(filePart.getInputStream(), StandardCharsets.UTF_8))) {
		        String line;
		        while ((line = br.readLine()) != null) {
		            // Split by tab (\\t) not by space
		            rows.add(line.split("\\t"));
		        }
		    }

		    if (rows.isEmpty()) {
		        throw new ServletException("File is empty");
		    }

		    // First row = headers
		    String[] headers = rows.get(0); // sno, temperature, humidity, pressure, light

		    // Batch ID
		    String batchId = UUID.randomUUID().toString();

		    FileTokenDAO dao = new FileTokenDAO();
		    int tokenIndex = 1;

		    // Process rows starting from 2nd row
		    for (int i = 1; i < rows.size(); i++) {
		        String[] values = rows.get(i);

		        for (int j = 0; j < values.length && j < headers.length; j++) {
		            String columnName = headers[j].trim().toLowerCase(); // sno / temperature / humidity / pressure / light
		            String original = values[j].trim();

		            // Only save if the column is one of the expected headers
		            if (!original.isEmpty()) {
		                dao.saveSingle(batchId, tokenIndex++, original, columnName, v -> {
		                    try {
		                        return AESUtil.encrypt(v);
		                    } catch (Exception e) {
		                        throw new RuntimeException(e);
		                    }
		                });
		            }
		        }
		    }

		    request.setAttribute("batchId", batchId);
		    request.getRequestDispatcher("result.jsp").forward(request, response);

		} catch (Exception e) {
		    throw new ServletException(e);
		}

		
    }
	
	
	
    
}
