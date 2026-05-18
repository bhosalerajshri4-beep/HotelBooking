<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String ctx = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Checkout | Rivora Luxury</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/react@18/umd/react.production.min.js"></script>
    <script src="https://unpkg.com/react-dom@18/umd/react-dom.production.min.js"></script>
    <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700;800&family=Playfair+Display:ital,wght@0,700;1,700&display=swap');
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: #080808; color: white; margin: 0; overflow-x: hidden; }
        
        .bg-image-layer {
            position: fixed;
            inset: -50px;
            background: linear-gradient(to bottom, rgba(0,0,0,0.5), rgba(0,0,0,0.8)), 
                        url('https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');
           background-size: cover; background-position: center;
            animation: kenBurns 20s infinite alternate ease-in-out;
            
        }
        
        .card-glass {
            background: linear-gradient(135deg, rgba(25,25,25,0.9), rgba(10,10,10,0.95));
            backdrop-filter: blur(30px);
            border: 1px solid rgba(210, 166, 121, 0.2);
            border-radius: 40px;
        }

        .qr-box { background: white; padding: 10px; border-radius: 15px; width: 140px; height: 140px; margin: 0 auto; position: relative; }
        .scan-line {
            position: absolute; width: 90%; height: 2px; background: #d2a679;
            left: 5%; top: 10%; animation: scan 2s infinite linear; box-shadow: 0 0 10px #d2a679;
        }
        @keyframes scan { 0% { top: 10%; } 50% { top: 90%; } 100% { top: 10%; } }

        .detail-pill { background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.05); padding: 12px; border-radius: 20px; }
        
        .success-glow { text-shadow: 0 0 20px rgba(210, 166, 121, 0.5); }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4">

    <div id="bgLayer" class="bg-image-layer"></div>

    <div id="root" class="w-full max-w-xl z-10"></div>

    <script type="text/babel">
        const { useEffect, useState } = React;

        function App() {
            const [booking, setBooking] = useState(null);
            const [status, setStatus] = useState('idle');

            useEffect(() => {
                const handleMove = (e) => {
                    const x = (e.clientX - window.innerWidth / 2) / 60;
                    const y = (e.clientY - window.innerHeight / 2) / 60;
                    document.getElementById('bgLayer').style.transform = `translate(${x}px, ${y}px) scale(1.1)`;
                };
                window.addEventListener('mousemove', handleMove);

                const p = new URLSearchParams(window.location.search);
                setBooking({
                    name: p.get("customerName") || "Valued Guest",
                    hotel: p.get("hotel") || "Rivora Hotel",
                    room: p.get("room") || "Luxury Suite",
                    price: p.get("price") || "0",
                    cin: p.get("checkIn") || "Not Set",
                    cout: p.get("checkOut") || "Not Set",
                    adult: p.get("adult") || "0",
                    child: p.get("children") || "0",
                    rooms: p.get("rooms") || "0"
                });

                return () => window.removeEventListener('mousemove', handleMove);
            }, []);

            const onPay = async () => {
                setStatus('processing');
                const fd = new URLSearchParams();
                fd.append("customerName", booking.name);
                fd.append("hotelName", booking.hotel);
                fd.append("roomType", booking.room);
                fd.append("price", booking.price);
                fd.append("checkIn", booking.cin);
                fd.append("checkOut", booking.cout);
                fd.append("adults", booking.adult);
                fd.append("children", booking.child);
                fd.append("rooms", booking.rooms);

                try {
                    const res = await fetch('BookingServlet', { 
                        method: 'POST', 
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: fd.toString() 
                    });
                    if (res.ok) {
                        setStatus('success');
                        setTimeout(() => window.location.href = "index.jsp?status=ok", 3500);
                    } else { 
                        alert("Error processing request"); 
                        setStatus('idle'); 
                    }
                } catch { 
                    alert("Network Error"); 
                    setStatus('idle'); 
                }
            };

            if (status === 'success') return (
                <div className="card-glass p-16 text-center animate-in zoom-in-95 duration-700">
                    <div className="w-20 h-20 bg-[#d2a679] rounded-full flex items-center justify-center mx-auto mb-6 shadow-[0_0_40px_rgba(210,166,121,0.4)]">
                        <i className="bi bi-check-lg text-4xl text-black"></i>
                    </div>
                    <h2 className="text-3xl font-serif italic font-bold success-glow mb-2">Reservation Secured</h2>
                    <p className="text-[#d2a679] text-[10px] uppercase tracking-[4px] font-bold">Welcome to the Rivora Circle</p>
                    <div className="mt-8 text-stone-500 text-[9px] uppercase tracking-widest italic animate-pulse">Redirecting to dashboard...</div>
                </div>
            );

            if (!booking) return null;

            return (
                <div className="card-glass p-8 md:p-12 border border-white/10 shadow-2xl">
                    <div className="flex justify-between items-center mb-10">
                        <span className="font-serif italic text-2xl font-bold tracking-tighter">rivora</span>
                        <div className="flex items-center gap-2">
                             <i className="bi bi-shield-lock-fill text-[#d2a679] text-xs"></i>
                             <span className="text-[9px] font-bold uppercase tracking-[2px] text-stone-500">Secure Payment</span>
                        </div>
                    </div>

                    <div className="text-center mb-10">
                        <div className="qr-box shadow-xl">
                            <div className="scan-line"></div>
                            <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=rivora-payment" className="w-full h-full opacity-80" />
                        </div>
                        <p className="mt-4 text-[10px] font-bold text-[#d2a679] uppercase tracking-[4px]">Scan to Authorize</p>
                    </div>

                    <div className="grid grid-cols-2 gap-3 mb-10">
                        <div className="detail-pill col-span-2">
                            <p className="text-[8px] text-stone-500 uppercase font-bold tracking-widest mb-1">Guest Name</p>
                            <p className="text-sm font-bold text-white uppercase">{booking.name}</p>
                        </div>
                        <div className="detail-pill col-span-2">
                            <p className="text-[8px] text-stone-500 uppercase font-bold tracking-widest mb-1">Selected Destination</p>
                            <p className="text-sm font-bold text-[#d2a679]">{booking.hotel}</p>
                        </div>
                        <div className="detail-pill">
                            <p className="text-[8px] text-stone-500 uppercase font-bold tracking-widest mb-1">Check In</p>
                            <p className="text-xs font-bold">{booking.cin}</p>
                        </div>
                        <div className="detail-pill">
                            <p className="text-[8px] text-stone-500 uppercase font-bold tracking-widest mb-1">Check Out</p>
                            <p className="text-xs font-bold">{booking.cout}</p>
                        </div>
                        <div className="detail-pill">
                            <p className="text-[8px] text-stone-500 uppercase font-bold tracking-widest mb-1">Guest Details</p>
                            <p className="text-xs font-bold">{booking.adult} Adults • {booking.child} Children</p>
                        </div>
                        <div className="detail-pill">
                            <p className="text-[8px] text-stone-500 uppercase font-bold tracking-widest mb-1">Luxury Units</p>
                            <p className="text-xs font-bold">{booking.rooms} Room(s)</p>
                        </div>
                    </div>

                    <div className="border-t border-white/5 pt-6 mb-8 flex justify-between items-end px-2">
                        <div>
                            <p className="text-[9px] text-stone-500 uppercase font-black tracking-widest mb-1">Investment Total</p>
                            <p className="text-4xl font-black text-[#d2a679]">₹{Number(booking.price).toLocaleString()}</p>
                        </div>
                        <div className="text-right pb-1">
                            <p className="text-[8px] text-green-500 font-bold uppercase tracking-widest">Verified Merchant</p>
                        </div>
                    </div>

                    {status === 'processing' ? (
                        <div className="h-1 bg-white/5 rounded-full overflow-hidden">
                            <div className="h-full bg-[#d2a679] w-1/2 animate-[loading_1.5s_infinite_linear]"></div>
                        </div>
                    ) : (
                        <button onClick={onPay} className="w-full bg-[#d2a679] text-black py-5 rounded-2xl font-black uppercase text-[11px] tracking-[4px] hover:bg-white transition-all active:scale-95 shadow-lg">Finalize Reservation</button>
                    )}
                </div>
            );
        }

        const root = ReactDOM.createRoot(document.getElementById('root'));
        root.render(<App />);
    </script>
</body>
</html>