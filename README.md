# 🏨 Hotel Booking Management System (Rivora Luxury)

A premium, full-stack Hotel Booking web application developed using enterprise Java EE standards and an elegant, responsive luxury UI. The system separates standard guest browsing/booking environments from secure, high-level administrative analytical dashboard controls.

---

## 🚀 Features

### 👤 User Panel
* **Dynamic Landing Portal:** Immersive UI styled with Tailwind CSS, featuring custom interactive hover effects, glowing design configurations, and layout matrices.
* **Location Search Filters:** Flexible room explorer options to search premium room stays across key city hubs like Pune, Mumbai, and Bangalore.
* **Session Management:** Secure user state handling and route validation contexts using standard `HttpSession` APIs.

### ⚙️ Admin Dashboard
* **Real-time Analytics:** Modern tracking counters measuring business-critical parameters like Total Bookings, Active Room Occupancy, and Gross Revenue.
* **Reservation Pipelines:** High-fidelity data modules displaying live checkout states, guest check-ins, and pending validation streams.

---

## 🛠️ Technologies Used

### Frontend
* HTML5 / CSS3 (Custom transitions and animations)
* Tailwind CSS (Via cloud-based CDN integration)
* JavaScript (Interactive alerts and structural triggers)
* JSP (JavaServer Pages for dynamic page compiling)

### Backend Engine
* Java 17
* Java Servlets (Java EE Architecture)
* JDBC (Java Database Connectivity API)

### Database Management
* MySQL 8.0 Server

### Web Container Server
* Apache Tomcat 9.0

---

## 📂 Project Directory Structure

```bash
Hotel_Booking/
│
├── src/
│   └── main/
│       └── java/
│           └── com/
│               └── org/
│                   ├── LoginServlet.java     # Handles session auth & role-based routing
│                   ├── SignupServlet.java    # Manages secure registration persistence
│                   └── LogoutServlet.java    # Destroys active tokens & state drops
│
├── src/
│   └── main/
│       └── webapp/ (or WebContent/)
│           ├── WEB-INF/
│           │   └── lib/
│           │       └── mysql-connector-j-8.0.33.jar  # Relational Database Driver
│           ├── auth.jsp                      # Combined Dynamic Login & Signup UI
│           ├── index.jsp                     # User Dashboard & Destination Explorer
│           └── Admin_Dashboard.jsp           # Admin Analytics Panel
