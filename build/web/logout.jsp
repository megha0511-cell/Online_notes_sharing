<%@ page session="true" %>
<%
    // Invalidate the session to remove all session attributes
    session.invalidate(); 

    // Optionally, display a message or log out success
    response.setHeader("Cache-Control", "no-store"); // Prevent caching of the page after logout
    response.setHeader("Pragma", "no-cache"); // For older browsers
    response.setDateHeader("Expires", 0); // Ensures that the page is not cached

    // Redirect to login page
    response.sendRedirect("login.jsp"); 
%>
