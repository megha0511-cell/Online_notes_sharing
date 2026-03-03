<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String departmentName = request.getParameter("departmentName");

    if (departmentName != null && !departmentName.trim().isEmpty()) {
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Set up the connection
            String url = "jdbc:mysql://localhost:3306/notes_db";
            String user = "root";
            String password = "root";
            Connection conn = DriverManager.getConnection(url, user, password);

            // Insert new department into the database
            String query = "INSERT INTO departments (dept_name) VALUES (?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, departmentName);
            int rowsInserted = stmt.executeUpdate();

            // Close connection
            stmt.close();
            conn.close();

            if (rowsInserted > 0) {
                response.sendRedirect("department.jsp");
            } else {
                out.println("<p>Error: Department was not added.</p>");
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    } else {
        out.println("<p>Error: Department name is required.</p>");
    }
%>
