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

@WebServlet("/DeleteBookingServlet")
public class DeleteBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
        String bookingId = request.getParameter("id");
        
        if (bookingId != null) {
            try {
       
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivora_db", "root", "rajshri");

                String sql = "DELETE FROM bookings WHERE id = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, bookingId);

                int result = ps.executeUpdate();

                if (result > 0) {
                    
                    response.sendRedirect("My_Reservations.jsp?msg=success");
                } else {
                   
                    response.sendRedirect("My_Reservations.jsp?msg=fail");
                }

                ps.close();
                conn.close();

            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Error: " + e.getMessage());
            }
        }
    }
}