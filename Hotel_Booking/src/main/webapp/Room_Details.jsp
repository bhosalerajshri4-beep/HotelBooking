<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
    String roomId = request.getParameter("id");
    if (roomId == null) roomId = "101"; 
    String ctx = request.getContextPath();
    String userName = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Details | Rivora Luxury</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
    <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
    <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&family=Playfair+Display:ital,wght@0,600;1,600&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #fff; color: #1a1a1a; margin: 0; }
        .font-serif { font-family: 'Playfair Display', serif; }
        .hero-banner { height: 480px; position: relative; display: flex; flex-direction: column; justify-content: center; align-items: center; color: white; background-size: cover; background-position: center; border-radius: 0 0 50px 50px; overflow: hidden; }
        .hero-overlay { position: absolute; inset: 0; background: rgba(0,0,0,0.5); z-index: 1; }
        .info-bar { background: #fdf7f0; border-radius: 20px; padding: 30px 60px; position: relative; z-index: 10; margin: -55px auto 0 auto; display: flex; justify-content: space-between; align-items: center; width: 100%; max-width: 1140px; border: 1px solid #efe3d5; }
        .reserve-box { background: white; padding: 40px; border-radius: 30px; box-shadow: 0 15px 50px rgba(0,0,0,0.05); border: 1px solid #f2f2f2; }
        .price-text { color: #d2a679; font-weight: 800; }
        .counter-btn { width: 34px; height: 34px; display: flex; align-items: center; justify-content: center; border-radius: 8px; background: #d2a679; color: white; cursor: pointer; transition: 0.2s; }
        .modal-overlay { position: fixed; inset: 0; background: rgba(0,0,0,0.9); backdrop-filter: blur(10px); z-index: 1000; display: flex; align-items: center; justify-content: center; }
        .carousel-snap { display: flex; overflow-x: auto; scroll-snap-type: x mandatory; scroll-behavior: smooth; border-radius: 30px; scrollbar-width: none; position: relative; }
        .carousel-snap::-webkit-scrollbar { display: none; }
        .snap-item { min-width: 100%; scroll-snap-align: start; height: 500px; }
        .snap-item img { width: 100%; height: 100%; object-fit: cover; }
        
        .chat-container { position: fixed; bottom: 100px; right: 30px; width: 350px; height: 500px; background: white; border-radius: 30px; z-index: 2000; display: flex; flex-direction: column; box-shadow: 0 20px 60px rgba(0,0,0,0.1); border: 1px solid #eee; overflow: hidden; }
        .chat-trigger { position: fixed; bottom: 30px; right: 30px; width: 65px; height: 65px; background: #1a1a1a; color: #d2a679; border-radius: 50%; display: flex; align-items: center; justify-content: center; cursor: pointer; z-index: 2000; box-shadow: 0 10px 30px rgba(0,0,0,0.2); font-size: 24px; }

        /* --- FOOTER SPECIFIC STYLES --- */
        .rivora-footer { background-color: #5C4B40; color: white; padding: 60px 20px 30px 20px; border-radius: 40px 40px 0 0; margin-top: 50px; }
        .footer-logo { font-size: 2.5rem; font-weight: 700; letter-spacing: 2px; }
        .footer-bottom { border-top: 1px solid rgba(255,255,255,0.1); margin-top: 40px; padding-top: 20px; text-align: center; font-size: 0.8rem; color: rgba(255,255,255,0.7); }

        /* --- NEW BUTTON STYLE --- */
        .view-all-btn { position: absolute; bottom: 20px; right: 20px; background: rgba(255, 255, 255, 0.8); backdrop-filter: blur(5px); color: #1a1a1a; padding: 10px 20px; border-radius: 12px; font-size: 12px; font-weight: 700; cursor: pointer; z-index: 20; border: none; transition: 0.3s; display: flex; align-items: center; gap: 8px; }
        .view-all-btn:hover { background: #fff; transform: translateY(-2px); }
    </style>
</head>
<body>
    <div id="root"></div>

    <script type="text/babel">
        const { useState, useMemo, useEffect, useRef } = React;

        function App() {
            const ctx = "<%= ctx %>";
            const currentId = "<%= roomId %>";
            const sessionUser = "<%= (userName != null) ? userName : "" %>";
            
            const [customerName, setCustomerName] = useState(sessionUser);
            const [showAuthModal, setShowAuthModal] = useState(false);
            const [checkIn, setCheckIn] = useState("");
            const [checkOut, setCheckOut] = useState("");
            const [booking, setBooking] = useState({ adult: 2, children: 0, rooms: 1, extraBed: 0 });

            const [isChatOpen, setIsChatOpen] = useState(false);
            const [chatInput, setChatInput] = useState("");
            const [messages, setMessages] = useState([{ role: "assistant", content: "Hi! I am Rivora AI. How can I help you today?" }]);
            
            const chatEndRef = useRef(null);
            const carouselRef = useRef(null);

            useEffect(() => { chatEndRef.current?.scrollIntoView({ behavior: "smooth" }); }, [messages]);

            const scrollToLastImage = () => {
                if (carouselRef.current) {
                    carouselRef.current.scrollTo({
                        left: carouselRef.current.scrollWidth,
                        behavior: 'smooth'
                    });
                }
            };

            const getBotResponse = (userInput) => {
                const msg = userInput.toLowerCase();
                if (msg.includes("price") || msg.includes("rent")) return "Our luxury rooms start from ₹4,200 (Pune) to ₹25,000 (Mumbai).";
                if (msg.includes("mumbai")) return "Rivora Mumbai is located in Skyline Suite Mumbai.";
                if (msg.includes("bangluru") || msg.includes("bangalore")) return "Rivora Bengaluru is located in Indiranagar Boutique.";
                if (msg.includes("pune")) return "Rivora Pune is located in Hinjewadi Phase 1.";
                if (msg.includes("wifi")) return "Yes, we provide 5G high-speed Wi-Fi.";
                if (msg.includes("hi") || msg.includes("hello")) return "Hello! Welcome to Rivora Luxury. Looking for a room?";
                return "That's a great question! Our concierge will help you with that at +91 98765 43210.";
            };

            const handleChatSend = (e) => {
                e.preventDefault();
                if (!chatInput.trim()) return;
                const newMessages = [...messages, { role: "user", content: chatInput }];
                setMessages(newMessages);
                const response = getBotResponse(chatInput);
                setChatInput("");
                setTimeout(() => {
                    setMessages(prev => [...prev, { role: "assistant", content: response }]);
                }, 600);
            };

            useEffect(() => {
                const today = new Date();
                const tomorrow = new Date();
                tomorrow.setDate(today.getDate() + 1);
                const f = (d) => d.toISOString().split('T')[0];
                setCheckIn(f(today));
                setCheckOut(f(tomorrow));
            }, []);

            const allHotels = useMemo(() => ({
               "101": { 
                    name: "ibis Pune Hinjewadi", hotel: "Yerawada,Pune", price: 19500, guests: "2 Guests", size: "28 Feets", bed: "Queen Bed", view: "City View", 
                    img: ctx + "/assets/Images/bg-1.avif",
                    gallery: [ctx + "/assets/Images/Ritz1.jpeg",ctx + "/assets/Images/Ritz4.jpeg", ctx + "/assets/Images/Ritz2.jpg", ctx + "/assets/Images/Rits3.webp"],
                    desc: "A smart hub for modern business travelers in the heart of Pune's IT corridor. Features high-speed Wi-Fi and ergonomic workspaces.",
                    amenities: ["Free Wi-Fi", "Smart TV", "Mini Fridge", "Coffee Maker", "Safe", "Work Desk"]
                },
                "104": { 
                    name: "The Westin Pune", hotel: "Westin Pune", price: 4200, guests: "2 Guests", size: "28 Feets", bed: "Queen Bed", view: "City View", 
                    img: ctx + "/assets/Images/bg-2.webp",
                    gallery: [ctx + "/assets/Images/westin1.webp", ctx + "/assets/Images/westin2.jpg", ctx + "/assets/Images/westin4.jpg",ctx + "/assets/Images/westin6.webp"],
                    desc: "A smart hub for modern business travelers in the heart of Pune's IT corridor. Features high-speed Wi-Fi and ergonomic workspaces.",
                    amenities: ["Free Wi-Fi", "Smart TV", "Mini Fridge", "Coffee Maker", "Safe", "Work Desk"]
                },
                "102": { 
                    name: "Conrad Pune", hotel: "Conrad Pune", price: 20000, guests: "4 Guests", size: "28 Feets", bed: "Queen Bed", view: "City View", 
                    img: ctx + "/assets/Images/conrad-bg.webp",
                    gallery: [ctx + "/assets/Images/Conrad1.jpg", ctx + "/assets/Images/conrad2.jpg", ctx + "/assets/Images/conrad3.jpeg",ctx + "/assets/Images/conrad4.webp",ctx + "/assets/Images/conrad5.webp"],
                    desc: "A smart hub for modern business travelers in the heart of Pune's IT corridor. Features high-speed Wi-Fi and ergonomic workspaces.",
                    amenities: ["Free Wi-Fi", "Smart TV", "Mini Fridge", "Coffee Maker", "Safe", "Work Desk"]
                },
                "103": { 
                    name: "JW Marriott Pune", hotel: "JW Marriott Pune", price: 12000, guests: "2 Guests", size: "28 Feets", bed: "Queen Bed", view: "City View", 
                    img: ctx + "/assets/Images/bg-4.avif",
                    gallery: [ctx + "/assets/Images/jwmarriot1.avif", ctx + "/assets/Images/jwmarriott2.jpg", ctx + "/assets/Images/jwmariott3.jpg",ctx + "/assets/Images/jwmariott4.avif"],
                    desc: "A smart hub for modern business travelers in the heart of Pune's IT corridor. Features high-speed Wi-Fi and ergonomic workspaces.",
                    amenities: ["Free Wi-Fi", "Smart TV", "Mini Fridge", "Coffee Maker", "Safe", "Work Desk"]
                },
                "105": { 
                    name: "Blue Diamond SeleQtions", hotel: "Blue Diamond SeleQtions", price: 6200, guests: "2 Guests", size: "28 Feets", bed: "Queen Bed", view: "City View", 
                    img: ctx + "/assets/Images/bg-5.avif",
                    gallery: [ctx + "/assets/Images/blue_diamond1.jpg", ctx + "/assets/Images/blue_diamond2.jpg", ctx + "/assets/Images/blue_diamond3.jpg",ctx + "/assets/Images/blue_diamond4.jpg",ctx + "/assets/Images/blue_diamond5.jpg",ctx + "/assets/Images/blue_diamond6.jpg"],
                    desc: "A smart hub for modern business travelers in the heart of Pune's IT corridor. Features high-speed Wi-Fi and ergonomic workspaces.",
                    amenities: ["Free Wi-Fi", "Smart TV", "Mini Fridge", "Coffee Maker", "Safe", "Work Desk"]
                },
                "202": { 
                    name: "The St. Regis Mumbai", hotel: " Mumbai", price: 25000, guests: "4 Guests", size: "85 Feets", bed: "Royal King", view: "Gateway View", 
                    img: ctx + "/assets/Images/bg-6.avif",
                    gallery: [ctx + "/assets/Images/stregin1.jpg", ctx + "/assets/Images/stregin2.avif", ctx + "/assets/Images/stregin3.avif", ctx + "/assets/Images/stregin4.jpeg", ctx + "/assets/Images/stregin5.avif", ctx + "/assets/Images/stregin6.jpeg", ctx + "/assets/Images/stregin7.jpg"],
                    desc: "Heritage luxury landmark overlooking the Gateway of India. Experience royalty with world-class service.",
                    amenities: ["Butler Service", "Luxury Tub", "Antique Decor", "Heritage Tour"]
                },
                "201": { 
                    name: "Skyline Suite Mumbai", hotel: "The Taj Mahal Palace", price: 45000, guests: "4 Guests", size: "85 Feets", bed: "Royal King", view: "Gateway View", 
                    img: ctx + "/assets/Images/bg-7.avif",
                    gallery: [ctx + "/assets/Images/tajmahal1.jpg", ctx + "/assets/Images/tajmahal2.avif", ctx + "/assets/Images/tajmahal3.jpg", ctx + "/assets/Images/tajmahal4.jpg", ctx + "/assets/Images/tajmahal5.jpg", ctx + "/assets/Images/tajmahal6.jpg"],
                    desc: "Heritage luxury landmark overlooking the Gateway of India. Experience royalty with world-class service.",
                    amenities: ["Butler Service", "Luxury Tub", "Antique Decor", "Heritage Tour"]
                },
                "204": { 
                    name: "InterContinental Marine Drive", hotel: "Trident Nariman Point", price: 10000, guests: "3 Guests", size: "85 Feets", bed: "Royal King", view: "Gateway View", 
                    img: ctx + "/assets/Images/bg-8.avif",
                    gallery: [ctx + "/assets/Images/marine1.avif", ctx + "/assets/Images/marine2.avif", ctx + "/assets/Images/marine3.avif", ctx + "/assets/Images/marine4.avif", ctx + "/assets/Images/marine5.avif", ctx + "/assets/Images/marine6.avif"],
                    desc: "Heritage luxury landmark overlooking the Gateway of India. Experience royalty with world-class service.",
                    amenities: ["Butler Service", "Luxury Tub", "Antique Decor", "Heritage Tour"]
                },
                "205": { 
                    name: "Taj Lands End", hotel: "Mumbai", price: 25000, guests: "4 Guests", size: "85 Feets", bed: "Royal King", view: "Gateway View", 
                    img: ctx + "/assets/Images/bg-9.avif",
                    gallery: [ctx + "/assets/Images/bg-1.avif", ctx + "/assets/Images/bg-2.avif", ctx + "/assets/Images/bg-3.avif"],
                    desc: "Heritage luxury landmark overlooking the Gateway of India. Experience royalty with world-class service.",
                    amenities: ["Butler Service", "Luxury Tub", "Antique Decor", "Heritage Tour"]
                },
                "203": { 
                    name: "JW Marriott Sahara", hotel: "Sahara Star", price: 25000, guests: "4 Guests", size: "85 Feets", bed: "Royal King", view: "Gateway View", 
                    img: ctx + "/assets/Images/bg-10.avif",
                    gallery: [ctx + "/assets/Images/jwmumbai1.avif", ctx + "/assets/Images/jwmumbai2.avif", ctx + "/assets/Images/jwmumbai3.avif", ctx + "/assets/Images/jwmumbai4.jpg", ctx + "/assets/Images/jwmumbai5.avif", ctx + "/assets/Images/jwmumbai6.avif"],
                    desc: "Heritage luxury landmark overlooking the Gateway of India. Experience royalty with world-class service.",
                    amenities: ["Butler Service", "Luxury Tub", "Antique Decor", "Heritage Tour"]
                },
                "303": { 
                    name: "The Park MG Road", hotel: "Indiranagar Boutique", price: 17000, guests: "2 Guests", size: "85 Feets", bed: "Royal King", view: "Gateway View", 
                    img: ctx + "/assets/Images/bg-11.avif",
                    gallery: [ctx + "/assets/Images/mg1.avif", ctx + "/assets/Images/mg2.avif", ctx + "/assets/Images/mg3.avif", ctx + "/assets/Images/mg4.avif", ctx + "/assets/Images/mg5.avif", ctx + "/assets/Images/mg6.avif"],
                    desc: "Heritage luxury landmark overlooking the Gateway of India. Experience royalty with world-class service.",
                    amenities: ["Butler Service", "Luxury Tub", "Antique Decor", "Heritage Tour"]
                },
                "301": { 
                    name: "Indiranagar Boutique", hotel: "Leela Palace Bangalore", price: 28000, guests: "3 Guests", size: "85 Feets", bed: "Royal King", view: "Gateway View", 
                    img: ctx + "/assets/Images/bg-12.avif",
                    gallery: [ctx + "/assets/Images/leela1.jpg", ctx + "/assets/Images/leela9.jpeg", ctx + "/assets/Images/leela3.avif", ctx + "/assets/Images/leela4.webp", ctx + "/assets/Images/leela5.jpg", ctx + "/assets/Images/leela6.jpg", ctx + "/assets/Images/leela7.webp", ctx + "/assets/Images/leela8.avif"],
                    desc: "Heritage luxury landmark overlooking the Gateway of India. Experience royalty with world-class service.",
                    amenities: ["Butler Service", "Luxury Tub", "Antique Decor", "Heritage Tour"]
                },
                "302": { 
                    name: "ITC Gardenia", hotel: "ITC Gardenia", price: 34999, guests: "2 Guests", size: "85 Feets", bed: "Royal King", view: "Gateway View", 
                    img: ctx + "/assets/Images/bg-13.avif",
                    gallery: [ctx + "/assets/Images/itc1.webp", ctx + "/assets/Images/itc2.jpeg", ctx + "/assets/Images/itc3.jpg", ctx + "/assets/Images/itc4.jpeg", ctx + "/assets/Images/itc5.avif", ctx + "/assets/Images/itc6.jpg", ctx + "/assets/Images/itc7.jpeg"],
                    desc: "Heritage luxury landmark overlooking the Gateway of India. Experience royalty with world-class service.",
                    amenities: ["Butler Service", "Luxury Tub", "Antique Decor", "Heritage Tour"]
                },
                "304": { 
                    name: "Sheraton Grand", hotel: "Sheraton Grand", price: 49999, guests: "3 Guests", size: "85 Feets", bed: "Royal King", view: "Gateway View", 
                    img: ctx + "/assets/Images/bg-14.avif",
                    gallery: [ctx + "/assets/Images/shera1.avif", ctx + "/assets/Images/shera2.avif", ctx + "/assets/Images/shera3.avif", ctx + "/assets/Images/shera4.avif", ctx + "/assets/Images/shera5.avif"],
                    desc: "Heritage luxury landmark overlooking the Gateway of India. Experience royalty with world-class service.",
                    amenities: ["Butler Service", "Luxury Tub", "Antique Decor", "Heritage Tour"]
                },
                "305": { 
                    name: "Vivanta Bengaluru Whitefield", hotel: "Shangri-La", price: 23000, guests: "2 Guests", size: "85 Feets", bed: "Royal King", view: "Gateway View", 
                    img: ctx + "/assets/Images/bg-15.avif",
                    gallery: [ctx + "/assets/Images/white1.avif", ctx + "/assets/Images/white2.avif", ctx + "/assets/Images/white2.avif", ctx + "/assets/Images/white3.avif", ctx + "/assets/Images/white4.avif", ctx + "/assets/Images/white5.avif", ctx + "/assets/Images/white6.avif", ctx + "/assets/Images/white7.avif", ctx + "/assets/Images/white8.avif"],
                    desc: "Heritage luxury landmark overlooking the Gateway of India. Experience royalty with world-class service.",
                    amenities: ["Butler Service", "Luxury Tub", "Antique Decor", "Heritage Tour"]
                },
            }), [ctx]);

            const data = allHotels[currentId] || allHotels["101"];

            const totalCost = useMemo(() => {
                const base = data.price;
                const extraAdults = booking.adult > 2 ? (booking.adult - 2) * 1200 : 0;
                const childrenPrice = booking.children * 600;
                const bedPrice = booking.extraBed * 1000;
                return (base + extraAdults + childrenPrice + bedPrice) * booking.rooms;
            }, [booking, data.price]);

            const handleConfirm = () => {
                if (sessionUser === "") { setShowAuthModal(true); return; }
                
                const query = "customerName=" + encodeURIComponent(customerName) + 
                              "&hotel=" + encodeURIComponent(data.hotel) + 
                              "&room=" + encodeURIComponent(data.name) + 
                              "&price=" + totalCost + 
                              "&checkIn=" + checkIn + 
                              "&checkOut=" + checkOut + 
                              "&adult=" + booking.adult + 
                              "&children=" + booking.children + 
                              "&rooms=" + booking.rooms + 
                              "&extraBed=" + booking.extraBed + 
                              "&img=" + encodeURIComponent(data.img);

                window.location.href = "Booking_Confirmation.jsp?" + query;
            };

            return (
                <div className="pb-0">
                    <div className="chat-trigger" onClick={() => setIsChatOpen(!isChatOpen)}>
                        <i className={isChatOpen ? "bi bi-x-lg" : "bi bi-chat-dots-fill"}></i>
                    </div>
                    {isChatOpen && (
                        <div className="chat-container">
                            <div className="bg-[#1a1a1a] p-5 text-[#d2a679] font-bold text-xs tracking-widest uppercase font-serif flex justify-between">
                                <span>Rivora AI</span>
                                <i className="bi bi-circle-fill text-green-500 text-[8px] animate-pulse"></i>
                            </div>
                            <div className="flex-1 p-4 overflow-y-auto space-y-4 bg-stone-50">
                                {messages.map((m, i) => (
                                    <div key={i} className={"flex " + (m.role === 'user' ? 'justify-end' : 'justify-start')}>
                                        <div className={"max-w-[80%] p-3 rounded-2xl text-[11px] font-bold " + (m.role === 'user' ? 'bg-[#d2a679] text-white rounded-br-none' : 'bg-white text-stone-700 rounded-bl-none shadow-sm')}>
                                            {m.content}
                                        </div>
                                    </div>
                                ))}
                                <div ref={chatEndRef} />
                            </div>
                            <form onSubmit={handleChatSend} className="p-3 border-t bg-white flex gap-2">
                                <input type="text" value={chatInput} onChange={(e)=>setChatInput(e.target.value)} placeholder="Type here..." className="flex-1 bg-stone-100 p-2 rounded-xl text-[11px] outline-none" />
                                <button type="submit" className="bg-[#1a1a1a] text-[#d2a679] p-2 rounded-xl px-4"><i className="bi bi-send-fill"></i></button>
                            </form>
                        </div>
                    )}

                    {showAuthModal && (
                        <div className="modal-overlay">
                            <div className="bg-[#1a1a1a] p-10 rounded-[40px] border border-white/10 w-full max-w-sm text-center">
                                <h2 className="font-serif italic text-3xl text-white mb-6 font-bold">Sign In Required</h2>
                                <button onClick={() => window.location.href='auth.jsp'} className="w-full bg-[#d2a679] text-black py-4 rounded-xl font-bold uppercase text-[10px]">Go to Login</button>
                                <button onClick={() => setShowAuthModal(false)} className="mt-4 text-stone-600 text-[9px] uppercase font-bold">Cancel</button>
                            </div>
                        </div>
                    )}

                    <header className="hero-banner" style={{ backgroundImage: "url('" + data.img + "')" }}>
                        <div className="hero-overlay"></div>
                        <h1 className="relative z-10 text-4xl md:text-6xl font-bold text-white font-serif italic uppercase text-center px-4 leading-tight">{data.name}</h1>
                    </header>

                    <div className="info-bar shadow-sm">
                        <div className="flex items-center gap-4"><i className="bi bi-people text-2xl text-[#d2a679]"></i><span className="text-gray-700 font-bold text-xs uppercase tracking-wider">{data.guests}</span></div>
                        <div className="flex items-center gap-4"><i className="bi bi-aspect-ratio text-xl text-[#d2a679]"></i><span className="text-gray-700 font-bold text-xs uppercase tracking-wider">{data.size}</span></div>
                        <div className="text-right">
                            <span className="text-2xl md:text-4xl font-black price-text">₹{totalCost.toLocaleString()}</span>
                        </div>
                    </div>

                    <main className="max-w-7xl mx-auto px-6 mt-20 grid grid-cols-1 lg:grid-cols-12 gap-16">
                        <div className="lg:col-span-8">
                            <div className="relative group">
                                <div className="carousel-snap mb-12 shadow-xl" ref={carouselRef}>
                                    {data.gallery.map((img, i) => (<div key={i} className="snap-item"><img src={img} alt="Hotel" /></div>))}
                                </div>
                                <button className="view-all-btn shadow-lg" onClick={scrollToLastImage}>
                                    <i className="bi bi-images"></i> View All Photos
                                </button>
                            </div>
                            
                            <h2 className="text-3xl font-serif italic mb-6 border-b pb-4">Description</h2>
                            <p className="text-gray-500 text-lg leading-relaxed mb-12">{data.desc}</p>
                            
                            <h2 className="text-2xl font-bold mb-8 uppercase italic font-serif text-stone-800">Luxury Amenities</h2>
                            <div className="grid grid-cols-2 md:grid-cols-3 gap-6">
                                {data.amenities.map((item, i) => (
                                    <div key={i} className="flex items-center gap-4 bg-stone-50 p-4 rounded-2xl border border-stone-100 hover:border-[#d2a679] transition-all">
                                        <i className="bi bi-patch-check-fill text-[#d2a679] text-xl"></i>
                                        <span className="text-xs font-bold uppercase tracking-tight text-stone-700">{item}</span>
                                    </div>
                                ))}
                            </div>
                        </div>

                        <div className="lg:col-span-4">
                            <div className="reserve-box sticky top-10">
                                <h3 className="text-2xl font-bold font-serif italic mb-8 border-b pb-4">Reserve</h3>
                                <div className="space-y-4">
                                    <div className="grid grid-cols-2 gap-4">
                                        <div><label className="text-[8px] font-bold text-gray-400 uppercase">Check In</label><input type="date" value={checkIn} onChange={(e)=>setCheckIn(e.target.value)} className="w-full bg-stone-50 p-2 text-xs font-bold rounded border" /></div>
                                        <div><label className="text-[8px] font-bold text-gray-400 uppercase">Check Out</label><input type="date" value={checkOut} onChange={(e)=>setCheckOut(e.target.value)} className="w-full bg-stone-50 p-2 text-xs font-bold rounded border" /></div>
                                    </div>
                                    <input type="text" value={customerName} onChange={(e)=>setCustomerName(e.target.value)} placeholder="Full Name" className="w-full outline-none font-bold text-lg bg-transparent border-b pb-2" />
                                    
                                    {[{l:'Adults', k:'adult', m:1}, {l:'Children', k:'children', m:0}, {l:'Rooms', k:'rooms', m:1}, {l:'Extra Bed', k:'extraBed', m:0}].map(x => (
                                        <div key={x.k} className="flex justify-between items-center bg-stone-50 p-4 rounded-2xl">
                                            <span className="text-[10px] font-black text-gray-400 uppercase tracking-widest">{x.l}</span>
                                            <div className="flex items-center gap-5">
                                                <div className="counter-btn" onClick={() => setBooking(p => ({...p, [x.k]: Math.max(x.m, p[x.k]-1)}))}>-</div>
                                                <span className="font-bold text-sm">{booking[x.k]}</span>
                                                <div className="counter-btn" onClick={() => setBooking(p => ({...p, [x.k]: p[x.k]+1}))}>+</div>
                                            </div>
                                        </div>
                                    ))}
                                </div>
                                <button onClick={handleConfirm} className="w-full bg-black text-white py-5 rounded-2xl font-black uppercase text-[10px] mt-10 hover:bg-[#d2a679] transition-all">Confirm Booking</button>
                            </div>
                        </div>
                    </main>

                    <section className="max-w-7xl mx-auto px-6 mt-28 border-t pt-20">
                        <h2 className="text-4xl font-serif italic text-stone-800 mb-12">Explore More Stays</h2>
                        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
                            {[102, 201, 301, 101].map(id => {
                                const h = allHotels[id] || allHotels["101"];
                                return (
                                    <div key={id} className="group cursor-pointer" onClick={() => window.location.href="Room_Details.jsp?id=" + id}>
                                        <div className="h-72 rounded-[40px] overflow-hidden mb-6 relative">
                                            <img src={h.img} className="w-full h-full object-cover group-hover:scale-110 transition-all duration-700" />
                                            <div className="absolute top-4 right-4 bg-black/60 backdrop-blur-md px-3 py-1 rounded-full text-white text-[8px] font-bold uppercase tracking-widest">{h.hotel}</div>
                                        </div>
                                        <h4 className="font-bold text-lg mb-1 group-hover:text-[#d2a679] transition-colors">{h.name}</h4>
                                        <p className="price-text font-black text-sm tracking-tight">₹{h.price.toLocaleString()} / Night</p>
                                    </div>
                                );
                            })}
                        </div>
                    </section>

                   
                    <footer className="rivora-footer">
                    <div className="max-w-7xl mx-auto px-6 grid grid-cols-1 md:grid-cols-3 items-center text-center gap-10 md:gap-0">
                       
                        <div className="space-y-2">
                            <h4 className="text-lg font-bold tracking-widest uppercase mb-4">Address</h4>
                            <p className="text-sm opacity-80">742 Evergreen Terrace</p>
                            <p className="text-sm opacity-80">Brooklyn, NY 11201</p>
                        </div>

                        {/* Logo & Socials */}
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
                </div>
            );
        }
        const root = ReactDOM.createRoot(document.getElementById('root'));
        root.render(<App />);
    </script>
</body>
</html>