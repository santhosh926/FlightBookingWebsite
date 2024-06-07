package com.cs336.pkg;

import java.io.IOException;
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
 * Servlet implementation class DeleteUserServlet
 */
@WebServlet("/DeleteUserServ")
public class DeleteUserServ extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DeleteUserServ() {
        super();
        // Auto-generated constructor stub
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Existing doPost method logic
        performDelete(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Logic for handling GET request
        performDelete(request, response);
    }

    private void performDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = (Connection) DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/cs336project", "root", "root");

            String username = request.getParameter("username");
            PreparedStatement ps = (PreparedStatement) con.prepareStatement(
                "DELETE FROM user WHERE username = ?");
            ps.setString(1, username);
            ps.executeUpdate();

            response.sendRedirect("adminHome.jsp"); // Redirect to the admin home page after deletion

            con.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}