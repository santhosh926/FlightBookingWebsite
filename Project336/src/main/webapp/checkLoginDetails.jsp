<%@ page import="java.sql.*"%>
<%
String userid = request.getParameter("username");
String pwd = request.getParameter("password");
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "root");
Statement st = con.createStatement();
ResultSet rs;
rs = st.executeQuery("select * from user where username='" + userid + "' and password='" + pwd + "'");
if (rs.next()) {
	session.setAttribute("user", userid); // the username will be stored in the session
	String accountType = rs.getString("account_type");
	// out.println("welcome " + userid);
	// out.println("<a href='logout.jsp'>Log out</a>");
	if (accountType.equals("Admin"))
		response.sendRedirect("adminHome.jsp");
	else if (accountType.equals("Customer"))
		response.sendRedirect("customer.jsp");
	else
		response.sendRedirect("CustomerRepHub.jsp");
} else {
	out.println("Invalid password <a href='login.jsp'>try again</a>");
}
%>