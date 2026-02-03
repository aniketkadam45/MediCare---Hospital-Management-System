# 🏥 MediCare – Enterprise Healthcare Management Application

# You Can view Live website at : http://13.61.4.141:8080/hospital

MediCare is a web-based **Enterprise Healthcare Management System** developed to manage hospital operations efficiently. 
The system provides a centralized dashboard for administrators to handle patient records, doctor registration, admissions, and billing with a modern and responsive user interface.

---

## 🚀 Key Features

### 🔐 Admin Dashboard
- Secure session-based authentication
- Hospital overview statistics:
  - Total patients
  - Patients admitted today
  - Currently active cases
- Recent patient admissions table
- Clean and modern UI using Bootstrap 5

### 🧑‍⚕️ Patient Management
- Register new patients
- View and search patient records
- Track admission and discharge dates
- Automatic Active / Inactive status handling

### 👨‍⚕️ Doctor Management
- Register and manage doctor details

### 💳 Billing System
- Patient billing module
- Easy access from admin dashboard

---

## 🛠️ Technology Stack

- Frontend: HTML, CSS, Bootstrap 5, JSP
- Backend: Java (JSP & Servlets)
- Database: MySQL
- Database Connectivity: JDBC
- Server: Apache Tomcat
- Icons: Bootstrap Icons
- Fonts: Google Fonts (Inter)

---

## 📂 Project Structure

MediCare/
├── src/
│   ├── com.dao/
│   │   └── DBConnection.java
│   ├── com.model/
│   └── com.controller/
│
├── WebContent/
│   ├── Patient/
│   │   ├── register.jsp
│   │   └── viewPatients.jsp
│   ├── Doctor/
│   │   └── registerDoc.jsp
│   ├── Bills/
│   │   └── billing.jsp
│   ├── header.jsp
│   ├── footer.jsp
│   ├── index.html
│   └── dashboard.jsp
│
├── img/
│   └── logo.svg
│
└── README.md

---

## 🗄️ Database Schema (Sample)

CREATE TABLE patient (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    disease VARCHAR(255),
    admission_date DATE,
    discharge_date DATE
);

---

## ⚙️ Installation & Setup

### Prerequisites
- Java JDK 8 or higher
- Apache Tomcat 9+
- MySQL Server
- Eclipse 

### Steps
1. Clone the repository
2. Import the project into your IDE
3. Configure MySQL database and update DBConnection.java
4. Deploy the project on Apache Tomcat
5. Access the application at http://localhost:8080/MediCare

---

## 📈 Future Enhancements

- Role-based access control
- Appointment scheduling
- Reports & analytics
- Email/SMS notifications

---

## 📄 License

MIT License
