<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
    	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    	<title>Flight Reservations</title>
	</head>
	<body>

    	Enter customer's information:
    	
    	<br>

    	<form method="post" action="reservation.jsp">
    	
            	
        	<label for="username">Username: </label>
        	<input type="text" id="username" name="username" required><br>
        	
        	<label for="flight">Flight: </label>
        	<input type="text" id="flight" name="flight" required><br>

           	<br>

        	<input type="submit" value="Reserve">
    	</form>
	</body>
</html>
 
