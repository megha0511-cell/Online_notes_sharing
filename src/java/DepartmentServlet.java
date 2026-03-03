import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DepartmentServlet")
public class DepartmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String deptName = request.getParameter("dept_name");
        int deptId = request.getParameter("dept_id") != null ? Integer.parseInt(request.getParameter("dept_id")) : -1;

        try (Connection conn = DatabaseConnection.getConnection()) {
            if ("add".equals(action)) {
                PreparedStatement stmt = conn.prepareStatement("INSERT INTO departments (dept_name) VALUES (?)");
                stmt.setString(1, deptName);
                stmt.executeUpdate();
                request.getSession().setAttribute("message", "Department added successfully!");
            } else if ("delete".equals(action)) {
                PreparedStatement stmt = conn.prepareStatement("DELETE FROM departments WHERE dept_id = ?");
                stmt.setInt(1, deptId);
                stmt.executeUpdate();
                request.getSession().setAttribute("message", "Department deleted successfully!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect("index.jsp");
    }
}
