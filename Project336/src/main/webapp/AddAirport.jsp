<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="com.cs336.pkg.Airport"%>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String airportId = request.getParameter("airportId");

        Airport newAirport = new Airport(airportId);

        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        
        try {
            String insertQuery = "INSERT INTO Airport (airportId) VALUES (?)";
            PreparedStatement preparedStatement = con.prepareStatement(insertQuery);
            preparedStatement.setString(1, newAirport.getAirportId());

            int rows = preparedStatement.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("viewAirports.jsp");
            } else {
                out.println("Failed to add new airport.");
            }
        }
        catch (SQLException e) {
            out.println("An error occurred while adding the new airport.");
            e.printStackTrace();
        }
    }
%>

<html>
<head>
    <title>Add New Airport</title>
</head>
<body>

<h2>Add New Airport</h2>

<form method="post" action="AddAirport.jsp">
    <label for="airportId">Airport ID:</label>
    <input type="text" id="airportId" name="airportId" required><br>

    <input type="submit" value="Add Airport">
</form>

</body>
</html>
