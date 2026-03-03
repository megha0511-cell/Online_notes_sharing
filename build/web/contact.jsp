<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Contact Us</title>
  <style>
    /* Global Styles */
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #DFD8C5;
      color: #523A2E;
      box-sizing: border-box;
      position: relative;
    }

    /* Small Dashboard Button in Top Left Corner */
    .dashboard-button-small {
      position: absolute;
      top: 20px;
      left: 20px;
      padding: 5px 10px;
      background-color: #523A2E;
      color: #EEC994;
      text-decoration: none;
      font-size: 0.8rem;
      border-radius: 4px;
      transition: background 0.3s;
      z-index: 100;
    }
    
    .dashboard-button-small:hover {
      background-color: #402A20;
    }

    /* Contact Form Section */
    .contact-form-section {
      background-color: #DFD8C5;
      padding: 80px 20px 40px; /* Added extra top padding to account for the dashboard button */
    }

    .contact-form {
      max-width: 600px;
      margin: 0 auto;
      background-color: #EEC994;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .contact-form h3 {
      text-align: center;
      color: #523A2E;
      margin-bottom: 20px;
    }

    .contact-form label {
      display: block;
      margin-bottom: 5px;
      font-size: 0.9rem;
      color: #523A2E;
    }

    .contact-form input,
    .contact-form textarea {
      width: 100%;
      padding: 10px;
      margin-bottom: 15px;
      border: 1px solid #523A2E;
      border-radius: 4px;
    }

    .contact-form button {
      width: 100%;
      padding: 10px;
      background-color: #523A2E;
      color: #EEC994;
      border: none;
      border-radius: 4px;
      font-size: 1rem;
      cursor: pointer;
      transition: background 0.3s;
    }

    .contact-form button:hover {
      background-color: #402A20;
    }

    /* Information Section */
    .info-section {
      background-color: #EEC994;
      padding: 20px 0;
      border-top: 1px solid #523A2E;
    }

    .info-container {
      display: flex;
      justify-content: space-between;
      max-width: 1200px;
      margin: 0 auto;
      padding: 0 20px;
      flex-wrap: wrap;
    }

    .info-container div {
      flex: 1;
      margin: 0 10px;
      text-align: left;
      min-width: 200px;
    }

    .info-container h3 {
      color: #523A2E;
      font-size: 1.2rem;
      margin-bottom: 10px;
    }

    .info-container ul {
      list-style: none;
      padding: 0;
    }

    .info-container ul li {
      margin: 5px 0;
      font-size: 0.9rem;
    }

    .info-container ul li a {
      text-decoration: none;
      color: #523A2E;
      font-weight: bold;
    }

    .info-container ul li a:hover {
      text-decoration: underline;
    }

    /* Footer */
    .footer {
      background-color: #523A2E;
      color: #EEC994;
      text-align: center;
      padding: 10px 0;
      margin-top: 20px;
    }

    .footer a {
      color: #EEC994;
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <!-- Small Back to Dashboard Button in Top Left Corner -->
  <a class="dashboard-button-small" href="dashboard.jsp">Dashboard</a>

  <!-- Contact Form Section -->
  <div class="contact-form-section">
    <div class="contact-form">
      <h3>Send Us a Message</h3>
      <form action="saveMessage.jsp" method="post">
        <label for="name">Your Name</label>
        <input type="text" id="name" name="name" placeholder="Enter your name" required>

        <label for="email">Your Email</label>
        <input type="email" id="email" name="email" placeholder="Enter your email" required>

        <label for="message">Your Message</label>
        <textarea id="message" name="message" rows="5" placeholder="Enter your message" required></textarea>

        <button type="submit">Send Message</button>
      </form>
    </div>
  </div>

  <!-- Information Section -->
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
      <!-- Services -->
      <div class="services">
        <h3>Services</h3>
        <ul>
          <li>Easy Download Process</li>
          <li>User-Friendly Interface</li>
          <li>Customizable Profiles</li>
        </ul>
      </div>
      <!-- Social Links -->
      <div class="social-links">
        <h3>Social Links</h3>
        <ul>
          <li><a href="https://facebook.com" target="_blank">Facebook</a></li>
          <li><a href="https://twitter.com" target="_blank">Twitter</a></li>
          <li><a href="https://linkedin.com" target="_blank">LinkedIn</a></li>
        </ul>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <footer class="footer">
    <p>
        &copy; 2024 Online Notes Sharing. All rights reserved</p>
    
  </footer>
</body>
</html>
