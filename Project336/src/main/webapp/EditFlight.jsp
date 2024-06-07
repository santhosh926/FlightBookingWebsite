<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>
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
        Flight flight = new Flight(flightNum, airlineId, aircraftId, departureTime, arrivalTime, airportIdFrom, airportIdTo, domesticOrInternational);
        
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        try {
            String updateQuery = "UPDATE Flight SET aircraftId=?, departure_time=?, arrival_time=?, departure_airport=?, arrival_airport=?, domestic_or_international=? WHERE flight_num=? AND airlineId=?";
            PreparedStatement preparedStatement = con.prepareStatement(updateQuery);
            try {
                preparedStatement.setString(1, flight.getAircraftId());
                preparedStatement.setString(2, flight.getDepartureTime());
                preparedStatement.setString(3, flight.getArrivalTime());
                preparedStatement.setString(4, flight.getAirportIdFrom());
                preparedStatement.setString(5, flight.getAirportIdTo());
                preparedStatement.setString(6, flight.getDomesticOrInternational());
                preparedStatement.setInt(7, flight.getFlightNum());
                preparedStatement.setString(8, flight.getAirlineId());

                int rows = preparedStatement.executeUpdate();

                if (rows > 0) {
                    response.sendRedirect("viewFlights.jsp");
                } else {
                    out.println("Failed to edit the flight.");
                }
            } catch (SQLException e) {
                out.println("An error occurred while editing the flight.");
                e.printStackTrace();
            }
        } catch (SQLException e) {
            out.println("An error occurred while editing the flight.");
            e.printStackTrace();
        }
    }
%>

<html>
<head>
    <title>Edit Flight</title>
</head>
<body>

<h2>Edit Flight</h2>

<form method="post" action="EditFlight.jsp">
    <input type="hidden" name="flightNum" value="<%= request.getParameter("flightNum") %>">
    <input type="hidden" name="airlineId" value="<%= request.getParameter("airlineId") %>">
        
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
    
    <input type="submit" value="Update Flight">
</form>

</body>
</html>
