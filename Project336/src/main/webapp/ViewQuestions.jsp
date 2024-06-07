<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>

<%
    ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
    try {
        String query = "SELECT * FROM questions";
        Statement stmt = con.createStatement();
        ResultSet resultSet = stmt.executeQuery(query);
        try {
%>
            <html>
            <head>
                <title>View Questions</title>
            </head>
            <body>
            
            <a href="CustomerRepHub.jsp">Back to Hub</a>
            

            <h2>List of Questions</h2>

            <table border="1">
                <tr>
                    <th>Question</th>
                    <th>Answer</th>
                    <th>Answer Question</th>
                </tr>

                <% while (resultSet.next()) { %>
                    <tr>
                        <td><%= resultSet.getString("question") %></td>
                        <td><%= resultSet.getString("answer") %></td>
                        <td><a href="ProvideAnswer.jsp?question=<%= resultSet.getString("question") %>">Answer</a></td>
                    </tr>
                <% } %>
            </table>

            </body>
            </html>
<%
        } catch (SQLException e) {
            out.println("An error occurred while retrieving questions.");
            e.printStackTrace();
        }
    } catch (SQLException e) {
        out.println("An error occurred while retrieving questions.");
        e.printStackTrace();
    }
%>
