package com.cs336.pkg;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

/**
 * Servlet implementation class RTBookingServ
 */
@WebServlet("/RTBookingServ")
public class RTBookingServ extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RTBookingServ() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		try {
			
			PrintWriter out = response.getWriter();
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project","root",
			"root");
			String n = request.getParameter("username");
			String s = request.getParameter("bookInitialFlight");
			String d = request.getParameter("bookReturnFlight");
			PreparedStatement ps1 = (PreparedStatement) con.prepareStatement(
					"INSERT INTO bookings (username, flight) VALUES (?, ?)");
			ps1.setString(1, n);
			ps1.setString(2, s);
			ps1.executeUpdate();
			ps1.setString(2, d);
			ps1.executeUpdate();
		   response.sendRedirect("bookings.jsp");   
		   
		   con.close();
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
