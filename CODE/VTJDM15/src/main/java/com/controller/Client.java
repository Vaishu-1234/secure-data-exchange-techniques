package com.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.ClientDao;

/**
 * Servlet implementation class Client
 */
@WebServlet("/Client")
public class Client extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Client() {
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
		 String username = request.getParameter("username");
	        String password = request.getParameter("password");

	        ClientDao dao = new ClientDao();
	        boolean valid = dao.validateClient(username, password);

	        if (valid) {
	            HttpSession session = request.getSession();
	            session.setAttribute("clientUser", username);
	            response.sendRedirect("clienthome.jsp");   // redirect to upload page
	        } else {
	            request.setAttribute("error", "Invalid username or password!");
	            request.getRequestDispatcher("login.jsp").forward(request, response);
	        }
	}

}
