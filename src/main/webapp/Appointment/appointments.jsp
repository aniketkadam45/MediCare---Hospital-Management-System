<%@ page import="com.dao.DBConnection"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Security Guard
    if (session.getAttribute("adminSession") == null) {
        response.sendRedirect(request.getContextPath() + "/index.html");
        return; 
    }

    Connection con = null;
    try {
    	con = DBConnection.getConnection();
    } catch (Exception e) { 
        e.printStackTrace(); 
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MediCare | Appointment Schedule</title>
    <link rel="icon" type="image/svg+xml" href="<%= request.getContextPath() %>/img/logo.svg">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f0f2f5;
            color: #1a202c;
        }

        /* Matches your Home Page Header Style */
        .page-header-section {
            padding: 40px 0 30px;
        }

        .bg-gradient-medical {
            background: linear-gradient(135deg, #0d6efd 0%, #0dcaf0 100%);
        }

        /* Appointment Card Styling - Matches Stat Cards */
        .apt-card {
            border: none;
            border-radius: 16px;
            background: white;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .apt-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 20px rgba(0, 0, 0, 0.1);
        }

        .card-accent-bar {
            height: 4px;
            width: 100%;
            background: linear-gradient(to right, #0d6efd, #0dcaf0);
            border-radius: 16px 16px 0 0;
        }

        /* Elements from Home Page Styling */
        .time-badge {
            background-color: #e0e7ff;
            color: #4338ca;
            padding: 6px 12px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.85rem;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .status-pill {
            background-color: #dcfce7;
            color: #15803d;
            font-size: 0.75rem;
            font-weight: 700;
            padding: 4px 12px;
            border-radius: 20px;
        }

        .patient-avatar {
            width: 45px;
            height: 45px;
            background: #f1f5f9;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: #0d6efd;
            font-size: 1.1rem;
        }

        .doctor-info-box {
            background-color: #f8fafc;
            border-radius: 12px;
            padding: 12px;
            margin-top: auto;
        }

        .search-box-modern {
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            padding: 12px 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
        }

        .search-box-modern:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 3px rgba(13, 110, 253, 0.1);
        }
    </style>
</head>
<body>

    <jsp:include page="/header.jsp" />

    <div class="container py-5">
        
        <div class="row align-items-center mb-5">
            <div class="col-md-7">
                <h1 class="fw-bold mb-1">Appointment Schedule</h1>
                <p class="text-muted">Manage today's clinical checkups and patient visits</p>
            </div>
            <div class="col-md-5">
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0 rounded-start-3"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" id="aptSearch" class="form-control search-box-modern border-start-0" placeholder="Search by patient or doctor name...">
                </div>
            </div>
        </div>

        <div class="row g-4" id="appointmentList">
            <%
                try {
                    if (con != null) {
                        Statement st = con.createStatement();
                        ResultSet rs = st.executeQuery("SELECT * FROM patient ORDER BY admission_date DESC LIMIT 5");
                        while(rs.next()) {
                            String fName = rs.getString("first_name");
                            String lName = rs.getString("last_name");
                            String initials = (fName.substring(0,1) + lName.substring(0,1)).toUpperCase();
            %>
            <div class="col-md-6 col-lg-4 appointment-item">
                <div class="card apt-card">
                    <div class="card-accent-bar"></div>
                    <div class="p-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="time-badge">
                                <i class="bi bi-clock-fill"></i> 09:30 AM
                            </div>
                            <span class="status-pill">Confirmed</span>
                        </div>
                        
                        <div class="d-flex align-items-center mb-3">
                            <div class="patient-avatar me-3"><%= initials %></div>
                            <div>
                                <h5 class="fw-bold mb-0 text-dark"><%= fName %> <%= lName %></h5>
                                <small class="text-muted">Case: <%= rs.getString("disease") %></small>
                            </div>
                        </div>

                        <div class="doctor-info-box d-flex align-items-center justify-content-between">
                            <div class="small">
                                <span class="text-muted d-block">Doctor</span>
                                <span class="fw-semibold text-dark"><%= rs.getString("doctor_name") %></span>
                            </div>
                            <a href="#" class="btn btn-sm btn-outline-primary rounded-pill px-3">Details</a>
                        </div>
                    </div>
                </div>
            </div>
            <%
                        }
                    }
                } catch(Exception e) { 
                    out.println("<div class='col-12 text-center text-muted py-5'>Error loading schedule: " + e.getMessage() + "</div>"); 
                } finally {
                    if (con != null) con.close();
                }
            %>
        </div>
    </div>

    <jsp:include page="/footer.jsp" />

    <script>
        // Simple search filter
        document.getElementById('aptSearch').addEventListener('keyup', function() {
            let val = this.value.toLowerCase();
            document.querySelectorAll('.appointment-item').forEach(item => {
                let text = item.innerText.toLowerCase();
                item.style.display = text.includes(val) ? 'block' : 'none';
            });
        });
    </script>
</body>
</html>