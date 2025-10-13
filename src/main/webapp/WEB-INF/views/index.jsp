<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="UTF-8">
    <meta name="viewport"
	content="width=device-width, initial-scale=1.0">
    <title>KisanMate - Agricultural E-commerce</title>
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

/* Splash Screen */
#splash-screen {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: white;
	display: flex;
	justify-content: center;
	align-items: center;
	z-index: 2000;
	transition: opacity 0.5s ease-out;
}

.splash-logo {
	font-size: 42px;
	font-weight: bold;
	color: #1ae010;
	animation: pulse 1.5s infinite;
}

@
keyframes pulse { 0% {
	transform: scale(1);
}

50%
{
transform
:
 
scale
(1
.05
);
 
}
100%
{
transform
:
 
scale
(1);
 
}
}
.mate {
	color: #eba708;
}

/* Main Content */
#main-content {
	opacity: 0;
	transition: opacity 0.5s ease-in;
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

/* Hero Section */
.hero {
	margin-top: 80px;
	height: calc(100vh - 80px);
	background:
		url('https://images.unsplash.com/photo-1500937386664-56d1dfef3854?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80')
		no-repeat center center/cover;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: flex-start;
	padding-left: 80px;
	color: white;
	position: relative;
}

.hero::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
}

.hero-content {
	position: relative;
	z-index: 1;
	max-width: 600px;
}

.hero h1 {
	font-size: 3.5rem;
	margin: 0;
	font-weight: bold;
	line-height: 1.2;
}

.hero h4 {
	font-size: 1.5rem;
	margin-top: 15px;
	font-weight: 500;
}

.underline {
	width: 80px;
	height: 4px;
	background: #eba708;
	margin: 20px 0;
}

.hero-buttons {
	display: flex;
	margin-top: 30px;
}

.btn-hero {
	padding: 12px 30px;
	font-size: 1.1rem;
	margin-right: 20px;
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

.form-group input {
	width: 100%;
	padding: 12px 15px;
	border: 1px solid #ddd;
	border-radius: 5px;
	font-size: 16px;
	transition: 0.3s;
}

.form-group input:focus {
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

/* Responsive */
@media ( max-width : 992px) {
	.hero {
		padding-left: 40px;
	}
	.hero h1 {
		font-size: 2.8rem;
	}
}

@media ( max-width : 768px) {
	header {
		padding: 15px 20px;
	}
	nav a {
		margin-left: 15px;
		font-size: 14px;
	}
	.hero {
		padding-left: 20px;
		align-items: center;
		text-align: center;
	}
	.hero-content {
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	.hero h1 {
		font-size: 2.2rem;
	}
	.hero h4 {
		font-size: 1.2rem;
	}
	.auth-buttons {
		display: none;
	}
	.mobile-auth {
		display: flex;
		margin-top: 20px;
	}
}

@media ( max-width : 576px) {
	.logo {
		font-size: 20px;
	}
	.hero h1 {
		font-size: 1.8rem;
	}
	.hero-buttons {
		flex-direction: column;
	}
	.btn-hero {
		margin-right: 0;
		margin-bottom: 15px;
		text-align: center;
	}
}
</style>
</head>
<body>
    <!-- Splash Screen -->
    <div id="splash-screen">
        <div class="splash-logo">
            Kisan<span class="mate">Mate</span>
        </div>
    </div>

    <!-- Main Content -->
    <div id="main-content">
        <!-- Header -->
        <header>
            <a href="index.html" class="logo">
                <span class="logo-icon">🌱</span> Kisan<span
			class="mate">Mate</span>
            </a>
            <nav>
                <a href="index.html" class="active">Home</a>
                <a href="#">About</a>
                <a href="home.html">Services</a>
                <a href="#">Testimonials</a>
                <a href="#">Contact</a>
                <a href="#">Store</a>
                <div class="auth-buttons">
                    <a href="userLogin" class="btn btn-login">Login</a>
                    <a href="registration" class="btn btn-register">Register</a>
                </div>
            </nav>
        </header>

        <!-- Hero Section -->
        <section class="hero">
            <div class="hero-content">
                <h1>
				<b>Welcome to Kisan<br>Mate</b>
			</h1>
                <div class="underline"></div>
                <h4>Your Gateway to Modern Agricultural Shopping</h4>
                <div class="hero-buttons">
                    <a href="#" class="btn btn-login btn-hero">Explore Products</a>
                    <a href="#" class="btn btn-register btn-hero">Become a Seller</a>
                </div>
            </div>
        </section>
    </div>

    <script>
					// Wait for the page to load completely
					window.addEventListener('load', function() {
						// Show splash screen for 2 seconds
						setTimeout(function() {
							const
							splashScreen = document
									.getElementById('splash-screen');
							const
							mainContent = document
									.getElementById('main-content');

							// Fade out the splash screen
							splashScreen.style.opacity = '0';

							// After the fade out animation completes, hide the splash screen and show main content
							setTimeout(function() {
								splashScreen.style.display = 'none';
								mainContent.style.opacity = '1';
							}, 500); // This should match the CSS transition time
						}, 1000); // Show splash for 1 seconds
					});
				</script>
</body>
</html>
</body>
</html>