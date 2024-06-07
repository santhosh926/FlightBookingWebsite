<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>


<%-- <html>
<head>
    <title>Customer List</title>
</head>
<body>
    <h2>Customer List</h2>
    <form action="AddUser.jsp">
        <input type="submit" value="Add New Customer/Representative" />
    </form>
    <table border="1">
        <tr>
            <th>Username</th>
            <th>Password</th>
            <th>Account Type</th>
            <th>Actions</th>
        </tr>
        <%
        Statement stmt = null;
        ResultSet rs = null;
        Connection con = null; // Declare con here
        try {
            ApplicationDB db = new ApplicationDB();    
            con = db.getConnection(); // Initialize con
            stmt = con.createStatement();
            String sql = "SELECT username, password, account_type FROM user";
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                String username = rs.getString("username");
                String password = rs.getString("password");
                String accountType = rs.getString("account_type");

                out.println("<tr><td>" + username + "</td><td>" + password + "</td><td>" + accountType + "</td>");
                out.println("<td><a href='EditUser.jsp?username=" + username + "'>Edit</a> | ");
                out.println("<a href='DeleteUserServ?username=" + username + "'>Delete</a></td></tr>");
            }
        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (stmt != null) {
                try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (con != null) {
                try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        %>
    </table>
</body>
</html> --%>




<%-- <html>
<head>
    <title>Admin Home</title>
</head>
<body>
    <h2>Customer List</h2>
    <form action="AddUser.jsp">
        <input type="submit" value="Add New Customer/Representative" />
    </form>

    <!-- Existing User Table -->
    <h3>Users</h3>
    <table border="1">
        <tr>
            <th>Username</th>
            <th>Password</th>
            <th>Account Type</th>
            <th>Actions</th>
        </tr>
        <%
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            ApplicationDB db = new ApplicationDB();    
            con = db.getConnection();
            stmt = con.createStatement();
            String sql = "SELECT username, password, account_type FROM user";
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                String username = rs.getString("username");
                String password = rs.getString("password");
                String accountType = rs.getString("account_type");

                out.println("<tr><td>" + username + "</td><td>" + password + "</td><td>" + accountType + "</td>");
                out.println("<td><a href='EditUser.jsp?username=" + username + "'>Edit</a> | ");
                out.println("<a href='DeleteUserServ?username=" + username + "'>Delete</a></td></tr>");
            }
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        %>
    </table>

    <!-- Search Form for Bookings -->
    <h3>Search Bookings</h3>
    <form method="get">
        <label for="searchBy">Search By:</label>
        <select name="searchBy" id="searchBy">
            <option value="username">Username</option>
            <option value="flight">Flight Number</option>
        </select>
        <input type="text" name="searchTerm" required>
        <input type="submit" value="Search">
    </form>

    <!-- Bookings Table -->
    <h3>Bookings</h3>
    <table border="1">
        <tr>
            <th>Username</th>
            <th>Flight Number</th>
        </tr>
        <%
        String searchBy = request.getParameter("searchBy");
        String searchTerm = request.getParameter("searchTerm");
        if (searchBy != null && searchTerm != null && !searchTerm.trim().isEmpty()) {
            PreparedStatement pstmt = null;
            ResultSet rs2 = null;
            try {
                ApplicationDB db = new ApplicationDB();    
                con = db.getConnection();
                String query = "SELECT username, flight FROM bookings WHERE " + searchBy + " = ?";
                pstmt = con.prepareStatement(query);
                pstmt.setString(1, searchTerm);
                rs2 = pstmt.executeQuery();

                while (rs2.next()) {
                    out.println("<tr><td>" + rs2.getString("username") + "</td><td>" + rs2.getString("flight") + "</td></tr>");
                }
            } catch (SQLException se) {
                se.printStackTrace();
            } finally {
                if (rs2 != null) try { rs2.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        %>
    </table>
</body>
</html> --%>





<html>
<head>
    <title>Admin Home</title>
</head>
<body>
    <h2>Customer List</h2>
    <form action="AddUser.jsp">
        <input type="submit" value="Add New Customer/Representative" />
    </form>

    <!-- User Table -->
    <h3>Users</h3>
    <table border="1">
        <tr>
            <th>Username</th>
            <th>Password</th>
            <th>Account Type</th>
            <th>Actions</th>
        </tr>
        <%
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            ApplicationDB db = new ApplicationDB();    
            con = db.getConnection();
            stmt = con.createStatement();
            String sql = "SELECT username, password, account_type FROM user";
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                String username = rs.getString("username");
                String password = rs.getString("password");
                String accountType = rs.getString("account_type");

                out.println("<tr><td>" + username + "</td><td>" + password + "</td><td>" + accountType + "</td>");
                out.println("<td><a href='EditUser.jsp?username=" + username + "'>Edit</a> | ");
                out.println("<a href='DeleteUserServ?username=" + username + "'>Delete</a></td></tr>");
            }
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        %>
    </table>

    <!-- Search Form for Bookings -->
    <h3>Search Bookings</h3>
    <form method="get">
        <label for="searchBy">Search By:</label>
        <select name="searchBy" id="searchBy">
            <option value="username">Username</option>
            <option value="flight">Flight Number</option>
        </select>
        <input type="text" name="searchTerm" required>
        <input type="submit" value="Search">
    </form>

    <!-- Bookings Table -->
    <h3>Bookings</h3>
    <table border="1">
        <tr>
            <th>Username</th>
            <th>Flight Number</th>
        </tr>
        <%
        PreparedStatement pstmt = null;
        ResultSet rs2 = null;
        try {
            String searchBy = request.getParameter("searchBy");
            String searchTerm = request.getParameter("searchTerm");
            if (searchBy != null && searchTerm != null && !searchTerm.trim().isEmpty()) {
                ApplicationDB db = new ApplicationDB();    
                con = db.getConnection();
                String query = "SELECT username, flight FROM bookings WHERE " + searchBy + " = ?";
                pstmt = con.prepareStatement(query);
                pstmt.setString(1, searchTerm);
                rs2 = pstmt.executeQuery();

                while (rs2.next()) {
                    out.println("<tr><td>" + rs2.getString("username") + "</td><td>" + rs2.getString("flight") + "</td></tr>");
                }
            }
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            if (rs2 != null) try { rs2.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        %>
    </table>

    <!-- Most Popular Flight Number -->
    <h3>Most Popular Flight Number</h3>
   <%
try {
    ApplicationDB db = new ApplicationDB();    
    con = db.getConnection();
    String popularFlightsQuery = "SELECT flight, COUNT(*) as count FROM bookings GROUP BY flight HAVING COUNT(*) > 2";
    PreparedStatement popularFlightsStmt = con.prepareStatement(popularFlightsQuery);
    ResultSet popularFlightsRs = popularFlightsStmt.executeQuery();
    boolean hasData = false;

    while (popularFlightsRs.next()) {
        if (!hasData) {
            hasData = true;
            out.println("<table border='1'><tr><th>Flight Number</th><th>Bookings Count</th></tr>");
        }
        String flight = popularFlightsRs.getString("flight");
        int count = popularFlightsRs.getInt("count");
        out.println("<tr><td>" + flight + "</td><td>" + count + "</td></tr>");
    }

    if (!hasData) {
        out.println("<p>No flights found with more than two bookings.</p>");
    } else {
        out.println("</table>");
    }

    popularFlightsRs.close();
    popularFlightsStmt.close();
} catch (SQLException se) {
    se.printStackTrace();
    out.println("<p>Error retrieving popular flights: " + se.getMessage() + "</p>");
} finally {
    if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
}
%>
<a href='logout.jsp'>Log out</a>
</body>
</html>