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

@WebServlet("/CheckUserServlet")
public class CheckUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
        String name = request.getParameter("name");
        if (name != null) {
            name = name.trim(); 
        }
        
        String result = "not_found";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivora_db", "root", "rajshri");
            
            String sql = "SELECT * FROM bookings WHERE TRIM(customer_name) = ? LIMIT 1";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                result = "exists";
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            result = "error: " + e.getMessage();
        }
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(result);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}