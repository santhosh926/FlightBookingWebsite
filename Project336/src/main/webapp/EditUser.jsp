<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>

<%
    String username = request.getParameter("username");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String currentPassword = "";
    String currentAccountType = "";

    try {
        ApplicationDB db = new ApplicationDB();
        conn = db.getConnection();
        String query = "SELECT password, account_type FROM user WHERE username = ?";
        ps = conn.prepareStatement(query);
        ps.setString(1, username);
        rs = ps.executeQuery();

        if(rs.next()) {
            currentPassword = rs.getString("password");
            currentAccountType = rs.getString("account_type");
        }
    } catch (Exception e) {
        e.printStackTrace();
        // Handle exceptions
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (ps != null) ps.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
%>

<html>
<head>
    <title>Edit Customer/Representative</title>
</head>
<body>
    <h2>Edit Customer/Representative - <%= username %></h2>
    <form action="EditUserServ" method="post">
        Username: <input type="text" name="username" value="<%= username %>" readonly><br>
        Password: <input type="password" name="password" value="<%= currentPassword %>"><br>
        Account Type: <input type="text" name="accountType" value="<%= currentAccountType %>"><br>
        <input type="hidden" name="originalUsername" value="<%= username %>">
        <input type="submit" value="Update Customer/Representative">
    </form>
</body>
</html> --%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>

<%
    String originalUsername = request.getParameter("username");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String currentPassword = "";
    String currentAccountType = "";

    try {
        ApplicationDB db = new ApplicationDB();
        conn = db.getConnection();
        String query = "SELECT password, account_type FROM user WHERE username = ?";
        ps = conn.prepareStatement(query);
        ps.setString(1, originalUsername);
        rs = ps.executeQuery();

        if(rs.next()) {
            currentPassword = rs.getString("password");
            currentAccountType = rs.getString("account_type");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (Exception e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
%>

<html>
<head>
    <title>Edit Customer/Representative</title>
</head>
<body>
    <h2>Edit User</h2>
    <form action="EditUserServ" method="post">
        Original Username: <input type="text" name="originalUsername" value="<%= originalUsername %>" readonly><br>
        New Username: <input type="text" name="username" value="<%= originalUsername %>"><br>
        Password: <input type="password" name="password" value="<%= currentPassword %>"><br>
        Account Type: <input type="text" name="accountType" value="<%= currentAccountType %>"><br>
        <input type="submit" value="Update Customer/Representative">
    </form>
</body>
</html>