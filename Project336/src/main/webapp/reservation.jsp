<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>

<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

	if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String flight = request.getParameter("flight");

        /* ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection(); */
        try {
            String insertQuery = "INSERT INTO bookings (username, flight) VALUES (?, ?)";
            PreparedStatement preparedStatement = con.prepareStatement(insertQuery);
            try {
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, flight);

                int rows = preparedStatement.executeUpdate();

                if (rows > 0) {
                    out.println("Reservation added successfully.");
                } else {
                    out.println("Failed to add reservation.");
                }
            } catch (SQLException e) {
                out.println("An error occurred while adding the reservation.");
                e.printStackTrace();
            }
        } catch (SQLException e) {
            out.println("An error occurred while adding the reservation.");
            e.printStackTrace();
        }
    }

	/* Connection con = db.getConnection(); */
    try {
        String query = "SELECT * FROM bookings";
        Statement stmt = con.createStatement();
        ResultSet resultSet = stmt.executeQuery(query);
        try {
%>
            <html>
            <head>
                <title>Flight Reservations</title>
            </head>
            <body>
            
            <a href="CustomerRepHub.jsp">Back to Hub</a>
            

            <h2>List of Reservations</h2>

            <table border="1">
                <tr>
                    <th>Username</th>
                    <th>Flight</th>
                    <th>Edit</th>
                </tr>

                <% while (resultSet.next()) { %>
                    <tr>
                        <td><%= resultSet.getString("username") %></td>
                        <td><%= resultSet.getString("flight") %></td>
                        <td><a href="EditReservation.jsp?username=<%= resultSet.getString("username") %>&flight=<%= resultSet.getString("flight") %>">Edit</a></td>
                    </tr>
                <% } %>
            </table>
            
            <a href='flightReservations.jsp'>Reserve another flight</a>

            </body>
            </html>
<%
        } catch (SQLException e) {
            out.println("An error occurred while retrieving reservations.");
            e.printStackTrace();
        }
    } catch (SQLException e) {
        out.println("An error occurred while retrieving reservations.");
        e.printStackTrace();
    }
%>
