<%@ page session="true" %>
<%@ page language="java" %>
<%
    // Ensure session is active
    if (session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp"); // Redirect if not logged in
        return;
    }
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Online Notes Sharing</title>
   <link rel="stylesheet" href="dashboard.css">
</head>
<body>
    <!-- Navigation Bar -->
    <header>
        <!-- Logo / Title -->
       

        <!-- Navigation Links -->
        <nav>
            <ul>
                <li><a href="dashboard.jsp">Home</a></li>
                <li><a href="contact.jsp">Contact</a></li>
                <li><a href="department.jsp">Notes</a></li>
                <li><a href="upload.html">Upload Notes</a></li>
                <li><a href="profile.jsp">Profile</a></li>
            </ul>
        </nav>

        <!-- Logout Button -->
        <a href="logout.jsp" class="logout-btn">Logout</a>
    </header>

    <!-- Welcome Section -->
    <section class="welcome-section">
        <h2>Welcome to our Notes Sharing Platform</h2>
        <p>We provide a platform for uploading and sharing notes files, making it easy to access and download resources for your studies or work.</p>
        <a href="#features" class="explore-btn">Explore</a>
    </section>

        <!-- New Section: Driving Progress -->
    <section class="progress-section">
        <div class="progress-content">
            <div class="text-content">
                <h2>Driving Progress in Every Field</h2>
                <p>Our goal is to simplify the process of sharing and accessing educational materials, making it convenient for students and professionals alike.</p>
            </div>
            <div class="image-grid">
                <div class="image-card">
                    <img src="images/book.jpg" alt="Book Image">
                </div>
                <div class="image-card">
                    <img src="images/note.jpg" alt="Note Image">
                </div>
                <div class="image-card">
                    <img src="images/person-writing.jpg" alt="Person Writing">
                </div>
            </div>
        </div>
    </section>


    <!-- Features Section -->
    <section id="features" class="features-section">
        <div class="feature-card">
            <img src="images/file.jpg" alt="Secure File Upload">
            <div class="overlay">
                <h3>Secure File Upload</h3>
            </div>
        </div>
        <div class="feature-card">
            <img src="images/easy-download.avif" alt="Easy Download Process">
            <div class="overlay">
                <h3>Easy Download Process</h3>
            </div>
        </div>
        <div class="feature-card">
            <img src="images/interface.jpg" alt="User-Friendly Interface">
            <div class="overlay">
                <h3>User-Friendly Interface</h3>
            </div>
        </div>
        <div class="feature-card">
            <img src="images/customizable-profiles.jpeg" alt="Customizable Profiles">
            <div class="overlay">
                <h3>Customizable Profiles</h3>
            </div>
        </div>
        <div class="feature-card">
            <img src="images/community-collaboration.jpg" alt="Community Collaboration">
            <div class="overlay">
                <h3>Community Collaboration</h3>
            </div>
        </div>
        <div class="feature-card">
            <img src="images/mobile-accessibility.jpg" alt="Mobile Accessibility">
            <div class="overlay">
                <h3>Mobile Accessibility</h3>
            </div>
        </div>
    </section>

    <div class="info-section">
      <div class="info-container">
        <!-- Contact Details -->
        <div class="contact">
          <h3>Contact</h3>
          <ul>
            <li>📍 Mumbai, India</li>
            <li>📞 +9669 9669 2323</li>
            <li>✉️ <a href="mailto:support@yourdomain.com">support@notesharing.com</a></li>
          </ul>
        </div>
    <div class="services">
      <h3>Services</h3>
      <ul>
        <li>Easy Download Process</li>
        <li>User-Friendly Interface</li>
        <li>Customizable Profiles</li>
      </ul>
    </div>
    <div class="social-links">
      <h3>Social Links</h3>
      <ul>
        <li><a href="#">Facebook</a></li>
        <li><a href="#">Twitter</a></li>
        <li><a href="#">LinkedIn</a></li>
      </ul>
    </div>
  </div>
</div>
<footer class="footer">
  <p>
     &copy; 2024 Online Notes Sharing. All rights reserved</p>
</footer>

</body>
</html>
