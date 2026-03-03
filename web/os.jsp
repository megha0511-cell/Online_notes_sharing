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

    int subjectId = 0;
    List<String> notesList = new ArrayList<>();
    List<String[]> filesList = new ArrayList<>(); // Store [filename, note_id] for downloads

    try {
        // Load Driver and Establish Connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Fetch Subject ID for "Advanced DBMS"
        String subjectQuery = "SELECT subject_id FROM subjects WHERE subject_name = 'Operating System'";
        pstmt = conn.prepareStatement(subjectQuery);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            subjectId = rs.getInt("subject_id");
        }

        rs.close();
        pstmt.close();

        // Fetch All Notes & Files
        String contentQuery = "SELECT note_id, file_text, file_name FROM department_notes WHERE subject_id = ?";
        pstmt = conn.prepareStatement(contentQuery);
        pstmt.setInt(1, subjectId);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            String note = rs.getString("file_text") != null ? rs.getString("file_text") : "No notes available.";
            String fileName = rs.getString("file_name");
            int noteId = rs.getInt("note_id");

            notesList.add(note);
            if (fileName != null) {
                filesList.add(new String[]{fileName, String.valueOf(noteId)});
            }
        }

    } catch (Exception e) {
        notesList.add("Error: " + e.getMessage());
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
    <title>Operating System Notes</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #DFD8C5, #EEC994);
            color: #523A2E;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
        }

        .container {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(8px);
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            max-width: 800px;
            text-align: center;
        }

        .header {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #523A2E;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .notes-section, .download-section {
            background: rgba(255, 255, 255, 0.6);
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 15px;
        }

        .notes-section h3, .download-section h3 {
            color: #523A2E;
            font-size: 20px;
        }

        .note-text {
            background: rgba(255, 255, 255, 0.3);
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 10px;
            color: #523A2E;
            text-align: left;
        }

        .download-link {
            display: inline-block;
            background: #523A2E;
            color: #FFF;
            padding: 10px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s;
        }

        .download-link:hover {
            background: #40201F;
        }

        .icon {
            margin-right: 8px;
            width: 18px;
            height: 18px;
        }

        .back-button {
            margin-top: 15px;
            padding: 10px 20px;
            background: #523A2E;
            color: #FFF;
            text-decoration: none;
            font-weight: bold;
            border-radius: 5px;
            transition: 0.3s;
        }

        .back-button:hover {
            background: #40201F;
        }
    </style>

</head>
<body>

    <div class="container">
        <h2 class="header">&#x1F4D8; Operating System Notes</h2>

       

        <% if (!filesList.isEmpty()) { %>
        <div class="download-section">
            <h3>📂 Download Notes</h3>
            <% for (String[] file : filesList) { %>
                <a class="download-link" href="download.jsp?note_id=<%= file[1] %>">
                    <img src="images/download-icon.png" class="icon" alt="Download"> <%= file[0] %>
                </a><br>
            <% } %>
        </div>
        <% } %>
    </div>
<a href="dashboard.jsp" class="back-button">⬅ Back to Dashboard</a>
</body>
</html>
