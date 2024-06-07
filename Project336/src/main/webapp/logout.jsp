<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout</title>
</head>
<body>
	<%
		session.invalidate();
	%>
	Thanks for using our service. We hope to see you again.
	<br>
	<a href='login.jsp'>Click here to log back in</a>
</body>
</html>