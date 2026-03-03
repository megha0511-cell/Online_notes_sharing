<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    // Check if the user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp"); // Redirect to login page if not logged in
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Notes</title>
</head>
<body>
    <h2>Welcome to the Notes Section</h2>
    <p>You are logged in as: <%= session.getAttribute("user") %></p>
    
    <h3>Available Notes</h3>
    <ul>
        <li><a href="notes/math.pdf">Mathematics Notes</a></li>
        <li><a href="notes/computer_science.pdf">Computer Science Notes</a></li>
        <li><a href="notes/physics.pdf">Physics Notes</a></li>
    </ul>
    
    <a href="logout.jsp">Logout</a>
</body>
</html>
