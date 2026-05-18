Hotel Booking Management System (Rivora Luxury)

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
💾 Database Setup
1. Create Schema & Tables
Run the following relational table structure inside your local MySQL instance or Workbench client to set up the authentication schema and insert initial users:

SQL
CREATE DATABASE IF NOT EXISTS rivora_db;
USE rivora_db;

CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'User'
);

-- Seed an Administrator account (Email: admin@rivora.com | Password: admin123)
INSERT INTO users (username, email, password, role) 
VALUES ('Rajshri Admin', 'admin@rivora.com', 'admin123', 'Admin')
ON DUPLICATE KEY UPDATE id=id;

-- Seed a sample regular User account (Email: john@gmail.com | Password: user123)
INSERT INTO users (username, email, password, role) 
VALUES ('John Doe', 'john@gmail.com', 'user123', 'User')
ON DUPLICATE KEY UPDATE id=id;
2. Configure Connections
Make sure to apply these driver connection string setups inside your Java Servlet controller files:

Java
Connection conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/rivora_db",
    "root",
    "your_password" // Replace with your local MySQL root password
);
⚙️ How to Setup & Run Locally
Clone Repository:

Bash
git clone [https://github.com/bhosalerajshri4-beep/HotelBooking.git](https://github.com/bhosalerajshri4-beep/HotelBooking.git)
Import into Workspace: Open Eclipse IDE -> File -> Import -> Existing Projects into Workspace -> Browse and select this folder.

Add Database Driver: Verify that mysql-connector-j-8.0.33.jar is correctly dropped inside the src/main/webapp/WEB-INF/lib/ folder pathway.

Link Server Container: Right-click project folder -> Properties -> Project Facets -> Runtimes -> Check mark Apache Tomcat v9.0 -> Click Apply.

Clean & Compile: Top menu bar -> Project -> Clean... to reset and rebuild workspace caches.

Deploy App: Right-click on auth.jsp -> Run As -> Run on Server.

🔮 Future Enhancements
💳 Online Payment Gateway Integrations (Stripe/Razorpay)

✉️ OTP Verification via SMS and Automated Email Bookings Confirmation

📅 Dynamic Room Availability Tracking using Calendar Grid UIs

📊 Analytical data charts and downloadable invoices for operational Admins
