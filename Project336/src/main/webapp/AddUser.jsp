<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Customer/Representative</title>
</head>
<body>
    <h2>Add New Customer/Representative</h2>
    <form action="AddUserServ" method="post">
        Username: <input type="text" name="username" required><br>
        Password: <input type="password" name="password" required><br>
        Account Type: <input type="text" name="accountType" required><br>
        <input type="submit" value="Add Customer/Representative">
    </form>
</body>
</html>