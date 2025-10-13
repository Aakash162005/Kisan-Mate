<%@page import="org.springframework.orm.hibernate5.HibernateTemplate"%>
<%@page import="com.aakash.model.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>KisanMate - Admin Dashboard</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    :root {
      --primary: #1976d2; /* Changed to a modern blue */
      --secondary: #ff9f00;
      --success: #388e3c;
      --danger: #d32f2f;
      --warning: #f57c00;
      --info: #0288d1;
      --dark: #212121;
      --light: #f5f5f5;
      --sidebar-width: 250px;
    }
    
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    body {
      background-color: #f1f3f6;
      color: #333;
      overflow-x: hidden;
    }
    
    /* Admin Header */
    .admin-header {
      background: white;
      box-shadow: 0 1px 5px rgba(0,0,0,0.1);
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      z-index: 1000;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 15px 30px;
    }
    
    .admin-header .logo {
      font-size: 24px;
      font-weight: bold;
      color: var(--primary);
      text-decoration: none;
      display: flex;
      align-items: center;
    }
    
    .logo-icon {
      margin-right: 8px;
      font-size: 26px;
    }
    
    .mate {
      color: var(--secondary);
    }
    
    .admin-actions {
      display: flex;
      align-items: center;
    }
    
    .admin-user {
      display: flex;
      align-items: center;
      margin-left: 20px;
    }
    
    .admin-avatar {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      background: var(--secondary);
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-weight: bold;
      margin-right: 10px;
    }
    
    .admin-name {
      font-weight: 500;
    }
    
    .notification-icon {
      position: relative;
      margin-right: 20px;
      font-size: 20px;
      color: var(--dark);
      cursor: pointer;
    }
    
    .notification-badge {
      position: absolute;
      top: -5px;
      right: -5px;
      background: var(--danger);
      color: white;
      border-radius: 50%;
      width: 18px;
      height: 18px;
      font-size: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    
    .menu-toggle {
      display: none;
      font-size: 20px;
      cursor: pointer;
      margin-right: 15px;
    }
    
    /* Sidebar */
    .admin-sidebar {
      position: fixed;
      top: 70px;
      left: 0;
      width: var(--sidebar-width);
      height: calc(100vh - 70px);
      background: white;
      box-shadow: 1px 0 5px rgba(0,0,0,0.1);
      z-index: 999;
      overflow-y: auto;
      transition: transform 0.3s ease;
    }
    
    .sidebar-menu {
      list-style: none;
      padding: 20px 0;
    }
    
    .menu-item {
      padding: 12px 25px;
      display: flex;
      align-items: center;
      color: var(--dark);
      text-decoration: none;
      transition: all 0.3s;
      border-left: 3px solid transparent;
      cursor: pointer;
    }
    
    .menu-item:hover, .menu-item.active {
      background: #f0f5ff;
      color: var(--primary);
      border-left: 3px solid var(--primary);
    }
    
    .menu-item i {
      margin-right: 12px;
      font-size: 18px;
      width: 24px;
      text-align: center;
    }
    
    .menu-item span {
      font-weight: 500;
    }
    
    /* Main Content */
    .admin-content {
      margin-left: var(--sidebar-width);
      margin-top: 70px;
      padding: 30px;
      min-height: calc(100vh - 70px);
      transition: margin-left 0.3s ease;
    }
    
    .page {
      display: none;
    }
    
    .page.active {
      display: block;
    }
    
    .page-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
    }
    
    .page-title {
      font-size: 24px;
      font-weight: 600;
      color: var(--dark);
    }
    
    .page-actions button {
      padding: 10px 20px;
      background: var(--primary);
      color: white;
      border: none;
      border-radius: 4px;
      font-weight: 500;
      cursor: pointer;
      display: flex;
      align-items: center;
    }
    
    .page-actions button i {
      margin-right: 8px;
    }
    
    /* Dashboard Stats */
    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
      gap: 20px;
      margin-bottom: 30px;
    }
    
    .stat-card {
      background: white;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      display: flex;
      align-items: center;
    }
    
    .stat-icon {
      width: 60px;
      height: 60px;
      border-radius: 8px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 15px;
      font-size: 24px;
      color: white;
    }
    
    .stat-info h3 {
      font-size: 24px;
      font-weight: 600;
      margin-bottom: 5px;
    }
    
    .stat-info p {
      color: #666;
      font-size: 14px;
    }
    
    /* Tables */
    .data-table {
      background: white;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      margin-bottom: 30px;
    }
    
    .table-header {
      padding: 20px;
      border-bottom: 1px solid #eee;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    
    .table-title {
      font-size: 18px;
      font-weight: 600;
    }
    
    .table-search {
      position: relative;
    }
    
    .table-search input {
      padding: 8px 15px 8px 35px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 14px;
      width: 250px;
    }
    
    .table-search i {
      position: absolute;
      left: 12px;
      top: 50%;
      transform: translateY(-50%);
      color: #999;
    }
    
    table {
      width: 100%;
      border-collapse: collapse;
    }
    
    thead {
      background: #f5f5f5;
    }
    
    th, td {
      padding: 15px;
      text-align: left;
      border-bottom: 1px solid #eee;
    }
    
    th {
      font-weight: 600;
      color: #555;
    }
    
    .status {
      padding: 5px 10px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: 500;
    }
    
    .status-pending { background: #fff3e0; color: var(--warning); }
    .status-approved, .status-active, .status-shipped, .status-delivered { background: #e8f5e9; color: var(--success); }
    .status-rejected, .status-blocked, .status-cancelled { background: #ffebee; color: var(--danger); }
    
    .action-buttons {
      display: flex;
      gap: 8px;
    }
    
    .btn {
      padding: 6px 12px;
      border: none;
      border-radius: 4px;
      font-size: 12px;
      font-weight: 500;
      cursor: pointer;
      display: flex;
      align-items: center;
    }
    
    .btn i { margin-right: 5px; }
    .btn-approve { background: #e8f5e9; color: var(--success); }
    .btn-reject { background: #ffebee; color: var(--danger); }
    .btn-edit { background: #e3f2fd; color: var(--info); }
    .btn-delete { background: #ffebee; color: var(--danger); }
    .btn-block { background: #fff3e0; color: var(--warning); }
    
    /* Forms */
    .form-container {
      background: white;
      border-radius: 8px;
      padding: 25px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      margin-bottom: 30px;
    }
    
    .form-group { margin-bottom: 20px; }
    .form-group label { display: block; margin-bottom: 8px; font-weight: 500; }
    .form-control { width: 100%; padding: 10px 15px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; }
    .form-row { display: flex; gap: 20px; }
    .form-row .form-group { flex: 1; }
    textarea.form-control { min-height: 120px; resize: vertical; }
    .form-actions { display: flex; justify-content: flex-end; gap: 15px; margin-top: 25px; }
    .btn-primary { background: var(--primary); color: white; }
    .btn-secondary { background: #e0e0e0; color: #666; }
    
    /* Charts */
    .chart-container {
      background: white;
      border-radius: 8px;
      padding: 25px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      margin-bottom: 30px;
    }
    
    /* **FIX**: Style for Chart Titles */
    .chart-title {
        font-size: 18px;
        font-weight: 600;
        color: var(--dark);
        margin-bottom: 20px;
    }
    
    /* Responsive */
    @media (max-width: 992px) {
      .menu-toggle { display: block; }
      .admin-sidebar { transform: translateX(-100%); }
      .admin-sidebar.active { transform: translateX(0); }
      .admin-content { margin-left: 0; }
    }
    
    @media (max-width: 768px) {
      .stats-grid { grid-template-columns: 1fr; }
      .form-row { flex-direction: column; gap: 0; }
      .table-search input { width: 150px; }
    }
    
    @media (max-width: 576px) {
      .admin-header { padding: 15px; }
      .admin-content { padding: 15px; }
      .page-header, .table-header { flex-direction: column; align-items: flex-start; }
      .page-actions, .table-search { margin-top: 15px; width: 100%; }
      .table-search input { width: 100%; }
    }
  </style>
</head>
<body>
  <header class="admin-header">
    <div class="menu-toggle">
      <i class="fas fa-bars"></i>
    </div>
    <a href="#" class="logo">
      <span class="logo-icon">🌱</span>
      Kisan<span class="mate">Mate</span> <small style="color: #777; margin-left: 5px;">Admin</small>
    </a>
    <div class="admin-actions">
      <div class="notification-icon">
        <i class="fas fa-bell"></i>
        <span class="notification-badge">3</span>
      </div>
      <div class="admin-user">
        <div class="admin-avatar">
          <i class="fas fa-user-shield"></i>
        </div>
        <div class="admin-name">Admin</div>
      </div>
    </div>
  </header>

  <nav class="admin-sidebar">
    <ul class="sidebar-menu">
      <li><a class="menu-item active" data-page="dashboard"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a></li>
      <li><a class="menu-item" data-page="users"><i class="fas fa-users"></i> <span>Manage Users</span></a></li>
      <li><a class="menu-item" data-page="products"><i class="fas fa-seedling"></i> <span>Manage Products</span></a></li>
      <li><a class="menu-item" data-page="orders"><i class="fas fa-shopping-cart"></i> <span>Manage Orders</span></a></li>
      <li><a class="menu-item" data-page="schemes"><i class="fas fa-hand-holding-usd"></i> <span>Govt. Schemes</span></a></li>
      <li><a class="menu-item" data-page="reports"><i class="fas fa-chart-bar"></i> <span>Reports</span></a></li>
      <li><a class="menu-item" data-page="settings"><i class="fas fa-cog"></i> <span>Settings</span></a></li>
    </ul>
  </nav>

  <main class="admin-content">
    <div id="dashboard" class="page active">
      <div class="page-header">
        <h1 class="page-title">Dashboard Overview</h1>
        <div class="page-actions">
          <button id="exportDashboardBtn"><i class="fas fa-download"></i> Export Report</button>
        </div>
      </div>

      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-icon" style="background: var(--primary);"><i class="fas fa-users"></i></div>
          <div class="stat-info"><h3>1,452</h3><p>Total Users</p></div>
        </div>
        <div class="stat-card">
          <div class="stat-icon" style="background: var(--success);"><i class="fas fa-seedling"></i></div>
          <div class="stat-info"><h3>981</h3><p>Active Products</p></div>
        </div>
        <div class="stat-card">
          <div class="stat-icon" style="background: var(--warning);"><i class="fas fa-shopping-cart"></i></div>
          <div class="stat-info"><h3>172</h3><p>Pending Orders</p></div>
        </div>
        <div class="stat-card">
          <div class="stat-icon" style="background: var(--info);"><i class="fas fa-hand-holding-usd"></i></div>
          <div class="stat-info"><h3>21</h3><p>Active Schemes</p></div>
        </div>
      </div>

      <div class="data-table">
        <div class="table-header">
          <h2 class="table-title">Recent Activity</h2>
          <div class="table-search">
            <i class="fas fa-search"></i><input type="text" class="table-filter" data-table="recent-activity-table" placeholder="Search activity...">
          </div>
        </div>
        <table id="recent-activity-table">
          <thead><tr><th>User</th><th>Activity</th><th>Date</th><th>Status</th></tr></thead>
          <tbody>
            <tr><td>Patil Farms</td><td>New vendor registration</td><td>28 Sep 2025, 08:30 PM</td><td><span class="status status-pending">Pending Approval</span></td></tr>
            <tr><td>Jadhav Seeds</td><td>Product #PRO-5008 submitted</td><td>28 Sep 2025, 04:15 PM</td><td><span class="status status-pending">Pending</span></td></tr>
            <tr><td>Ramesh Kumar</td><td>Order #ORD-7015 placed</td><td>27 Sep 2025, 09:45 AM</td><td><span class="status status-approved">Processing</span></td></tr>
            <tr><td>Shirpur Agro</td><td>Product update approved</td><td>26 Sep 2025, 05:20 PM</td><td><span class="status status-approved">Completed</span></td></tr>
          </tbody>
        </table>
      </div>

      <div class="chart-container">
        <h2 class="chart-title">Revenue Overview (Last 7 Days)</h2>
        <canvas id="revenueChart"></canvas>
      </div>
    </div>
    
    <div id="users" class="page">
      <div class="page-header">
        <h1 class="page-title">Manage Users</h1>
        <div class="page-actions"><button><i class="fas fa-plus"></i> Add New User</button></div>
      </div>
      
      <%
      	
		List<User> users = (List<User>) request.getAttribute("users");
      	if(users !=  null && !users.isEmpty())
      		for(User user : users){}
      %>
      
      <div class="data-table">
        <div class="table-header">
          <h2 class="table-title">All Users</h2>
          <div class="table-search"><i class="fas fa-search"></i><input type="text" class="table-filter" data-table="users-table" placeholder="Search users..."></div>
        </div>
        <table id="users-table">
          <thead><tr><th>ID</th><th>Name</th><th>Email</th><th>Type</th><th>Actions</th></tr></thead>
          <tbody>
            <tr><td>#USR-1001</td><td>Ramesh Kumar</td><td>ramesh.k@example.com</td><td>Farmer</td><td><button class="btn btn-block"><i class="fas fa-ban"></i> Block</button></td></tr>
          
          </tbody>
        </table>
      </div>
    </div>
    
    <div id="products" class="page">
        <div class="page-header">
            <h1 class="page-title">Manage Products</h1>
            <div class="page-actions"><button><i class="fas fa-plus"></i> Add New Product</button></div>
        </div>
        <div class="data-table">
            <div class="table-header">
                <h2 class="table-title">Product Listings</h2>
                <div class="table-search"><i class="fas fa-search"></i><input type="text" class="table-filter" data-table="products-table" placeholder="Search products..."></div>
            </div>
            <table id="products-table">
                <thead><tr><th>ID</th><th>Name</th><th>Vendor</th><th>Category</th><th>Price</th><th>Date Added</th><th>Status</th><th>Actions</th></tr></thead>
                <tbody>
                    <tr><td>#PRO-5001</td><td>Hybrid Maize Seeds</td><td>Shirpur Agro</td><td>Seeds</td><td>₹650/kg</td><td>20 Sep 2025</td><td><span class="status status-approved">Approved</span></td><td><div class="action-buttons"><button class="btn btn-edit"><i class="fas fa-edit"></i></button><button class="btn btn-delete"><i class="fas fa-trash"></i></button></div></td></tr>
                    <tr><td>#PRO-5002</td><td>Organic Vermicompost</td><td>Patil Farms</td><td>Fertilizers</td><td>₹950/50kg</td><td>22 Sep 2025</td><td><span class="status status-pending">Pending</span></td><td><div class="action-buttons"><button class="btn btn-approve"><i class="fas fa-check"></i></button><button class="btn btn-reject"><i class="fas fa-times"></i></button></div></td></tr>
                    <tr><td>#PRO-5005</td><td>Neem Oil Pesticide</td><td>Shirpur Agro</td><td>Pesticides</td><td>₹1,800/unit</td><td>21 Sep 2025</td><td><span class="status status-rejected">Rejected</span></td><td><div class="action-buttons"><button class="btn btn-edit"><i class="fas fa-edit"></i></button><button class="btn btn-approve"><i class="fas fa-check"></i> Approve</button></div></td></tr>
                </tbody>
            </table>
        </div>
    </div>
    
    <div id="orders" class="page">
        <div class="page-header">
            <h1 class="page-title">Manage Orders</h1>
            <div class="page-actions"><button id="exportOrdersBtn"><i class="fas fa-download"></i> Export Orders</button></div>
        </div>
        <div class="data-table">
            <div class="table-header">
                <h2 class="table-title">All Orders</h2>
                <div class="table-search"><i class="fas fa-search"></i><input type="text" class="table-filter" data-table="orders-table" placeholder="Search orders..."></div>
            </div>
            <table id="orders-table">
                <thead><tr><th>Order ID</th><th>Customer</th><th>Vendor</th><th>Amount</th><th>Order Date</th><th>Status</th><th>Actions</th></tr></thead>
                <tbody>
                    <tr><td>#ORD-7001</td><td>Ramesh Kumar</td><td>Shirpur Agro</td><td>₹2,250</td><td>23 Sep 2025</td><td><span class="status status-pending">Processing</span></td><td><div class="action-buttons"><button class="btn btn-edit"><i class="fas fa-eye"></i> View</button><button class="btn btn-approve"><i class="fas fa-truck"></i> Ship</button></div></td></tr>
                    <tr><td>#ORD-7002</td><td>Suresh Patil</td><td>Patil Farms</td><td>₹1,600</td><td>22 Sep 2025</td><td><span class="status status-shipped">Shipped</span></td><td><div class="action-buttons"><button class="btn btn-edit"><i class="fas fa-eye"></i> View</button></div></td></tr>
                    <tr><td>#ORD-7003</td><td>Ramesh Kumar</td><td>Shirpur Agro</td><td>₹3,600</td><td>21 Sep 2025</td><td><span class="status status-delivered">Delivered</span></td><td><div class="action-buttons"><button class="btn btn-edit"><i class="fas fa-eye"></i> View</button></div></td></tr>
                    <tr><td>#ORD-7005</td><td>Suresh Patil</td><td>Patil Farms</td><td>₹3,850</td><td>19 Sep 2025</td><td><span class="status status-cancelled">Cancelled</span></td><td><div class="action-buttons"><button class="btn btn-edit"><i class="fas fa-eye"></i> View</button><button class="btn btn-delete"><i class="fas fa-trash"></i></button></div></td></tr>
                </tbody>
            </table>
        </div>
    </div>

    <div id="schemes" class="page">
        <div class="page-header">
            <h1 class="page-title">Subsidy / Government Schemes</h1>
            <div class="page-actions"><button id="addSchemeBtn"><i class="fas fa-plus"></i> Add New Scheme</button></div>
        </div>
        <div id="schemeForm" class="form-container" style="display: none;">
            <h2>Add New Scheme</h2>
            <form id="newSchemeForm">
                <div class="form-row">
                    <div class="form-group"><label for="schemeName">Scheme Name</label><input type="text" id="schemeName" class="form-control" required></div>
                    <div class="form-group"><label for="schemeCategory">Category</label><select id="schemeCategory" class="form-control" required><option value="">Select Category</option><option value="subsidy">Subsidy</option><option value="loan">Loan Scheme</option><option value="insurance">Crop Insurance</option></select></div>
                </div>
                <div class="form-group"><label for="schemeDescription">Scheme Description</label><textarea id="schemeDescription" class="form-control" required></textarea></div>
                <div class="form-row">
                    <div class="form-group"><label for="schemeStartDate">Start Date</label><input type="date" id="schemeStartDate" class="form-control" required></div>
                    <div class="form-group"><label for="schemeEndDate">End Date</label><input type="date" id="schemeEndDate" class="form-control"></div>
                </div>
                <div class="form-actions"><button type="button" class="btn btn-secondary" id="cancelSchemeBtn">Cancel</button><button type="submit" class="btn btn-primary">Save Scheme</button></div>
            </form>
        </div>
        <div class="data-table">
            <div class="table-header">
                <h2 class="table-title">Active Schemes</h2>
                <div class="table-search"><i class="fas fa-search"></i><input type="text" class="table-filter" data-table="schemes-table" placeholder="Search schemes..."></div>
            </div>
            <table id="schemes-table">
                <thead><tr><th>ID</th><th>Name</th><th>Category</th><th>End Date</th><th>Status</th><th>Actions</th></tr></thead>
                <tbody>
                    <tr><td>#SCH-9001</td><td>PM-KISAN Yojana</td><td>Subsidy</td><td>31 Mar 2026</td><td><span class="status status-active">Active</span></td><td><div class="action-buttons"><button class="btn btn-edit"><i class="fas fa-edit"></i></button><button class="btn btn-delete"><i class="fas fa-trash"></i></button></div></td></tr>
                    <tr><td>#SCH-9003</td><td>PMFBY - Crop Insurance</td><td>Insurance</td><td>30 Jun 2026</td><td><span class="status status-active">Active</span></td><td><div class="action-buttons"><button class="btn btn-edit"><i class="fas fa-edit"></i></button><button class="btn btn-delete"><i class="fas fa-trash"></i></button></div></td></tr>
                    <tr><td>#SCH-9005</td><td>Micro Irrigation Fund</td><td>Equipment</td><td>31 Oct 2025</td><td><span class="status status-rejected">Expired</span></td><td><div class="action-buttons"><button class="btn btn-edit"><i class="fas fa-edit"></i></button><button class="btn btn-approve"><i class="fas fa-redo"></i> Renew</button></div></td></tr>
                </tbody>
            </table>
        </div>
    </div>
    
    <div id="reports" class="page">
        <div class="page-header">
            <h1 class="page-title">Reports & Analytics</h1>
            <div class="page-actions"><button id="exportReportsBtn"><i class="fas fa-download"></i> Export All Data</button></div>
        </div>
        <div class="stats-grid">
            <div class="stat-card"><div class="stat-icon" style="background: var(--primary);"><i class="fas fa-rupee-sign"></i></div><div class="stat-info"><h3>₹3,12,890</h3><p>Total Revenue (YTD)</p></div></div>
            <div class="stat-card"><div class="stat-icon" style="background: var(--success);"><i class="fas fa-shopping-cart"></i></div><div class="stat-info"><h3>2,150</h3><p>Total Orders (YTD)</p></div></div>
            <div class="stat-card"><div class="stat-icon" style="background: var(--warning);"><i class="fas fa-users"></i></div><div class="stat-info"><h3>97</h3><p>New Users (30 days)</p></div></div>
            <div class="stat-card"><div class="stat-icon" style="background: var(--info);"><i class="fas fa-percentage"></i></div><div class="stat-info"><h3>18.2%</h3><p>Growth (MoM)</p></div></div>
        </div>
        <div class="chart-container">
            <h2 class="chart-title">Sales Overview (Last 6 Months)</h2>
            <canvas id="salesChart"></canvas>
        </div>
    </div>
    
    <div id="settings" class="page">
        <div class="page-header"><h1 class="page-title">Settings</h1></div>
        <div class="form-container">
            <h2>General Settings</h2>
            <form>
                <div class="form-row">
                    <div class="form-group"><label for="siteName">Site Name</label><input type="text" id="siteName" class="form-control" value="KisanMate"></div>
                    <div class="form-group"><label for="adminEmail">Admin Email</label><input type="email" id="adminEmail" class="form-control" value="admin@kisanmate.com"></div>
                </div>
                <div class="form-group"><label for="currency">Currency</label><select id="currency" class="form-control"><option value="INR" selected>Indian Rupee (₹)</option></select></div>
                <div class="form-actions"><button type="submit" class="btn btn-primary">Save Settings</button></div>
            </form>
        </div>
    </div>
  </main>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      // --- **FIX**: CSV EXPORT FUNCTIONALITY ---
      function exportTableToCSV(tableId, filename) {
        const table = document.getElementById(tableId);
        if (!table) {
            console.error('Table not found!');
            return;
        }

        let csv = [];
        const rows = table.querySelectorAll("tr");
        
        for (const row of rows) {
            const cols = row.querySelectorAll("td, th");
            const rowData = [];
            for (const col of cols) {
                // To handle commas within cells, wrap them in double quotes
                let cellData = col.innerText.replace(/"/g, '""');
                if (cellData.includes(',')) {
                    cellData = `"${cellData}"`;
                }
                // Exclude the 'Actions' column from export
                if (col.textContent.trim().toLowerCase() !== 'actions') {
                    rowData.push(cellData);
                }
            }
            csv.push(rowData.join(","));
        }

        const csvFile = new Blob([csv.join("\n")], { type: "text/csv" });
        const downloadLink = document.createElement("a");
        downloadLink.download = filename;
        downloadLink.href = window.URL.createObjectURL(csvFile);
        downloadLink.style.display = "none";
        document.body.appendChild(downloadLink);
        downloadLink.click();
        document.body.removeChild(downloadLink);
      }

      // Attaching export function to buttons
      document.getElementById('exportDashboardBtn')?.addEventListener('click', () => {
          exportTableToCSV('recent-activity-table', 'dashboard-recent-activity.csv');
      });
      document.getElementById('exportOrdersBtn')?.addEventListener('click', () => {
          exportTableToCSV('orders-table', 'all-orders-report.csv');
      });
      document.getElementById('exportReportsBtn')?.addEventListener('click', () => {
          // In a real scenario, this might export multiple tables or server-generated data.
          // For this simulation, we'll export the users table as an example.
          exportTableToCSV('users-table', 'all-users-report.csv');
          Swal.fire('Export Started', 'A report of all users has been downloaded.', 'info');
      });

      // --- CORE NAVIGATION LOGIC (as before) ---
      const menuItems = document.querySelectorAll('.menu-item');
      const pages = document.querySelectorAll('.page');
      const menuToggle = document.querySelector('.menu-toggle');
      const sidebar = document.querySelector('.admin-sidebar');
      
      menuToggle.addEventListener('click', () => sidebar.classList.toggle('active'));
      
      menuItems.forEach(item => {
        item.addEventListener('click', function(e) {
          e.preventDefault();
          menuItems.forEach(i => i.classList.remove('active'));
          pages.forEach(p => p.classList.remove('active'));
          this.classList.add('active');
          const pageId = this.getAttribute('data-page');
          document.getElementById(pageId)?.classList.add('active');
          if (window.innerWidth <= 992) sidebar.classList.remove('active');
        });
      });

      // --- DYNAMIC TABLE SEARCH FILTER (as before) ---
      document.querySelectorAll('.table-filter').forEach(input => {
        input.addEventListener('keyup', function() {
          const searchTerm = this.value.toLowerCase();
          const tableId = this.getAttribute('data-table');
          const table = document.getElementById(tableId);
          table.querySelectorAll('tbody tr').forEach(row => {
            row.style.display = row.textContent.toLowerCase().includes(searchTerm) ? '' : 'none';
          });
        });
      });

      // --- ADD SCHEME FORM TOGGLE (as before) ---
      const addSchemeBtn = document.getElementById('addSchemeBtn');
      const schemeFormContainer = document.getElementById('schemeForm');
      const cancelSchemeBtn = document.getElementById('cancelSchemeBtn');
      const newSchemeForm = document.getElementById('newSchemeForm');
      
      if(addSchemeBtn) addSchemeBtn.addEventListener('click', () => { schemeFormContainer.style.display = 'block'; });
      if(cancelSchemeBtn) cancelSchemeBtn.addEventListener('click', () => { schemeFormContainer.style.display = 'none'; newSchemeForm.reset(); });
      if(newSchemeForm) newSchemeForm.addEventListener('submit', function(e) {
          e.preventDefault();
          Swal.fire('Success!', 'New scheme added successfully!', 'success');
          schemeFormContainer.style.display = 'none';
          this.reset();
      });

      // --- INTERACTIVE ACTION BUTTONS WITH SWEETALERT2 (as before) ---
      document.querySelector('.admin-content').addEventListener('click', function(e) {
        if (!e.target.closest('.btn')) return;
        const button = e.target.closest('.btn');
        const action = button.textContent.trim();
        const row = button.closest('tr');
        if (!row) return;

        const id = row.querySelector('td:first-child').textContent;
        const name = row.querySelector('td:nth-child(2)').textContent;
        
        const actions = {
          'Approve': { title: `Approve ${name}?`, text: `${id} will be approved.`, icon: 'question', confirmButtonColor: '#388e3c' },
          'Reject': { title: `Reject ${name}?`, text: `${id} will be rejected.`, icon: 'warning', confirmButtonColor: '#d32f2f' },
          'Block': { title: `Block ${name}?`, text: `This user will be blocked.`, icon: 'warning', confirmButtonColor: '#f57c00' },
          'Unblock': { title: `Unblock ${name}?`, text: `This user will be unblocked.`, icon: 'question', confirmButtonColor: '#388e3c' },
          'Delete': { title: `Delete ${name}?`, text: `This action cannot be undone!`, icon: 'error', confirmButtonColor: '#d32f2f' },
          'Renew': { title: `Renew ${name}?`, text: `This scheme will be renewed.`, icon: 'question', confirmButtonColor: '#1976d2' }
        };

        const currentAction = Object.keys(actions).find(key => action.includes(key));
        if (!currentAction) return;

        Swal.fire({
          ...actions[currentAction],
          showCancelButton: true,
          confirmButtonText: `Yes, ${currentAction.toLowerCase()} it!`,
          cancelButtonText: 'No, cancel'
        }).then((result) => {
          if (result.isConfirmed) {
            const statusElement = row.querySelector('.status');
            if (currentAction === 'Delete') {
              row.remove();
            } else if (statusElement) {
                if(currentAction === 'Approve') statusElement.className = 'status status-approved';
                if(currentAction === 'Reject') statusElement.className = 'status status-rejected';
                if(currentAction === 'Block') statusElement.className = 'status status-blocked';
                if(currentAction === 'Unblock' || currentAction === 'Renew') statusElement.className = 'status status-active';
                statusElement.textContent = currentAction + (currentAction.endsWith('e') ? 'd' : 'ed');
            }
            Swal.fire('Success!', `${name} has been ${currentAction.toLowerCase()}ed.`, 'success');
          }
        });
      });
      
      // --- CHART.JS IMPLEMENTATION (as before) ---
      const revenueCtx = document.getElementById('revenueChart');
      if (revenueCtx) {
        new Chart(revenueCtx, {
          type: 'line',
          data: {
            labels: ['Sep 22', 'Sep 23', 'Sep 24', 'Sep 25', 'Sep 26', 'Sep 27', 'Today'],
            datasets: [{
              label: 'Revenue (₹)',
              data: [12500, 19800, 15300, 28600, 22000, 35100, 41200],
              borderColor: 'rgba(25, 118, 210, 1)',
              backgroundColor: 'rgba(25, 118, 210, 0.1)',
              fill: true,
              tension: 0.4
            }]
          },
          options: { responsive: true, maintainAspectRatio: false }
        });
      }

      const salesCtx = document.getElementById('salesChart');
      if (salesCtx) {
        new Chart(salesCtx, {
          type: 'bar',
          data: {
            labels: ['April', 'May', 'June', 'July', 'August', 'September'],
            datasets: [{
              label: 'Sales (in ₹)',
              data: [45000, 52000, 68000, 55000, 72000, 89500],
              backgroundColor: [
                'rgba(25, 118, 210, 0.7)',
                'rgba(56, 142, 60, 0.7)',
                'rgba(245, 124, 0, 0.7)',
                'rgba(211, 47, 47, 0.7)',
                'rgba(2, 136, 209, 0.7)',
                'rgba(255, 159, 0, 0.7)'
              ]
            }]
          },
          options: { responsive: true, maintainAspectRatio: false }
        });
      }
    });
  </script>
</body>
</html>