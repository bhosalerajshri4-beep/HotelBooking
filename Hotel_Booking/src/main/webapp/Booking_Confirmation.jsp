<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String ctx = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Summary | Rivora Luxury</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
    <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
    <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700;800&family=Playfair+Display:ital,wght@0,700;1,700&display=swap');
        
        body { font-family: 'Plus Jakarta Sans', sans-serif; overflow-x: hidden; background: #0a0a0a; }
        .font-serif { font-family: 'Playfair Display', serif; }

        
        .bg-luxury-wrap { position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: -1; background: #121212; overflow: hidden; }
        .bg-image {
            width: 110%; height: 110%;
            background-image: linear-gradient(to bottom, rgba(0,0,0,0.5), rgba(0,0,0,0.8)), 
                              url('https://images.unsplash.com/photo-1670589953903-b4e2f17a70a9?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');
            background-size: cover; background-position: center;
            animation: kenBurns 20s infinite alternate ease-in-out;
        }
        @keyframes kenBurns { from { transform: scale(1); } to { transform: scale(1.1); } }

        
        .glass-container {
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(25px) saturate(180%);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 40px;
            color: white;
        }

        
        .animate-pop-in { animation: popIn 0.8s cubic-bezier(0.26, 0.53, 0.74, 1.48) forwards; opacity: 0; }
        @keyframes popIn { from { transform: scale(0.8); opacity: 0; } to { transform: scale(1); opacity: 1; } }

        .hover-lift { transition: all 0.4s ease; }
        .hover-lift:hover { transform: translateY(-5px); }
        
        .btn-luxury { 
            background: #d2a679; color: black; transition: 0.3s ease; 
            border: 1px solid #d2a679; font-weight: 800; 
        }
        .btn-luxury:hover { 
            background: transparent; color: #d2a679; 
            box-shadow: 0 0 30px rgba(210, 166, 121, 0.3); 
        }

       
        .info-label { text-[10px] font-black text-stone-500 uppercase tracking-widest mb-1; }
        .info-value { text-lg font-bold text-white tracking-tight; }

    </style>
</head>
<body class="min-h-screen p-4 md:p-10 flex items-center justify-center">

    <div class="bg-luxury-wrap"><div class="bg-image"></div></div>

    <div id="root" class="w-full max-w-7xl animate-pop-in"></div>

    <script type="text/babel">
        const { useEffect, useState } = React;

        function App() {
            const [booking, setBooking] = useState(null);

            useEffect(() => {
                const params = new URLSearchParams(window.location.search);
                setBooking({
                    customerName: params.get("customerName") || "Valued Guest",
                    hotel: params.get("hotel") || "Rivora Resort",
                    room: params.get("room") || "Luxury Suite",
                    price: params.get("price") || "0",
                    checkIn: params.get("checkIn") || "N/A",
                    checkOut: params.get("checkOut") || "N/A",
                    adult: params.get("adult") || "1",
                    children: params.get("children") || "0",
                    rooms: params.get("rooms") || "1",
                    extraBed: params.get("extraBed") || "0",
                    img: params.get("img")
                });
            }, []);

            if (!booking) return null;

            const handlePayment = () => {
                const query = new URLSearchParams(booking).toString();
                window.location.href = "Final_Payment.jsp?" + query;
            };

            return (
                <div className="glass-container p-6 md:p-16 shadow-2xl relative overflow-hidden">
                    {/* Header Row */}
                    <div className="flex justify-between items-center mb-10 md:mb-16 gap-6">
                        <div>
                            <h1 className="text-3xl md:text-5xl font-serif italic font-bold tracking-tighter">Your Stay, Secured.</h1>
                            <p className="text-[#d2a679] font-bold uppercase tracking-[5px] text-[10px] mt-2">Confirmation Summary</p>
                        </div>
                        <button 
                            onClick={() => window.location.href='index.jsp'}
                            className="text-stone-400 hover:text-red-400 transition-colors uppercase font-black text-[10px] tracking-widest flex items-center gap-2"
                        >
                            <i className="bi bi-x-lg"></i> Cancel
                        </button>
                    </div>

                    <div className="grid grid-cols-1 lg:grid-cols-12 gap-10 lg:gap-16">
                        {/* LEFT: TABLE STRUCTURE */}
                        <div className="lg:col-span-8">
                            <div className="hidden md:grid grid-cols-12 border-b border-white/10 pb-4 text-[10px] font-black text-stone-500 uppercase tracking-widest">
                                <div className="col-span-6">Accommodation Details</div>
                                <div className="col-span-4 text-center">Guest & Room Stats</div>
                                <div className="col-span-2 text-right">Investment</div>
                            </div>

                            <div className="grid grid-cols-1 md:grid-cols-12 items-center py-8 border-b border-white/5 group gap-6">
                                {/* Room Info */}
                                <div className="col-span-1 md:col-span-6 flex flex-col md:flex-row gap-6">
                                    <div className="w-full md:w-32 h-48 md:h-32 rounded-3xl overflow-hidden shadow-2xl hover-lift">
                                        <img src={booking.img} className="w-full h-full object-cover" alt="room" />
                                    </div>
                                    <div className="flex flex-col justify-center">
                                        <h3 className="text-xl font-bold mb-1 tracking-tight">{booking.room}</h3>
                                        <p className="text-[#d2a679] text-xs font-bold uppercase tracking-widest mb-3">{booking.hotel}</p>
                                        <div className="flex gap-2">
                                            <div className="inline-flex items-center gap-2 bg-white/5 px-3 py-1 rounded-full text-[10px]">
                                                <i className="bi bi-calendar-check text-[#d2a679]"></i>
                                                <span className="font-bold">{booking.checkIn}</span>
                                            </div>
                                            <div className="inline-flex items-center gap-2 bg-white/5 px-3 py-1 rounded-full text-[10px]">
                                                <i className="bi bi-calendar-x text-red-400"></i>
                                                <span className="font-bold">{booking.checkOut}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                {/* Stats Grid */}
                                <div className="col-span-1 md:col-span-4">
                                    <div className="grid grid-cols-2 gap-3 text-center">
                                        <div className="bg-white/5 p-3 rounded-2xl border border-white/10">
                                            <p className="text-[8px] font-black uppercase text-[#d2a679] mb-1">Adults</p>
                                            <p className="font-bold text-sm">{booking.adult}</p>
                                        </div>
                                        <div className="bg-white/5 p-3 rounded-2xl border border-white/10">
                                            <p className="text-[8px] font-black uppercase text-[#d2a679] mb-1">Children</p>
                                            <p className="font-bold text-sm">{booking.children}</p>
                                        </div>
                                        <div className="bg-white/5 p-3 rounded-2xl border border-white/10">
                                            <p className="text-[8px] font-black uppercase text-[#d2a679] mb-1">Rooms</p>
                                            <p className="font-bold text-sm">{booking.rooms}</p>
                                        </div>
                                        <div className="bg-white/5 p-3 rounded-2xl border border-white/10">
                                            <p className="text-[8px] font-black uppercase text-[#d2a679] mb-1">Extra Bed</p>
                                            <p className="font-bold text-sm">{booking.extraBed}</p>
                                        </div>
                                    </div>
                                </div>

                                {/* Price Column */}
                                <div className="col-span-1 md:col-span-2 text-center md:text-right">
                                    <p className="md:hidden text-[10px] text-stone-500 uppercase font-black mb-2">Subtotal</p>
                                    <span className="text-3xl md:text-4xl font-black tracking-tighter text-[#d2a679]">
                                        ₹{Number(booking.price).toLocaleString()}
                                    </span>
                                </div>
                            </div>
                        </div>

                        {/* RIGHT: SUMMARY CARD */}
                        <div className="lg:col-span-4">
                            <div className="bg-white/5 p-8 md:p-10 rounded-[35px] border border-white/10 sticky top-10 backdrop-blur-md">
                                <h4 className="text-lg font-bold mb-8 flex items-center gap-3">
                                    <i className="bi bi-receipt text-[#d2a679]"></i> Order Totals
                                </h4>
                                
                                <div className="space-y-4 mb-10 border-b border-white/5 pb-8 text-sm opacity-70">
                                    <div className="flex justify-between">
                                        <span>Room Stay x {booking.rooms}</span>
                                        <span>₹{Number(booking.price).toLocaleString()}</span>
                                    </div>
                                    <div className="flex justify-between text-green-400 font-bold uppercase text-[10px]">
                                        <span>Tax & Service</span>
                                        <span>Included</span>
                                    </div>
                                </div>

                                <div className="flex justify-between items-center mb-10">
                                    <span className="text-xs font-black uppercase tracking-widest opacity-40">Final Amount</span>
                                    <span className="text-3xl md:text-4xl font-black text-white tracking-tighter">
                                        ₹{Number(booking.price).toLocaleString()}
                                    </span>
                                </div>

                                <button 
                                    onClick={handlePayment}
                                    className="w-full py-5 rounded-2xl font-black uppercase text-[11px] tracking-[3px] btn-luxury hover:bg-white active:scale-95 transition-all shadow-2xl"
                                >
                                    Proceed to Checkout
                                </button>
                                
                                <p className="text-center text-[9px] text-white/20 mt-6 uppercase tracking-widest font-bold italic">
                                    Trusted by Rivora Luxury Group
                                </p>
                            </div>
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