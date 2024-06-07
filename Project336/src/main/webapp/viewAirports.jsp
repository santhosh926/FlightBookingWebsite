<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="com.cs336.pkg.Aircraft"%>
<%@ page import="com.cs336.pkg.Airport"%>
<%@ page import="com.cs336.pkg.Flight"%>


<%
    ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
			
    try {
        List<Airport> airportList = new ArrayList<Airport>();
        String query = "SELECT * FROM Airport";
        Statement stmt = con.createStatement();
        ResultSet resultSet = stmt.executeQuery(query);
        try {
            while (resultSet.next()) {
                String airportId = resultSet.getString("airportId");

                Airport airport = new Airport(airportId);
                airportList.add(airport);
            }
        } catch (SQLException e) {
            out.println("An error occurred while retrieving airport information.");
            e.printStackTrace();
        }
%>
        <html>
        <head>
            <title>View Airports</title>
        </head>
        <body>
        
        <a href="CustomerRepHub.jsp">Back to Hub</a>
        

        <h2>List of Airports</h2>
        
        <a href="AddAirport.jsp">Add New Airport</a>

        <table border="1">
            <tr>
                <th>Airport ID</th>
        		<th>Delete</th>
            </tr>

            <% if (airportList != null && !airportList.isEmpty()) {
                for (Airport airport : airportList) { %>
                    <tr>
                        <td><%= airport.getAirportId() %></td>
                        <td>
                    		<form method="post" action="DeleteAirport.jsp">
                        	<input type="hidden" name="airportId" value="<%= airport.getAirportId() %>">
                        	<input type="submit" value="Delete">
                    		</form>
                		</td>
                    </tr>
                <% }
            } else { %>
                <tr>
                    <td colspan="2">No airport data available.</td>
                </tr>
            <% } %>
        </table>

        </body>
        </html>
<%
    } catch (SQLException e) {
        out.println("An error occurred while retrieving airport information.");
        e.printStackTrace();
    }
%>
