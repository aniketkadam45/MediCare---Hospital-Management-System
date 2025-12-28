<%@ page import="com.dao.DBConnection"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("adminSession") == null) {
    	response.sendRedirect(request.getContextPath() + "/index.html");
        return; 
    }
%>

<%
 
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
    <title>MediCare | View All Patients</title>
    <link rel="icon" type="image/svg+xml" href="<%= request.getContextPath() %>/img/logo.svg">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root { --med-blue: #3b82f6; --dark: #0f172a; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #f8fafc; }
        
        /* Search Bar Styling */
        .search-wrapper {
            background: white;
            border-radius: 16px;
            padding: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.03);
            margin-bottom: 25px;
            border: 1px solid #e2e8f0;
        }
        
        .search-input {
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 10px 15px 10px 45px; /* Space for icon */
        }
        
        .search-icon { 
            position: absolute; 
            left: 15px; 
            top: 50%; 
            transform: translateY(-50%); 
            color: #94a3b8; 
            z-index: 10;
        }

        .main-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            border: none;
        }

        .table thead th {
            background-color: #f1f5f9;
            color: #64748b;
            text-transform: uppercase;
            font-size: 0.7rem;
            letter-spacing: 1px;
            padding: 15px;
            border: none;
        }

        .patient-name { font-weight: 700; color: var(--dark); }
        .info-label { font-size: 0.75rem; color: #94a3b8; display: block; }
        .data-value { font-size: 0.9rem; color: #475569; font-weight: 500; }
        
        .bill-amt { color: #16a34a; font-weight: 700; }
        
        .avatar-circle {
            width: 40px; height: 40px;
            background: #eff6ff; color: #2563eb;
            border-radius: 10px; display: flex;
            align-items: center; justify-content: center;
            font-weight: 700;
        }

        @media print { .no-print { display: none !important; } }
    </style>
</head>
<body>

    <jsp:include page="/header.jsp" />

    <div class="container py-5">
        
        <div class="row align-items-center mb-4 no-print">
            <div class="col-md-6">
                <h2 class="fw-bold mb-1 text-dark">Patient Directory</h2>
                <p class="text-muted small">Manage and monitor all admitted medical records.</p>
            </div>
            <div class="col-md-6 text-md-end">
                <button onclick="window.print()" class="btn btn-light border me-2 rounded-pill px-3">
                    <i class="bi bi-printer me-2"></i>Print List
                </button>
                <a href="<%= request.getContextPath() %>/Patient/register.jsp" class="btn btn-primary rounded-pill px-4 shadow-sm">
                    <i class="bi bi-plus-lg me-2"></i>Add Patient
                </a>
            </div>
        </div>

        <div class="search-wrapper no-print">
            <div class="position-relative">
                <i class="bi bi-search search-icon"></i>
                <input type="text" id="searchInput" class="form-control search-input shadow-none" 
                       placeholder="Search by name, disease, or doctor...">
            </div>
        </div>

        <div class="card main-card">
            <div class="table-responsive">
                <table class="table align-middle mb-0" id="patientTable">
                    <thead>
                        <tr>
                            <th class="ps-4">Patient / Identity</th>
                            <th>Contact / Address</th>
                            <th>Medical Info</th>
                            <th>Dates (Adm/Dis)</th>
                            <th>Billing & Room</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        try {
                            if (con != null) {
                                // Adjusted query to match common primary key naming or 'id'
                                String sql = "SELECT * FROM patient ORDER BY patient_id DESC";
                                Statement st = con.createStatement();
                                ResultSet rs = st.executeQuery(sql);

                                while(rs.next()) {
                                    String fName = rs.getString("first_name");
                                    String lName = rs.getString("last_name");
                                    String initial = fName.substring(0,1).toUpperCase();
                        %>
                        <tr class="patient-row">
                            <td class="ps-4">
                                <div class="d-flex align-items-center">
                                    <div class="avatar-circle me-3"><%= initial %></div>
                                    <div>
                                        <span class="patient-name"><%= fName %> <%= lName %></span>
                                        <span class="info-label"><%= rs.getString("gender") %>, <%= rs.getInt("age") %> Years</span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="data-value d-block"><i class="bi bi-telephone me-1"></i><%= rs.getString("phone") %></span>
                                <span class="info-label text-truncate" style="max-width: 150px;"><%= rs.getString("address") %></span>
                            </td>
                            <td>
                                <span class="badge bg-light text-dark border mb-1"><%= rs.getString("disease") %></span>
                                <span class="info-label">Doctor: <span class="text-primary fw-bold"><%= rs.getString("doctor_name") %></span></span>
                            </td>
                            <td>
                                <div class="data-value small"><b>Admit:</b> <%= rs.getDate("admission_date") %></div>
                                <div class="data-value small"><b>Discharge:</b> <%= rs.getDate("discharge_date") %></div>
                            </td>
                            <td>
                                <div class="data-value">Room: <span class="badge bg-secondary"><%= rs.getInt("room_number") %></span></div>
                                <div class="bill-amt">₹<%= String.format("%.2f", rs.getDouble("bill_amount")) %></div>
                            </td>
                            <td class="text-center">
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-light border rounded-pill" data-bs-toggle="dropdown">
                                        <i class="bi bi-three-dots"></i>
                                    </button>
                                    <ul class="dropdown-menu shadow border-0">
                                        <li><a class="dropdown-item" href="#"><i class="bi bi-eye me-2"></i>Details</a></li>
                                        <li><a class="dropdown-item text-danger" href="#"><i class="bi bi-trash me-2"></i>Delete</a></li>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                        <%
                                }
                                rs.close();
                                st.close();
                                con.close();
                            }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='6' class='text-center py-5'>Error loading data: " + e.getMessage() + "</td></tr>");
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <jsp:include page="/footer.jsp" />

    <script>
        document.getElementById('searchInput').addEventListener('keyup', function() {
            let filter = this.value.toLowerCase();
            let rows = document.querySelectorAll('#patientTable tbody tr.patient-row');
            
            rows.forEach(row => {
                let text = row.innerText.toLowerCase();
                row.style.display = text.includes(filter) ? '' : 'none';
            });
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>