<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String ctx = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room List | Rivora Luxury</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
    <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
    <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700&family=Inter:wght@400;600;700&display=swap');
        
        body { font-family: 'Inter', sans-serif; background-color: #fcfcfc; margin: 0; padding: 0; }
        .font-serif { font-family: 'Playfair Display', serif; }

        .room-banner {
            height: 400px;
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), 
                        url('https://images.unsplash.com/photo-1566073771259-6a8506099945?w=1600');
            background-size: cover;
            background-position: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            text-align: center;
        }
        .banner-label { color: #cda274; font-weight: 700; text-transform: uppercase; letter-spacing: 3px; font-size: 0.9rem; }
        .banner-title { font-size: 5rem; font-weight: 800; margin: 10px 0; letter-spacing: -2px; }
        .breadcrumb-box { background: rgba(255,255,255,0.15); padding: 8px 25px; border-radius: 50px; backdrop-filter: blur(5px); font-size: 0.8rem; font-weight: 600; }
        
        .room-card { transition: 0.4s ease; background: white; border-radius: 20px; overflow: hidden; border: 1px solid #eee; }
        .room-card:hover { transform: translateY(-8px); box-shadow: 0 20px 40px rgba(0,0,0,0.08); }

        /* RIVORA FOOTER STYLES */
        .rivora-footer { background-color: #55443d; color: #fff; padding: 80px 0 40px 0; margin-top: 100px; border-radius: 60px 60px 0 0; }
        .footer-logo-main { font-size: 42px; font-weight: 700; font-family: 'Playfair Display', serif; display: flex; align-items: center; justify-content: center; gap: 12px; }
        .footer-socials a { color: #fff; font-size: 18px; opacity: 0.8; transition: 0.3s; }
        .footer-socials a:hover { color: #d2a679; opacity: 1; }
        .footer-copyright { border-top: 1px solid rgba(255,255,255,0.08); margin-top: 60px; padding-top: 30px; font-size: 13px; color: rgba(255,255,255,0.5); text-align: center; position: relative; }
        .back-to-top { position: absolute; right: 20px; bottom: 20px; width: 45px; height: 45px; background: #d2a679; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: #000; cursor: pointer; }
    </style>
</head>
<body>
    <div id="root"></div>

    <script type="text/babel">
        const { useState, useMemo } = React;

        function App() {
            const [searchTerm, setSearchTerm] = useState("");

            const rooms = useMemo(() => [
    { id: 101, name: "ibis Pune Hinjewadi", city: "pune", loc: "Hinjawadi,Pune", mapUrl: "https://www.google.com/maps/search/ibis+Pune+Hinjewadi", desc: "Palatial luxury with a stunning infinity pool and signature golf course views.", price: 19500, rating: "4.9/5", img: "https://assets.vogue.in/photos/68875070e14e6654b5c77aee/2:3/w_2560%2Cc_limit/ritz.jpg" },
    { id: 102, name: "Conrad Pune", city: "pune", loc: "Mangaldas Road, Pune", mapUrl: "https://www.google.com/maps/search/Conrad+Pune", desc: "Art Deco-inspired elegance featuring 7 award-winning restaurants and a luxury spa.", price: 12500, rating: "4.8/5", img: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0a/de/39/00/queen-double-room.jpg?w=700&h=-1&s=1" },
    { id: 103, name: "JW Marriott Pune", city: "pune", loc: "Senapati Bapat Road, Pune", mapUrl: "https://www.google.com/maps/search/JW+Marriott+Pune", desc: "A premier landmark for business travelers with a vibrant rooftop lounge and city views.", price: 14200, rating: "4.7/5", img: "https://images.trvl-media.com/lodging/4000000/3880000/3877900/3877863/44345830.jpg?impolicy=resizecrop&rw=575&rh=575&ra=fill" },
    { id: 104, name: "The Westin Koregaon Park", city: "pune", loc: "Koregaon Park, Pune", mapUrl: "https://www.google.com/maps/search/Westin+Pune", desc: "Riverside retreat offering Heavenly beds and easy access to the city's best nightlife.", price: 11000, rating: "4.6/5", img: "https://z.cdrst.com/foto/hotel-sf/12015c4a/granderesp/foto-hotel-120151a0.jpg" },
    { id: 105, name: "Blue Diamond SeleQtions", city: "pune", loc: "Koregaon Road, Pune", mapUrl: "https://www.google.com/maps/search/Blue+Diamond+Pune", desc: "The city's original luxury hotel, blending heritage charm with modern urban flair.", price: 8200, rating: "4.5/5", img: "https://images.pexels.com/photos/34377944/pexels-photo-34377944.jpeg" },

    // MUMBAI
    { id: 201, name: "Skyline Suite Mumbai", city: "mumbai", loc: "Marine Drive, Mumbai", mapUrl: "https://www.google.com/maps/search/Marine+Drive+Mumbai", desc: "An architectural marvel overlooking the Gateway of India with legendary service.", price: 28000, rating: "4.9/5", img: "https://static.toiimg.com/thumb/msid-64028431,width=1200,height=900/64028431.jpg" },
    { id: 202, name: "The St. Regis Mumbai", city: "mumbai", loc: "Lower Parel, Mumbai", mapUrl: "https://www.google.com/maps/search/St+Regis+Mumbai", desc: "India's highest hotel towers over the city with signature butler service and luxury malls.", price: 18500, rating: "4.8/5", img: "https://images.unsplash.com/photo-1546967900-1bea5f16b69d?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
    { id: 203, name: "JW Marriott Sahar", city: "mumbai", loc: "Andheri East, Mumbai", mapUrl: "https://www.google.com/maps/search/JW+Marriott+Sahar", desc: "Sophisticated airport hotel featuring lush greenery and expansive poolside cabanas.", price: 13000, rating: "4.7/5", img: "https://swisstravelmanager.com/wp-content/uploads/2024/10/img_8947.jpg" },
    { id: 204, name: "InterContinental Marine Drive", city: "mumbai", loc: "Marine Drive, Mumbai", mapUrl: "https://www.google.com/maps/search/InterContinental+Mumbai", desc: "Boutique luxury on the Queen's Necklace with a rooftop bar facing the sunset.", price: 15500, rating: "4.6/5", img: "https://juggler.makemytrip.com/juggler/stream/key/platform-ugc-01K7EWCCB4QPBHFN9JBJZN0H29/01K7EWCCB4QPBHFN9JBJZN0H29.jpg" },
    { id: 205, name: "Taj Lands End", city: "mumbai", loc: "Bandra West, Mumbai", mapUrl: "https://www.google.com/maps/search/Taj+Lands+End+Bandra", desc: "Stunning sea-facing property in Mumbai's trendiest suburb, Bandra.", price: 16800, rating: "4.7/5", img: "https://images.unsplash.com/photo-1564501049412-61c2a3083791?w=800" },

    // BANGALORE
    { id: 301, name: "Indiranagar Boutique", city: "bangalore", loc: "Indiranagar, Bengaluru", mapUrl: "https://www.google.com/maps/search/Indiranagar+Bangalore", desc: "Inspired by the Royal Palace of Mysore, set in nine acres of lush gardens.", price: 17500, rating: "4.9/5", img: "https://image.wedmegood.com/resized/800X/uploads/member/34644/1739447529_2022_05_23.jpg" },
    { id: 302, name: "ITC Gardenia", city: "bangalore", loc: "Residency Road, Bengaluru", mapUrl: "https://www.google.com/maps/search/ITC+Gardenia+Bangalore", desc: "A tribute to the Garden City, this eco-luxury hotel features vertical gardens.", price: 15000, rating: "4.8/5", img: "https://images.unsplash.com/photo-1596436889106-be35e843f974?w=800" },
    { id: 303, name: "The Park MG Road", city: "bangalore", loc: "MG Road, Bengaluru", mapUrl: "https://www.google.com/maps/search/The+Park+Bangalore", desc: "A chic boutique hotel in the heart of the business district with a famous pool bar.", price: 9500, rating: "4.4/5", img: "https://images.unsplash.com/photo-1498503182468-3b51cbb6cb24?w=800" },
    { id: 304, name: "Sheraton Grand Gateway", city: "bangalore", loc: "Brigade Gateway, Bengaluru", mapUrl: "https://www.google.com/maps/search/Sheraton+Grand+Bangalore", desc: "Directly connected to the World Trade Center with spectacular skyline views.", price: 12200, rating: "4.6/5", img: "https://images.unsplash.com/photo-1618773928121-c32242e63f39?w=800" },
    { id: 305, name: "Vivanta Bengaluru Whitefield", city: "bangalore", loc: "Whitefield, Bengaluru", mapUrl: "https://www.google.com/maps/search/Vivanta+Whitefield", desc: "Futuristic design meets the tech hub, perfect for the modern business nomad.", price: 10800, rating: "4.5/5", img: "https://images.unsplash.com/photo-1535827841776-24afc1e255ac?w=800" }
                
                
            ], []);

            const filtered = rooms.filter(r => r.city.toLowerCase().includes(searchTerm.toLowerCase()));

            const openMap = (url) => {
                window.open(url, '_blank');
            };

            return (
                <div className="min-h-screen flex flex-col">
                    <div className="flex-1">
                        <div className="room-banner">
                            <div className="banner-label">Enjoy Your Stay</div>
                            <h1 className="banner-title font-serif italic">Room List</h1>
                            <div className="breadcrumb-box text-white">
                                <a href="index.jsp" className="hover:text-[#cda274] transition">Home</a>
                                <span className="mx-3 text-[#cda274]">/</span>
                                <span>Room List</span>
                            </div>
                        </div>

                        <div className="max-w-4xl mx-auto -mt-10 px-4 relative z-20">
                            <div className="bg-white rounded-full p-2 flex items-center shadow-2xl border">
                                <input 
                                    type="text" 
                                    placeholder="Filter by City (e.g. Pune, Mumbai, Bangalore)..." 
                                    className="flex-1 px-8 md:px-12 py-4 outline-none text-gray-600 text-sm font-medium rounded-full"
                                    value={searchTerm}
                                    onChange={(e) => setSearchTerm(e.target.value)}
                                />
                                <button className="bg-[#1c1c1c] text-white px-10 py-4 rounded-full text-xs font-bold uppercase tracking-widest">Search</button>
                            </div>
                        </div>

                        <section className="max-w-6xl mx-auto py-24 px-6 text-gray-800">
                            <div className="flex justify-between items-center mb-12 border-b-2 border-stone-100 pb-6">
                                <h2 className="text-3xl font-serif italic">Exclusive Accommodations</h2>
                                <p className="text-[10px] font-bold text-gray-400 uppercase tracking-widest">{filtered.length} Properties Found</p>
                            </div>

                            <div className="space-y-12">
                                {filtered.map(room => (
                                    <div key={room.id} className="room-card flex flex-col md:flex-row shadow-sm">
                                        <div className="md:w-1/3 h-64 md:h-72 overflow-hidden relative">
                                            <img src={room.img} className="w-full h-full object-cover transition-transform duration-1000 hover:scale-110" />
                                            <div className="absolute top-4 left-4 bg-black/60 backdrop-blur-md px-4 py-1.5 rounded text-[10px] font-bold text-white uppercase tracking-widest">Rivora Select</div>
                                        </div>
                                        <div className="flex-1 p-8 flex flex-col justify-center">
                                            <h3 className="text-2xl font-bold tracking-tight">{room.name}</h3>
                                            <span 
                                                onClick={() => openMap(room.mapUrl)}
                                                className="text-blue-600 text-[10px] font-bold mt-1 uppercase tracking-widest inline-block cursor-pointer hover:underline"
                                            >
                                                📍 {room.loc}
                                            </span>
                                            <p className="mt-4 text-gray-500 text-sm leading-relaxed line-clamp-2">{room.desc}</p>
                                            <div className="mt-8 flex items-center gap-6">
                                                <span className="text-red-500 text-[10px] font-bold uppercase tracking-wider flex items-center gap-2">❤️ Couple Friendly</span>
                                                <span className="text-[#cda274] text-[10px] font-bold uppercase tracking-wider">🛡️ Safety Gold Verified</span>
                                            </div>
                                        </div>
                                        <div className="md:w-1/4 p-8 border-t md:border-l bg-gray-50/50 flex flex-col justify-between items-end text-right">
                                            <div className="bg-black text-white px-3 py-1 rounded text-[10px] font-bold uppercase">{room.rating}</div>
                                            <div>
                                                <p className="text-[10px] text-gray-400 font-bold uppercase mb-1">Starts From</p>
                                                <div className="text-4xl font-bold text-gray-900 tracking-tighter">₹{room.price.toLocaleString()}</div>
                                                <p className="text-[10px] text-gray-400 mt-1 uppercase">+ Taxes & Fees</p>
                                            </div>
                                            <button 
                                                onClick={() => window.location.href='Room_Details.jsp?id=' + room.id}
                                                className="w-full bg-[#d2a679] text-white py-4 rounded-xl text-[10px] font-bold uppercase tracking-[0.2em] shadow-lg transition-all active:scale-95"
                                            >
                                                Explore Room
                                            </button>
                                        </div>
                                    </div>
                                ))}
                            </div>
                        </section>
                    </div>

                    <footer className="rivora-footer">
                        <div className="max-w-7xl mx-auto px-6">
                            <div className="grid grid-cols-1 md:grid-cols-3 gap-16 items-center text-center">
                                <div>
                                    <h4 className="text-[12px] font-bold uppercase tracking-[2px] mb-6">Address</h4>
                                    <p className="text-stone-300 text-sm leading-relaxed">742 Evergreen Terrace<br/>Brooklyn, NY 11201</p>
                                </div>
                                <div>
                                    <div className="footer-logo-main">
                                        <i className="bi bi-flower3 text-[#d2a679]"></i>
                                        <span>rivora</span>
                                    </div>
                                    <div className="flex justify-center gap-6 mt-8 footer-socials">
                                        <a href="#"><i className="bi bi-facebook"></i></a>
                                        <a href="#"><i className="bi bi-twitter-x"></i></a>
                                        <a href="#"><i className="bi bi-instagram"></i></a>
                                        <a href="#"><i className="bi bi-youtube"></i></a>
                                    </div>
                                </div>
                                <div>
                                    <h4 className="text-[12px] font-bold uppercase tracking-[2px] mb-6">Contact Us</h4>
                                    <p className="text-stone-300 text-sm leading-relaxed">T. (+1) 234-5678<br/>M. contact@homely.com</p>
                                </div>
                            </div>
                            <div className="footer-copyright">
                                <p>Copyright 2026 – Rivora by Reacthemes</p>
                                <div className="back-to-top" onClick={() => window.scrollTo({top: 0, behavior: 'smooth'})}>
                                    <i className="bi bi-chevron-up"></i>
                                </div>
                            </div>
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