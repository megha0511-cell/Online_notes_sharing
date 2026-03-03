<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>

<%
    // Debugging: Print session ID and attribute value
    System.out.println("Session ID: " + session.getId());
    System.out.println("registerid value in session: " + session.getAttribute("registerid"));

    // Retrieve 'registerid' from session
    Object registerIdObj = session.getAttribute("registerid");

    if (registerIdObj == null) {
        out.println("<p style='color:red;'>Session expired or not set. Please log in again.</p>");
        response.sendRedirect("login.jsp"); // Redirect to login page
        return; // Stop further execution
    }

    int userId;
    try {
        userId = Integer.parseInt(registerIdObj.toString()); // Ensure userId is an integer
    } catch (NumberFormatException e) {
        out.println("<p style='color:red;'>Invalid session data. Please log in again.</p>");
        response.sendRedirect("login.jsp"); // Redirect to login page
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile - Online Notes Sharing</title>
    <style>
        /* Global Styles */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #DFD8C5;  /* Soft background from our palette */
            margin: 0;
            padding: 0;
            color: #523A2E;
        }
        /* Dashboard Button in Top Left Corner */
        .dashboard-button-small {
            position: fixed;
            top: 15px;
            left: 15px;
            padding: 5px 10px;
            background-color: #EEC994;
            color: #523A2E;
            text-decoration: none;
            font-size: 0.8rem;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
            transition: background-color 0.3s ease;
            z-index: 1000;
        }
        .dashboard-button-small:hover {
            background-color: #523A2E;
            color: #EEC994;
        }
        /* Header with Gradient */
        header {
            background: linear-gradient(135deg, #523A2E, #EEC994);
            padding: 20px;
            text-align: center;
            color: #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        header h1 {
            margin: 0;
            font-size: 2em;
            letter-spacing: 1px;
        }
        /* Main Container */
        .container {
            max-width: 1100px;
            margin: 30px auto;
            padding: 0 20px;
        }
        /* Card Style Section */
        .profile-section, .notes-section, .edit-section {
            background-color: #fff;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .profile-section h3, .notes-section h3, .edit-section h3 {
            color: #523A2E;
            margin-top: 0;
            border-bottom: 2px solid #EEC994;
            padding-bottom: 5px;
        }
        .profile-section p {
            font-size: 1.1em;
            line-height: 1.6;
        }
        .profile-section a {
            color: #523A2E;
            text-decoration: none;
            font-weight: bold;
        }
        .profile-section a:hover {
            text-decoration: underline;
        }
        /* Notes List Styling */
        .notes-section ul {
            list-style-type: none;
            padding: 0;
        }
        .notes-section li {
            background-color: #EEC994;
            margin-bottom: 10px;
            padding: 12px;
            border-radius: 6px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .notes-section li a {
            color: #523A2E;
            font-weight: bold;
            text-decoration: none;
        }
        .notes-section li a:hover {
            text-decoration: underline;
        }
        /* Edit Profile Form */
        .edit-section form {
            display: flex;
            flex-direction: column;
        }
        .edit-section input[type="text"],
        .edit-section input[type="email"] {
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1em;
        }
        .edit-section input[type="submit"] {
            padding: 12px;
            border: none;
            border-radius: 4px;
            background-color: #523A2E;
            color: #EEC994;
            font-size: 1em;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .edit-section input[type="submit"]:hover {
            background-color: #402A20;
        }
        /* Footer */
        footer {
            text-align: center;
            padding: 15px;
            background-color: #523A2E;
            color: #EEC994;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <!-- Dashboard Button -->
    <a class="dashboard-button-small" href="dashboard.jsp">Dashboard</a>

    <!-- Header -->
    <header>
        <h1>User Profile</h1>
    </header>

    <div class="container">
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            String username = "";
            String email = "";
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/notes_db", "root", "root");

                // Fetch user profile
                String query = "SELECT name, email FROM register WHERE registerid=?";
                stmt = conn.prepareStatement(query);
                stmt.setInt(1, userId);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    username = rs.getString("name");
                    email = rs.getString("email");
        %>
                    <div class="profile-section">
                        <h3>Profile Information</h3>
                        <p><strong>Username:</strong> <%= username %></p>
                        <p><strong>Email:</strong> <%= email %></p>
                        <a href="profile.jsp?action=editProfile">Update Profile</a>
                    </div>
        <% 
                } else {
                    out.println("<p style='color:red;'>No user found with this ID. Please log in again.</p>");
                    response.sendRedirect("login.jsp");
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error fetching profile: " + e.getMessage() + "</p>");
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { }
                try { if (stmt != null) stmt.close(); } catch (SQLException e) { }
            }
        %>

        <% 
            // Fetch uploaded notes for user
            ResultSet rsNotes = null;
            try {
                String queryNotes = "SELECT * FROM department_notes WHERE registerid=?";
                stmt = conn.prepareStatement(queryNotes);
                stmt.setInt(1, userId);
                rsNotes = stmt.executeQuery();
        %>
        <div class="notes-section">
            <h3>Your Uploaded Notes</h3>
            <ul>
                <% while (rsNotes.next()) { %>
                    <li>
                        <span><%= rsNotes.getString("file_name") %></span>
                        <a href="profile.jsp?action=deleteNote&noteId=<%= rsNotes.getInt("note_id") %>">Delete</a>
                    </li>
                <% } %>
            </ul>
        </div>
        <% 
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error fetching notes: " + e.getMessage() + "</p>");
            } finally {
                try { if (rsNotes != null) rsNotes.close(); } catch (SQLException e) { }
                try { if (stmt != null) stmt.close(); } catch (SQLException e) { }
            }
        %>

        <% 
            // Handle profile update action
            if ("editProfile".equals(request.getParameter("action"))) {
                String newUsername = request.getParameter("name");
                String newEmail = request.getParameter("email");
        %>
        <div class="edit-section">
            <h3>Edit Profile</h3>
            <form action="profile.jsp?action=editProfile" method="POST">
                <input type="text" name="name" value="<%= username %>" required />
                <input type="email" name="email" value="<%= email %>" required />
                <input type="submit" value="Update Profile" />
            </form>
        </div>
        <% 
                if (newUsername != null && newEmail != null) {
                    try {
                        String queryUpdate = "UPDATE register SET name=?, email=? WHERE registerid=?";
                        stmt = conn.prepareStatement(queryUpdate);
                        stmt.setString(1, newUsername);
                        stmt.setString(2, newEmail);
                        stmt.setInt(3, userId);
                        int rowsUpdated = stmt.executeUpdate();

                        if (rowsUpdated > 0) {
                            out.println("<p style='color:green;'>Profile updated successfully!</p>");
                            username = newUsername;
                            email = newEmail;
                        } else {
                            out.println("<p style='color:red;'>Error updating profile. Please try again later.</p>");
                        }
                    } catch (Exception e) {
                        out.println("<p style='color:red;'>Error updating profile: " + e.getMessage() + "</p>");
                    } finally {
                        try { if (stmt != null) stmt.close(); } catch (SQLException e) { }
                    }
                }
            }
        %>

        <%
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("<p style='color:red;'>Error closing connection: " + e.getMessage() + "</p>");
            }
        %>
    </div>

    <footer>
        <p>&copy; 2024 Online Notes Sharing. All rights reserved.</p>
    </footer>
</body>
</html>
