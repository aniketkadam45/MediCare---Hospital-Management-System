<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>

<%
    // 1. Get the data from the HTML form
    String user = request.getParameter("username");
    String pass = request.getParameter("password");

    // 2. Define your Hardcoded Admin Credentials
    String ADMIN_ID = "admin";
    String ADMIN_KEY = "admin";

    // 3. Validation Logic
    if (user != null && pass != null) {
        if (user.equals(ADMIN_ID) && pass.equals(ADMIN_KEY)) {
            
            // SUCCESS: Create a session variable to protect internal pages
            session.setAttribute("adminSession", user);
            
            // Redirect to your main dashboard/home page
            response.sendRedirect("home.jsp");
            
        } else {
            // FAILURE: Show alert and go back to login
            out.println("<script type='text/javascript'>");
            out.println("alert('ACCESS DENIED: Invalid System Credentials');");
            out.println("window.location.href = 'index.html';");
            out.println("</script>");
        }
    } else {
        // Prevent direct access to this handler file
        response.sendRedirect("index.html");
    }
%>