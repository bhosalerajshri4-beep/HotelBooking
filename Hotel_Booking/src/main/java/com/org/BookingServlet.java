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

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String customerName = request.getParameter("customerName");
            String hotel = request.getParameter("hotelName");
            String room = request.getParameter("roomType");
            String price = request.getParameter("price");
            String checkIn = request.getParameter("checkIn");
            
            int adults = (request.getParameter("adults") != null) ? Integer.parseInt(request.getParameter("adults")) : 0; 
            int children = (request.getParameter("children") != null) ? Integer.parseInt(request.getParameter("children")) : 0;
            int rooms = (request.getParameter("rooms") != null) ? Integer.parseInt(request.getParameter("rooms")) : 0;
            int extraBed = (request.getParameter("extraBed") != null) ? Integer.parseInt(request.getParameter("extraBed")) : 0;
           
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivora_db", "root", "rajshri");

            String sql = "INSERT INTO bookings (customer_name, hotel_name, room_type, total_price, check_in_date, adults, children, rooms, extra_bed) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, customerName);
            ps.setString(2, hotel);
            ps.setString(3, room);
            ps.setString(4, price);
            ps.setString(5, checkIn);
            ps.setInt(6, adults);
            ps.setInt(7, children);
            ps.setInt(8, rooms);
            ps.setInt(9, extraBed);

            int result = ps.executeUpdate();
            System.out.println("Success! Rows inserted: " + result); 

            con.close();
            response.setStatus(200);

        } catch (Exception e) {
            System.out.println("SQL ERROR: " + e.getMessage()); 
            e.printStackTrace(); 
            response.setStatus(500);
        }
    }
}