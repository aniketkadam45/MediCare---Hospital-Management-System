<%
if (session.getAttribute("adminSession") == null) {
	response.sendRedirect(request.getContextPath() + "/index.html");
	return;
}
%>

<footer class="footer-premium">
	<div class="container py-5">
		<div class="row gy-5">
			
			<div class="col-xl-4 col-lg-12">
				<div class="d-flex align-items-center mb-4">
					<div class="logo-wrapper me-3">
						<img src="<%=request.getContextPath()%>/img/logo.png" alt="Logo" width="32" height="32">
					</div>
					<h3 class="mb-0 fw-800 text-white letter-spacing-tight">
						Medi<span class="brand-accent">Care</span>
					</h3>
				</div>
				<p class="footer-desc mb-4 me-xl-5">
					A high-performance administrative ecosystem designed for modern medical precision. 
					Empowering healthcare providers with real-time data and seamless patient oversight.
				</p>
				<div class="social-grid">
					<a href="#" class="social-box" aria-label="Facebook"><i class="bi bi-facebook"></i></a>
					<a href="#" class="social-box" aria-label="Twitter"><i class="bi bi-twitter-x"></i></a>
					<a href="#" class="social-box" aria-label="LinkedIn"><i class="bi bi-linkedin"></i></a>
					<a href="#" class="social-box" aria-label="Instagram"><i class="bi bi-instagram"></i></a>
				</div>
			</div>

			<div class="col-xl-2 col-md-4 col-6">
				<h6 class="footer-title">Operations</h6>
				<ul class="list-unstyled footer-links">
					<li><a href="<%=request.getContextPath()%>/Patient/viewPatients.jsp">Patient Index</a></li>
					<li><a href="<%=request.getContextPath()%>/Doctor/viewDoctors.jsp">Medical Staff</a></li>
					<li><a href="<%=request.getContextPath()%>/Appointment/appointments.jsp">Live Schedule</a></li>
					<li><a href="<%=request.getContextPath()%>/Bills/billing.jsp">Financial Hub</a></li>
				</ul>
			</div>

			<div class="col-xl-3 col-md-6">
    <h6 class="footer-title">Support Hub</h6>
    <div class="support-glass-card mb-3">
        <div class="d-flex align-items-center gap-3">
            <div class="support-icon">
                <i class="bi bi-headset"></i>
            </div>
            <div>
                <span class="support-label">Priority Line</span>
                <p class="support-value">1-800-MED-CARE</p>
            </div>
        </div>
    </div>
    <div class="support-glass-card">
        <div class="d-flex align-items-center gap-3">
            <div class="support-icon security">
                <i class="bi bi-shield-lock"></i>
            </div>
            <div>
                <span class="support-label">Data Protocol</span>
                <p class="support-value">AES-256 Encrypted</p>
            </div>
        </div>
    </div>
</div>

<div class="col-xl-3 col-md-6">
    <h6 class="footer-title">Network Integrity</h6>
    <div class="status-panel-premium">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div class="d-flex align-items-center gap-2">
                <div class="live-pulse"></div>
                <span class="status-node">Global Node 01</span>
            </div>
            <span class="status-tag">Online</span>
        </div>
        
        <div class="sync-bar-wrapper">
            <div class="sync-bar-progress" style="width: 98%"></div>
        </div>
        
        <div class="row g-0 mt-3 text-center border-top border-white border-opacity-10 pt-2">
            <div class="col-6 border-end border-white border-opacity-10">
                <span class="stat-mini-label">Load</span>
                <p class="stat-mini-value">12%</p>
            </div>
            <div class="col-6">
                <span class="stat-mini-label">Uptime</span>
                <p class="stat-mini-value">99.9%</p>
            </div>
        </div>
    </div>
</div>

		<hr class="footer-divider">

		<div class="row">
			<div class="col-12 text-center">
				<div class="bottom-branding">
					<p class="copyright-text mb-1">
						&copy; <%=java.time.Year.now()%> MediCare Hospital Management System
					</p>
					<h5 class="company-name">MediCare Pvt. Ltd.</h5>
				</div>
			</div>
		</div>
	</div>
</footer>

<style>
@import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap');

:root {
	--f-navy: #020617;
	--f-card: rgba(15, 23, 42, 0.6);
	--f-blue: #3b82f6;
	--f-slate: #94a3b8;
	--f-border: rgba(255, 255, 255, 0.06);
}

.footer-premium {
	background-color: var(--f-navy);
	font-family: 'Plus Jakarta Sans', sans-serif;
	color: white;
	border-top: 1px solid var(--f-border);
	padding: 10px 0;
	padding-bottom: 10px;
}

