<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="register.css">
</head>
<body>
    <div class="container">
    <div class="row justify-content-center align-items-center min-vh-100">
      <div class="col-md-6 col-lg-4">
        <div class="card shadow-sm">
          <div class="card-header text-center " style="background-color: #D8C9AE; font-family:verdana; font-weight:bolder; color:#575757;"> 
            <form method="post" action="register.jsp">
                <h2>Register</h2>
                <div class="form-group">
                    <label for="name">Username</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter Username" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter your Email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block" style="background-color: teal; font-family: verdana; font-weight: bolder;">Register</button>
                <div class="card-footer text-center" style="color:#5252522;">
                    <p>Already have an account? <a href="login.jsp">login here</a></p>
                </div>
            </form>
        </div>     

        <%
            // Database Connection Parameters
            String dbURL = "jdbc:mysql://localhost:3306/notes_db";
            String dbUser = "root";
            String dbPass = "root"; // Replace with your MySQL password

            // Fetch form data
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (name != null && email != null && password != null) {
                Connection conn = null;
                PreparedStatement stmt = null;

                try {
                    // Connect to Database
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                    
                    // Check if email already exists
                    String checkEmailQuery = "SELECT COUNT(*) FROM register WHERE email=?";
                    stmt = conn.prepareStatement(checkEmailQuery);
                    stmt.setString(1, email);
                    ResultSet rs = stmt.executeQuery();
                    rs.next();
                    if (rs.getInt(1) > 0) {
                        out.println("<p style='color:red;'>Email already registered. Please use a different email.</p>");
                    } else {
                        // Insert user into the database
                        String sql = "INSERT INTO register (name, email, password) VALUES (?, ?, ?)";
                        stmt = conn.prepareStatement(sql);
                        stmt.setString(1, name);
                        stmt.setString(2, email);
                        stmt.setString(3, password);

                        int rowsInserted = stmt.executeUpdate();
                        if (rowsInserted > 0) {
                            // Redirect to dashboard.jsp upon successful registration
                            response.sendRedirect("dashboard.jsp");
                        } else {
                            out.println("<p style='color:red;'>Failed to register. Try again.</p>");
                        }
                    }

                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
    </div>
</body>
</html>
