<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
    String userName = (String) session.getAttribute("username");
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rivora Luxury - Home</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
    <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
    <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700&family=Inter:wght@400;500;600&display=swap');
        
        body { font-family: 'Inter', sans-serif; background-color: #FAF9F6; margin: 0; padding: 0; overflow-x: hidden; width: 100%; }
        .font-serif { font-family: 'Playfair Display', serif; }
        html { scroll-behavior: smooth; }

        .glass-nav { 
            position: fixed; top: 0; left: 0; width: 100%; z-index: 1000;
            background: white; border-bottom: 1px solid #eee; height: 75px; 
        }

 
        .chat-btn { background: #C5A06B !important; border: 4px solid white !important; }
        .chat-header { background: #1a1a1a !important; color: #C5A06B !important; }
        .chat-send-btn { color: #C5A06B !important; }
        .chat-container { position: fixed; bottom: 100px; right: 30px; width: 350px; height: 500px; background: white; border-radius: 30px; z-index: 2000; display: flex; flex-direction: column; box-shadow: 0 20px 60px rgba(0,0,0,0.1); border: 1px solid #eee; overflow: hidden; }
        .chat-trigger { position: fixed; bottom: 30px; right: 30px; width: 65px; height: 65px; background: #1a1a1a; color: #d2a679; border-radius: 50%; display: flex; align-items: center; justify-content: center; cursor: pointer; z-index: 2000; box-shadow: 0 10px 30px rgba(0,0,0,0.2); font-size: 24px; }

        .mobile-sidebar {
            position: fixed; top: 0; right: -100%; width: 300px; height: 100vh;
            background: #ffffff; z-index: 2000; transition: 0.4s ease-in-out;
            display: flex; flex-direction: column; padding: 100px 30px; gap: 20px;
            box-shadow: -10px 0 30px rgba(0,0,0,0.2);
        }
        .mobile-sidebar.active { right: 0 !important; }
        .sidebar-link { font-size: 1.1rem; font-weight: 700; color: #1a1a1a; text-decoration: none; border-bottom: 1px solid #f0f0f0; padding-bottom: 10px; text-transform: uppercase; }

        .expand-container { display: flex !important; height: 400px; gap: 12px; width: 100%; margin: 40px 0; }
        .expand-card { flex: 1 !important; border-radius: 20px; cursor: pointer; position: relative; transition: all 0.6s cubic-bezier(0.4, 0, 0.2, 1); overflow: hidden; background-size: cover; background-position: center; }

        @media (min-width: 1025px) { .expand-card:hover { flex: 3.5 !important; } }
        @media (max-width: 768px) {
            .expand-container { flex-direction: column !important; height: auto !important; }
            .expand-card { flex: none !important; height: 180px !important; width: 100% !important; }
        }

        .room-card { display: flex !important; background: white; border-radius: 20px; overflow: hidden; border: 1px solid #eee; margin-bottom: 2rem; transition: 0.3s; }
        .room-card:hover { transform: translateY(-5px); box-shadow: 0 15px 30px rgba(0,0,0,0.05); }

        @media (max-width: 1024px) {
            .room-card { flex-direction: column !important; }
            .room-price-side { width: 100% !important; border-left: none !important; border-top: 1px solid #eee; text-align: center !important; align-items: center !important; padding: 25px !important; }
        }

   
        .rivora-footer { background-color: #5C4B40; color: white; padding: 60px 20px 30px 20px; border-radius: 40px 40px 0 0; margin-top: 50px; }
        .footer-logo { font-size: 2.5rem; font-weight: 700; letter-spacing: 2px; }
        .footer-bottom { border-top: 1px solid rgba(255,255,255,0.1); margin-top: 40px; padding-top: 20px; text-align: center; font-size: 0.8rem; color: rgba(255,255,255,0.7); }
    </style>
</head>
<body>
    <div id="root"></div>

    <script type="text/babel">
        const { useState, useMemo, useEffect, useRef } = React;

       
        function ChatGPTWidget() {
            const [isOpen, setIsOpen] = useState(false);
            const [input, setInput] = useState("");
            const [isTyping, setIsTyping] = useState(false);
            const [messages, setMessages] = useState([{ role: "assistant", content: "Hi! I am Rivora AI. How can I help you today?" }]);
            const chatEndRef = useRef(null);

            useEffect(() => { chatEndRef.current?.scrollIntoView({ behavior: "smooth" }); }, [messages, isTyping]);

            const getBotResponse = (userInput) => {
                const msg = userInput.toLowerCase();
                if (msg.includes("price") || msg.includes("rent")) return "Our luxury rooms start from ₹4,200 (Pune) to ₹25,000 (Mumbai).";
                if (msg.includes("mumbai"))return "Rivora mumbai is located in Skyline Suite Mumbai.";
                if (msg.includes("bangluru"))return "Rivora bangluru is located in Indiranagar Boutique.";
                if (msg.includes("pune"))return "Rivora Pune is located in Hinjewadi Phase 1.";
                if (msg.includes("wifi")) return "Yes, we provide 5G high-speed Wi-Fi.";
                if (msg.includes("hi") || msg.includes("hello")) return "Hello! Welcome to Rivora Luxury. Looking for a room?";
                return "That's a great question! Our concierge will help you with that at +91 98765 43210.";
            };

            const handleSend = () => {
                if (!input.trim()) return;
                const userMsg = input;
                setMessages(prev => [...prev, { role: "user", content: input }]);
                setInput("");
                setIsTyping(true);
                setTimeout(() => {
                    const botReply = getBotResponse(userMsg);
                    setIsTyping(false);
                    setMessages(prev => [...prev, { role: "assistant", content: botReply }]);
                }, 1000);
            };

            return (
                <div className="fixed bottom-6 right-6 z-[5000]">
                    {isOpen ? (
                        <div className="w-[320px] md:w-[350px] h-[500px] bg-white rounded-2xl shadow-2xl flex flex-col border border-gray-200 overflow-hidden">
                            <div className="p-4 chat-header flex justify-between font-bold">
                                <span className="text-sm tracking-widest uppercase italic font-serif">Rivora GPT</span>
                                <i className="bi bi-x-lg cursor-pointer text-white" onClick={() => setIsOpen(false)}></i>
                            </div>
                            <div className="flex-1 overflow-y-auto p-4 space-y-4 text-gray-800 text-xs bg-stone-50">
                                {messages.map((m, i) => (
                                    <div key={i} className={"flex gap-2 " + (m.role === 'user' ? 'flex-row-reverse' : '')}>
                                        <div className={"w-6 h-6 rounded-full flex items-center justify-center text-[10px] text-white " + (m.role === 'assistant' ? 'bg-[#C5A06B]' : 'bg-gray-800')}>{m.role === 'assistant' ? 'R' : 'U'}</div>
                                        <div className={"p-3 rounded-xl max-w-[80%] shadow-sm " + (m.role === 'assistant' ? 'bg-white border' : 'bg-[#C5A06B] text-white')}>{m.content}</div>
                                    </div>
                                ))}
                                {isTyping && <div className="text-[10px] text-gray-500 animate-pulse ml-8 italic">Rivora is thinking...</div>}
                                <div ref={chatEndRef} />
                            </div>
                            <div className="p-4 flex gap-2 bg-white border-t">
                                <input value={input} onChange={(e)=>setInput(e.target.value)} onKeyPress={(e)=>e.key==='Enter' && handleSend()} className="flex-1 bg-stone-100 p-2 rounded-lg outline-none text-xs" placeholder="Ask anything..." />
                                <button onClick={handleSend} className="chat-send-btn"><i className="bi bi-send-fill text-xl"></i></button>
                            </div>
                        </div>
                    ) : (
                        <button onClick={() => setIsOpen(true)} className="w-14 h-14 chat-btn text-white rounded-full shadow-2xl flex items-center justify-center text-2xl hover:scale-110 transition-all">
                            <i className="bi bi-robot"></i>
                        </button>
                    )}
                </div>
            );
        }
    
        function Footer() {
            return (
                <footer className="rivora-footer">
                    <div className="max-w-7xl mx-auto px-6 grid grid-cols-1 md:grid-cols-3 items-center text-center gap-10 md:gap-0">
                        {/* Address */}
                        <div className="space-y-2">
                            <h4 className="text-lg font-bold tracking-widest uppercase mb-4">Address</h4>
                            <p className="text-sm opacity-80">742 Evergreen Terrace</p>
                            <p className="text-sm opacity-80">Brooklyn, NY 11201</p>
                        </div>

                        
                        <div className="flex flex-col items-center">
                            <div className="footer-logo font-serif italic mb-6">rivora</div>
                            <div className="flex gap-6 text-xl">
                                <i className="bi bi-facebook cursor-pointer hover:text-[#C5A06B]"></i>
                                <i className="bi bi-twitter-x cursor-pointer hover:text-[#C5A06B]"></i>
                                <i className="bi bi-instagram cursor-pointer hover:text-[#C5A06B]"></i>
                                <i className="bi bi-youtube cursor-pointer hover:text-[#C5A06B]"></i>
                            </div>
                        </div>

                       
                        <div className="space-y-2 text-center">
                            <h4 className="text-lg font-bold tracking-widest uppercase mb-4">Contact Us</h4>
                            <p className="text-sm opacity-80 font-bold">T. (+1) 234-5678</p>
                            <p className="text-sm opacity-80">M. contact@homely.com</p>
                        </div>
                    </div>
                    
                    <div className="footer-bottom">
                        Copyright 2026 – Rivora by Reacthemes
                    </div>
                </footer>
            );
        }

       
        function App() {
            const [searchTerm, setSearchTerm] = useState("");
            const [isMenuOpen, setIsMenuOpen] = useState(false);
            const ctx = "<%= ctx %>";
            const userName = "<%= (userName != null) ? userName : "" %>";

            const rooms = useMemo(() => [
                { id: 101, name: "ibis Pune Hinjewadi", city: "pune", loc: "Hinjawadi, Pune", mapUrl: "https://www.google.com/maps/search/ibis+Pune+Hinjewadi", desc: "Modern hub for business travelers. Tech-ready rooms and vibrant dining spaces.", price: 4200, rating: "4.5/5", img: "https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=800" },
                { id: 201, name: "Skyline Suite Mumbai", city: "mumbai", loc: "Marine Drive, Mumbai", mapUrl: "https://www.google.com/maps/search/Marine+Drive+Mumbai", desc: "Breathtaking Arabian Sea views meet timeless colonial charm on the iconic promenade.", price: 8500, rating: "4.8/5", img: "https://images.unsplash.com/photo-1611892440504-42a792e24d32?w=800" },
                { id: 301, name: "Indiranagar Boutique", city: "bangalore", loc: "Indiranagar, Bengaluru", mapUrl: "https://www.google.com/maps/search/Indiranagar+Bangalore", desc: "An artistic sanctuary tucked in Bangalore's trendiest neighborhood.", price: 6400, rating: "4.7/5", img: "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800" },
            ], []);

            const filtered = rooms.filter(r => r.city.toLowerCase().includes(searchTerm.toLowerCase()));

            const handleSearchScroll = () => {
                const element = document.getElementById('accommodations');
                if (element) window.scrollTo({ top: element.offsetTop - 80, behavior: 'smooth' });
            };

            const handleReservationClick = () => {
                if (userName) {
                    window.location.href = 'My_Reservations.jsp';
                } else {
                    window.location.href = 'auth.jsp';
                }
            };

            return (
                <div className="min-h-screen">
                    {/* NAVBAR */}
                    <nav className="glass-nav px-6 md:px-12 flex justify-between items-center">
                        <div className="text-2xl font-bold italic font-serif flex items-center gap-2">
                            <div className="w-6 h-6 border-2 border-[#C5A06B] rotate-45 flex items-center justify-center">
                                <div className="w-1.5 h-1.5 bg-[#C5A06B]"></div>
                            </div>
                            rivora
                        </div>

                        <div className="hidden lg:flex gap-10 items-center text-[13px] font-bold uppercase tracking-widest text-black">
                            <a href="index.jsp" className="hover:text-[#C5A06B]">Home</a>
                            <a href="AllRoom.jsp" className="hover:text-[#C5A06B]">Pages</a>
                            <a href="#" className="hover:text-[#C5A06B]">Blog</a>
                            
                            {userName ? (
                                <div className="flex items-center gap-4 border-l pl-6 border-gray-200">
                                    <span className="text-[#C5A06B] italic font-serif">Hi, {userName}</span>
                                    <a href="LogoutServlet" className="text-[10px] bg-[#C5A06B] text-white px-3 py-1 rounded-full hover:bg-black transition-all">Logout</a>
                                </div>
                            ) : (
                                <a href="auth.jsp" className="hover:text-[#C5A06B]">Login</a>
                            )}

                            <div className="flex items-center gap-3">
                                <button onClick={handleReservationClick} className="bg-white border-2 border-[#C5A06B] text-[#C5A06B] px-6 py-2.5 rounded-full font-bold hover:bg-[#C5A06B] hover:text-white transition-all text-[11px]">My Reservations</button>
                            </div>
                        </div>

                        <div className="lg:hidden flex flex-col gap-1.5 cursor-pointer z-[2500]" onClick={() => setIsMenuOpen(!isMenuOpen)}>
                            <div className={`w-7 h-0.5 bg-black transition-all ${isMenuOpen ? 'rotate-45 translate-y-2' : ''}`}></div>
                            <div className={`w-7 h-0.5 bg-black ${isMenuOpen ? 'opacity-0' : ''}`}></div>
                            <div className={`w-7 h-0.5 bg-black transition-all ${isMenuOpen ? '-rotate-45 -translate-y-2' : ''}`}></div>
                        </div>
                    </nav>

                    {/* HERO */}
                    <header className="relative h-[100vh] w-full flex items-center px-6 md:px-20 overflow-hidden">
                        <video autoPlay loop muted playsInline className="absolute inset-0 w-full h-full object-cover brightness-[0.8] z-0">
                            <source src={ctx + "/assets/video/video.mp4"} type="video/mp4" />
                        </video>
                        <div className="relative z-10 text-white w-full">
                            <h1 className="hero-title text-5xl md:text-8xl font-serif italic uppercase leading-tight tracking-tight">Luxury Comfort</h1>
                            <h1 className="hero-title text-5xl md:text-8xl md:ms-20 font-serif italic uppercase leading-tight tracking-tight">Timeless Elegance</h1>
                            <p className="hero-para mt-6 text-sm md:text-lg max-w-2xl opacity-90 leading-relaxed">
                                We deliver a refined hospitality experience where elegance, comfort, and attentive service come together.
                            </p>
                            <button className="mt-8 bg-[#C5A06B] px-8 py-3 rounded-full font-bold uppercase text-xs tracking-widest hover:bg-white hover:text-black">Reserve Your Stay</button>
                        </div>
                    </header>

                    {/* SEARCH AREA */}
                    <div id="search-area" className="relative z-20 -mt-10 flex justify-center px-4">
                        <div className="w-full max-w-4xl bg-white rounded-full p-2 flex items-center shadow-2xl border">
                            <input 
                                type="text" 
                                placeholder="Search by city (Pune, Mumbai...)" 
                                className="flex-1 px-8 py-3 outline-none text-gray-600 text-sm font-medium rounded-full"
                                value={searchTerm}
                                onChange={(e) => setSearchTerm(e.target.value)}
                            />
                            <button onClick={handleSearchScroll} className="bg-[#1c1c1c] text-white px-10 py-3 rounded-full text-xs font-bold uppercase">Search Now</button>
                        </div>
                    </div>

                    
                    <section className="px-6 md:px-10 mt-12 max-w-7xl mx-auto">
                        <div className="expand-container">
                            <div className="expand-card" style={{ backgroundImage: "url(./assets/Images/lobby_hotel1.avif)" }}>
                                <div className="absolute inset-0 bg-black/30"></div>
                                <div className="absolute bottom-6 left-6 text-white z-10 font-serif italic text-xl tracking-wide">The Lobby</div>
                            </div>
                            <div className="expand-card" style={{ backgroundImage: "url(./assets/Images/fining_dining_hotel1.avif)" }}>
                                <div className="absolute inset-0 bg-black/30"></div>
                                <div className="absolute bottom-6 left-6 text-white z-10 font-serif italic text-xl tracking-wide">Grand Suite</div>
                            </div>
                            <div className="expand-card" style={{ backgroundImage: "url(./assets/Images/luxury_hotel1.avif)" }}>
                                <div className="absolute inset-0 bg-black/30"></div>
                                <div className="absolute bottom-6 left-6 text-white z-10 font-serif italic text-xl tracking-wide">Culinary Hub</div>
                            </div>
                            <div className="expand-card" style={{ backgroundImage: "url(./assets/Images/hotel_pool1.avif)" }}>
                                <div className="absolute inset-0 bg-black/30"></div>
                                <div className="absolute bottom-6 left-6 text-white z-10 font-serif italic text-xl tracking-wide">Azure Pool</div>
                            </div>
                        </div>
                    </section>

                    
                    <section id="accommodations" className="max-w-6xl mx-auto py-16 px-6">
                        <div className="space-y-10">
                            {filtered.map(room => (
                                <div key={room.id} className="room-card">
                                    <div className="md:w-1/3 h-64 overflow-hidden relative">
                                        <img src={room.img} className="w-full h-full object-cover" />
                                    </div>
                                    <div className="flex-1 p-8 flex flex-col justify-center">
                                        <h3 className="text-2xl font-bold text-gray-800">{room.name}</h3>
                                        <a href={room.mapUrl} className="text-blue-600 text-[11px] font-bold uppercase tracking-widest block mt-1">📍 {room.loc}</a>
                                        <p className="mt-4 text-gray-500 text-sm leading-relaxed">{room.desc}</p>
                                        <div className="mt-6 flex items-center gap-4 text-red-500 text-[10px] font-bold uppercase"><span>❤️ Couple Friendly</span><span className="text-[#C5A06B]">🛡️ Safety Verified</span></div>
                                    </div>
                                    <div className="room-price-side md:w-1/4 p-8 border-l bg-gray-50 flex flex-col justify-between items-end">
                                        <div className="bg-black text-white px-3 py-1 rounded text-[10px] font-bold uppercase">{room.rating}</div>
                                        <div className="text-3xl font-bold text-gray-900">₹{room.price.toLocaleString()}</div>
                                        <button 
                                            onClick={() => window.location.href='Room_Details.jsp?id=' + room.id}
                                            className="w-full bg-[#d2a679] text-white py-4 rounded-xl text-[10px] font-bold uppercase tracking-[0.2em] shadow-lg"
                                        >
                                            Explore Room
                                        </button>
                                    </div>
                                </div>
                            ))}
                        </div>
                        <div className="mt-16 text-center">
                            <button onClick={() => window.location.href='AllRoom.jsp'}
                            className="border-2 border-[#C5A06B] text-[#C5A06B] px-12 py-4 text-[10px] font-bold uppercase tracking-[0.3em] rounded-full hover:bg-[#C5A06B] hover:text-white transition-all shadow-lg active:scale-95">
                            Explore All Accommodations
                            </button>
                        </div>
                    </section>
                    
                    
                    <Footer />

                    
                    <ChatGPTWidget />
                </div>
            );
        }

        const root = ReactDOM.createRoot(document.getElementById('root'));
        root.render(<App />);
    </script>
</body>
</html>