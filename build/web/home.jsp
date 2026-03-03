<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Note Sharing Website</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            background-color: #ffffff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        header h1 {
            margin: 0;
            font-size: 1.5rem;
            color: #333;
        }

        nav {
            display: flex;
            gap: 20px;
        }

        nav a {
            text-decoration: none;
            color: #333;
            font-size: 1rem;
            font-weight: bold;
        }

        nav a:hover {
            color: #007BFF;
        }

        .hero {
            text-align: center;
            padding: 50px 20px;
            background-color: #f0f4f8;
        }

        .hero h1 {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 10px;
        }

        .hero p {
            font-size: 1.2rem;
            color: #555;
            margin-bottom: 20px;
        }

        .hero .buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .hero .buttons a {
            text-decoration: none;
            padding: 10px 20px;
            font-size: 1rem;
            font-weight: bold;
            border: 2px solid #007BFF;
            border-radius: 5px;
            color: #007BFF;
        }

        .hero .buttons a:hover {
            background-color: #007BFF;
            color: #ffffff;
        }

        .features {
            display: flex;
            align-items: center;
            padding: 40px 20px;
            gap: 20px;
            background-color: #ffffff;
        }

        .features img {
            max-width: 40%;
            height: auto;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .features .content {
            flex: 1;
        }

        .features h3 {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 10px;
        }

        .features p {
            font-size: 1rem;
            color: #555;
            margin-bottom: 20px;
        }

        .features .feature {
            margin-bottom: 20px;
        }

        .cta-section {
            background-color: #b0a6b1;
            padding: 40px 20px;
            text-align: center;
            margin: 20px auto;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 800px;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .cta-section:hover {
            background-color: #000; 
            transform: scale(1.02); 
        }

        .cta-section h2 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 10px;
            transition: color 0.3s ease;
        }

        .cta-section p {
            font-size: 1.2rem;
            color: #555;
            margin-bottom: 20px;
            transition: color 0.3s ease;
        }

        .cta-section:hover h2,
        .cta-section:hover p {
            color: #fff; 
        }

        .cta-button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 1rem;
            font-weight: bold;
            color: #fff;
            background-color: #e53935;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .cta-button:hover {
            background-color: #c62828;
            transform: scale(1.05);
            cursor: pointer;
        }

       
        footer {
            text-align: center;
            background-color: #333;
            color: #fff;
            padding: 10px 0;
            margin-top: 20px;
        }

        .get-started-features {
            display: flex;
            align-items: center;
            padding: 40px 20px;
            gap: 20px;
            background-color: #f3e5f5;
            margin-top: 20px;
            border-radius: 10px;
        }

        .get-started-features img {
            max-width: 70%; 
            height: auto;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .get-started-features .content {
            flex: 1;
        }

        .get-started-features h3 {
            font-size: 1.5rem;
            color: #6a1b9a;
            margin-bottom: 10px;
        }

        .get-started-features p {
            font-size: 1rem;
            color: #333;
            margin-bottom: 20px;
        }

        
        .get-started-features img {
            max-width: 70%; 
        }

        .get-started-features .content {
            flex: 1;
        }

        .contact-section {
            padding: 40px 20px;
            background-color: #f7f7f7;
            text-align: center;
        }

        .contact-section h2 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 20px;
        }

        .contact-section form {
            max-width: 600px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .contact-section input,
        .contact-section textarea {
            padding: 10px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 100%;
        }

        .contact-section textarea {
            resize: none;
            height: 150px;
        }

        .contact-section button {
            padding: 10px;
            font-size: 1rem;
            background-color: #007BFF;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .contact-section button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <header>
        <h1>Note Sharing Platform</h1>
        
        <nav>
            <a href="home.jsp">Home</a>
            <a href="notes.jsp">Notes</a>
            <a href="about.jsp">About</a>
            <a href="contact.jsp">Contact</a>
           <a href="login.jsp">Login</a>
           <a href="register.jsp">Register</a>
        </nav>
    </header>

    <section class="hero">
        <h1>Share and Collaborate on Notes Online</h1>
        <p>Effortlessly share your notes with classmates, colleagues, or friends. Collaborate in real-time and stay organized together.</p>
        <div class="buttons">
            <a href="register.jsp">Get Started</a>
            <a href="register.jsp">Learn More</a>
        </div>
    </section>

    <!-- FEATURES -->
    <section class="features">
        <img src="images/notes-coffee.jpg" alt="Desk with notes and coffee">
        <div class="content">
            <div class="feature">
                <h3>Notes Sharing</h3>
                <p>Easily share your notes with classmates, colleagues, or friends with just a few clicks.</p>
            </div>
            <div class="feature">
                <h3>Collaborative Editing</h3>
                <p>Work together in real-time on notes, projects, or study materials with seamless collaboration tools.</p>
            </div>
            <div class="feature">
                <h3>Access Control</h3>
                <p>Control who can view, edit, or comment on your notes by setting specific access permissions.</p>
            </div>
        </div>
    </section>

    <!-- CTA -->
    <section class="cta-section">
        <h2>Start sharing your notes today!</h2>
        <p>Join our community of students and educators to collaborate and share notes seamlessly.</p>
        <a href="register.jsp" class="cta-button">Get Started</a>
    </section>

    
    <section class="get-started-features">
        <img src="images/features.jpg" alt="Illustration of starting a project">
        <div class="content">
            <h3>Start Your Journey</h3>
            <p>Embark on a seamless note-sharing experience with our platform. Begin by creating your profile and uploading your first note.</p>

            <div class="feature">
                <h3>Feature 1: Real-Time Collaboration</h3>
                <p>Work with peers simultaneously and see changes in real-time.</p>
            </div>
            <div class="feature">
                <h3>Feature 2: Secure Storage</h3>
                <p>Your notes are safely stored with encrypted access.</p>
            </div>
            <div class="feature">
                <h3>Feature 3: Easy Sharing</h3>
                <p>Share notes effortlessly via links or direct email invites.</p>
            </div>
        </div>
    </section>

    <!-- Contact  -->
    <section class="contact-section">
        <h2>Contact Us</h2>
        <form action="saveMessage.jsp" method="post">
            <input type="text" name="name" placeholder="Your Name" required>
            <input type="email" name="email" placeholder="Your Email" required>
            <textarea name="message" placeholder="Your Message" required></textarea>
            <button type="submit">Send Message</button>
        </form>
    </section>

    <footer>
        <p>&copy; 2025 Note Sharing Platform. All Rights Reserved.</p>
    </footer>
</body>
</html>
