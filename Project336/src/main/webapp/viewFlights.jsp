<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Time" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="com.cs336.pkg.Aircraft"%>
<%@ page import="com.cs336.pkg.Airport"%>
<%@ page import="com.cs336.pkg.Flight"%>

<%
    ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

    try {
        List<Flight> flightList = new ArrayList<Flight>();
        String query = "SELECT * FROM Flight";
        Statement stmt = con.createStatement();
        ResultSet resultSet = stmt.executeQuery(query);
        try {
            while (resultSet.next()) {
                int flightNum = resultSet.getInt("flight_num");
                String airlineId = resultSet.getString("airlineId");
                String aircraftId = resultSet.getString("aircraftId");
                String departureTime = resultSet.getString("departure_time"); // change to datetime
                String arrivalTime = resultSet.getString("arrival_time"); // change to datetime
                String airportIdFrom = resultSet.getString("departure_airport");
                String airportIdTo = resultSet.getString("arrival_airport");
                String domesticOrInternational = resultSet.getString("domestic_or_international");

                Flight flight = new Flight(flightNum, airlineId, aircraftId, departureTime, arrivalTime, airportIdFrom, airportIdTo, domesticOrInternational);
                flightList.add(flight);
            }
        } catch (SQLException e) {
            out.println("An error occurred while retrieving flight information.");
            e.printStackTrace();
        }

%>
        <html>
        <head>
            <title>View Flights</title>
        </head>
        <body>
        
        <a href="CustomerRepHub.jsp">Back to Hub</a>
        

        <h2>List of Flights</h2>
        
        <a href="AddFlight.jsp">Add New Flight</a>

        <table border="1">
            <tr>
                <th>Flight Number</th>
                <th>Airline ID</th>
                <th>Aircraft ID</th>
                <th>Departure Time</th>
                <th>Arrival Time</th>
                <th>Airport ID From</th>
                <th>Airport ID To</th>
                <th>Domestic/International</th>
                <th>Delete</th>
                <th>Edit</th>
            </tr>

            <% if (flightList != null && !flightList.isEmpty()) {
                for (Flight flight : flightList) { %>
                    <tr>
                        <td><%= flight.getFlightNum() %></td>
                        <td><%= flight.getAirlineId() %></td>
                        <td><%= flight.getAircraftId() %></td>
                        <td><%= flight.getDepartureTime() %></td>
                        <td><%= flight.getArrivalTime() %></td>
                        <td><%= flight.getAirportIdFrom() %></td>
                        <td><%= flight.getAirportIdTo() %></td>
                        <td><%= flight.getDomesticOrInternational() %></td>
                        <td>
                    		<form method="post" action="DeleteFlight.jsp">
                        	<input type="hidden" name="flightNum" value="<%= flight.getFlightNum() %>">
                        	<input type="submit" value="Delete">
                    		</form>
                		</td>
                		<td>
                    		<form method="get" action="EditFlight.jsp">
                        	<input type="hidden" name="flightNum" value="<%= flight.getFlightNum() %>">
                        	<input type="hidden" name="airlineId" value="<%= flight.getAirlineId() %>">
                        	<input type="hidden" name="aircraftId" value="<%= flight.getAircraftId() %>">
                        	<input type="hidden" name="departureTime" value="<%= flight.getDepartureTime() %>">
                        	<input type="hidden" name="arrivalTime" value="<%= flight.getArrivalTime() %>">
                        	<input type="hidden" name="airportIdFrom" value="<%= flight.getAirportIdFrom() %>">
                        	<input type="hidden" name="airportIdTo" value="<%= flight.getAirportIdTo() %>">
                        	<input type="hidden" name="domesticOrInternational" value="<%= flight.getDomesticOrInternational() %>">
                        	<input type="submit" value="Edit">
                    		</form>
                		</td>
                    </tr>
                <% }
            } else { %>
                <tr>
                    <td colspan="10">No flight data available.</td>
                </tr>
            <% } %>
        </table>

        </body>
        </html>
<%
    } catch (SQLException e) {
        out.println("An error occurred while retrieving flight information.");
        e.printStackTrace();
    }
%>
