<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<%
    String siteName = " Notes Sharing";  
    String description = "A platform for students to share and access study notes.";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - <%= siteName %></title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #DFD8C5;
            color: #523A2E;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
        }

        .container {
            background: #EEC994;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            max-width: 900px;
            text-align: center;
        }

        .header {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 20px;
            text-transform: uppercase;
            color: #523A2E;
        }

        .content-section {
            margin-bottom: 20px;
        }

        .section-title {
            font-size: 24px;
            color: #523A2E;
            margin-bottom: 10px;
            text-transform: uppercase;
        }

        .section-text {
            font-size: 16px;
            line-height: 1.6;
            color: #523A2E;
        }

        .button {
            margin-top: 20px;
            padding: 12px 25px;
            background-color: #523A2E;
            color: #EEC994;
            text-decoration: none;
            font-weight: bold;
            border-radius: 5px;
            transition: 0.3s;
        }

        .button:hover {
            background-color: #3D2A1F;
            color: #fff;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2 class="header">About <%= siteName %></h2>

        <div class="content-section">
            <h3 class="section-title">What is <%= siteName %>?</h3>
            <p class="section-text">
                <%= description %> This platform allows students to share notes, download them for studying, and collaborate with peers to enhance their learning experience. The website provides a smooth and easy-to-use interface for students to upload, manage, and download course materials. Whether you're looking to find notes for your upcoming exams or share your own, we are here to help!
            </p>
        </div>

        <div class="content-section">
            <h3 class="section-title">How It Works</h3>
            <p class="section-text">
                1.  <b>Login</b> – Create an account and log in to access notes.<br>
                2.  <b>Upload</b> – Upload your study materials and share them with others.<br>
                3.  <b>Browse and Download</b> – Browse the available notes, download them for studying.<br>
                4.  <b>Collaborate</b> – Share feedback and collaborate with fellow students.
            </p>
        </div>

        <div class="content-section">
            <h3 class="section-title">Our Vision</h3>
            <p class="section-text">
                Our vision is to create an easy-to-access online community where students can find reliable study material and share their knowledge. We aim to help students succeed academically by providing them with the resources they need.
            </p>
        </div>

        <a href="home.jsp" class="button">Go Back to Home</a>
    </div>

</body>
</html>
