<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | Rivora Luxury</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body class="bg-gray-50 p-10">

    <div className="max-w-7xl mx-auto">
        <div class="flex justify-between items-center mb-10">
            <h1 class="text-3xl font-black uppercase tracking-tighter">Reservations Management</h1>
            <button onclick="window.location.reload()" class="bg-black text-white px-6 py-2 rounded-lg text-xs font-bold uppercase">Refresh Data</button>
        </div>

        <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
            <table class="w-full text-left">
                <thead class="bg-gray-100 border-b border-gray-200">
                    <tr class="text-[10px] font-black uppercase tracking-widest text-gray-500">
                        <th class="p-5">ID</th>
                        <th class="p-5">Hotel & Room</th>
                        <th class="p-5">Check-In</th>
                        <th class="p-5 text-center">Guests (A/C)</th>
                        <th class="p-5">Extra Bed</th>
                        <th class="p-5">Amount</th>
                        <th class="p-5">Action</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivora_db", "root", "rajshri");
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM bookings ORDER BY id DESC");

                            while(rs.next()) {
                    %>
                    <tr class="hover:bg-gray-50 transition-colors">
                        <td class="p-5 font-bold text-gray-400">#<%= rs.getInt("id") %></td>
                        <td class="p-5">
                            <p class="font-bold text-gray-800"><%= rs.getString("hotel_name") %></p>
                            <p class="text-[10px] text-gray-400 font-bold uppercase"><%= rs.getString("room_type") %></p>
                        </td>
                        <td class="p-5 text-sm font-semibold text-gray-600"><%= rs.getString("check_in_date") %></td>
                        <td class="p-5 text-center">
                            <span class="bg-blue-50 text-blue-600 px-2 py-1 rounded text-[10px] font-bold"><%= rs.getInt("adults") %>A</span>
                            <span class="bg-green-50 text-green-600 px-2 py-1 rounded text-[10px] font-bold ml-1"><%= rs.getInt("children") %>C</span>
                        </td>
                        <td class="p-5 font-bold text-gray-600"><%= rs.getInt("extra_bed") > 0 ? "YES" : "NO" %></td>
                        <td class="p-5 font-black text-[#d2a679]">₹<%= rs.getString("total_price") %></td>
                        <td class="p-5">
                            <td class="p-5">
    <a href="DeleteBookingServlet?id=<%= rs.getInt("id") %>" 
       onclick="return confirm('Delete Confirm')"
       class="text-red-400 hover:text-red-600 transition-colors text-xl">
        <i class="bi bi-trash3"></i>
    </a>
</td>
                        </td>
                    </tr>
                    <%
                            }
                            con.close();
                        } catch(Exception e) { out.println("Error: " + e.getMessage()); }
                    %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>