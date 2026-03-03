<%@ page import="java.sql.*, java.io.*" %>
<%
    // Database connection details
    String url = "jdbc:mysql://localhost:3306/notes_db";
    String user = "root";
    String password = "root";
    Connection conn = null;

    // Validate the `subject_id` parameter
    String noteIdParam = request.getParameter("note_id");
    int noteId = 0;

    if (noteIdParam != null && !noteIdParam.isEmpty()) {
        try {
            noteId = Integer.parseInt(noteIdParam);
        } catch (NumberFormatException e) {
            out.println("<p style='color:red;'>Invalid subject_id format. Please provide a valid integer.</p>");
            return;
        }
    } else {
        out.println("<p style='color:red;'>Error: note_id parameter is missing.</p>");
        return;
    }

    try {
        // Load JDBC driver and establish a connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // SQL query to fetch the file details
        String query = "SELECT file_name, file_type, file_data FROM department_notes WHERE note_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, noteId);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            // Retrieve file details from the database
            String fileName = rs.getString("file_name");
            String fileType = rs.getString("file_type");
            Blob fileBlob = rs.getBlob("file_data");

            byte[] fileBytes = fileBlob.getBytes(1, (int) fileBlob.length());

            // Set the response headers for file download
            response.setContentType(fileType);
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

            // Write the file data to the response output stream
            OutputStream os = response.getOutputStream();
            os.write(fileBytes);
            os.flush();
            os.close();
        } else {
            out.println("<p style='color:red;'>No file found for the provided note_id.</p>");
        }

        // Close resources
        rs.close();
        pstmt.close();
    } catch (SQLException sqlEx) {
        out.println("<p style='color:red;'>Database Error: " + sqlEx.getMessage() + "</p>");
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                out.println("<p style='color:red;'>Error closing database connection: " + ex.getMessage() + "</p>");
            }
        }
    }
%>
