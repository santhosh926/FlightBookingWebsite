<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>




<%

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String newFlight = request.getParameter("newFlight");
        String flight = request.getParameter("flight");

        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        try {
            String updateQuery = "UPDATE bookings SET flight = ? WHERE username = ? AND flight = ?";
            PreparedStatement preparedStatement = con.prepareStatement(updateQuery);
            try {
                preparedStatement.setString(1, newFlight);
                preparedStatement.setString(2, username);
                preparedStatement.setString(3, flight);

                int rows = preparedStatement.executeUpdate();

                if (rows > 0) {
                    response.sendRedirect("reservation.jsp");
                } else {
                    out.println("Failed to update reservation.");
                }
            } catch (SQLException e) {
                out.println("An error occurred while editing the reservation. Code 1");
                e.printStackTrace();
            }
        } catch (SQLException e) {
            out.println("An error occurred while editing the reservation. Code 2");
            e.printStackTrace();
        }
    }
%>
        <html>
        <head>
            <title>Edit Reservation</title>
        </head>
        <body>

        <h2>Edit Reservation</h2>

        <form method="post" action="EditReservation.jsp">
            <input type="hidden" name="username" value="<%= request.getParameter("username") %>">
            <input type="hidden" name="flight" value="<%= request.getParameter("flight") %>">
            <label for="newFlight">New Flight:</label>
            <input type="text" id="newFlight" name="newFlight" required><br>

            <input type="submit" value="Update Reservation">
        </form>

        </body>
        </html>
