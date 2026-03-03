import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.nio.file.*;

@WebServlet("/notes")
public class notesServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/notes_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet deptRS = stmt.executeQuery("SELECT * FROM departments")) {

            out.println("<html><body>");
            out.println("<h2>Departments and Notes</h2>");

            out.println("<h3>Add a New Department</h3>");
            out.println("<form action='departments' method='POST'>");
            out.println("<input type='hidden' name='action' value='addDepartment'>");
            out.println("Department Name: <input type='text' name='department_name' required><br>");
            out.println("Description: <textarea name='department_description' required></textarea><br>");
            out.println("<button type='submit'>Add Department</button>");
            out.println("</form>");

            out.println("<h3>Upload Note</h3>");
            out.println("<form action='departments' method='POST' enctype='multipart/form-data'>");
            out.println("<input type='hidden' name='action' value='uploadNote'>");
            out.println("Select Department: <select name='department_id' required>");
            while (deptRS.next()) {
                out.println("<option value='" + deptRS.getInt("id") + "'>" + deptRS.getString("department_name") + "</option>");
            }
            out.println("</select><br>");
            out.println("Note Title: <input type='text' name='note_title' required><br>");
            out.println("Upload File: <input type='file' name='note_file' accept='application/pdf' required><br>");
            out.println("<button type='submit'>Upload Note</button>");
            out.println("</form>");

            out.println("<h3>Department List</h3>");
            deptRS.beforeFirst();
            while (deptRS.next()) {
                int deptId = deptRS.getInt("id");
                String deptName = deptRS.getString("department_name");
                String deptDesc = deptRS.getString("department_description");

                out.println("<div style='border: 1px solid #000; padding: 10px; margin: 10px;'>");
                out.println("<h4>" + deptName + "</h4>");
                out.println("<p>" + deptDesc + "</p>");
                out.println("<h5>Notes:</h5>");
                out.println("<ul>");

                try (PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM department_notes WHERE department_id = ?")) {
                    pstmt.setInt(1, deptId);
                    ResultSet notesRS = pstmt.executeQuery();
                    while (notesRS.next()) {
                        String noteTitle = notesRS.getString("note_title");
                        String noteFilePath = notesRS.getString("note_file_path");
                        out.println("<li>" + noteTitle + " - <a href='" + noteFilePath + "' target='_blank'>Download</a></li>");
                    }
                }
                out.println("</ul>");
                out.println("</div>");
            }

            out.println("</body></html>");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            if ("addDepartment".equals(action)) {
                String departmentName = request.getParameter("department_name");
                String departmentDescription = request.getParameter("department_description");

                String sql = "INSERT INTO departments (department_name, department_description) VALUES (?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, departmentName);
                    pstmt.setString(2, departmentDescription);
                    pstmt.executeUpdate();
                }

                response.sendRedirect("departments");
            } else if ("uploadNote".equals(action)) {
                String noteTitle = request.getParameter("note_title");
                int departmentId = Integer.parseInt(request.getParameter("department_id"));
                Part filePart = request.getPart("note_file");
                String fileName = filePart.getSubmittedFileName();

                String uploadPath = getServletContext().getRealPath("/") + "uploaded_notes";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                filePart.write(uploadPath + File.separator + fileName);

                String filePath = "uploaded_notes/" + fileName;
                String sql = "INSERT INTO department_notes (department_id, note_title, note_file_path) VALUES (?, ?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setInt(1, departmentId);
                    pstmt.setString(2, noteTitle);
                    pstmt.setString(3, filePath);
                    pstmt.executeUpdate();
                }

                response.sendRedirect("departments");
            }
        } catch (SQLException | ServletException | IOException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred");
        }
    }
}
