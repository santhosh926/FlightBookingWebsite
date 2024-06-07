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
 * Servlet implementation class QuestionServ
 */
@WebServlet("/QuestionServ")
public class QuestionServ extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuestionServ() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		try {
			PrintWriter out = response.getWriter();
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project","root",
			"root");
			String n = request.getParameter("ques");
			PreparedStatement ps = (PreparedStatement) con.prepareStatement(
					"INSERT INTO questions (question) VALUES (?)");
			ps.setString(1, n);
			//ps.setString(2, p);
			//ResultSet rs = ps.executeQuery();
			ps.executeUpdate();
		   response.sendRedirect("faq.jsp");   
		   
		   con.close();
//			RequestDispatcher rd = request.getRequestDispatcher("faq.jsp");
//			rd.forward(request, response);
//			if (rs.next()) {
//				RequestDispatcher rd = request.getRequestDispatcher("faq.jsp");
//				rd.forward(request, response);
//			}
//			else {
//				out.println("<font color=red size=18>Login Failed!<br>");
//				out.println("<a href=login.jsp>TRY AGAIN!</a>");
//			}
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
