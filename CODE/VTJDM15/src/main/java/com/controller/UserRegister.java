package com.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.UserDAO;

/**
 * Servlet implementation class UserRegister
 */
@WebServlet("/UserRegister")
public class UserRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserRegister() {
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
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
            String username = req.getParameter("fullname");
            String password = req.getParameter("password");
            String email = req.getParameter("email");
            String dob = req.getParameter("dob");
            String mobile = req.getParameter("mobile");
            String address = req.getParameter("address");
            String dataValue = req.getParameter("data_value");

            //String hashedPwd = hashPassword(password);

            UserDAO dao = new UserDAO();
            boolean result = dao.registerUser(username, password, email, dob, mobile, address, dataValue);

            if (result) {
                req.setAttribute("message", "Registration successful! Please login.");
                RequestDispatcher rd = req.getRequestDispatcher("ulogin.jsp");
                rd.forward(req, resp);
            } else {
                req.setAttribute("error", "Registration failed. Try again.");
                RequestDispatcher rd = req.getRequestDispatcher("UserSignUp.jsp");
                rd.forward(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
	}

}
