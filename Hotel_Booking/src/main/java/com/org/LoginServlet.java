package com.org;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivora_db", "root", "rajshri");

            
            String sql = "SELECT username, role FROM users WHERE email=? AND password=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, password);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String name = rs.getString("username");
                String dbRole = rs.getString("role"); 

                HttpSession session = request.getSession(true);
                session.setAttribute("username", name);
                
                
                if ("ADMIN".equalsIgnoreCase(dbRole) || 
                    (email != null && "bhosalerajshri4@gmail.com".equalsIgnoreCase(email.trim()))) { 
                    
                    session.setAttribute("role", "ADMIN");
                    response.sendRedirect("Admin_Dashboard.jsp"); 
                } else {
                    session.setAttribute("role", "USER");
                    response.sendRedirect("index.jsp");
                }
            } else {
                response.sendRedirect("auth.jsp?error=notfound");
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("auth.jsp?error=servererror");
        }
    }
}