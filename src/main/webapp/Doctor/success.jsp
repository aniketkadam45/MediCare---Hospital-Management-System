<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
    <title>MediCare | Doctor Registration Success</title>
    <link rel="icon" type="image/svg+xml" href="<%= request.getContextPath() %>/img/logo.svg">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --medical-blue: #3b82f6;
            --success-green: #22c55e;
            --dark-navy: #0f172a;
        }

        body { 
            font-family: 'Plus Jakarta Sans', sans-serif; 
            background-color: #f8fafc;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .content-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        .success-card {
            background: #ffffff;
            border: none;
            border-radius: 28px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.08);
            padding: 50px;
            text-align: center;
            max-width: 500px;
            width: 100%;
            border-bottom: 5px solid var(--success-green);
        }

        .success-animation {
            margin: 0 auto 30px;
        }

        .checkmark-circle {
            width: 100px;
            height: 100px;
            background: #f0fdf4;
            color: var(--success-green);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 50px;
            margin: 0 auto;
            animation: pulse-green 2s infinite;
        }

        @keyframes pulse-green {
            0% { box-shadow: 0 0 0 0 rgba(34, 197, 94, 0.4); }
            70% { box-shadow: 0 0 0 20px rgba(34, 197, 94, 0); }
            100% { box-shadow: 0 0 0 0 rgba(34, 197, 94, 0); }
        }

        h1 { color: var(--dark-navy); font-weight: 800; margin-bottom: 15px; }
        p { color: #64748b; font-size: 1.1rem; margin-bottom: 35px; }

        .btn-group-custom { display: flex; flex-direction: column; gap: 12px; }

        .btn-primary-custom {
            background: var(--dark-navy);
            color: white;
            border: none;
            padding: 14px 28px;
            border-radius: 14px;
            font-weight: 700;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-primary-custom:hover {
            background: var(--medical-blue);
            transform: translateY(-3px);
            box-shadow: 0 10px 15px -3px rgba(59, 130, 246, 0.3);
            color: white;
        }

        .btn-outline-custom {
            background: transparent;
            color: #64748b;
            border: 2px solid #e2e8f0;
            padding: 12px 28px;
            border-radius: 14px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
        }

        .btn-outline-custom:hover {
            background: #f1f5f9;
            color: var(--dark-navy);
            border-color: #cbd5e1;
        }
    </style>
</head>
<body>

    <jsp:include page="/header.jsp" />

    <div class="content-wrapper">
        <div class="success-card">
            <div class="success-animation">
                <div class="checkmark-circle">
                    <i class="bi bi-check-lg"></i>
                </div>
            </div>

            <h1>All Set!</h1>
            <p>The doctor record has been successfully added to the hospital database.</p>

            <div class="btn-group-custom">
                <a href="<%= request.getContextPath() %>/Doctor/registerDoc.jsp" class="btn-primary-custom">
                    <i class="bi bi-person-plus-fill me-2"></i> Register Another Doctor
                </a>
                <a href="<%= request.getContextPath() %>/Doctor/viewDoctors.jsp" class="btn-outline-custom">
                    <i class="bi bi-list-ul me-2"></i> Go to Doctor Directory
                </a>
                <a href="<%=request.getContextPath()%>/home.jsp" class="btn-outline-custom mt-2 border-0">
                    <i class="bi bi-house-door me-1"></i> Back to Dashboard
                </a>
            </div>
        </div>
    </div>

    <jsp:include page="/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
