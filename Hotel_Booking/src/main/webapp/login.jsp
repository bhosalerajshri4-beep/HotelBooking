<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Rivora - Sign In</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-stone-950 flex items-center justify-center min-h-screen font-sans">
    <div class="bg-black/80 p-10 rounded-lg border border-[#C5A06B]/30 w-full max-w-md shadow-2xl">
        <div class="text-center mb-10">
            <h2 class="text-[#C5A06B] text-3xl font-light tracking-[0.2em] uppercase">Sign In</h2>
            <p class="text-gray-500 text-xs mt-2 uppercase tracking-widest">Experience Timeless Elegance</p>
        </div>
        
        <form action="LoginServlet" method="post" class="space-y-6">
            <div>
                <label class="text-gray-400 text-xs uppercase tracking-widest block mb-2">Email Address</label>
                <input type="email" name="email" required class="w-full bg-transparent border-b border-gray-700 py-2 text-white focus:outline-none focus:border-[#C5A06B] transition-colors" placeholder="your@email.com">
            </div>
            <div>
                <label class="text-gray-400 text-xs uppercase tracking-widest block mb-2">Password</label>
                <input type="password" name="password" required class="w-full bg-transparent border-b border-gray-700 py-2 text-white focus:outline-none focus:border-[#C5A06B] transition-colors" placeholder="••••••••">
            </div>
            <button type="submit" class="w-full bg-[#C5A06B] py-4 text-xs font-bold uppercase tracking-[0.3em] hover:bg-white hover:text-black transition-all">
                Login to Rivora
            </button>
        </form>
    </div>
</body>
</html>