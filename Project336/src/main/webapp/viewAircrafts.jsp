<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="com.cs336.pkg.Aircraft"%>
<%@ page import="com.cs336.pkg.Airport"%>
<%@ page import="com.cs336.pkg.Flight"%>

<%
    //Establish a database connection and create an SQL statement
    ApplicationDB db = new ApplicationDB();    
	Connection con = db.getConnection();
	Statement stmt = con.createStatement(); 
	
	List<Aircraft> aircraftList = new ArrayList<Aircraft>();
     
	
    try {
        //Retrieve aircrafts list from database
        
       	String query = "SELECT * FROM Aircraft";
       	ResultSet resultSet = stmt.executeQuery(query);
        try {
            while (resultSet.next()) {
                String aircraftId = resultSet.getString("aircraftId");
                String airlineId = resultSet.getString("airlineId");
                int numSeats = resultSet.getInt("num_seats");
                String operateDaysString = resultSet.getString("operate_days");
                Set<String> operateDays = new HashSet<String>(Arrays.asList(operateDaysString.split(",")));

                Aircraft aircraft = new Aircraft(aircraftId, airlineId, numSeats, operateDays);
                aircraftList.add(aircraft);
            }
        } catch (SQLException e) {
            out.println("An error occurred while adding the new airport.");
            e.printStackTrace();
        }
    } catch (SQLException e) {
        out.println("An error occurred while adding the new airport.");
        e.printStackTrace();
    }

%>
        <html>
        <head>
            <title>View Aircrafts</title>
        </head>
        <body>
        
        <a href="CustomerRepHub.jsp">Back to Hub</a>
        

        <h2>List of Aircrafts</h2>
        
        <a href="AddAircraft.jsp">Add New Aircraft</a>

        <table border="1">
            <tr>
                <th>Aircraft ID</th>
                <th>Airline ID</th>
                <th>Number of Seats</th>
                <th>Operate Days</th>
                <th>Delete</th>
                <th>Edit</th>
            </tr>

            <% if (aircraftList != null && !aircraftList.isEmpty()) {
                for (Aircraft aircraft : aircraftList) { %>
                    <tr>
                        <td><%= aircraft.getAircraftId() %></td>
                        <td><%= aircraft.getAirlineId() %></td>
                        <td><%= aircraft.getNumSeats() %></td>
                        <td><%= aircraft.getOperateDays() %></td>
               			<td>
                    		<form method="post" action="DeleteAircraft.jsp">
                        	<input type="hidden" name="aircraftId" value="<%= aircraft.getAircraftId() %>">
                        	<input type="submit" value="Delete">
                    		</form>
                		</td>
                		<td>
                    		<form method="get" action="EditAircraft.jsp">
                        	<input type="hidden" name="aircraftId" value="<%= aircraft.getAircraftId() %>">
                        	<input type="hidden" name="airlineId" value="<%= aircraft.getAirlineId() %>">
                        	<input type="hidden" name="numSeats" value="<%= aircraft.getNumSeats() %>">
                        	<input type="hidden" name="operateDays" value="<%= aircraft.getOperateDays() %>">
                        	<input type="submit" value="Edit">
                    		</form>
                		</td>
                    </tr>
                <% }
            } else { %>
                <tr>
                    <td colspan="6">No aircraft data available.</td>
                </tr>
            <% } %>
        </table>

        </body>
        </html>
<%
    /* } catch (SQLException e) {
        out.println("An error occurred while retrieving aircraft information.");
    	e.printStackTrace();
    } */
%>
