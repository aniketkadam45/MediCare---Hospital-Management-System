<%@ page session="true" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">

<%
    if (session.getAttribute("adminSession") == null) {
    	response.sendRedirect(request.getContextPath() + "/index.html");
        return; 
    }
%>

<style>
    /* Premium Header Styling */
    .navbar-custom {
        background: #0f172a !important; /* Matches Footer Deep Navy */
        backdrop-filter: blur(10px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        padding: 0.8rem 0;
        transition: all 0.3s ease;
    }

    .navbar-brand {
        font-weight: 700;
        letter-spacing: -0.5px;
        font-size: 1.5rem;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .brand-accent { color: #3b82f6; } /* Medical Blue */

    /* Navigation Links */
    .nav-link {
        font-weight: 600;
        color: #94a3b8 !important;
        padding: 0.5rem 1.2rem !important;
        transition: all 0.3s ease;
        position: relative;
    }

    .nav-link:hover, .nav-link.active {
        color: #fff !important;
    }

    /* Animated Underline Effect */
    .nav-link::after {
        content: '';
        position: absolute;
        width: 0;
        height: 2px;
        bottom: 0;
        left: 50%;
        background: #3b82f6;
        transition: all 0.3s ease;
        transform: translateX(-50%);
    }

    .nav-link:hover::after {
        width: 60%;
    }

    /* Profile Dropdown Styling */
    .user-avatar-circle {
        width: 35px;
        height: 35px;
        background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        font-size: 0.8rem;
        border: 2px solid rgba(255,255,255,0.1);
    }

    .dropdown-menu {
        border: none;
        box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        border-radius: 12px;
        padding: 10px;
        margin-top: 15px;
        background: #ffffff;
    }

    .dropdown-item {
        border-radius: 8px;
        padding: 10px 20px;
        font-weight: 500;
        color: #475569;
        transition: 0.2s;
    }

    .dropdown-item:hover {
        background-color: #f1f5f9;
        color: #3b82f6;
        transform: translateX(5px);
    }

    /* Mobile Toggle */
    .navbar-toggler { border: none; padding: 0; }
    .navbar-toggler:focus { box-shadow: none; }
</style>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top">
    <div class="container">
        <a class="navbar-brand" href="<%= request.getContextPath() %>/home.jsp">
            <div class="bg-white p-1 rounded-3">
                <img src="<%= request.getContextPath() %>/img/logo.png" alt="Logo" width="33" height="33">
            </div>
            <span>Medi<span class="brand-accent">Care</span></span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="bi bi-list fs-1 text-white"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto"> <li class="nav-item">
            	<li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/home.jsp"><i class="bi bi-house-door me-1"></i> Dashboard</a>
                </li>
                <li>
                    <a class="nav-link" href="<%= request.getContextPath() %>/Patient/viewPatients.jsp"><i class="bi bi-people me-1"></i> Patients</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/Doctor/viewDoctors.jsp"><i class="bi bi-person-badge me-1"></i> Doctors</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/Appointment/appointments.jsp"><i class="bi bi-calendar-check me-1"></i> Appointments</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/Bills/billing.jsp"><i class="bi bi-credit-card me-1"></i> Billing</a>
                </li>
            </ul>

            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center gap-2" href="#" id="profileDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <% 
                           String user = (session.getAttribute("username") != null) ? (String)session.getAttribute("username") : "Admin";
                           String initial = user.substring(0,1).toUpperCase();
                        %>
                        <div class="user-avatar-circle"><%= initial %></div>
                        <span class="d-none d-lg-inline"><%= user %></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                        <li class="px-3 py-2 border-bottom mb-2">
                            <small class="text-muted d-block">Signed in as</small>
                            <span class="fw-bold text-dark"><%= user %></span>
                        </li>
                        <li><a class="dropdown-item" href="profile.jsp"><i class="bi bi-person me-2"></i> Profile</a></li>
                        <li><a class="dropdown-item" href="changePassword.jsp"><i class="bi bi-shield-lock me-2"></i> Security</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="<%= request.getContextPath() %>/index.html"><i class="bi bi-box-arrow-right me-2"></i> Sign Out</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>