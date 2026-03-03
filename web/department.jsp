<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Departments - Online Notes Sharing</title>
    <style>
        /* Global Styles */
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #DFD8C5; /* Updated background */
            position: relative;
        }

        /* Small Dashboard Button in Top Left Corner */
        .dashboard-button-small {
            position: absolute;
            top: 10px;
            left: 10px;
            padding: 5px 10px;
            background-color: #ffc107;
            color: #000;
            text-decoration: none;
            font-size: 0.8rem;
            border-radius: 4px;
            transition: opacity 0.3s ease;
            z-index: 100;
        }
        .dashboard-button-small:hover {
            opacity: 0.9;
        }

        /* Header */
        header {
            background-color: #523A2E; /* Changed from blue to accent color */
            padding: 10px 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        h1 {
            color: #fff;
            font-size: 1.5em;
            margin: 0;
        }

        /* Container Layout */
        .container {
            display: flex;
            padding: 20px;
            box-sizing: border-box;
        }
        .sidebar {
            width: 25%;
            background-color: #fff;
            padding: 20px;
            border-right: 1px solid #ddd;
            box-sizing: border-box;
        }
        .sidebar ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }
        .sidebar li {
            position: relative;
            padding: 10px;
            cursor: pointer;
            font-weight: bold;
            color: #333;
        }
        .sidebar li:hover {
            background-color: #f1f1f1;
        }
        .sidebar li a {
            text-decoration: none;
            color: inherit;
        }
        .sidebar li .dropdown {
            display: none;
            position: absolute;
            top: 0;
            left: 100%;
            width: 200px;
            background-color: #fff;
            border: 1px solid #ddd;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            z-index: 1000;
        }
        .sidebar li:hover .dropdown {
            display: block;
        }
        .sidebar li .dropdown li {
            padding: 10px;
            white-space: nowrap;
            color: #523A2E; /* Updated color */
            font-weight: normal;
        }
        .sidebar li .dropdown li:hover {
            background-color: #f1f1f1;
        }
        .main-content {
            flex: 1;
            padding: 20px;
            box-sizing: border-box;
        }

        /* Search Bar */
        .search-bar {
            margin-bottom: 20px;
            text-align: center;
        }
        .search-bar input[type="text"] {
            width: 70%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        /* Departments and Popular Notes */
        .departments-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .departments-list li {
            margin-bottom: 10px;
        }
        .department {
            cursor: pointer;
            font-weight: bold;
            color: #523A2E; /* Updated color */
        }
        .department:hover {
            text-decoration: underline;
        }
        .popular-notes {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            padding-left: 20px;
        }
        .note {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 15px;
            text-align: center;
        }
        .note h3 {
            margin: 0;
            font-size: 1.2em;
            color: #523A2E; /* Updated color */
        }
        .note p {
            margin: 10px 0;
            color: #555;
        }
        .note a {
            text-decoration: none;
            color: #28a745;
            font-weight: bold;
        }
        .note a:hover {
            text-decoration: underline;
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
        footer {
            text-align: center;
            padding: 10px;
            background-color: #523A2E; /* Updated footer background */
            color: #fff;
        }
    </style>
</head>
<body>
    <!-- Small Dashboard Button -->
    <a class="dashboard-button-small" href="dashboard.jsp">Dashboard</a>

    <!-- Header -->
    <header>
        <h1>Departments</h1>
    </header>

    <!-- Search Bar -->
    <div class="search-bar">
        <input type="text" placeholder="Search for notes..." id="search-notes">
    </div>

    <!-- Main Container -->
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <h2>Departments</h2>
            <ul class="departments-list">
                <li>
                    <span class="department" onclick="toggleDropdown('cs-dropdown')">Computer Science</span>
                    <ul id="cs-dropdown" class="dropdown">
                        <li><a href="os.jsp">Operating System</a></li>
                        <li><a href="AJAVA.jsp">Advanced Java</a></li>
                        <li><a href="ADBMS.jsp">Advanced DBMS</a></li>
                    </ul>
                </li>
                <li>
                    <span class="department" onclick="toggleDropdown('it-dropdown')">Information Technology</span>
                    <ul id="it-dropdown" class="dropdown">
                        <li><a href="wp.jsp">Web Programming</a></li>
                        <li><a href="cn.jsp">Computer Network</a></li>
                        <li><a href="dsa.jsp">Data Structure</a></li>
                    </ul>
                </li>
                <li>
                    <span class="department" onclick="toggleDropdown('bba-dropdown')">Business Administration</span>
                    <ul id="bba-dropdown" class="dropdown">
                        <li><a href="bba_marketing.jsp">Marketing</a></li>
                        <li><a href="bba_finance.jsp">Finance</a></li>
                        <li><a href="bba_management.jsp">Management</a></li>
                    </ul>
                </li>
                <!-- New Department -->
                <li>
                    <span class="department" onclick="toggleDropdown('ee-dropdown')">Electrical Engineering</span>
                    <ul id="ee-dropdown" class="dropdown">
                        <li><a href="ee_circuit_theory.jsp">Circuit Theory</a></li>
                        <li><a href="ee_analog_electronics.jsp">Analog Electronics</a></li>
                        <li><a href="ee_power_systems.jsp">Power Systems</a></li>
                    </ul>
                </li>
            </ul>
        </div>

        <!-- Main Content (Popular Notes Section) -->
        <div class="main-content">
            <h2>Popular Notes</h2>
            <div class="popular-notes">
                <div class="note">
                    <h3>Data Structures</h3>
                    <p>Comprehensive notes on stacks, queues, and trees.</p>
                    <a href="dsa.jsp">View Note</a>
                </div>
                <div class="note">
                    <h3>Marketing Strategies</h3>
                    <p>Detailed study material on effective marketing.</p>
                    <a href="marketing.jsp">View Note</a>
                </div>
                <div class="note">
                    <h3>Operating Systems</h3>
                    <p>Insights into processes, threads, and scheduling.</p>
                    <a href="os.jsp">View Note</a>
                </div>
                <div class="note">
                    <h3>Financial Accounting</h3>
                    <p>Key concepts in accounting and balance sheets.</p>
                    <a href="finance_notes.jsp">View Note</a>
                </div>
            </div>
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
    <footer>
        <p>&copy; 2024 Online Notes Sharing. All rights reserved.</p>
    </footer>

    <!-- JavaScript for Dropdowns -->
    <script>
        function toggleDropdown(id) {
            const dropdown = document.getElementById(id);
            dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
        }
    </script>
</body>
</html>
