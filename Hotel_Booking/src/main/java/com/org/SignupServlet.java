package com.org;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("Attempting Signup for: " + name + " | " + email);

        Connection conn = null;
        try {
           
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivora_db", "root", "rajshri");

            String sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, password);

            int rows = pstmt.executeUpdate();

            if (rows > 0) {
                System.out.println("Data Inserted Successfully!");
         
                response.sendRedirect("auth.jsp?status=success");
            } else {
                System.out.println("Data insertion failed.");
                response.sendRedirect("auth.jsp?error=signupfailed");
            }

        } catch (Exception e) {
            System.out.println("Error detected: " + e.getMessage());
            e.printStackTrace(); 
            response.sendRedirect("auth.jsp?error=exception");
        } finally {
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}