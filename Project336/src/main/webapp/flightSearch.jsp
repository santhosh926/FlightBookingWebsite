<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Search for Flights</title>
	</head>
	<body>
	
		Are you flying one way or round trip?:
	
		<br>
	
		<form method="post" action="oneWaySearch.jsp">
        	
        	<input type="submit" value="I'm Flying One Way" />
			
		</form>
		
		<form method="post" action="roundTripSearch.jsp">
        	
        	<input type="submit" value="I'm Flying RoundTrip" />
			
		</form>
		
		<form method="post" action="customer.jsp">
        	
        	<input type="submit" value="Go home" />
			
		</form>
	
	<a href='bookings.jsp'>View your reservations</a>
	<br>
	<a href='faq.jsp'>Confused? Check out our FAQ page!</a>
	</body>
</html>