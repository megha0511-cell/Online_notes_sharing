<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Save Contact Message</title>
</head>
<body>
<%
    // Retrieve form data
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");

    // Database connection details
    String dbURL = "jdbc:mysql://localhost:3306/notes_db"; // Replace with your database name
    String dbUser = "root"; // Replace with your database username
    String dbPassword = "root"; // Replace with your database password

    // Response message
    String responseMessage;

    Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // SQL query to insert contact message
        String sql = "INSERT INTO ContactMessages (name, email, message) VALUES (?, ?, ?)";

        // Prepare and execute the query
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, name);
        preparedStatement.setString(2, email);
        preparedStatement.setString(3, message);

        int rows = preparedStatement.executeUpdate();

        if (rows > 0) {
            responseMessage = "Thank you, " + name + "! Your message has been successfully saved.";
        } else {
            responseMessage = "Something went wrong. Please try again.";
        }
    } catch (Exception e) {
        e.printStackTrace();
        responseMessage = "Error: " + e.getMessage();
    } finally {
        // Close resources
        try {
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Display the response message
    out.println("<h3>" + responseMessage + "</h3>");
%>
</body>
</html>
