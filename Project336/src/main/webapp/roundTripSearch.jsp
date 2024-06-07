<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Search for FLights</title>
	</head>
	<body>
	
		Enter Your Flight Information:
	
		<br>
	
		<form method="post" action="roundTripResults.jsp">
	
			<!--  One way or Round Trip? -->
			<!-- <input type="radio" name="type" value="one-way" required/> One Way Flight
			<br> 
			<input type="radio" name="type" value="round-trip" required/> Round Trip
			<br>
			<br> -->
			
			Enter Airport IDs: 
			<table>
				<tr>    
					<td>Start</td><td><input type="text" name="start" required></td>
				</tr>
				<tr>
					<td>Destination</td><td><input type="text" name="destination" required></td>
				</tr>
			</table>
			
			Enter Departure Date (The date the initial flight should take off)
			<input type="date" name="startDate" required>
        	<br>
        	
        	Enter Return Date (The date the return flight should land)
        	<input type="date" name="returnDate" required>
        	<br> 
			
			How many days are you flexible with?
			<input type="number" name="flexibility" min="0" max="3" value="0" required>
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
        	
        	<input type="submit" value="Search" />
			
		</form>
		
		<form method="post" action="oneWaySearch.jsp">
			<br>
			<br>
			<input type="submit" value="Switch to One Way" />
		</form>
	
	
	</body>
</html>