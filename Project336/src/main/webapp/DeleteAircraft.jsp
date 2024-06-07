<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="com.cs336.pkg.Aircraft"%>
<%@ page import="java.util.*" %>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String aircraftIdToDelete = request.getParameter("aircraftId");

        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        try {
            String deleteQuery = "DELETE FROM Aircraft WHERE aircraftId=?";
            PreparedStatement preparedStatement = con.prepareStatement(deleteQuery);
            try {
                preparedStatement.setString(1, aircraftIdToDelete);
                int rows = preparedStatement.executeUpdate();
                if (rows > 0) {
                    response.sendRedirect("viewAircrafts.jsp");
                } else {
                    out.println("Failed to delete the aircraft.");
                }
            } catch (SQLException e) {
                out.println("An error occurred while deleting the selected aircraft.");
                e.printStackTrace();
            }
        } catch (SQLException e) {
            out.println("An error occurred while deleting the selected aircraft.");
            e.printStackTrace();
        }
    }
%>
