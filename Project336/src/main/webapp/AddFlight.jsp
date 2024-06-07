<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="com.cs336.pkg.Flight"%>
<%@ page import="com.cs336.pkg.Flight"%>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
    	int flightNum = Integer.parseInt(request.getParameter("flightNum"));
        String airlineId = request.getParameter("airlineId");
        String aircraftId = request.getParameter("aircraftId");
        String departureTime = request.getParameter("departureTime");
        String arrivalTime = request.getParameter("arrivalTime");
        String airportIdFrom = request.getParameter("departure_airport");
        String airportIdTo = request.getParameter("arrival_airport");
        String domesticOrInternational = request.getParameter("domesticOrInternational");

        Flight newFlight = new Flight(flightNum, airlineId, aircraftId, departureTime, arrivalTime, airportIdFrom, airportIdTo, domesticOrInternational);

        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        try {
            String insertQuery = "INSERT INTO Flight (flight_num, airlineId, aircraftId, departure_time, arrival_time, departure_airport, arrival_airport, domestic_or_international) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement preparedStatement = con.prepareStatement(insertQuery);
            try {
            	preparedStatement.setInt(1, newFlight.getFlightNum());
            	preparedStatement.setString(2, newFlight.getAirlineId());
                preparedStatement.setString(3, newFlight.getAircraftId());
                preparedStatement.setString(4, newFlight.getDepartureTime());
                preparedStatement.setString(5, newFlight.getArrivalTime());
                preparedStatement.setString(6, newFlight.getAirportIdFrom());
                preparedStatement.setString(7, newFlight.getAirportIdTo());
                preparedStatement.setString(8, newFlight.getDomesticOrInternational());

                out.println("Hello");
                
                int rows = preparedStatement.executeUpdate();

                if (rows > 0) {
                    response.sendRedirect("viewFlights.jsp");
                } else {
                    out.println("Failed to add new flight.");
                }
            } catch (SQLException e) {
                out.println("An error occurred while adding the new flight.");
                e.printStackTrace();
            }
        } catch (SQLException e) {
            out.println("An error occurred while adding the new flight.");
            e.printStackTrace();
        }
    }
%>

<html>
<head>
    <title>Add New Flight</title>
</head>
<body>

<h2>Add New Flight</h2>

<form method="post" action="AddFlight.jsp">
    <label for="flightNum">Flight Number:</label>
    <input type="text" id="flightNum" name="flightNum" required><br>
    
    <label for="airlineId">Airline ID:</label>
    <input type="text" id="airlineId" name="airlineId" required><br>

    <label for="aircraftId">Aircraft ID:</label>
    <input type="text" id="aircraftId" name="aircraftId" required><br>

    <label for="departureTime">Departure Time:</label>
    <input type="datetime-local" id="departureTime" name="departureTime" required><br>

    <label for="arrivalTime">Arrival Time:</label>
    <input type="datetime-local" id="arrivalTime" name="arrivalTime" required><br>

    <label for="departure_airport">Airport ID From:</label>
    <input type="text" id="departure_airport" name="departure_airport" required><br>
    
    <label for="arrival_airport">Airport ID To:</label>
    <input type="text" id="arrival_airport" name="arrival_airport" required><br>

    <label for="domesticOrInternational">Domestic/International:</label>
    <input type="text" id="domesticOrInternational" name="domesticOrInternational" required><br>

    <input type="submit" value="Add Flight">
</form>

</body>
</html>
