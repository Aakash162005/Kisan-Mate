<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - KisanMate</title>
<style>
/* General */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	margin: 0;
	padding: 0;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	overflow-x: hidden;
	color: #333;
}

/* Header */
header {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	background: #1e1f21;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 15px 40px;
	z-index: 1000;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
}

.logo {
	font-size: 26px;
	font-weight: bold;
	color: #1ae010;
	text-decoration: none;
	display: flex;
	align-items: center;
}

.logo-icon {
	margin-right: 8px;
	font-size: 28px;
}

nav {
	display: flex;
	align-items: center;
}

nav a {
	margin-left: 25px;
	text-decoration: none;
	color: white;
	font-weight: 500;
	transition: 0.3s;
	position: relative;
}

nav a:hover, nav a.active {
	color: #eba708;
}

nav a:hover::after, nav a.active::after {
	content: '';
	position: absolute;
	bottom: -5px;
	left: 0;
	width: 100%;
	height: 2px;
	background: #eba708;
}

.auth-buttons {
	display: flex;
	align-items: center;
	margin-left: 20px;
}

.btn {
	padding: 8px 20px;
	border-radius: 30px;
	text-decoration: none;
	font-weight: 600;
	transition: all 0.3s;
	margin-left: 15px;
	display: inline-block;
}

.btn-login {
	background: transparent;
	color: white;
	border: 2px solid #1ae010;
}

.btn-login:hover {
	background: #1ae010;
	color: #1e1f21;
}

.btn-register {
	background: #eba708;
	color: #1e1f21;
	border: 2px solid #eba708;
}

.btn-register:hover {
	background: transparent;
	color: #eba708;
}

/* Auth Pages */
.auth-page {
	position: relative;
	min-height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 100px 20px 60px;
}

.auth-page::before {
	content: '';
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background:
		url('https://images.unsplash.com/photo-1500937386664-56d1dfef3854?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80')
		no-repeat center center/cover;
	filter: blur(8px);
	z-index: -1;
}

.auth-page::after {
	content: '';
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.6);
	z-index: -1;
}

.auth-container {
	background: white;
	width: 90%;
	max-width: 450px;
	border-radius: 10px;
	overflow: hidden;
	box-shadow: 0 5px 30px rgba(0, 0, 0, 0.3);
}

.auth-header {
	background: #1e1f21;
	padding: 20px;
	text-align: center;
	position: relative;
}

.auth-header h2 {
	color: white;
	margin: 0;
}

.auth-form {
	padding: 30px;
}

.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	font-weight: 500;
}

.form-group input, .form-group select {
	width: 100%;
	padding: 12px 15px;
	border: 1px solid #ddd;
	border-radius: 5px;
	font-size: 16px;
	transition: 0.3s;
}

.form-group input:focus, .form-group select:focus {
	border-color: #1ae010;
	outline: none;
	box-shadow: 0 0 0 2px rgba(26, 224, 16, 0.2);
}

.auth-submit {
	width: 100%;
	padding: 12px;
	background: #1ae010;
	color: white;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	font-weight: 600;
	cursor: pointer;
	transition: 0.3s;
	margin-top: 10px;
}

.auth-submit:hover {
	background: #17c40d;
}

.auth-footer {
	text-align: center;
	padding: 20px;
	border-top: 1px solid #eee;
}

.auth-footer a {
	color: #1ae010;
	text-decoration: none;
	font-weight: 600;
}

.auth-footer a:hover {
	text-decoration: underline;
}

/* User Type Selector */
.user-type-selector {
	display: flex;
	justify-content: center;
	margin-bottom: 0;
	border-bottom: 1px solid #eee;
}

.user-type-option {
	flex: 1;
	text-align: center;
	padding: 12px 0;
	cursor: pointer;
	font-weight: 500;
	transition: all 0.3s;
	border-bottom: 3px solid transparent;
}

.user-type-option.active {
	color: #1ae010;
	border-bottom: 3px solid #1ae010;
}

.user-type-option:hover:not(.active) {
	background-color: #f5f5f5;
}

/* Login Forms */
.login-form {
	display: none;
}

.login-form.active {
	display: block;
}

/* Registration Links */
.registration-links {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 10px;
	margin-top: 15px;
}

.registration-links a {
	color: #1ae010;
	text-decoration: none;
	font-size: 14px;
	padding: 5px 10px;
	border: 1px solid #1ae010;
	border-radius: 4px;
	transition: all 0.3s;
}

.registration-links a:hover {
	background-color: #1ae010;
	color: white;
}

