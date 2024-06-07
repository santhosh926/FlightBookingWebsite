<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="com.cs336.pkg.Airport"%>


<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String airportIdToDelete = request.getParameter("airportId");

        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        try {
            String deleteQuery = "DELETE FROM Airport WHERE airportId=?";
            PreparedStatement preparedStatement = con.prepareStatement(deleteQuery);
            try {
                preparedStatement.setString(1, airportIdToDelete);
                int rows = preparedStatement.executeUpdate();
                if (rows > 0) {
                    response.sendRedirect("viewAirports.jsp");
                } else {
                    out.println("Failed to delete the airport.");
                }
            } catch (SQLException e) {
                out.println("An error occurred while deleting the selected airport.");
                e.printStackTrace();
            }
        } catch (SQLException e) {
            out.println("An error occurred while deleting the selected airport.");
            e.printStackTrace();
        }
    }
%>
