import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;


@MultipartConfig(maxFileSize = 16177215) // 16MB file limit
public class NotesServlet1 extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int subjectId = Integer.parseInt(request.getParameter("subject_id"));
        Part filePart = request.getPart("file");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO department_notes (subject_id, file_name, file_type, file_data) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, subjectId);
            pstmt.setString(2, filePart.getSubmittedFileName());
            pstmt.setString(3, filePart.getContentType());
            pstmt.setBinaryStream(4, filePart.getInputStream(), filePart.getSize());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect("index.jsp");
    }
}
