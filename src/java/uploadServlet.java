import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

@MultipartConfig(maxFileSize = 18177215) // Limit file size to ~16MB
public class uploadServlet extends HttpServlet {

    // Database Connection Details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/notes_db?serverTimezone=UTC";
    private static final String DB_USER = "root"; 
    private static final String DB_PASSWORD = "root";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ensure user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) { // ✅ FIXED: Corrected session key
            response.getWriter().println("Error: Please log in first.");
            return;
        }

        String userEmail = (String) session.getAttribute("email");
        String noteName = request.getParameter("note_name"); // Ensure this is a subject name
        String fileText = request.getParameter("file_text"); // Optional text-based notes
        Part filePart = request.getPart("file");

        if (noteName == null || noteName.isEmpty()) {
            response.getWriter().println("Error: Subject name is required.");
            return;
        }

        InputStream fileContent = null;
        String fileName = null;
        String fileType = null;

        if (filePart != null && filePart.getSize() > 0) {
            fileContent = filePart.getInputStream();
            fileName = filePart.getSubmittedFileName();
            fileType = filePart.getContentType();
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int registerId = -1;
        int subjectId = -1;

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // ✅ FIXED: Use separate PreparedStatements to prevent reuse issues
            // Get Register ID from user email
            String getUserIdSQL = "SELECT registerid FROM register WHERE email = ?";
            pstmt = conn.prepareStatement(getUserIdSQL);
            pstmt.setString(1, userEmail);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                registerId = rs.getInt("registerid");
            } else {
                response.getWriter().println("Error: User not found.");
                return;
            }
            rs.close(); // ✅ FIXED: Close result set before new query
            pstmt.close();

            // Get Subject ID from subject name
            String getSubjectIdSQL = "SELECT subject_id FROM subjects WHERE subject_name = ?";
            pstmt = conn.prepareStatement(getSubjectIdSQL);
            pstmt.setString(1, noteName);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                subjectId = rs.getInt("subject_id");
            } else {
                response.getWriter().println("Error: Subject not found.");
                return;
            }
            rs.close();
            pstmt.close();

            // ✅ FIXED: Insert file into department_notes table
            String insertSQL = "INSERT INTO department_notes (registerid, subject_id, file_name, file_type, file_data, file_text) VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insertSQL);
            pstmt.setInt(1, registerId);
            pstmt.setInt(2, subjectId);
            pstmt.setString(3, fileName);
            pstmt.setString(4, fileType);

            if (fileContent != null) {
                pstmt.setBinaryStream(5, fileContent, filePart.getSize()); // BLOB Data
            } else {
                pstmt.setNull(5, java.sql.Types.BLOB);
            }

            if (fileText != null && !fileText.isEmpty()) {
                pstmt.setString(6, fileText); // CLOB Data
            } else {
                pstmt.setNull(6, java.sql.Types.LONGVARCHAR);
            }

            int rows = pstmt.executeUpdate();
            response.getWriter().println(rows > 0 
                ? "File uploaded and saved successfully." 
                : "File upload failed.");

        } catch (SQLException e) {
            response.getWriter().println("Database error: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            response.getWriter().println("JDBC Driver not found: " + e.getMessage());
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                response.getWriter().println("Error closing resources: " + e.getMessage());
            }
        }
    }
}
