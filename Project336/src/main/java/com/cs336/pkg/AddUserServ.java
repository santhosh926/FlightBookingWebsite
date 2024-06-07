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
 * Servlet implementation class AddUserServlet
 */
@WebServlet("/AddUserServ")
public class AddUserServ extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddUserServ() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = (Connection) DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/cs336project", "root", "root");

            String username = request.getParameter("username");
            String password = request.getParameter("password"); // Consider hashing the password
            String accountType = request.getParameter("accountType");

            PreparedStatement ps = (PreparedStatement) con.prepareStatement(
                "INSERT INTO user (username, password, account_type) VALUES (?, ?, ?)");
            ps.setString(1, username);
            ps.setString(2, password); // Hash the password for security
            ps.setString(3, accountType);

            ps.executeUpdate();

            response.sendRedirect("adminHome.jsp"); // Redirect to the user list page after adding the user

            con.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}