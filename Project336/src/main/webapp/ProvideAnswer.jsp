<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>

<%
    String question = request.getParameter("question");

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String answer = request.getParameter("answer");

        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        try {
            String updateQuery = "UPDATE questions SET answer = ? WHERE question = ?";
            PreparedStatement preparedStatement = con.prepareStatement(updateQuery);
            try {
                preparedStatement.setString(1, answer);
                preparedStatement.setString(2, question);

                int rows = preparedStatement.executeUpdate();

                if (rows > 0) {
                    response.sendRedirect("ViewQuestions.jsp");
                } else {
                    out.println("Failed to update answer.");
                }
            } catch (SQLException e) {
                out.println("An error occurred while updating the answer.");
                e.printStackTrace();
            }
        } catch (SQLException e) {
            out.println("An error occurred while updating the answer.");
            e.printStackTrace();
        }
    }
%>

<html>
<head>
    <title>Answer Question</title>
</head>
<body>

<h2>Answer Question</h2>

<form method="post" action="ProvideAnswer.jsp">
    <label for="question">Question:</label>
    <textarea id="question" name="question" rows="4" cols="50" readonly><%= question %></textarea><br>

    <label for="answer">Answer:</label>
    <textarea id="answer" name="answer" rows="4" cols="50" required></textarea><br>

    <input type="submit" value="Submit Answer">
</form>

</body>
</html>
