<%
if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%} else {
%>
Welcome <%=session.getAttribute("user")%> 
<br>
<a href='flightSearch.jsp'>Book a Flight</a>
<br>
<a href='bookings.jsp'>View your Reservations</a>
<br>
<a href='logout.jsp'>Log out</a>
<%
}
%>