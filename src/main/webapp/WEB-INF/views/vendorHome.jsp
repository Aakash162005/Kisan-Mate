<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor Panel - KisanMate</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --primary: #1976d2;
            --secondary: #f57c00; /* Adjusted Orange */
            --green: #388e3c;
            --dark: #2c3e50;
            --light-bg: #f8f9fa;
            --text-color: #333;
            --sidebar-width: 260px;
            --sidebar-collapsed-width: 80px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: var(--light-bg);
            color: var(--text-color);
            overflow-x: hidden;
        }
        
        /* Header */
        header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            border-bottom: 1px solid #eee;
        }

        .header-left { display: flex; align-items: center; }

        .menu-toggle {
            font-size: 1.5rem;
            cursor: pointer;
            color: var(--primary);
            margin-right: 20px;
        }
        
        .logo {
            font-size: 26px;
            font-weight: bold;
            color: var(--green);
            text-decoration: none;
        }

        .mate{ color: var(--secondary); }
        
        .user-actions {
            display: flex;
            align-items: center;
        }
        
        .user-profile {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--secondary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }

        .user-name { font-weight: 600; }
        
        /* Sidebar Styles */
        .sidebar {
            width: var(--sidebar-width);
            background: #ffffff;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            transition: all 0.3s ease-in-out;
            z-index: 1001;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.05);
            border-right: 1px solid #eee;
        }
        
        .sidebar-header {
            padding: 18px 25px;
            display: flex;
            align-items: center;
            gap: 10px;
            border-bottom: 1px solid #eee;
        }
        
        .sidebar-header .logo { font-size: 24px; }
        
        .sidebar-menu { padding: 15px 0; }
        .sidebar-menu ul { list-style: none; }
        
        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 14px 25px;
            color: #555;
            text-decoration: none;
            transition: 0.3s;
            gap: 15px;
            font-weight: 500;
            white-space: nowrap;
        }
        
        .sidebar-menu a:hover, .sidebar-menu a.active {
            background: #f0f5ff;
            color: var(--primary);
            border-right: 4px solid var(--primary);
        }
        
        .sidebar-menu i {
            width: 24px;
            text-align: center;
            font-size: 1.2rem;
            color: var(--primary);
        }

        /* Main Content Styles */
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 30px;
            padding-top: 95px; /* header height + padding */
            transition: all 0.3s ease-in-out;
        }
        
        .page-title h1 { font-size: 2rem; color: var(--dark); margin-bottom: 5px; }
        .page-title p { font-size: 1rem; color: #7f8c8d; margin-bottom: 30px;}
        
        /* Card Styles */
        .card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 25px;
            margin-bottom: 25px;
            border: 1px solid #eee;
        }
        
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        
        .card-header h3 { font-size: 1.2rem; color: var(--dark); }
        
        /* Dashboard Styles */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
        }
        
        .stat-card {
            display: flex; align-items: center; gap: 15px;
            padding: 20px;
        }
        
        .stat-icon {
            width: 55px; height: 55px; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.5rem; color: white;
        }
        
        .sales .stat-icon { background: var(--green); }
        .orders .stat-icon { background: var(--secondary); }
        .stock .stat-icon { background: var(--primary); }
        
        .stat-info h4 { font-size: 0.9rem; color: #7f8c8d; margin-bottom: 5px; text-transform: uppercase;}
        .stat-info p { font-size: 1.8rem; font-weight: 600; color: var(--dark); }
        
        /* General Table Styles */
        .data-table { width: 100%; border-collapse: collapse; }
        .data-table th, .data-table td { padding: 12px 15px; text-align: left; border-bottom: 1px solid #eee; }
        .data-table th { background: #f8f9fa; font-weight: 600; color: #555; }
        .data-table tbody tr:hover { background-color: #f8f9fa; }
        
        .status { padding: 5px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; text-align: center;}
        .status.pending { background: #fff3e0; color: #f57c00; }
        .status.completed, .status.active { background: #e8f5e9; color: var(--green); }
        .status.processing { background: #e3f2fd; color: var(--primary); }
        .status.low-stock { background: #ffebee; color: #d32f2f;}
        
        /* Form Styles */
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #555; }
        .form-control { width: 100%; padding: 12px 15px; border: 1px solid #ddd; border-radius: 5px; font-size: 1rem; transition: border 0.3s; }
        .form-control:focus { outline: none; border-color: var(--primary); box-shadow: 0 0 0 2px rgba(25, 118, 210, 0.2); }
        textarea.form-control { min-height: 120px; resize: vertical; }
        .form-row { display: flex; gap: 20px; }
        .form-row .form-group { flex: 1; }
        
        .btn { padding: 10px 20px; border: none; border-radius: 5px; font-size: 1rem; cursor: pointer; transition: all 0.3s; font-weight: 600; }
        .btn-primary { background: var(--primary); color: white; }
        .btn-primary:hover { background: #1565c0; }
        .btn-secondary { background: #e0e0e0; color: #333; }
        .btn-secondary:hover { background: #bdbdbd; }
        .btn-small { padding: 6px 12px; font-size: 0.9rem; }
        .action-buttons { display: flex; gap: 10px; justify-content: flex-end; margin-top: 20px; }
        
        .stock-low { color: #e74c3c; font-weight: 600; }
        .stock-ok { color: var(--green); font-weight: 600; }
        
        /* Page Styles */
        .page { display: none; }
        .page.active { display: block; animation: fadeIn 0.5s; }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }

        /* Responsive Design */
        body.sidebar-collapsed .sidebar { width: var(--sidebar-collapsed-width); }
        body.sidebar-collapsed .sidebar-header .logo, body.sidebar-collapsed .sidebar-menu span { display: none; }
        body.sidebar-collapsed .sidebar-menu a { justify-content: center; }
        body.sidebar-collapsed .main-content { margin-left: var(--sidebar-collapsed-width); }
        
        @media (max-width: 992px) {
            body:not(.sidebar-mobile-active) .sidebar { transform: translateX(-100%); }
            .sidebar { box-shadow: 5px 0 15px rgba(0,0,0,0.1); }
            .main-content { margin-left: 0; }
            body.sidebar-collapsed .main-content { margin-left: 0; } /* Override for mobile */
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <a href="#" class="logo">
                <i class="fas fa-seedling"></i>
                Kisan<span class="mate">Mate</span>
            </a>
        </div>
        <nav class="sidebar-menu">
            <ul>
                <li><a href="#" class="nav-link active" data-page="dashboard"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a></li>
                <li><a href="#" class="nav-link" data-page="products"><i class="fas fa-box-open"></i> <span>My Products</span></a></li>
                <li><a href="#" class="nav-link" data-page="orders"><i class="fas fa-shopping-cart"></i> <span>Orders</span></a></li>
                <li><a href="#" class="nav-link" data-page="add-product"><i class="fas fa-plus-circle"></i> <span>Add New Product</span></a></li>
                <li><a href="#" class="nav-link" data-page="profile"><i class="fas fa-user-cog"></i> <span>My Profile</span></a></li>
                <li><a href="#" class="nav-link"><i class="fas fa-sign-out-alt"></i> <span>Logout</span></a></li>
            </ul>
        </nav>
    </div>

    <div class="page-container">
        <header>
            <div class="header-left">
                <div class="menu-toggle"><i class="fas fa-bars"></i></div>
                <h2 style="font-weight: 500; color: #333;" id="page-header-title">Dashboard</h2>
            </div>
            <div class="user-actions">
                <div class="user-profile">
                    <span class="user-name">Shirpur Agro</span>
                    <div class="user-avatar">SA</div>
                </div>
            </div>
        </header>

        <main class="main-content">
            <div id="dashboard" class="page active">
                <div class="page-title">
                    <h1>Welcome Back, Shirpur Agro!</h1>
                    <p>Here's a summary of your store's activity.</p>
                </div>
                
                <div class="stats-container card">
                    <div class="stat-card sales">
                        <div class="stat-icon"><i class="fas fa-rupee-sign"></i></div>
                        <div class="stat-info"><h4>Total Sales (Month)</h4><p>₹48,950</p></div>
                    </div>
                    <div class="stat-card orders">
                        <div class="stat-icon"><i class="fas fa-shopping-bag"></i></div>
                        <div class="stat-info"><h4>New Orders (Month)</h4><p>32</p></div>
                    </div>
                    <div class="stat-card stock">
                        <div class="stat-icon"><i class="fas fa-cubes"></i></div>
                        <div class="stat-info"><h4>Products in Stock</h4><p>53</p></div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header"><h3>Monthly Sales Overview</h3></div>
                    <canvas id="salesChart"></canvas>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h3>Recent Orders</h3>
                        <a href="#" class="btn btn-primary btn-small nav-link" data-page="orders">View All</a>
                    </div>
                    <table class="data-table">
                        <thead><tr><th>Order ID</th><th>Customer</th><th>Date</th><th>Amount</th><th>Status</th></tr></thead>
                        <tbody>
                            <tr><td>#ORD-7845</td><td>Suresh Patil</td><td>28 Sep 2025</td><td>₹2,850</td><td><span class="status processing">Processing</span></td></tr>
                            <tr><td>#ORD-7844</td><td>Anil Jadhav</td><td>27 Sep 2025</td><td>₹9,487</td><td><span class="status completed">Shipped</span></td></tr>
                            <tr><td>#ORD-7843</td><td>Ramesh Kumar</td><td>27 Sep 2025</td><td>₹1,200</td><td><span class="status pending">Payment Pending</span></td></tr>
                            <tr><td>#ORD-7842</td><td>Vikas More</td><td>26 Sep 2025</td><td>₹12,458</td><td><span class="status completed">Delivered</span></td></tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="products" class="page">
                <div class="page-title">
                    <h1>My Products</h1>
                    <p>View, search, and manage your product listings.</p>
                </div>
                <div class="card">
                    <div class="card-header">
                        <h3>Your Product Listings</h3>
                        <input type="text" id="product-search" class="form-control" placeholder="Search products..." style="width: 250px;">
                    </div>
                    <table class="data-table" id="products-table">
                        <thead><tr><th>Product Name</th><th>Category</th><th>Price</th><th>Stock</th><th>Status</th><th>Actions</th></tr></thead>
                        <tbody>
                            <tr><td>Hybrid Jowar Seeds</td><td>Seeds</td><td>₹550/kg</td><td class="stock-ok">150 units</td><td><span class="status active">Active</span></td><td><a href="#" class="btn btn-secondary btn-small">Edit</a></td></tr>
                            <tr><td>Tractor Plough Attachment</td><td>Tools</td><td>₹18,500</td><td class="stock-low">3 units</td><td><span class="status low-stock">Low Stock</span></td><td><a href="#" class="btn btn-secondary btn-small">Edit</a></td></tr>
                            <tr><td>Urea Fertilizer</td><td>Fertilizers</td><td>₹350/50kg</td><td class="stock-ok">82 units</td><td><span class="status active">Active</span></td><td><a href="#" class="btn btn-secondary btn-small">Edit</a></td></tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="orders" class="page">
                <div class="page-title">
                    <h1>Manage Orders</h1>
                    <p>View and update the status of incoming orders.</p>
                </div>
                <div class="card">
                    <div class="card-header">
                        <h3>All Orders</h3>
                        <select id="order-status-filter" class="form-control" style="width: 200px;">
                            <option value="">All Statuses</option>
                            <option value="Processing">Processing</option>
                            <option value="Shipped">Shipped</option>
                            <option value="Delivered">Delivered</option>
                            <option value="Payment Pending">Payment Pending</option>
                        </select>
                    </div>
                    <table class="data-table" id="orders-table">
                        <thead><tr><th>Order ID</th><th>Customer</th><th>Date</th><th>Total</th><th>Status</th><th>Actions</th></tr></thead>
                        <tbody>
                            <tr><td>#ORD-7845</td><td>Suresh Patil</td><td>28 Sep 2025</td><td>₹2,850</td><td><span class="status processing">Processing</span></td><td><a href="#" class="btn btn-primary btn-small">Update Status</a></td></tr>
                            <tr><td>#ORD-7844</td><td>Anil Jadhav</td><td>27 Sep 2025</td><td>₹9,487</td><td><span class="status completed">Shipped</span></td><td><a href="#" class="btn btn-secondary btn-small">View Details</a></td></tr>
                            <tr><td>#ORD-7843</td><td>Ramesh Kumar</td><td>27 Sep 2025</td><td>₹1,200</td><td><span class="status pending">Payment Pending</span></td><td><a href="#" class="btn btn-primary btn-small">Update Status</a></td></tr>
                            <tr><td>#ORD-7842</td><td>Vikas More</td><td>26 Sep 2025</td><td>₹12,458</td><td><span class="status completed">Delivered</span></td><td><a href="#" class="btn btn-secondary btn-small">View Details</a></td></tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <form action="addProduct" method="POST" > 
            <div id="add-product" class="page">
                <div class="page-title"><h1>Add New Product</h1><p>Fill out the form below to list a new item in your store.</p></div>
                <div class="card">
                    <form id="product-form">
                        <div class="form-row">
                            <div class="form-group"><label for="product-name">Product Name</label><input type="text" id="product-name" name="pName" class="form-control" required placeholder="e.g., Hybrid Jowar Seeds"></div>
                            <div class="form-group"><label for="vendor-email">Vendor Email</label><input type="email" id="vendor-email" name="vEmail" class="form-control" required placeholder="e.g., xxxx@gmail.com"></div>
                            <div class="form-group"><label for="product-category">Category</label><select id="product-category" name="pCategory" class="form-control" required><option value="">Select Category</option><option value="Seeds">Seeds</option><option value="Tools">Tools</option><option value="Fertilizers">Fertilizers</option><option value="Irrigation">Irrigation</option><option value="Pesticides">Pesticides</option></select></div>
                        </div>
                        <div class="form-row">
                            <div class="form-group"><label for="product-price">Price (₹)</label><input type="number" id="product-price" name="pPrice" class="form-control" required placeholder="0.00" step="0.01"></div>
                            <div class="form-group"><label for="product-stock">Initial Stock</label><input type="number" id="product-stock" name="pInitialStock" class="form-control" required placeholder="e.g., 150"></div>
                        </div>
                        <div class="form-group"><label for="product-description">Description</label><textarea id="product-description" name="Description" class="form-control" placeholder="Describe the product details, benefits, and usage instructions."></textarea></div>
                        <div class="form-group"><label for="product-image">Product Image</label><input type="file" id="product-image" name="pImage" class="form-control"></div>
                        <div class="action-buttons"><button type="submit" class="btn btn-primary">Add Product to Store</button></div>
                    </form>
                </div>
            </div>
           </form>
            <div id="profile" class="page">
                <div class="page-title"><h1>Vendor Profile</h1><p>Manage your public store and contact information.</p></div>
                <div class="card">
                    <form>
                        <div class="form-row">
                            <div class="form-group"><label for="vendor-name">Business Name</label><input type="text" id="vendor-name" class="form-control" value="Shirpur Agro Suppliers"></div>
                            <div class="form-group"><label for="contact-person">Contact Person</label><input type="text" id="contact-person" class="form-control" value="Rajesh Patil"></div>
                        </div>
                        <div class="form-row">
                            <div class="form-group"><label for="email">Email</label><input type="email" id="email" class="form-control" value="contact@shirpuragro.com"></div>
                            <div class="form-group"><label for="phone">Phone</label><input type="tel" id="phone" class="form-control" value="+91 9123456789"></div>
                        </div>
                        <div class="form-group"><label for="address">Business Address</label><textarea id="address" class="form-control">Shop No. 5, Market Yard, Shirpur, Dist. Dhule, Maharashtra - 425405</textarea></div>
                        <div class="action-buttons"><button type="submit" class="btn btn-primary">Update Profile</button></div>
                    </form>
                </div>
            </div>
        </main>
    </div>

    <script>
    document.addEventListener('DOMContentLoaded', function () {
        const menuToggle = document.querySelector('.menu-toggle');
        const navLinks = document.querySelectorAll('.nav-link');
        const pages = document.querySelectorAll('.page');
        const pageHeaderTitle = document.getElementById('page-header-title');

        // --- Sidebar Toggle Logic ---
        menuToggle.addEventListener('click', () => {
            if (window.innerWidth <= 992) {
                document.body.classList.toggle('sidebar-mobile-active');
                document.querySelector('.sidebar').classList.toggle('active');
            } else {
                document.body.classList.toggle('sidebar-collapsed');
            }
        });

        // --- Page Navigation Logic ---
        navLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                const pageId = this.getAttribute('data-page');
                if (!pageId) return; // For logout link etc.
                
                e.preventDefault();
                navLinks.forEach(item => item.classList.remove('active'));
                this.classList.add('active');
                
                pages.forEach(page => page.classList.remove('active'));
                document.getElementById(pageId)?.classList.add('active');

                // Update header title
                const pageTitleText = this.querySelector('span')?.textContent || 'Dashboard';
                pageHeaderTitle.textContent = pageTitleText;

                // Close mobile sidebar on navigation
                if (window.innerWidth <= 992) {
                    document.body.classList.remove('sidebar-mobile-active');
                    document.querySelector('.sidebar').classList.remove('active');
                }
            });
        });

        // --- Live Search for Products ---
        document.getElementById('product-search')?.addEventListener('keyup', function() {
            const searchTerm = this.value.toLowerCase();
            document.querySelectorAll('#products-table tbody tr').forEach(row => {
                row.style.display = row.textContent.toLowerCase().includes(searchTerm) ? '' : 'none';
            });
        });

        // --- Live Filter for Orders ---
        document.getElementById('order-status-filter')?.addEventListener('change', function() {
            const filterTerm = this.value.toLowerCase();
            document.querySelectorAll('#orders-table tbody tr').forEach(row => {
                const status = row.querySelector('.status').textContent.toLowerCase();
                row.style.display = (filterTerm === '' || status === filterTerm) ? '' : 'none';
            });
        });

        // --- Add Product Form Submission ---
        document.getElementById('product-form')?.addEventListener('submit', function(e) {
            e.preventDefault();
            Swal.fire({
                icon: 'success',
                title: 'Product Added!',
                text: 'Your new product has been successfully listed.',
                confirmButtonColor: 'var(--primary)'
            });
            this.reset();
        });

        // --- Chart.js: Monthly Sales Chart ---
        const salesCtx = document.getElementById('salesChart');
        if (salesCtx) {
            new Chart(salesCtx, {
                type: 'bar',
                data: {
                    labels: ['April', 'May', 'June', 'July', 'August', 'September'],
                    datasets: [{
                        label: 'Monthly Sales (₹)',
                        data: [22500, 31000, 45000, 38500, 52000, 48950],
                        backgroundColor: 'rgba(25, 118, 210, 0.7)',
                        borderColor: 'rgba(25, 118, 210, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: { y: { beginAtZero: true } },
                    plugins: { legend: { display: false } }
                }
            });
        }
    });
    </script>
</body>
</html>