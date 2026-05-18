<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<% 
    String sessionUser = (String) session.getAttribute("username");
    if (sessionUser == null) {
        response.sendRedirect("auth.jsp");
        return; 
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Reservations | Rivora Luxury</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
    <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
    <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700;800&family=Playfair+Display:ital,wght@0,700;1,700&display=swap');
        
        body { 
            font-family: 'Plus Jakarta Sans', sans-serif; 
            margin: 0; 
            background: #000; /* Fallback color */
            overflow-x: hidden;
            color: white;
        }

        /* --- Background Animation Styling --- */
        .luxury-bg-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }

        .luxury-bg-image {
            width: 110%;
            height: 110%;
            background-image: linear-gradient(to bottom, rgba(0,0,0,0.7), rgba(0,0,0,0.9)), 
                              url('https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?q=80&w=2070');
            background-size: cover;
            background-position: center;
            animation: luxuryZoom 25s infinite alternate ease-in-out;
        }

        @keyframes luxuryZoom {
            0% { transform: scale(1) translate(0, 0); }
            100% { transform: scale(1.1) translate(-2%, -2%); }
        }
        /* ------------------------------------ */

        .font-serif { font-family: 'Playfair Display', serif; }
        
        .glass-card { 
            background: rgba(255, 255, 255, 0.03); 
            backdrop-filter: blur(20px); 
            border: 1px solid rgba(255, 255, 255, 0.1); 
            border-radius: 35px; 
            transition: 0.5s cubic-bezier(0.4, 0, 0.2, 1); 
        }
        
        .glass-card:hover { 
            border-color: #d2a679; 
            background: rgba(255, 255, 255, 0.06); 
            transform: translateY(-5px);
        }

        .animate-up {
            animation: fadeInUp 1s ease-out forwards;
            opacity: 0;
        }

        @keyframes fadeInUp {
            from { transform: translateY(30px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
    </style>
</head>
<body class="min-h-screen pb-20">

    <!-- Background Layer -->
    <div class="luxury-bg-container">
        <div class="luxury-bg-image"></div>
    </div>

    <div class="max-w-7xl mx-auto px-6 pt-16 mb-12 flex justify-between items-end animate-up">
        <div>
            <p class="text-[#d2a679] font-bold uppercase tracking-[5px] text-[10px] mb-2">Exclusive Member Portal</p>
            <h1 class="text-4xl md:text-5xl font-serif italic font-bold tracking-tighter">My Reservations</h1>
        </div>
        <button onclick="location.href='index.jsp'" class="bg-white/5 hover:bg-white/10 px-8 py-3 rounded-full text-[10px] font-black uppercase tracking-widest transition-all border border-white/10">
            <i class="bi bi-house-door mr-2"></i> Home
        </button>
    </div>

    <div id="root" class="max-w-7xl mx-auto px-6"></div>

    <script type="text/babel">
        const { useState } = React;

        const hotelImages = {
            "Skyline Suite Mumbai": "https://images.unsplash.com/photo-1611892440504-42a792e24d32?w=800",
            "Pune Hinjewadi": "https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=800",
            "Yerawada,Pune": "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800",
            "Conrad Pune": "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800"
        };

        function ReservationCard({ data, onCancel }) {
            const displayImg = hotelImages[data.hotelName] || "https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80";

            return (
                <div className="glass-card overflow-hidden grid grid-cols-1 md:grid-cols-12 gap-6 p-6 mb-8 items-center animate-up">
                    <div className="md:col-span-3 h-48 rounded-[25px] overflow-hidden shadow-2xl bg-stone-900 group">
                        <img src={displayImg} className="w-full h-full object-cover transition-transform duration-1000 group-hover:scale-125" alt="hotel" />
                    </div>
                    
                    <div className="md:col-span-4">
                        <h3 className="text-2xl font-bold mb-1 tracking-tight">{data.roomType}</h3>
                        <p className="text-[#d2a679] font-medium text-xs mb-4 uppercase tracking-[3px]">{data.hotelName}</p>
                        <div className="flex gap-4">
                            <div className="bg-white/5 p-3 rounded-2xl border border-white/5">
                                <p className="text-[7px] text-stone-500 uppercase font-black">Date</p>
                                <p className="text-xs font-bold">{data.checkIn}</p>
                            </div>
                            <div className="bg-white/5 p-3 rounded-2xl border border-white/5">
                                <p className="text-[7px] text-stone-500 uppercase font-black">Guests</p>
                                <p className="text-xs font-bold">{data.adults} Adults</p>
                            </div>
                        </div>
                    </div>

                    <div className="md:col-span-2 text-center">
                        <p className="text-[10px] text-stone-500 uppercase font-black mb-1">Status</p>
                        <span className="bg-green-500/10 text-green-400 px-4 py-1 rounded-full text-[10px] font-bold border border-green-500/20 uppercase">
                            {data.status}
                        </span>
                    </div>

                    <div className="md:col-span-3 text-right">
                        <p className="text-[10px] text-stone-500 uppercase font-black mb-1">Final Total</p>
                        <p className="text-3xl font-black text-[#d2a679] tracking-tighter">₹{data.price}</p>
                        <button 
                            onClick={() => onCancel(data.bookingId)}
                            className="mt-4 bg-red-500/10 hover:bg-red-500 text-red-500 hover:text-white px-8 py-3 rounded-2xl text-[9px] font-black uppercase tracking-widest transition-all border border-red-500/20"
                        >
                            Cancel Stay
                        </button>
                    </div>
                </div>
            );
        }

        function App() {
            const [myBookings] = useState([
                <%
                    Connection conn = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivora_db", "root", "rajshri");
                        String sql = "SELECT id, hotel_name, room_type, check_in_date, adults, total_price, booking_status FROM bookings WHERE customer_name = ? ORDER BY id DESC";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ps.setString(1, sessionUser);
                        ResultSet rs = ps.executeQuery();
                        while(rs.next()) {
                %>
                { 
                    bookingId: "<%= rs.getString("id") %>", 
                    hotelName: "<%= rs.getString("hotel_name") %>",
                    roomType: "<%= rs.getString("room_type") %>",
                    checkIn: "<%= rs.getString("check_in_date") %>", 
                    adults: "<%= rs.getString("adults") %>",
                    price: "<%= rs.getString("total_price") %>",
                    status: "<%= rs.getString("booking_status") %>"
                },
                <%      }
                    } catch(Exception e) { e.printStackTrace(); } finally { if(conn != null) conn.close(); }
                %>
            ]);

            return (
                <div className="pb-10">
                    {myBookings.length > 0 ? (
                        myBookings.map((b, i) => <ReservationCard key={i} data={b} onCancel={(id) => {
                            if(confirm('Are you sure you want to cancel this luxury stay?')) window.location.href='DeleteBookingServlet?id='+id;
                        }} />)
                    ) : (
                        <div className="text-center py-32 opacity-30 glass-card">
                            <i className="bi bi-calendar-x text-7xl block mb-6"></i>
                            <p className="uppercase font-black tracking-[8px] text-[10px]">No active reservations found</p>
                        </div>
                    )}
                </div>
            );
        }

        const root = ReactDOM.createRoot(document.getElementById('root'));
        root.render(<App />);
    </script>
</body>
</html>