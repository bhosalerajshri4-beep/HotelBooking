<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<% 
    String sessionUser = (String) session.getAttribute("username");
    String sessionRole = (String) session.getAttribute("role"); 
    
    if (sessionUser == null || !"ADMIN".equals(sessionRole)) {
        out.println("<script>alert('Access Denied!'); window.location.href='index.jsp';</script>");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Panel | Rivora Luxury</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
    <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
    <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&family=Playfair+Display:ital,wght@0,700;1,700&display=swap');
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: #f8f9fa; margin: 0; }
        .sidebar { background: #1a1a1a; min-height: 100vh; color: white; }
    </style>
</head>
<body>
    <div id="root"></div>

    <script type="text/babel">
        const { useState } = React;

        function App() {
            const [bookings] = useState([
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivora_db", "root", "rajshri");
                        String sql = "SELECT * FROM bookings ORDER BY id DESC";
                        Statement st = conn.createStatement();
                        ResultSet rs = st.executeQuery(sql);
                        while(rs.next()) {
                %>
                { 
                    id: "<%= rs.getString("id") %>", 
                    user: "<%= rs.getString("customer_name") %>",
                    hotel: "<%= rs.getString("hotel_name") %>",
                    room: "<%= rs.getString("room_type") %>",
                    price: "<%= rs.getString("total_price") %>"
                },
                <%      
                        }
                        conn.close();
                    } catch(Exception e) { } 
                %>
            ]);

            const deleteBooking = (id) => {
                if (window.confirm("Admin Action: Are you sure you want to delete this booking?")) {
                    window.location.href = "DeleteBookingServlet?id=" + id;
                }
            };

            return (
                <div className="flex">
                    <div className="w-64 sidebar p-8 hidden md:block">
                        <h2 className="text-2xl font-bold italic font-serif mb-12 text-[#d2a679]">rivora</h2>
                        <nav className="space-y-4">
                            <div className="p-3 bg-[#d2a679] text-black rounded-xl font-bold flex items-center gap-3"><i className="bi bi-grid-fill"></i> Dashboard</div>
                            <a href="LogoutServlet" className="p-3 text-red-400 flex items-center gap-3"><i className="bi bi-box-arrow-left"></i> Logout</a>
                        </nav>
                    </div>

                    <div className="flex-1 p-10">
                        <h2 className="text-3xl font-serif font-bold text-stone-800 mb-10">Reservation Overview</h2>
                        <div className="bg-white rounded-[30px] shadow-sm border border-stone-100 overflow-hidden">
                            <table className="w-full text-left">
                                <thead className="bg-stone-50 border-b border-stone-100">
                                    <tr>
                                        <th className="p-5 text-[10px] uppercase font-black text-stone-400">ID</th>
                                        <th className="p-5 text-[10px] uppercase font-black text-stone-400">Customer</th>
                                        <th className="p-5 text-[10px] uppercase font-black text-stone-400">Hotel</th>
                                        <th className="p-5 text-[10px] uppercase font-black text-stone-400">Price</th>
                                        <th className="p-5 text-center text-[10px] uppercase font-black text-stone-400">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {bookings.map((b, i) => (
                                        <tr key={i} className="border-b border-stone-50 hover:bg-stone-50">
                                            <td className="p-5 text-stone-400">{"#"+b.id}</td>
                                            <td className="p-5 font-bold">{b.user}</td>
                                            <td className="p-5">
                                                <p className="font-bold text-stone-700">{b.hotel}</p>
                                                <p className="text-[10px] text-stone-400 uppercase tracking-tighter">{b.room}</p>
                                            </td>
                                            <td className="p-5 font-black text-[#d2a679]">₹{b.price}</td>
                                            <td className="p-5 text-center">
                                                <button onClick={() => deleteBooking(b.id)} className="w-10 h-10 bg-red-50 text-red-500 rounded-xl hover:bg-red-500 hover:text-white transition-all">
                                                    <i className="bi bi-trash3-fill"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            );
        }

        const root = ReactDOM.createRoot(document.getElementById('root'));
        root.render(<App />);
    </script>
</body>
</html>