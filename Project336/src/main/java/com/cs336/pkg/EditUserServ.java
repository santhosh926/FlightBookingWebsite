//package com.cs336.pkg;
//
//import java.io.IOException;
//import java.sql.DriverManager;
//import java.sql.SQLException;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import com.mysql.jdbc.Connection;
//import com.mysql.jdbc.PreparedStatement;
//
///**
// * Servlet implementation class EditUserServlet
// */
//@WebServlet("/EditUserServ")
//public class EditUserServ extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    public EditUserServ() {
//        super();
//        // TODO Auto-generated constructor stub
//    }
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        try {
//            Class.forName("com.mysql.jdbc.Driver");
//            Connection con = (Connection) DriverManager.getConnection(
//                "jdbc:mysql://localhost:3306/cs336project", "root", "Sairam26800-");
//
//            String originalUsername = request.getParameter("originalUsername"); // Assuming original username is used as a key
//            String newUsername = request.getParameter("username");
//            String newPassword = request.getParameter("password"); // Consider hashing the password
//            String newAccountType = request.getParameter("accountType");
//
//            PreparedStatement ps = (PreparedStatement) con.prepareStatement(
//                "UPDATE user SET username = ?, password = ?, account_type = ? WHERE username = ?");
//            ps.setString(1, newUsername);
//            ps.setString(2, newPassword); // Hash the password for security
//            ps.setString(3, newAccountType);
//            ps.setString(4, originalUsername);
//
//            ps.executeUpdate();
//
//            response.sendRedirect("adminHome.jsp"); // Redirect to the user list page after updating the user
//
//            con.close();
//        } catch (ClassNotFoundException e) {
//            e.printStackTrace();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
//}

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

@WebServlet("/EditUserServ")
public class EditUserServ extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public EditUserServ() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = (Connection) DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/cs336project", "root", "root");

            String originalUsername = request.getParameter("originalUsername");
            String newUsername = request.getParameter("username");
            String newPassword = request.getParameter("password"); // Consider hashing the password
            String newAccountType = request.getParameter("accountType");

            PreparedStatement ps = (PreparedStatement) con.prepareStatement(
                "UPDATE user SET username = ?, password = ?, account_type = ? WHERE username = ?");
            ps.setString(1, newUsername);
            ps.setString(2, newPassword); // Hash the password for security
            ps.setString(3, newAccountType);
            ps.setString(4, originalUsername);

            ps.executeUpdate();

            response.sendRedirect("adminHome.jsp"); // Redirect to the user list page after updating the user

            con.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}