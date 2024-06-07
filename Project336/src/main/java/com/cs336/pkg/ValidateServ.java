package com.cs336.pkg;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ValidateServ
 */
public class ValidateServ extends HttpServlet {
	private static final long serialVersionUID = 1L;
//       
//    /**
//     * @see HttpServlet#HttpServlet()
//     */
//    public ValidateServ() {
//        super();
//        // TODO Auto-generated constructor stub
//    }
//
//	/**
//	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
//	 */
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
//	}
//
//	/**
//	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
//	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		try {
			PrintWriter out = response.getWriter();
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project","root",
			"root");
			String n = request.getParameter("txtUser");
			String p = request.getParameter("txtPwd");
			PreparedStatement ps = con.prepareStatement(
					"select username from user where username=? and password=?");
			ps.setString(1, n);
			ps.setString(2, p);
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				RequestDispatcher rd = request.getRequestDispatcher("welcome.jsp");
				rd.forward(request, response);
			}
			else {
				out.println("<font color=red size=18>Login Failed!<br>");
				out.println("<a href=login.jsp>TRY AGAIN!</a>");
			}
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
