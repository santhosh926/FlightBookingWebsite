<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.Duration" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>One Way Flights Available</title>
</head>
<body>

	Round Trip Flights Available:
	
	<a href='roundTripSearch.jsp'>Not seeing what you want? Try changing search preferences</a>
	
	<%!
		private List<String> getDates(String str, int flexibility) {
			if (str == null || str.equals("")) return null;
		
			List<String> dates = new ArrayList<String>();	
		
			if(flexibility == 0) {
				dates.add(str);
				return dates;
			}
			
			LocalDate date = LocalDate.parse(str);
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

	        // Iterate through x days and add formatted dates to the list
	        for (int i = -flexibility; i <= flexibility; i++) {
	            LocalDate currentDate = date.plusDays(i);
	            dates.add(currentDate.format(formatter));
	        }

	        return dates;
		}
	
	
		private List<String> getSqlVals(Statement stmt, String column) {
			List<String> list = new ArrayList<String>();

			String airlinesQuery = "SELECT DISTINCT " + column +
			                        " FROM flight f " +
			                        "JOIN ticket_flight tf ON f.flight_num = tf.flight_num " +
			                        "JOIN ticket t ON tf.ticket_num = t.ticket_num ";

			try {
				ResultSet result = stmt.executeQuery(airlinesQuery);
				while (result.next()) {
			        String airlineID = result.getString("airlineID");
			        list.add(airlineID);
			    }
				return list;
			} catch (SQLException e) {
			    e.printStackTrace();
			    list.add(" ");
			    return list;
			} 
		}
		
		void printFlightTable(ResultSet result, JspWriter out) {
			try{
				//Make an HTML table to show the results in:
				out.print("<table>");
		
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print("Airline");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Flight Num");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Departing From");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Arriving At");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Price");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Take Off Time");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Landing Time");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Duration of Flight ");
				out.print("</td>");		
				out.print("</tr>");
		
				//parse out the results
				while (result != null && result.next()) {
					//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out airlineID:
					out.print(result.getString("airlineID"));
					out.print("</td>");
					out.print("<td>");
					
					//Print out airlineID:
					out.print(result.getString("flight_num"));
					out.print("</td>");
					out.print("<td>");
					
					//Print out Departing Airport:
					out.print(result.getString("departure_airport"));
					out.print("</td>");
					out.print("<td>");
					
					//Print out Arrival Airport
					out.print(result.getString("arrival_airport"));
					out.print("</td>");
					out.print("<td>");
					
					//Print out Price
					out.print(result.getString("price"));
					out.print("</td>");
					out.print("<td>");
					
					//Print out Take Off Time
					out.print(result.getString("departure_time"));
					out.print("</td>");
					out.print("<td>");
					
					//Print out Arrival Time
					out.print(result.getString("arrival_time")); 
					out.print("</td>");
					out.print("<td>");
					
					//Print out Total Time
					out.print(result.getString("total_time"));
					out.print("</td>");
					out.print("</tr>");
		
				}
				out.print("</table>");
			} catch (Exception e) {
	            e.printStackTrace();
	        }
			
		}
		
		void filterAndPrintFlights(Connection con, String start, String destination, String departure,
	        String arrival, int flexibility, List<String> dates, List<String> airlines, String flightStart, String flightEnd, boolean initialFlight,
	        String priceLower, String priceUpper, String sort, JspWriter out) {
	        // Initial Flight
            String sql = "SELECT *, " +
                    "TIME_FORMAT(TIMEDIFF(f.arrival_time, f.departure_time), '%H:%i') AS total_time " + 
                    "FROM flight f " +
                    "JOIN ticket_flight tf ON f.flight_num = tf.flight_num " +
                    "JOIN ticket t ON tf.ticket_num = t.ticket_num " +
                    "WHERE f.num_seats > 0 AND f.departure_airport = ? AND f.arrival_airport = ? AND DATE(f.departure_time) IN (";

            for (int i = 0; i < dates.size(); i++) {
                if (i > 0) {
                    sql += ",";
                }
                sql += " ?";
            }
            sql += ") ";

            // Add additional conditions based on selected filters
            if (airlines != null && !airlines.isEmpty()) {
                sql += " AND f.airlineID IN (";
                for (int i = 0; i < airlines.size(); i++) {
                    if (i > 0) {
                        sql += ",";
                    }
                    sql += " ?";
                }
                sql += ")";
            }

            if (flightStart != null && !flightStart.isEmpty() && flightEnd != null && !flightEnd.isEmpty()) {
                if (initialFlight)
            		sql += " AND TIME(f.departure_time) BETWEEN ? AND ? ";
                else
                	sql += " AND TIME(f.arrival_time) BETWEEN ? AND ? ";
            }

            
            if (priceLower != null && !priceLower.isEmpty() && priceUpper != null && !priceUpper.isEmpty()) {
            	sql += " AND t.price BETWEEN ? AND ? ";
            }
            
            
            
            sql += sort;

            try {
            
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setString(1, start);
	            ps.setString(2, destination);
	
	            int paramIndex = 3;
	
	            for (int i = 0; i < dates.size(); i++) {
	                String dateStr = dates.get(i);
	                if (dateStr != null && !dateStr.isEmpty()) {
	                    ps.setString(paramIndex++, dateStr);
	                }
	            }
	
	            // Set parameters for additional filters
	            if (airlines != null && !airlines.isEmpty()) {
	                for (String airline : airlines) {
	                    ps.setString(paramIndex++, airline);
	                }
	            }
	            
	            if (flightStart != null && !flightStart.isEmpty() && flightEnd != null && !flightEnd.isEmpty()) {
	            	ps.setString(paramIndex++, flightStart);
	            	ps.setString(paramIndex++, flightEnd);
	            }
	            
	            if (priceLower != null && !priceLower.isEmpty() && priceUpper != null && !priceUpper.isEmpty()) {
	            	ps.setString(paramIndex++, priceLower);
	            	ps.setString(paramIndex++, priceUpper);
	            }
	
	            ResultSet result = ps.executeQuery();
	            
	            printFlightTable(result, out);
            
            } catch (Exception e) {
	            e.printStackTrace();
	        }
	        
	    }
		
		
	%>
	
	<%
		// Get Parameters
		String start = request.getParameter("start");
		String destination = request.getParameter("destination");
		String departure = request.getParameter("startDate");
		String arrival = request.getParameter("returnDate");
		String sort = request.getParameter("sort");
		
		int flexibility = Integer.parseInt(request.getParameter("flexibility"));
		
		String[] selectedAirlines = request.getParameterValues("airlines");
		List<String> airlines = (selectedAirlines != null) ? Arrays.asList(selectedAirlines) : null;
		
		String takeOffStart = request.getParameter("takeoffStartDate");
		String takeOffEnd = request.getParameter("takeoffEndDate");
		String landingStart = request.getParameter("landingStartDate");
		String landingEnd = request.getParameter("landingEndDate");
		
		String priceLower = request.getParameter("lowerPrice");
		String priceUpper = request.getParameter("upperPrice");
		
		List<String> departures = getDates(departure, flexibility);
		List<String> arrivals = getDates(arrival, flexibility);
		
		//try {
			// Get the database connection
            ApplicationDB db = new ApplicationDB();    
            Connection con = db.getConnection();        
        
            // Create a SQL statement
            Statement stmt = con.createStatement();
            
         	// Initial Flight
            filterAndPrintFlights(con, start, destination, departure, arrival, flexibility, departures, airlines,
                    takeOffStart, takeOffEnd, true, priceLower, priceUpper, sort, out);

            // Return flight
            filterAndPrintFlights(con, destination, start, departure, arrival, flexibility, arrivals, airlines,
                    takeOffStart, takeOffEnd, false, priceLower, priceUpper, sort, out);
            
           // Insert
	
			List<String> airlineList = getSqlVals(stmt, "f.airlineID");
			List<String> takeOffTimes = getSqlVals(stmt, "f.departure_time");
			List<String> arrivalTimes = getSqlVals(stmt, "f.arrival_time");
			
			//close the connection.
			con.close();
			
			//} catch (Exception e) {
			//}
	%>
	
	<form method="post" action="RTBookingServ">
		<label for="takeoffEndDate">Enter the airlineId and flight number of the initial flight you want to book (EX: AA420):</label>
        <input type="hidden" name="username" value="<%= (String) session.getAttribute("user") %>" />
        <input type="text" name="bookInitialFlight" required>
        <br>
        
        <label for="takeoffEndDate">Enter the airlineId and flight number of the return flight you want to book (EX: AA420):</label>
        <input type="text" name="bookReturnFlight" required>
        <br>
        
        <input type="submit" value="Book">
	</form>
	
	Or you can re-filter/sort by additional parameters:
    <br>
    <br>
    
    <form method="post" action="roundTripResults.jsp">
    	<input type="hidden" name="start" value="<%= start %>">
	    <input type="hidden" name="destination" value="<%= destination %>">
	    <input type="hidden" name="startDate" value="<%= departure %>">
	    <input type="hidden" name="returnDate" value="<%= arrival %>">
	    <input type="hidden" name="flexibility" value="<%= flexibility %>">
	    
        <label for="airlines">Select Airlines:</label>
		<%
			if (!airlineList.isEmpty() && airlineList != null) {
				for (String airline : airlineList) {
		%>
				    <input type="checkbox" name="airlines" value="<%= airline %>" id="<%= airline %>">
				    <label for="<%= airline %>"><%= airline %></label>
		<%
				}
			}
		%>
		<br>
		
		<label for="takeoffStartDate">Departure Start Date (hh:mm:ss):</label>
        <input type="text" name="takeoffStartDate">
        <label for="takeoffEndDate">Departure End Date (hh:mm:ss):</label>
        <input type="text" name="takeoffEndDate">
        <br>
        
        <label for="landingStartDate">Return Start Date (hh:mm:ss):</label>
        <input type="text" name="landingStartDate">
        <label for="landingEndDate">Return End Date (hh:mm:ss):</label>
        <input type="text" name="landingEndDate">
        <br>
        
        <label for="price">Enter Price Range. This is the price range for each flight, not total cost:</label> 
        <label for="price">Lower: $</label>
        <input type="text" name="lowerPrice">
        <label for="price">Upper: $</label>
        <input type="text" name="upperPrice">
        <br>
        
        
        How should we sort the results?
        <br>
        <input type="radio" name="sort" value="ORDER BY f.flight_num" required/> No Sort
		<br> 
		<input type="radio" name="sort" value="ORDER BY t.price" required/> Sort by Price
		<br>
		<input type="radio" name="sort" value="ORDER BY f.departure_time" required/> Sort by Take Off Time
		<br>
		<input type="radio" name="sort" value="ORDER BY f.arrival_time" required/> Sort by Landing Time
		<br>
		<input type="radio" name="sort" value="ORDER BY total_time" required/> Sort by Duration of Flight
		<br>
		<br>
        
        <input type="submit" value="Filter">
    </form>

</body>
</html>