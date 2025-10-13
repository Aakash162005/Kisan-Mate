<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - KisanMate</title>
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
            background: #f5f5f5;
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

        .auth-container {
            background: white;
            width: 90%;
            max-width: 500px;
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

        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: 0.3s;
        }

        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            border-color: #1ae010;
            outline: none;
            box-shadow: 0 0 0 2px rgba(26, 224, 16, 0.2);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 80px;
        }

        .form-row {
            display: flex;
            gap: 15px;
        }

        .form-row .form-group {
            flex: 1;
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

        .vendor-submit {
            background: #eba708;
        }

        .vendor-submit:hover {
            background: #d69900;
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
            margin-bottom: 20px;
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

        .user-type-option.vendor.active {
            color: #eba708;
            border-bottom: 3px solid #eba708;
        }

        .user-type-option:hover:not(.active) {
            background-color: #f5f5f5;
        }

        /* Form Containers */
        .form-container {
            display: none;
        }

        .form-container.active {
            display: block;
        }

        /* Responsive */
        @media ( max-width : 768px) {
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
            .form-row {
                flex-direction: column;
                gap: 0;
            }
        }

        @media ( max-width : 576px) {
            .logo {
                font-size: 20px;
            }
            .auth-container {
                width: 95%;
            }
        }

        /* Notification */
        .notification {
            position: fixed;
            top: 90px;
            right: 20px;
            padding: 15px 20px;
            background: #1ae010;
            color: white;
            border-radius: 5px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.2);
            z-index: 1001;
            transform: translateX(150%);
            transition: transform 0.3s ease;
        }

        .notification.show {
            transform: translateX(0);
        }

        .notification.error {
            background: #ff4d4d;
        }
        
        /* Additional styling for vendor-specific fields */
        .vendor-field {
            border-left: 3px solid #eba708;
            padding-left: 10px;
        }
        
        .vendor-field label {
            color: #d69900;
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

    <!-- Notification -->
    <div class="notification" id="notification"></div>

    <!-- Registration Page -->
    <div class="auth-page">
        <div class="auth-container">
            <div class="auth-header">
                <h2>Create an Account</h2>
            </div>
            
            <!-- User Type Selector -->
            <div class="user-type-selector">
                <div class="user-type-option active" data-type="user">User Registration</div>
                <div class="user-type-option vendor" data-type="vendor">Vendor Registration</div>
            </div>
            
            <!-- User Registration Form -->
            <form action="addUser" method="POST" class="form-container active" id="user-form">
                <div class="auth-form">
                    <div class="form-group">
                        <label for="register-name">Full Name</label>
                         <input type="text" name="uName" id="register-name" placeholder="Enter your full name" required>
                    </div>
                    <div class="form-group">
                        <label for="register-email">Email Address</label> 
                        <input type="email" name="uEmail" id="register-email" placeholder="Enter your email" required>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="register-password">Password</label> 
                            <input type="password" name="uPass" id="register-password" placeholder="Create a password" required>
                        </div>
                        <div class="form-group">
                            <label for="register-confirm">Confirm Password</label> 
                            <input type="password" name="uPassConfirm" id="register-confirm" placeholder="Confirm your password" required>
                        </div>
                    </div>
                    <button type="submit" class="auth-submit">Register as User</button>
                </div>
            </form>
            
            <!-- Vendor Registration Form -->
            <form action="addVendor" method="POST" class="form-container" id="vendor-form">
                <div class="auth-form">
                    <div class="form-group venor-field">
                        <label for="vendor-name">Business name</label>
                         <input type="text" name="vBusinessName" id="vendor-name" placeholder="business name" required>
                    </div>
                    <div class="form-group">
                        <label for="vendor-contact-name">Contact Person Name</label>
                         <input type="text" name="vName" id="vendor-contact-name" placeholder="Enter contact person name" required>
                    </div>
                    <div class="form-group">
                        <label for="vendor-email">Email Address</label> 
                        <input type="email" name="vEmail" id="vendor-email" placeholder="Enter your business email" required>
                    </div>
                    <div class="form-group">
                        <label for="vendor-phone">Phone Number</label> 
                        <input type="tel" name="vPhoneNo" id="vendor-phone" placeholder="Enter your business phone number" required>
                    </div>
                    <div class="form-group">
                        <label for="vendor-type">Vendor Type</label>
                        <select name="vType" id="vendor-type" required>
                            <option value="" disabled selected>Select your vendor type</option>
                            <option value="seeds">Seeds Supplier</option>
                            <option value="fertilizers">Fertilizers Supplier</option>
                            <option value="pesticides">Pesticides Supplier</option>
                            <option value="equipment">Farming Equipment</option>
                            <option value="irrigation">Irrigation Systems</option>
                            <option value="other">Other</option>
                        </select>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="vendor-password">Password</label> 
                            <input type="password" name="vPass" id="vendor-password" placeholder="Create a password" required>
                        </div>
                        <div class="form-group">
                            <label for="vendor-confirm">Confirm Password</label> 
                            <input type="password" name="vPassConfirm" id="vendor-confirm" placeholder="Confirm your password" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="vendor-address">Business Address</label>
                        <textarea name="vAddress" id="vendor-address" placeholder="Enter your business address" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="vendor-description">Business Description</label>
                        <textarea  name="vBusDescrip" id="vendor-description" placeholder="Briefly describe your business"></textarea>
                    </div>
                    <button type="submit" class="auth-submit vendor-submit">Register as Vendor</button>
                </div>
            </form>
            
            <div class="auth-footer">
                <p>
                    Already have an account? <a href="userLogin">Login</a>
                </p>
            </div>
        </div>
    </div>

    <script>
        // User type selection functionality
        document.addEventListener('DOMContentLoaded', function() {
            const userTypeOptions = document.querySelectorAll('.user-type-option');
            const userForm = document.getElementById('user-form');
            const vendorForm = document.getElementById('vendor-form');
            const notification = document.getElementById('notification');
            
            userTypeOptions.forEach(option => {
                option.addEventListener('click', function() {
                    // Remove active class from all options
                    userTypeOptions.forEach(opt => opt.classList.remove('active'));
                    
                    // Add active class to clicked option
                    this.classList.add('active');
                    
                    // Show the corresponding form
                    const type = this.getAttribute('data-type');
                    if (type === 'user') {
                        userForm.classList.add('active');
                        vendorForm.classList.remove('active');
                    } else if (type === 'vendor') {
                        vendorForm.classList.add('active');
                        userForm.classList.remove('active');
                    }
                });
            });
            
            // Password confirmation validation for both forms
            const userPassword = document.getElementById('register-password');
            const userConfirm = document.getElementById('register-confirm');
            const vendorPassword = document.getElementById('vendor-password');
            const vendorConfirm = document.getElementById('vendor-confirm');
            const userFormElem = document.getElementById('user-form');
            const vendorFormElem = document.getElementById('vendor-form');
            
            function validatePassword(password, confirm, form) {
                if (password.value !== confirm.value) {
                    confirm.setCustomValidity("Passwords don't match");
                    showNotification("Passwords don't match", "error");
                    return false;
                } else {
                    confirm.setCustomValidity('');
                    return true;
                }
            }
            
            function showNotification(message, type = "success") {
                notification.textContent = message;
                notification.className = "notification";
                if (type === "error") {
                    notification.classList.add("error");
                }
                notification.classList.add("show");
                
                setTimeout(() => {
                    notification.classList.remove("show");
                }, 3000);
            }
            
            userPassword.addEventListener('change', function() {
                validatePassword(userPassword, userConfirm, userFormElem);
            });
            
            userConfirm.addEventListener('keyup', function() {
                validatePassword(userPassword, userConfirm, userFormElem);
            });
            
            vendorPassword.addEventListener('change', function() {
                validatePassword(vendorPassword, vendorConfirm, vendorFormElem);
            });
            
            vendorConfirm.addEventListener('keyup', function() {
                validatePassword(vendorPassword, vendorConfirm, vendorFormElem);
            });
            
            // Form submission validation
            userFormElem.addEventListener('submit', function(e) {
                if (!validatePassword(userPassword, userConfirm, userFormElem)) {
                    e.preventDefault();
                } else {
                    showNotification("User registration successful!");
                }
            });
            
            vendorFormElem.addEventListener('submit', function(e) {
                if (!validatePassword(vendorPassword, vendorConfirm, vendorFormElem)) {
                    e.preventDefault();
                } else {
                    showNotification("Vendor registration successful!");
                }
            });
        });
    </script>
</body>
</html>