.brand-accent {
	color: var(--f-blue);
	background: linear-gradient(to bottom, #60a5fa, #3b82f6);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
}

.logo-wrapper {
	background: rgba(255, 255, 255, 0.05);
	padding: 8px;
	border-radius: 12px;
	border: 1px solid var(--f-border);
}

.footer-desc {
	color: var(--f-slate);
	font-size: 0.92rem;
	line-height: 1.7;
}

/* Titles */
.footer-title {
	font-weight: 700;
	font-size: 0.8rem;
	text-transform: uppercase;
	letter-spacing: 2px;
	margin-bottom: 1.8rem;
}

/* Links */
.footer-links li { margin-bottom: 0.9rem; }
.footer-links a {
	color: var(--f-slate);
	text-decoration: none;
	font-size: 0.9rem;
	transition: 0.3s;
}
.footer-links a:hover {
	color: var(--f-blue);
	transform: translateX(5px);
	display: inline-block;
}

/* Social Box */
.social-box {
	width: 38px; height: 38px;
	background: rgba(255, 255, 255, 0.03);
	border: 1px solid var(--f-border);
	border-radius: 10px;
	display: inline-flex; align-items: center; justify-content: center;
	color: var(--f-slate); transition: 0.3s;
	margin-right: 12px;
}
.social-box:hover {
	background: var(--f-blue);
	color: white;
	transform: translateY(-3px);
}

/* Status Card */
.status-card-premium {
	background: var(--f-card);
	backdrop-filter: blur(10px);
	border: 1px solid var(--f-border);
	border-radius: 20px;
	padding: 1.25rem;
}

.status-indicator {
	width: 8px; height: 8px;
	background: #22c55e;
	border-radius: 50%;
	box-shadow: 0 0 8px #22c55e;
	animation: footerPulse 2s infinite;
}

.progress-bar-glow {
	height: 100%; background: var(--f-blue);
	box-shadow: 0 0 10px rgba(59, 130, 246, 0.5);
}

/* Centralized Branding Styles */
.bottom-branding {
	margin-top: 10px;
}

.company-name {
	font-weight: 600;
	font-size: 0.7rem;
	letter-spacing: 1.2px;
	color: white;
	opacity: 0.7;
	text-transform: uppercase;
}

.copyright-text {
	color: var(--f-slate);
	font-size: 0.8rem;
	opacity: 0.5;
}

.footer-divider {
	border-color: var(--f-border);
	margin: 2.5rem 0 0;
}

/* Premium Support Cards */
.support-glass-card {
    background: rgba(255, 255, 255, 0.03);
    border: 1px solid rgba(255, 255, 255, 0.05);
    border-radius: 16px;
    padding: 12px;
    transition: 0.3s ease;
}


.support-icon {
    width: 40px;
    height: 40px;
    background: rgba(59, 130, 246, 0.1);
    color: var(--f-blue);
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.2rem;
}

.support-icon.security {
    color: #4ade80;
    background: rgba(74, 222, 128, 0.1);
}

.support-label {
    display: block;
    font-size: 0.7rem;
    color: var(--f-slate);
    text-transform: uppercase;
    letter-spacing: 1px;
}

.support-value {
    margin: 0;
    font-size: 0.9rem;
    font-weight: 700;
    color: white;
}

/* Network Integrity Panel */
.status-panel-premium {
    background: linear-gradient(135deg, rgba(15, 23, 42, 0.8), rgba(2, 6, 23, 0.8));
    border: 1px solid rgba(59, 130, 246, 0.2);
    border-radius: 20px;
    padding: 20px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
}

.status-node {
    font-family: 'JetBrains Mono', monospace;
    font-size: 0.75rem;
    color: var(--f-slate);
}

.status-tag {
    font-size: 0.65rem;
    font-weight: 800;
    color: #4ade80;
    text-transform: uppercase;
}

.live-pulse {
    width: 8px;
    height: 8px;
    background: #4ade80;
    border-radius: 50%;
    box-shadow: 0 0 10px #4ade80;
    animation: footerPulse 2s infinite;
}

.sync-bar-wrapper {
    height: 6px;
    background: rgba(255, 255, 255, 0.05);
    border-radius: 10px;
    overflow: hidden;
}

.sync-bar-progress {
    height: 100%;
    background: linear-gradient(to right, #3b82f6, #60a5fa);
    box-shadow: 0 0 10px rgba(59, 130, 246, 0.5);
}

.stat-mini-label {
    font-size: 0.6rem;
    color: var(--f-slate);
    display: block;
    text-transform: uppercase;
}

.stat-mini-value {
    font-family: 'JetBrains Mono', monospace;
    font-size: 0.85rem;
    font-weight: 700;
    color: white;
    margin: 0;
}

@keyframes footerPulse {
	0% { opacity: 1; transform: scale(1); }
	50% { opacity: 0.5; transform: scale(1.2); }
	100% { opacity: 1; transform: scale(1); }
}

@media (max-width: 991.98px) {
	.footer-premium { text-align: center; }
	.social-grid { justify-content: center; }
	.contact-item { justify-content: center; }
	.footer-links a:hover { transform: translateY(-2px); }
}
</style>