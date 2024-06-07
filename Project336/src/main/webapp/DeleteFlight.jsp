<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="com.cs336.pkg.Flight"%>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        int flightNumToDelete = Integer.parseInt(request.getParameter("flightNum"));

        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        try {
            String deleteQuery = "DELETE FROM Flight WHERE flight_num=?";
            PreparedStatement preparedStatement = con.prepareStatement(deleteQuery);
            try {
                preparedStatement.setInt(1, flightNumToDelete);
                int rows = preparedStatement.executeUpdate();
                if (rows > 0) {
                    response.sendRedirect("viewFlights.jsp");
                } else {
                    out.println("Failed to delete the flight.");
                }
            } catch (SQLException e) {
                out.println("An error occurred while deleting the selected flight.");
            } 
        } catch (SQLException e) {
            out.println("An error occurred while deleting the selected flight.");
            e.printStackTrace();
        }
    }
%>
