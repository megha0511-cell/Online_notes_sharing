<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<%
    // Database Connection Parameters
    String url = "jdbc:mysql://localhost:3306/notes_db";  // Replace with your DB name
    String user = "root";  // Replace with your DB username
    String password = "root";  // Replace with your DB password

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    List<String[]> userList = new ArrayList<>();
    List<String[]> departmentList = new ArrayList<>();
    List<String[]> subjectList = new ArrayList<>();
    List<String[]> notesList = new ArrayList<>();

    try {
        // Load Driver and Establish Connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Fetch All Users
        String userQuery = "SELECT registerid, name, email FROM register";
        pstmt = conn.prepareStatement(userQuery);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            String[] userItem = new String[]{rs.getString("registerid"), rs.getString("name"), rs.getString("email")};
            userList.add(userItem);
        }

        rs.close();
        pstmt.close();

        // Fetch All Departments
        String departmentQuery = "SELECT dept_id, dept_name FROM departments";
        pstmt = conn.prepareStatement(departmentQuery);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            String[] departmentItem = new String[]{rs.getString("dept_id"), rs.getString("dept_name")};
            departmentList.add(departmentItem);
        }

        rs.close();
        pstmt.close();

        // Fetch All Subjects
        String subjectQuery = "SELECT subject_id, subject_name, dept_id FROM subjects";
        pstmt = conn.prepareStatement(subjectQuery);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            String[] subjectItem = new String[]{
                rs.getString("subject_id"),
                rs.getString("subject_name"),
                rs.getString("dept_id")
            };
            subjectList.add(subjectItem);
        }

        rs.close();
        pstmt.close();

        // Fetch All Notes
        String notesQuery = "SELECT note_id, file_text, file_name, subject_id FROM department_notes";
        pstmt = conn.prepareStatement(notesQuery);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            String[] noteItem = new String[]{
                rs.getString("note_id"),
                rs.getString("file_text"),
                rs.getString("file_name"),
                rs.getString("subject_id")
            };
            notesList.add(noteItem);
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #DFD8C5;
            color: #523A2E;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            flex-direction: column;
        }

        .container {
            background: #EEC994;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            max-width: 1200px;
            width: 100%;
        }

        .header {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
            color: #523A2E;
        }

        .table-container {
            margin-bottom: 30px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }

        th {
            background-color: #523A2E;
            color: #fff;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .button {
            padding: 12px 25px;
            background-color: #523A2E;
            color: #EEC994;
            text-decoration: none;
            font-weight: bold;
            border-radius: 5px;
            transition: 0.3s;
            margin-top: 20px;
            display: inline-block;
        }

        .button:hover {
            background-color: #3D2A1F;
            color: #fff;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2 class="header">Admin Dashboard</h2>

        <!-- Users Table -->
        <div class="table-container">
            <h3>Users</h3>
            <table>
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Username</th>
                        <th>Email</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        // Debugging: Check if the userList is not empty
                        if(userList.size() > 0) {
                            for (String[] userItem : userList) { 
                    %>
                        <tr>
                            <td><%= userItem[0] %></td>
                            <td><%= userItem[1] %></td>
                            <td><%= userItem[2] %></td>
                        </tr>
                    <% 
                            }
                        } else {
                    %>
                        <tr><td colspan="3">No Users Found</td></tr>
                    <% 
                        }
                    %>
                </tbody>
            </table>
        </div>

        <!-- Departments Table -->
        <div class="table-container">
            <h3>Departments</h3>
            <table>
                <thead>
                    <tr>
                        <th>Department ID</th>
                        <th>Department Name</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (String[] departmentItem : departmentList) { %> <!-- Updated variable name -->
                        <tr>
                            <td><%= departmentItem[0] %></td>
                            <td><%= departmentItem[1] %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Subjects Table -->
        <div class="table-container">
            <h3>Subjects</h3>
            <table>
                <thead>
                    <tr>
                        <th>Subject ID</th>
                        <th>Subject Name</th>
                        <th>Department ID</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (String[] subjectItem : subjectList) { %> <!-- Updated variable name -->
                        <tr>
                            <td><%= subjectItem[0] %></td>
                            <td><%= subjectItem[1] %></td>
                            <td><%= subjectItem[2] %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Notes Table -->
        <div class="table-container">
            <h3>Notes</h3>
            <table>
                <thead>
                    <tr>
                        <th>Note ID</th>
                        <th>File Text</th>
                        <th>File Name</th>
                        <th>Subject ID</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (String[] noteItem : notesList) { %> <!-- Updated variable name -->
                        <tr>
                            <td><%= noteItem[0] %></td>
                            <td><%= noteItem[1] %></td>
                            <td><%= noteItem[2] %></td>
                            <td><%= noteItem[3] %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <a href="home.jsp" class="button">Go Back to Home</a>
    </div>

</body>
</html>
