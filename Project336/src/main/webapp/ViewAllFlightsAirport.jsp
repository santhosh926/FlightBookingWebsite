<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>

<%
    String airportID = request.getParameter("airportID");

    if (airportID != null && !airportID.isEmpty()) {
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        try {
            // Retrieve flights departing from the airport
            String departureQuery = "SELECT * FROM flight WHERE departure_airport = ?";
            PreparedStatement departureStmt = con.prepareStatement(departureQuery);
            try {
                departureStmt.setString(1, airportID);
                ResultSet departureResultSet = departureStmt.executeQuery();

                // Retrieve flights arriving at the airport
                String arrivalQuery = "SELECT * FROM flight WHERE arrival_airport = ?";
                PreparedStatement arrivalStmt = con.prepareStatement(arrivalQuery);
                try {
                    arrivalStmt.setString(1, airportID);
                    ResultSet arrivalResultSet = arrivalStmt.executeQuery();
%>
                    <html>
                    <head>
                        <title>All Flights</title>
                    </head>
                    <body>
                    
                    <a href="CustomerRepHub.jsp">Back to Hub</a>
                    

                    <h2>Flights at Airport <%= airportID %></h2>

                    <form method="post" action="AllFlightsForAirport.jsp">
                        <input type="submit" value="Back to Previous Page">
                    </form>

                    <h3>Departing Flights</h3>
                    <table border="1">
                        <tr>
                            <th>Flight Number</th>
                            <th>Airline ID</th>
                            <th>Aircraft ID</th>
                            <th>Departure Time</th>
                            <th>Arrival Time</th>
                            <th>Num Seats</th>
                            <th>Domestic/International</th>
                        </tr>

                        <% while (departureResultSet.next()) { %>
                            <tr>
                                <td><%= departureResultSet.getInt("flight_num") %></td>
                                <td><%= departureResultSet.getString("airlineID") %></td>
                                <td><%= departureResultSet.getString("aircraftID") %></td>
                                <td><%= departureResultSet.getString("departure_time") %></td>
                                <td><%= departureResultSet.getString("arrival_time") %></td>
                                <td><%= departureResultSet.getInt("num_seats") %></td>
                                <td><%= departureResultSet.getString("domestic_or_international") %></td>
                            </tr>
                        <% } %>
                    </table>

                    <h3>Arriving Flights</h3>
                    <table border="1">
                        <tr>
                            <th>Flight Number</th>
                            <th>Airline ID</th>
                            <th>Aircraft ID</th>
                            <th>Departure Time</th>
                            <th>Arrival Time</th>
                            <th>Num Seats</th>
                            <th>Domestic/International</th>
                        </tr>

                        <% while (arrivalResultSet.next()) { %>
                            <tr>
                                <td><%= arrivalResultSet.getInt("flight_num") %></td>
                                <td><%= arrivalResultSet.getString("airlineID") %></td>
                                <td><%= arrivalResultSet.getString("aircraftID") %></td>
                                <td><%= arrivalResultSet.getString("departure_time") %></td>
                                <td><%= arrivalResultSet.getString("arrival_time") %></td>
                                <td><%= arrivalResultSet.getInt("num_seats") %></td>
                                <td><%= arrivalResultSet.getString("domestic_or_international") %></td>
                            </tr>
                        <% } %>
                    </table>

                    </body>
                    </html>
<%
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("An error occurred while retrieving flights at the airport.");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("An error occurred while retrieving flights at the airport.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("An error occurred while retrieving flights at the airport.");
        }
    } else {
        out.println("Invalid or missing airport ID.");
    }
%>
