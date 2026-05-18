<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rivora Luxury | Authentication</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700&family=Playfair+Display:ital,wght@0,700;1,700&display=swap" rel="stylesheet">
    
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; }
        .font-serif { font-family: 'Playfair Display', serif; }
        .glass { 
            background: rgba(0, 0, 0, 0.85); 
            backdrop-filter: blur(20px); 
            border: 1px solid rgba(210, 166, 121, 0.2); 
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }
        .input-style { 
            background: transparent; 
            border-bottom: 1px solid #333; 
            padding: 15px 5px; 
            width: 100%; 
            outline: none; 
            color: white; 
            transition: 0.4s;
            font-size: 13px;
            letter-spacing: 1px;
        }
        .input-style:focus { border-color: #d2a679; }
        .btn-premium {
            background: #d2a679;
            color: black;
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .btn-premium:hover {
            background: white;
            letter-spacing: 5px;
        }
    </style>
</head>
<body class="bg-black flex items-center justify-center min-h-screen overflow-hidden">
    
    <div class="absolute inset-0 z-0">
        <img src="https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?q=80&w=2070" 
             class="w-full h-full object-cover opacity-30 scale-110 animate-[pulse_10s_infinite]">
    </div>

    <div class="relative z-10 w-full max-w-[420px] p-12 glass rounded-sm animate__animated animate__fadeIn">
        <div class="text-center mb-12">
            <h1 class="text-stone-500 font-bold uppercase tracking-[6px] text-[10px] mb-4">Welcome to Rivora</h1>
            <h2 id="title" class="text-4xl font-serif italic text-[#d2a679] tracking-widest uppercase">Sign In</h2>
            
            <% if("invalid".equals(request.getParameter("error"))) { %>
                <p class="text-red-400 text-[10px] mt-6 uppercase tracking-widest animate__animated animate__shakeX">
                    Invalid Credentials. Try Again.
                </p>
            <% } %>
            <% if("notfound".equals(request.getParameter("error"))) { %>
                <p class="text-red-400 text-[10px] mt-6 uppercase tracking-widest animate__animated animate__shakeX">
                    User not found. Please Sign Up!
                </p>
            <% } %>
            <% if("success".equals(request.getParameter("status"))) { %>
                <p class="text-green-500 text-[10px] mt-6 uppercase tracking-widest">
                    Account Created! Welcome Aboard.
                </p>
            <% } %>
        </div>

        <form id="authForm" action="<%=request.getContextPath()%>/LoginServlet" method="POST" class="space-y-8">
            <div id="nameContainer" class="hidden animate__animated animate__fadeIn">
                <input type="text" name="name" id="nameInput" placeholder="FULL NAME" class="input-style">
            </div>

            <div>
                <input type="email" name="email" placeholder="EMAIL ADDRESS" required class="input-style">
            </div>

            <div>
                <input type="password" name="password" placeholder="PASSWORD" required class="input-style">
            </div>
            
            <div class="pt-4">
                <button type="submit" id="submitBtn" class="w-full btn-premium py-5 text-[11px] font-black uppercase tracking-[0.3em] shadow-2xl">
                    Enter Rivora
                </button>
            </div>
        </form>

        <div class="mt-12 text-center border-t border-white/5 pt-8">
            <button onclick="toggle()" id="toggleBtn" class="text-[9px] text-gray-500 hover:text-[#d2a679] uppercase tracking-[0.2em] transition-all font-bold">
                New to Rivora? Create an Account
            </button>
        </div>
    </div>

    <script>
        let isLogin = true;
        function toggle() {
            isLogin = !isLogin;
            const title = document.getElementById('title');
            const nameContainer = document.getElementById('nameContainer');
            const nameInput = document.getElementById('nameInput');
            const submitBtn = document.getElementById('submitBtn');
            const toggleBtn = document.getElementById('toggleBtn');
            const form = document.getElementById('authForm');

           
            title.classList.add('animate__animated', 'animate__fadeIn');
            
            if (isLogin) {
                title.innerText = "Sign In";
                nameContainer.classList.add('hidden');
                nameInput.required = false;
                submitBtn.innerText = "Enter Rivora";
                toggleBtn.innerText = "New to Rivora? Create an Account";
                form.action = "<%=request.getContextPath()%>/LoginServlet";
            } else {
                title.innerText = "Sign Up";
                nameContainer.classList.remove('hidden');
                nameInput.required = true;
                submitBtn.innerText = "Begin Journey";
                toggleBtn.innerText = "Already a member? Sign In";
                form.action = "<%=request.getContextPath()%>/SignupServlet";
            }

            
            setTimeout(() => title.classList.remove('animate__animated', 'animate__fadeIn'), 500);
        }
    </script>
</body>
</html>