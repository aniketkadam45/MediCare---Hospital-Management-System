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
    String idParam = request.getParameter("id");
    if (idParam == null) {
        response.sendRedirect("billing.jsp");
        return;
    }

    int patientId = Integer.parseInt(idParam);
    
    Connection con = null;
    try {
    	con = DBConnection.getConnection();
        
        PreparedStatement ps = con.prepareStatement("SELECT * FROM patient WHERE patient_id = ?;");
        ps.setInt(1, patientId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            double total = rs.getDouble("bill_amount");
            double consultation = total * 0.15; 
            double roomCharges = total * 0.45;  
            double medicines = total * 0.30;    
            double taxes = total * 0.10;        
            String fileName = "Invoice_" + rs.getString("first_name") + "_" + rs.getString("last_name");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Download Invoice_HOS_<%= patientId %></title>
    <link rel="icon" type="image/svg+xml" href="<%= request.getContextPath() %>/img/logo.svg">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

    <style>
        body { background-color: #525659; padding: 50px 0; font-family: 'Plus Jakarta Sans', sans-serif; }
        
        .invoice-canvas {
            background: white;
            width: 210mm;
            margin: 0 auto;
            padding: 20mm;
            box-shadow: 0 0 20px rgba(0,0,0,0.3);
            position: relative;
            box-sizing: border-box;
        }
        .letterhead { border-bottom: 3px solid #3b82f6; padding-bottom: 25px; margin-bottom: 35px; }
        .hospital-logo-box {
            width: 50px; height: 50px; background: #0f172a; color: white;
            border-radius: 10px; display: flex; align-items: center;
            justify-content: center; font-weight: 700; font-size: 22px;
        }
        .info-label { color: #64748b; font-size: 11px; text-transform: uppercase; font-weight: 700; letter-spacing: 0.5px; }
        .info-value { color: #0f172a; font-weight: 600; font-size: 15px; margin-bottom: 10px; }
        .table-invoice thead th { background: #0f172a; color: white; border: none; font-size: 13px; padding: 12px; }
        .table-invoice tbody td { padding: 15px 12px; border-bottom: 1px solid #f1f5f9; font-size: 14px; }
        
        /* Updated styles for side-by-side layout */
        .total-section { background: #f8fafc; border-radius: 15px; padding: 20px; border: 1px solid #e2e8f0; }
        .grand-total-label { font-size: 16px; font-weight: 700; color: #0f172a; }
        .grand-total-value { font-size: 20px; font-weight: 800; color: #3b82f6; }
        
        .stamp-area { text-align: left; }
        .signature-line { width: 180px; border-bottom: 1px solid #cbd5e1; display: block; margin-bottom: 8px; }

        @media print {
            body { background: white; padding: 0; }
            .invoice-canvas { box-shadow: none; margin: 0; width: 100%; border: none; }
            .no-print { display: none !important; }
        }
    </style>
</head>
<body>

    <div class="container no-print mb-4 text-center">
        <button onclick="downloadInvoicePDF()" class="btn btn-dark btn-lg px-5 shadow-lg rounded-pill">
            <i class="bi bi-download me-2"></i> Download PDF
        </button>
        <a href="billing.jsp" class="btn btn-outline-light ms-3 rounded-pill">
            <i class="bi bi-arrow-left me-1"></i> Back to Billing
        </a>
    </div>

    <div id="invoice-content">
        <div class="invoice-canvas">
            <div class="letterhead d-flex justify-content-between align-items-start">
                <div class="d-flex align-items-center">
                    <div class="hospital-logo-box me-3">M</div>
                    <div>
                        <h2 class="fw-bold mb-0">MediCare Hospital</h2>
                        <p class="text-muted small mb-0">123 Health Avenue, Medical District, NY 10001</p>
                        <p class="text-muted small mb-0">GSTIN: 22AAAAA0000A1Z5 | +1 800-MEDICARE</p>
                    </div>
                </div>
                <div class="text-end">
                    <h1 class="text-uppercase text-muted opacity-25 fw-bold mb-0">Invoice</h1>
                    <p class="mb-0 fw-bold text-dark">#INV-<%= 1000 + patientId %></p>
                    <p class="small text-muted"><%= new SimpleDateFormat("dd MMM yyyy").format(new java.util.Date()) %></p>
                </div>
            </div>

            <div class="row mb-5">
                <div class="col-4">
                    <div class="info-label">Patient Details</div>
                    <div class="info-value"><%= rs.getString("first_name") %> <%= rs.getString("last_name") %></div>
                    <div class="info-label">Contact</div>
                    <div class="info-value"><%= rs.getString("phone") %></div>
                </div>
                <div class="col-4">
                    <div class="info-label">Assigned Doctor</div>
                    <div class="info-value"><%= rs.getString("doctor_name") %></div>
                    <div class="info-label">Room Details</div>
                    <div class="info-value">Premium Ward - <%= rs.getInt("room_number") %></div>
                </div>
                <div class="col-4">
                    <div class="info-label">Admission Date</div>
                    <div class="info-value"><%= rs.getDate("admission_date") %></div>
                    <div class="info-label">Case/Disease</div>
                    <div class="info-value"><%= rs.getString("disease") %></div>
                </div>
            </div>

            <table class="table table-invoice mb-4">
                <thead>
                    <tr>
                        <th>Description of Medical Services</th>
                        <th class="text-center">HSN Code</th>
                        <th class="text-end">Amount (₹)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>Professional Consultation</strong><br><small class="text-muted">Specialist doctor visits and clinical assessment</small></td>
                        <td class="text-center">999311</td>
                        <td class="text-end fw-bold">₹<%= String.format("%.2f", consultation) %></td>
                    </tr>
                    <tr>
                        <td><strong>Nursing & Accommodation</strong><br><small class="text-muted">Room charges including nursing care and utilities</small></td>
                        <td class="text-center">999312</td>
                        <td class="text-end fw-bold">₹<%= String.format("%.2f", roomCharges) %></td>
                    </tr>
                    <tr>
                        <td><strong>Pharmacy & Consumables</strong><br><small class="text-muted">Internal medicine supply and laboratory materials</small></td>
                        <td class="text-center">999313</td>
                        <td class="text-end fw-bold">₹<%= String.format("%.2f", medicines) %></td>
                    </tr>
                    <tr>
                        <td><strong>Service Tax & Medical Cess</strong><br><small class="text-muted">Standard 10% hospital administration tax</small></td>
                        <td class="text-center">-</td>
                        <td class="text-end fw-bold">₹<%= String.format("%.2f", taxes) %></td>
                    </tr>
                </tbody>
            </table>

            <div class="row align-items-end mt-5">
                <div class="col-6">
                    <div class="stamp-area">
                        <div class="signature-line"></div>
                        <p class="mb-0 fw-bold">Authorized Signatory</p>
                        <p class="text-muted small">MediCare Accounts Dept</p>
                    </div>
                </div>
                
                <div class="col-6">
                    <div class="total-section">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted small fw-bold">Taxable Subtotal</span>
                            <span class="fw-bold text-dark">₹<%= String.format("%,.2f", total - taxes) %></span>
                        </div>
                        <div class="d-flex justify-content-between border-top pt-3 mt-2">
                            <span class="grand-total-label">Grand Total (INR)</span>
                            <span class="grand-total-value">₹<%= String.format("%,.2f", total) %></span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="mt-5 p-3 rounded" style="background: #f1f5f9; border-left: 5px solid #0f172a;">
                <p class="small mb-0 text-dark">
                    <strong>Notes:</strong> This is a digital receipt. For insurance claims (TPA), please ensure this document is accompanied by the original discharge summary. Payment received with thanks.
                </p>
            </div>
        </div>
    </div>

    <script>
        function downloadInvoicePDF() {
            const element = document.getElementById('invoice-content');
            const opt = {
                margin:       0,
                filename:     '<%= fileName %>.pdf',
                image:        { type: 'jpeg', quality: 0.98 },
                html2canvas:  { scale: 2, useCORS: true, scrollY: 0 },
                jsPDF:        { unit: 'mm', format: 'a4', orientation: 'portrait' },
                pagebreak:    { mode: 'avoid-all' }
            };

            html2pdf().set(opt).from(element).toPdf().get('pdf').then(function (pdf) {
                var totalPages = pdf.internal.getNumberOfPages();
                for (var i = totalPages; i > 1; i--) {
                    pdf.deletePage(i); 
                }
            }).save();
        }
    </script>

</body>
</html>
<% 
        } else {
            out.println("<div class='container mt-5 text-white text-center'><h3>Patient Record Not Found</h3><a href='billing.jsp' class='btn btn-primary'>Back</a></div>");
        }
    } catch (Exception e) { 
        out.println("Error: " + e.getMessage()); 
    } finally {
        if (con != null) con.close();
    }
%>