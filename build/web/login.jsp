<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<%@ page import="com.notes.LoginDAO" %>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (email != null && password != null) {
        LoginDAO dao = new LoginDAO();

        if (dao.validateUser(email, password)) {

            // ✅ SET SESSION
            session.setAttribute("email", email);

            response.sendRedirect("dashboard.jsp");
        } else {
            out.println("<p style='color:red'>Invalid login</p>");
        }
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>

<body>
<div class="container">
    <div class="row justify-content-center align-items-center min-vh-100">
        <div class="col-md-6 col-lg-4">
            <div class="card shadow-sm">
                <div class="card-header text-center" style="background-color:#D8C9AE;">
                    <h2>Login</h2>
                </div>
                <div class="card-body">

                    <% if (request.getAttribute("error") != null) { %>
                        <p style="color:red;">
                            <%= request.getAttribute("error") %>
                        </p>
                    <% } %>

                    <form method="post" action="login.jsp">
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>

                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>

                        <button type="submit" class="btn btn-primary btn-block">
                            Login
                        </button>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
