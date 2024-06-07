<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>View All Flights For Airport</title>
</head>
<body>

    <h2>View Flights by Airport</h2>

    <form method="get" action="ViewAllFlightsAirport.jsp">
        <label for="airportID">Enter Airport ID:</label>
        <input type="text" id="airportID" name="airportID" required>
        <input type="submit" value="View Flights">
    </form>

</body>
</html>
