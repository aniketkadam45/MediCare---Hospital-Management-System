<%@ page import="com.dao.DBConnection"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
if (session.getAttribute("adminSession") == null) {
	response.sendRedirect("index.html");
	return;
}
%>

<%

int totalPatients = 0;
int todayPatients = 0;
int currentlyAdmitted = 0;

Connection con = null;
try {
	con = DBConnection.getConnection();
	if(con == null) {
		System.out.println("DataBase is NOT Connected.");
	}

	ResultSet rs1 = con.createStatement().executeQuery("SELECT COUNT(*) FROM patient");
	if (rs1.next())
		totalPatients = rs1.getInt(1);

	ResultSet rs2 = con.createStatement().executeQuery("SELECT COUNT(*) FROM patient WHERE admission_date = CURDATE()");
	if (rs2.next())
		todayPatients = rs2.getInt(1);

	ResultSet rs3 = con.createStatement().executeQuery("SELECT COUNT(*) FROM patient WHERE discharge_date > CURDATE()");
	if (rs3.next())
		currentlyAdmitted = rs3.getInt(1);
} catch (Exception e) {
	e.printStackTrace();
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>MediCare | Dashboard </title>
<link rel="icon" type="image/svg+xml" href="<%= request.getContextPath() %>/img/logo.svg">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap"
	rel="stylesheet">

<style>
body {
	font-family: 'Inter', sans-serif;
	background-color: #f0f2f5;
	color: #1a202c;
}

/* Modern Gradient Backgrounds */
.bg-gradient-medical {
	background: linear-gradient(135deg, #0d6efd 0%, #0dcaf0 100%);
}

.bg-gradient-success {
	background: linear-gradient(135deg, #198754 0%, #20c997 100%);
}

.bg-gradient-warning {
	background: linear-gradient(135deg, #f59e0b 0%, #fbbf24 100%);
}

/* Dashboard Card Styling */
.stat-card {
	border: none;
	border-radius: 16px;
	transition: all 0.3s ease;
	overflow: hidden;
	position: relative;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.stat-card:hover {
	transform: translateY(-8px);
	box-shadow: 0 12px 20px rgba(0, 0, 0, 0.1);
}

.stat-icon-bg {
	position: absolute;
	right: -10px;
	bottom: -10px;
	font-size: 5rem;
	opacity: 0.15;
	color: #fff;
}

/* Action Buttons */
.btn-action {
	border-radius: 12px;
	padding: 12px 24px;
	font-weight: 600;
	transition: all 0.2s;
	border: none;
	display: flex;
	align-items: center;
	gap: 10px;
}

.btn-add {
	background-color: #e0e7ff;
	color: #4338ca;
}

.btn-add:hover {
	background-color: #4338ca;
	color: white;
}

.btn-doctor {
	background-color: #cffafe; /* light cyan background */
	color: #0c4a6e; /* dark cyan text */
	border-radius: 12px;
	transition: all 0.3s;
}

.btn-doctor:hover {
	background-color: #0c4a6e; /* dark cyan background on hover */
	color: white; /* white text on hover */
}

/* Table Styling */
.custom-table-card {
	border-radius: 16px;
	border: none;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.table thead th {
	background-color: #f8fafc;
	text-transform: uppercase;
	font-size: 0.75rem;
	letter-spacing: 0.05em;
	color: #64748b;
	border: none;
}

.patient-avatar {
	width: 35px;
	height: 35px;
	background: #e2e8f0;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: bold;
	color: #475569;
}
</style>
</head>
<body>

	<jsp:include page="header.jsp" />

	<div class="container py-5">

		<div class="row align-items-center mb-5">
			<div class="col-md-8">
				<h1 class="fw-bold mb-1">Hospital Overview</h1>
				<p class="text-muted">
					Welcome back, <span class="text-primary fw-semibold"><%=session.getAttribute("username") != null ? session.getAttribute("username") : "Admin"%></span>
				</p>
			</div>
			<div class="col-md-4 text-md-end">
				<div class="d-inline-block p-2 bg-white rounded-pill shadow-sm px-4">
					<i class="bi bi-calendar3 text-primary me-2"></i> <span
						class="small fw-bold text-uppercase"><%=new SimpleDateFormat("EEEE, MMM dd").format(new java.util.Date())%></span>
				</div>
			</div>
		</div>

		<div class="row g-4 mb-5">
			<div class="col-md-4">
				<div class="card stat-card bg-gradient-medical text-white p-4">
					<div class="position-relative z-1">
						<h6 class="text-uppercase fw-semibold opacity-75">Total
							Patients</h6>
						<h2 class="display-5 fw-bold mb-0"><%=totalPatients%></h2>
					</div>
					<i class="bi bi-people stat-icon-bg"></i>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card stat-card bg-gradient-success text-white p-4">
					<div class="position-relative z-1">
						<h6 class="text-uppercase fw-semibold opacity-75">Admitted
							Today</h6>
						<h2 class="display-5 fw-bold mb-0"><%=todayPatients%></h2>
					</div>
					<i class="bi bi-heart-pulse stat-icon-bg"></i>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card stat-card bg-gradient-warning text-white p-4">
					<div class="position-relative z-1">
						<h6 class="text-uppercase fw-semibold opacity-75">Active
							Cases</h6>
						<h2 class="display-5 fw-bold mb-0"><%=currentlyAdmitted%></h2>
					</div>
					<i class="bi bi-hospital stat-icon-bg"></i>
				</div>
			</div>
		</div>

		<h5 class="fw-bold mb-3">Quick Management</h5>
		<div class="row g-3 mb-5">
			<div class="col-auto">
				<a href="<%=request.getContextPath()%>/Patient/register.jsp"
					class="btn btn-action btn-add shadow-sm"> <i
					class="bi bi-plus-circle-fill"></i> New Patient
				</a>

			</div>
			<div class="col-auto">
				<a href="<%=request.getContextPath()%>/Patient/viewPatients.jsp"
					class="btn btn-action btn-light shadow-sm bg-white"> <i
					class="bi bi-search text-primary"></i> Find Record
				</a>
			</div>
			<div class="col-auto">
				<a href="<%=request.getContextPath()%>/Doctor/registerDoc.jsp"
					class="btn btn-action btn-doctor shadow-sm"> <i
					class="bi bi-plus-circle-fill"></i> New Doctor
				</a>
			</div>
			<div class="col-auto">
				<a href="<%=request.getContextPath()%>/Bills/billing.jsp"
					class="btn btn-action btn-light shadow-sm bg-white"> <i
					class="bi bi-currency-dollar text-success"></i> Billing
				</a>
			</div>
		</div>

		<div class="card custom-table-card">
			<div class="card-header bg-white py-3 border-0">
				<h5 class="mb-0 fw-bold">Recent Admissions</h5>
			</div>
			<div class="table-responsive">
				<table class="table align-middle mb-0">
					<thead>
						<tr>
							<th class="ps-4">Patient Name</th>
							<th>Condition</th>
							<th>Admission Date</th>
							<th class="text-end pe-4">Status</th>
						</tr>
					</thead>
					<tbody>
						<%
						try {
							SimpleDateFormat sdf = new SimpleDateFormat("dd MMM, yyyy");
							PreparedStatement ps = con.prepareStatement(
							"SELECT first_name, last_name, disease, admission_date, discharge_date FROM patient ORDER BY admission_date DESC LIMIT 5");
							ResultSet rs = ps.executeQuery();
							while (rs.next()) {
								String initials = rs.getString("first_name").substring(0, 1) + rs.getString("last_name").substring(0, 1);
						%>
						<tr>
							<td class="ps-4">
								<div class="d-flex align-items-center">
									<div class="patient-avatar me-3"><%=initials.toUpperCase()%></div>
									<div>
										<div class="fw-bold"><%=rs.getString("first_name")%>
											<%=rs.getString("last_name")%></div>
										<small class="text-muted">ID: #<%=(int) (Math.random() * 9000) + 1000%></small>
									</div>
								</div>
							</td>
							<td><span class="badge bg-light text-dark border"><%=rs.getString("disease")%></span></td>
							<td><%=sdf.format(rs.getDate("admission_date"))%></td>
							<td class="text-end pe-4">
								<%
								java.sql.Date dischargeDate = rs.getDate("discharge_date");
								java.sql.Date today = new java.sql.Date(System.currentTimeMillis()); // CURDATE() equivalent

								if (dischargeDate != null && dischargeDate.after(today)) {
								%> <span class="badge rounded-pill bg-success-subtle text-success px-3">Active</span>
								<%
								} else {
								%> <span class="badge rounded-pill bg-danger-subtle text-danger px-3">Inactive</span>
								<%
								}
								%>
							</td>

						</tr>
						<%
						}
						} catch (Exception e) {
						%>
						<tr>
							<td colspan="4" class="text-center py-4">No data found</td>
						</tr>
						<%
						} finally {
						if (con != null)
							con.close();
						}
						%>
					</tbody>
				</table>
			</div>
			<div class="card-footer bg-white border-0 text-center py-3">
				<a href="<%=request.getContextPath()%>/Patient/viewPatients.jsp"
					class="text-primary text-decoration-none fw-semibold small">View
					All Patients <i class="bi bi-arrow-right"></i>
				</a>
			</div>
		</div>
	</div>

	<jsp:include page="footer.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>