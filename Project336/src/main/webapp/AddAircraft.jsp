<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="com.cs336.pkg.Aircraft"%>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Set" %>
<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String aircraftId = request.getParameter("aircraftId");
        String airlineId = request.getParameter("airlineId");
        int numSeats = Integer.parseInt(request.getParameter("numSeats"));
        // String operateDaysString = request.getParameter("operate_days");
        //List<String> operateDaysList = (selectedAirlines != null) ? Arrays.asList(selectedAirlines) : null;
        String[] operateDaysArr = request.getParameterValues("days");
        Set<String> operateDays = (operateDaysArr != null) ? new HashSet<String>(Arrays.asList(operateDaysArr)) : null;

        Aircraft newAircraft = new Aircraft(aircraftId, airlineId, numSeats, operateDays);

        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        try {
            String insertQuery = "INSERT INTO Aircraft (aircraftId, airlineId, num_seats, operate_days) VALUES (?, ?, ?, ?)";
            PreparedStatement preparedStatement = con.prepareStatement(insertQuery);
            try {
                preparedStatement.setString(1, newAircraft.getAircraftId());
                preparedStatement.setString(2, newAircraft.getAirlineId());
                preparedStatement.setInt(3, newAircraft.getNumSeats());
                preparedStatement.setString(4, String.join(",", operateDays));

                int rows = preparedStatement.executeUpdate();

                if (rows > 0) {
                    response.sendRedirect("viewAircrafts.jsp");
                } else {
                    out.println("Failed to add new aircraft.");
                }
            } catch (SQLException e) {
                out.println("An error occurred while adding the new aircraft.");
                e.printStackTrace();
            }
        } catch (SQLException e) {
            out.println("An error occurred while adding the new aircraft.");
            e.printStackTrace();
        }
    }
%>

<html>
<head>
    <title>Add New Aircraft</title>
</head>
<body>

<h2>Add New Aircraft</h2>

<form method="post" action="AddAircraft.jsp">
    <label for="aircraftId">Aircraft ID:</label>
    <input type="text" id="aircraftId" name="aircraftId" required><br>

    <label for="airlineId">Airline ID:</label>
    <input type="text" id="airlineId" name="airlineId" required><br>

    <label for="numSeats">Number of Seats:</label>
    <input type="number" id="numSeats" name="numSeats" required><br>

    <label for="operate_days">Operate Days:</label>
    <!-- <input type="text" id="operate_days" name="operate_days" required><br> -->
    <input type="checkbox" name="days" value="Monday">
    <label for="Monday">Monday</label>
    <input type="checkbox" name="days" value="Tuesday">
    <label for="Tuesday">Tuesday</label>
    <input type="checkbox" name="days" value="Wednesday">
    <label for="Wednesday">Wednesday</label>
    <input type="checkbox" name="days" value="Thursday">
    <label for="Thursday">Thursday</label>
    <input type="checkbox" name="days" value="Friday">
    <label for="Friday">Friday</label>
    <input type="checkbox" name="days" value="Saturday">
    <label for="Saturday">Saturday</label>
    <input type="checkbox" name="days" value="Sunday">
    <label for="Sunday">Sunday</label>

    <input type="submit" value="Add Aircraft">
</form>

</body>
</html>