/* Responsive */
@media (max-width: 768px) {
	header {
		padding: 15px 20px;
	}
	nav a {
		margin-left: 15px;
		font-size: 14px;
	}
	.auth-buttons {
		display: none;
	}
}

@media (max-width: 576px) {
	.logo {
		font-size: 20px;
	}
	.user-type-selector {
		flex-direction: column;
	}
	.registration-links {
		flex-direction: column;
		align-items: center;
	}
}
</style>
</head>
<body>
	<!-- Header -->
	<header> 
		<a href="index.html" class="logo"> 
			<span class="logo-icon">🌱</span> Kisan<span class="mate">Mate</span>
		</a> 
		<nav> 
			<a href="index.html">Home</a> 
			<a href="#">About</a> 
			<a href="#">Services</a> 
			<a href="#">Testimonials</a> 
			<a href="#">Contact</a>
			<a href="#">Store</a>
			<div class="auth-buttons">
				<a href="userLogin" class="btn btn-login">Login</a> 
				<a href="registration" class="btn btn-register">Register</a>
			</div>
		</nav> 
	</header>

	<!-- Login Page -->
	<div class="auth-page">
		<div class="auth-container">
			<div class="auth-header">
				<h2>Login to Your Account</h2>
			</div>

			<!-- User Type Selector -->
			<div class="user-type-selector">
				<div class="user-type-option active" data-type="user">User</div>
				<div class="user-type-option" data-type="vendor">Vendor</div>
				<div class="user-type-option" data-type="admin">Admin</div>
			</div>

			<!-- User Login Form -->
			<form action="checkUserLogin" method="POST" class="login-form active" id="user-login-form">
				<div class="auth-form">
					<div class="form-group">
						<label for="user-email">Email Address</label> 
						<input type="email" name="uEmail" id="user-email" placeholder="Enter your email" required>
					</div>
					<div class="form-group">
						<label for="user-password">Password</label> 
						<input type="password" name="uPass" id="user-password" placeholder="Enter your password" required>
					</div>
					<button type="submit" class="auth-submit">Login as User</button>
				</div>
				<div class="auth-footer">
					<p>Don't have a user account? <a href="userRegistration">Register here</a></p>
				</div>
			</form>

			<!-- Vendor Login Form -->
			<form action="checkVendorLogin" method="POST" class="login-form" id="vendor-login-form">
				<div class="auth-form">
					<div class="form-group">
						<label for="vendor-email">Email Address</label> 
						<input type="email" name="vEmail" id="vendor-email" placeholder="Enter your vendor email" required>
					</div>
					<div class="form-group">
						<label for="vendor-password">Password</label> 
						<input type="password" name="vPass" id="vendor-password" placeholder="Enter your password" required>
					</div>
					<button type="submit" class="auth-submit">Login as Vendor</button>
				</div>
				<div class="auth-footer">
					<p>Don't have a vendor account? <a href="vendorRegistration">Register here</a></p>
				</div>
			</form>

			<!-- Admin Login Form -->
			<form action="checkAdminLogin" method="POST" class="login-form" id="admin-login-form">
				<div class="auth-form">
					<div class="form-group">
						<label for="admin-email">Email Address</label> 
						<input type="email" name="aEmail" id="admin-email" placeholder="Enter admin email" required>
					</div>
					<div class="form-group">
						<label for="admin-password">Password</label> 
						<input type="password" name="aPass" id="admin-password" placeholder="Enter admin password" required>
					</div>
					<button type="submit" class="auth-submit">Login as Admin</button>
				</div>
				<div class="auth-footer">
					
				</div>
			</form>
		</div>
	</div>

	<script>
		// User type selection functionality
		document.addEventListener('DOMContentLoaded', function() {
			const userTypeOptions = document.querySelectorAll('.user-type-option');
			const loginForms = document.querySelectorAll('.login-form');
			
			userTypeOptions.forEach(option => {
				option.addEventListener('click', function() {
					// Remove active class from all options
					userTypeOptions.forEach(opt => opt.classList.remove('active'));
					
					// Add active class to clicked option
					this.classList.add('active');
					
					// Get the user type from data attribute
					const userType = this.getAttribute('data-type');
					
					// Hide all login forms
					loginForms.forEach(form => form.classList.remove('active'));
					
					// Show the corresponding login form
					const activeForm = document.getElementById(userType + '-login-form');
					if (activeForm) {
						activeForm.classList.add('active');
					}
				});
			});
		});
	</script>
</body>
</html>