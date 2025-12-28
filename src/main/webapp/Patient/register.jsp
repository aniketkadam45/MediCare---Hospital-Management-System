<%@ page import="com.dao.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    if (session.getAttribute("adminSession") == null) {
    	response.sendRedirect(request.getContextPath() + "/index.html");
        return; 
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCare | Patient Registration</title>
    <link rel="icon" type="image/svg+xml" href="<%= request.getContextPath() %>/img/logo.svg">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --medical-blue: #3b82f6;
            --dark-navy: #0f172a;
            --soft-bg: #f8fafc;
        }

        body { 
            font-family: 'Plus Jakarta Sans', sans-serif; 
            background-color: var(--soft-bg);
            color: #334155;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .registration-wrapper { padding: 40px 0; flex: 1; }

        .glass-card {
            background: #ffffff;
            border: none;
            border-radius: 24px;
            box-shadow: 0 20px 50px rgba(15, 23, 42, 0.08);
            padding: 40px;
            position: relative;
            border-top: 6px solid var(--medical-blue);
        }

        .section-header {
            font-weight: 700;
            font-size: 1rem;
            color: var(--dark-navy);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-label { font-weight: 600; font-size: 0.85rem; color: #64748b; margin-bottom: 6px; }

        .form-control, .form-select {
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 10px 14px;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            border-color: var(--medical-blue);
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
        }

        .btn-submit {
            background: var(--dark-navy);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 14px;
            font-weight: 700;
            transition: all 0.3s;
        }

        .btn-submit:hover {
            background: var(--medical-blue);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(59, 130, 246, 0.2);
        }
    </style>
</head>
<body>

    <jsp:include page="/header.jsp" />

    <div class="container registration-wrapper">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="glass-card">
                    
                    <div class="text-center mb-4">
                        <h2 class="fw-bold">New Patient Admission</h2>
                        <p class="text-muted small">Please fill all fields. Numeric fields cannot be left empty.</p>
                    </div>

                    <form action="<%= request.getContextPath() %>/Register" method="post">

                        
                        <div class="section-header"><i class="bi bi-person-fill"></i> Identity Details</div>
                        <div class="row g-3 mb-4">
                            <div class="col-md-4">
                                <label class="form-label">First Name</label>
                                <input type="text" name="first_name" class="form-control" placeholder="John" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Last Name</label>
                                <input type="text" name="last_name" class="form-control" placeholder="Doe" required>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">Age</label>
                                <input type="number" name="age" class="form-control" required>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">Gender</label>
                                <select name="gender" class="form-select" required>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                        </div>

                        <div class="section-header"><i class="bi bi-telephone-fill"></i> Contact & Health</div>
                        <div class="row g-3 mb-4">
                            <div class="col-md-4">
                                <label class="form-label">Phone Number</label>
                                <input type="text" name="phone" class="form-control" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Email Address</label>
                                <input type="email" name="email" class="form-control">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Blood Group</label>
                                <input type="text" name="blood_group" class="form-control" placeholder="e.g. O+">
                            </div>
                        </div>

                        <div class="section-header"><i class="bi bi-medical-check"></i> Clinical Record</div>
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label">Disease / Diagnosis</label>
                                <input type="text" name="disease" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Attending Doctor</label>
                                <input type="text" name="doctor_name" class="form-control" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Admission Date</label>
                                <input type="date" name="admission_date" class="form-control" value="<%= new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %>" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Discharge Date</label>
                                <input type="date" name="discharge_date" class="form-control" required>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">Room No.</label>
                                <input type="number" name="room_number" class="form-control" value="0" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Initial Bill Amount (₹)</label>
                                <input type="number" step="0.01" name="bill_amount" class="form-control" value="0.00" required>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label">Patient Address</label>
                                <input type="text" name="address" class="form-control" placeholder="Full Address Details">
                            </div>
                        </div>

                        <div class="mt-4">
                            <button type="submit" class="btn btn-submit w-100">
                                <i class="bi bi-plus-circle me-2"></i> Register Patient
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>