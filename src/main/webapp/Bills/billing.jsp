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
double totalRevenue = 0.0;
int totalPaidInvoices = 0;

try {
	con = DBConnection.getConnection();

	// Calculate Summary Stats
	Statement stSum = con.createStatement();
	ResultSet rsSum = stSum.executeQuery("SELECT SUM(bill_amount), COUNT(*) FROM patient");
	if (rsSum.next()) {
		totalRevenue = rsSum.getDouble(1);
		totalPaidInvoices = rsSum.getInt(2);
	}
} catch (Exception e) {
	e.printStackTrace();
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>MediCare | Billing Center</title>
<link rel="icon" type="image/svg+xml" href="<%= request.getContextPath() %>/img/logo.svg">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<link
	href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap"
	rel="stylesheet">

<style>
:root {
	--med-blue: #3b82f6;
	--dark: #0f172a;
	--success: #22c55e;
}

body {
	font-family: 'Plus Jakarta Sans', sans-serif;
	background-color: #f8fafc;
}

.stats-card {
	background: white;
	border-radius: 24px;
	padding: 30px;
	border: none;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
	position: relative;
	overflow: hidden;
}

.stats-card::after {
	content: '';
	position: absolute;
	right: -20px;
	top: -20px;
	width: 100px;
	height: 100px;
	background: rgba(59, 130, 246, 0.05);
	border-radius: 50%;
}

.currency-symbol {
	font-size: 1.5rem;
	color: #64748b;
	vertical-align: top;
	margin-right: 5px;
}

.amount-val {
	font-size: 2.5rem;
	font-weight: 800;
	color: var(--dark);
	letter-spacing: -1px;
}

.billing-table-card {
	background: white;
	border-radius: 24px;
	border: none;
	box-shadow: 0 15px 35px rgba(15, 23, 42, 0.05);
	margin-bottom: 50px;
}

.table thead th {
	background: #f1f5f9;
	color: #64748b;
	font-size: 0.75rem;
	text-transform: uppercase;
	padding: 20px;
	border: none;
}

.status-badge {
	background: #dcfce7;
	color: #15803d;
	padding: 6px 12px;
	border-radius: 50px;
	font-size: 0.75rem;
	font-weight: 700;
}

.invoice-link {
	border: 1px solid #e2e8f0;
	border-radius: 10px;
	padding: 8px 15px;
	font-size: 0.85rem;
	transition: 0.3s;
	text-decoration: none;
	display: inline-block;
	color: var(--dark);
}

.invoice-link:hover {
	background: var(--med-blue);
	color: white !important;
	border-color: var(--med-blue);
	transform: translateY(-2px);
}
</style>
</head>
<body>

	<jsp:include page="/header.jsp" />

	<div class="container py-5">
		<div class="mb-5">
			<h2 class="fw-bold text-dark">Financial Management</h2>
			<p class="text-muted">Track revenue and generate patient invoices</p>
		</div>

		<div class="row g-4 mb-5">
			<div class="col-lg-4">
				<div class="stats-card">
					<p class="text-muted small fw-bold text-uppercase mb-2">Total
						Hospital Revenue</p>
					<div>
						<span class="currency-symbol">₹</span> <span class="amount-val"><%=String.format("%,.2f", totalRevenue)%></span>
					</div>
					<div class="mt-3 text-success small fw-bold">
						<i class="bi bi-arrow-up-circle-fill me-1"></i> Live Database
						Totals
					</div>
				</div>
			</div>
			<div class="col-lg-4">
				<div class="stats-card">
					<p class="text-muted small fw-bold text-uppercase mb-2">Total
						Invoices</p>
					<div class="amount-val"><%=totalPaidInvoices%></div>
					<div class="mt-3 text-primary small fw-bold">
						<i class="bi bi-file-earmark-check me-1"></i> Processed Records
					</div>
				</div>
			</div>
		</div>

		<div class="card billing-table-card">
			<div class="table-responsive">
				<table class="table align-middle mb-0">
					<thead>
						<tr>
							<th class="ps-4">Patient & Room</th>
							<th>Date Admitted</th>
							<th>Doctor</th>
							<th>Bill Amount</th>
							<th>Payment Status</th>
							<th class="text-center">Action</th>
						</tr>
					</thead>
					<tbody>
						<%
						try {
							if (con != null) {
								Statement st = con.createStatement();
								// Querying by patient_id as per your database structure
								ResultSet rs = st.executeQuery("SELECT * FROM patient ORDER BY patient_id DESC");
								while (rs.next()) {
							int pId = rs.getInt("patient_id");
						%>
						<tr>
							<td class="ps-4">
								<div class="fw-bold text-dark"><%=rs.getString("first_name")%>
									<%=rs.getString("last_name")%></div>
								<div class="text-muted small">
									Room:
									<%=rs.getInt("room_number")%></div>
							</td>
							<td class="small text-muted"><%=rs.getDate("admission_date")%></td>
							<td class="small fw-semibold text-primary"><%=rs.getString("doctor_name")%></td>
							<td>
								<div class="fw-bold text-dark">
									₹<%=String.format("%,.2f", rs.getDouble("bill_amount"))%></div>
							</td>
							<td>
								<%
								java.sql.Date dischargeDate = rs.getDate("discharge_date");
								java.sql.Date today = new java.sql.Date(System.currentTimeMillis());

								if (dischargeDate != null && dischargeDate.before(today)) {
								%> <span class="status-badge"> <i
									class="bi bi-check2-circle me-1"></i> PAID
							</span> <%
 } else {
 %> <span class="status-badge"
								style="background: #fff3cd; color: #92400e;"> <i
									class="bi bi-clock me-1"></i> PENDING
							</span> <%
 }
 %>
							</td>

							<td class="text-center"><a href="invoice.jsp?id=<%=pId%>"
								target="_blank" class="invoice-link"> <i
									class="bi bi-file-earmark-pdf me-1"></i> Invoice
							</a></td>
						</tr>
						<%
						}
						con.close();
						}
						} catch (Exception e) {
						out.println("<tr><td colspan='6' class='text-center py-4 text-danger'>Error: " + e.getMessage() + "</td></tr>");
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<jsp:include page="/footer.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>