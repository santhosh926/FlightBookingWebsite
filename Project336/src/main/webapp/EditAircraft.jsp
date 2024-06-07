<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="com.cs336.pkg.Aircraft"%>
<%@ page import="java.util.Set" %>


<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
    	String aircraftId = request.getParameter("aircraftId");
        String airlineId = request.getParameter("airlineId");
        int updatedNumSeats = Integer.parseInt(request.getParameter("numSeats"));
        String[] newOperateDaysArr = request.getParameterValues("days");
        Set<String> updatedOperateDays = (newOperateDaysArr != null) ? new HashSet<String>(Arrays.asList(newOperateDaysArr)) : null;
        Aircraft updatedAircraft = new Aircraft(aircraftId, airlineId, updatedNumSeats, updatedOperateDays);

        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        try {
            String updateQuery = "UPDATE Aircraft SET num_seats=?, operate_days=? WHERE aircraftId=? AND airlineId=?";
            PreparedStatement preparedStatement = con.prepareStatement(updateQuery);
            try {
                preparedStatement.setInt(1, updatedAircraft.getNumSeats());
                preparedStatement.setString(2, String.join(",", updatedOperateDays));
                preparedStatement.setString(3, updatedAircraft.getAircraftId());
                preparedStatement.setString(4, updatedAircraft.getAirlineId());

                int rows = preparedStatement.executeUpdate();

                if (rows > 0) {
                	response.sendRedirect("viewAircrafts.jsp");
                } else {
                    out.println("Failed to edit the aircraft.");
                }
            } catch (SQLException e) {
                out.println("An error occurred while editing the aircraft.");
                e.printStackTrace();
            }
        } catch (SQLException e) {
            out.println("An error occurred while editing the aircraft.");
            e.printStackTrace();
        }
    }

%>

<html>
<head>
    <title>Edit Aircraft</title>
</head>
<body>

<h2>Edit Aircraft</h2>

<form method="post" action="EditAircraft.jsp">

    <input type="hidden" name="aircraftId" value="<%= request.getParameter("aircraftId") %>">
    <input type="hidden" name="airlineId" value="<%= request.getParameter("airlineId") %>">
    
    <label for="numSeats">Number of Seats:</label>
    <input type="number" id="numSeats" name="numSeats" required><br>

    <label for="operate_days">Operate Days:</label>
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

    <input type="submit" value="Update Aircraft">
</form>

</body>
</html>
