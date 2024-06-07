<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<style>
    .result-table {
        width: 100%;
        border-collapse: collapse;
    }

    .result-table th, .result-table td {
        border: 1px solid #ddd;
        padding: 8px;
    }

    .result-table th {
        background-color: #f2f2f2;
        text-align: left;
    }

    .result-table tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    
    .delete-button {
        background-color: red;
        color: white;
        border: none;
        padding: 5px 10px;
        cursor: pointer;
    }

    .delete-button:hover {
        background-color: darkred;
    }
</style>
	<meta charset="UTF-8">
	<title>Bookings</title>
</head>
<body>
<h2>Bookings for <%= (String) session.getAttribute("user") %>: </h2>
<% 
	ApplicationDB db = new ApplicationDB();    
	Connection con = db.getConnection();
	
	String n = (String) session.getAttribute("user");
/* 	String s = request.getParameter("bookFlight");
	PreparedStatement ps1 = con.prepareStatement(
			"INSERT INTO bookings (username, flight) VALUES (?, ?)");
	ps1.setString(1, n);
	ps1.setString(2, s);
	ps1.executeUpdate(); */
	
	PreparedStatement ps2 = con.prepareStatement(
			"SELECT flight FROM bookings where username = ?");
	ps2.setString(1, n);
	ResultSet result = ps2.executeQuery();
%>
	<table class="result-table">
    <tr>
        <th>Flights</th>
        <th>Action</th>
    </tr>
    <%
        while (result != null && result.next()) {
    %>
    <tr>
        <td><%= result.getString(1) %></td>
        <td>
           <form action="DeleteBookingServ" method="post">
           	   <input type="hidden" name="username" value="<%= (String) session.getAttribute("user") %>" />
           	   <input type="hidden" name="flightID" value="<%= result.getString("flight") %>">
               <input type="submit" value="Delete" class="delete-button">
           </form>
       </td>
    </tr>
    <%
        }
    %>
</table>
	
<% 	
	con.close();
%>
<a href='flightSearch.jsp'>Back to flight search</a>
</body>
</html>