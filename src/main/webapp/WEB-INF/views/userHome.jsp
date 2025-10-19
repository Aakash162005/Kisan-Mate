<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>KisanMate - Products</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
:root {
	--primary: #1976d2;
	--secondary: #f57c00;
	--green: #388e3c;
	--dark: #2c3e50;
	--light-bg: #f4f7f6;
    --info: #0288d1;
    --danger: #d32f2f;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
	background-color: var(--light-bg);
	color: #333;
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
	padding: 15px 40px;
	z-index: 1000;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
	border-bottom: 1px solid #eee;
}

.logo {
	font-size: 26px;
	font-weight: bold;
	color: var(--green);
	text-decoration: none;
}

.logo .mate {
	color: var(--secondary);
}

nav {
	display: flex;
	align-items: center;
}

nav a {
	margin-left: 25px;
	text-decoration: none;
	color: #333;
	font-weight: 500;
	transition: 0.3s;
	position: relative;
    cursor: pointer;
}

nav a:hover, nav a.active {
	color: var(--primary);
}

/* User Actions & Dropdown */
.user-actions {
	display: flex;
	align-items: center;
	margin-left: 25px;
}
.cart-icon-wrapper {
    margin-right: 20px;
}
.cart-icon {
	position: relative;
	font-size: 1.5rem;
	color: var(--dark);
	cursor: pointer;
}
.cart-count {
	position: absolute;
	top: -5px;
	right: -10px;
	background: var(--secondary);
	color: white;
	width: 20px;
	height: 20px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 0.8rem;
	font-weight: bold;
}
.account-menu {
    position: relative;
}
.account-menu-btn {
    background: none;
    border: none;
    font-size: 1.6rem;
    cursor: pointer;
    display: flex;
    align-items: center;
}
.dropdown-content {
    display: none;
    position: absolute;
    right: 0;
    background-color: white;
    min-width: 180px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.1);
    z-index: 1;
    border-radius: 8px;
    overflow: hidden;
    animation: fadeIn 0.3s;
}
.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: flex;
    align-items: center;
    gap: 10px;
    margin-left: 0;
}
.dropdown-content a:hover {
    background-color: #f1f1f1;
}
.account-menu:hover .dropdown-content {
    display: block;
}
@keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }

/* Main Content & Page Sections */
.container {
	max-width: 1300px;
	margin: 100px auto 40px;
	padding: 0 20px;
}
.page { 
    display: none; 
}
.page.active { 
    display: block; 
    animation: fadeIn 0.5s;
}

/* Controls: Search, Filter, Sort */
.product-controls {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
	align-items: center;
	gap: 20px;
	padding: 20px;
	background: white;
	border-radius: 8px;
	margin-bottom: 40px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}
.search-bar {
	position: relative;
	flex-grow: 1;
	min-width: 250px;
}
#product-search {
	width: 100%;
	padding: 12px 20px 12px 45px;
	border: 1px solid #ddd;
	border-radius: 30px;
	font-size: 1rem;
}
#product-search:focus {
	outline: none;
	border-color: var(--primary);
}
.search-bar i {
	position: absolute;
	left: 18px;
	top: 50%;
	transform: translateY(-50%);
	color: #999;
}
.sort-options {
	min-width: 200px;
}
#sort-by {
	width: 100%;
	padding: 12px;
	border: 1px solid #ddd;
	border-radius: 8px;
	font-size: 1rem;
}

/* Categories */
.categories {
	display: flex;
	justify-content: center;
	flex-wrap: wrap;
	margin-bottom: 40px;
	gap: 15px;
}
.category-btn {
	padding: 10px 20px;
	background: white;
	border: 1px solid #ddd;
	border-radius: 30px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s;
	display: flex;
	align-items: center;
	gap: 8px;
}
.category-btn i { color: var(--green); }
.category-btn.active, .category-btn:hover {
	background: var(--green);
	color: white;
	border-color: var(--green);
}
.category-btn.active i, .category-btn:hover i { color: white; }

/* Products Grid & Card (User's preferred design) */
.products-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
	gap: 30px;
}
.product-card {
	background: white;
	border-radius: 10px;
	overflow: hidden;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
	transition: transform 0.3s, box-shadow 0.3s;
	display: flex;
	flex-direction: column;
}
.product-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
}
.product-img { height: 200px; overflow: hidden; }
.product-img img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s; }
.product-card:hover .product-img img { transform: scale(1.05); }
.product-info { padding: 20px; flex-grow: 1; display: flex; flex-direction: column; }
.product-category { color: var(--green); font-size: 0.9rem; font-weight: 500; margin-bottom: 5px; }
.product-title { font-size: 1.2rem; margin-bottom: 10px; color: var(--dark); }
.product-description { color: #7f8c8d; font-size: 0.9rem; margin-bottom: 15px; line-height: 1.5; flex-grow: 1; }
.product-price { font-size: 1.3rem; font-weight: bold; color: var(--dark); margin-bottom: 15px; }
.product-actions { display: flex; justify-content: space-between; align-items: center; }
.add-to-cart { padding: 10px 20px; background: var(--secondary); color: white; border: none; border-radius: 5px; font-weight: 600; cursor: pointer; transition: background 0.3s; }
.add-to-cart:hover { background: #e65100; }
.wishlist { width: 40px; height: 40px; border-radius: 50%; border: 1px solid #ddd; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: all 0.3s; font-size: 1.2rem; }
.wishlist i.fas { color: #e74c3c; }
.wishlist:hover { background: #f1f1f1; }

/* My Orders & My Profile Styles */
.page-header { margin-bottom: 30px; border-bottom: 1px solid #ddd; padding-bottom: 15px; }
.page-header h1 { font-size: 2.2rem; color: var(--dark); }
.data-table { background: white; border-radius: 8px; overflow-x: auto; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
table { width: 100%; border-collapse: collapse; }
th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
th { font-weight: 600; background-color: #f9fafb; }
.status { padding: 5px 10px; border-radius: 20px; font-size: 12px; font-weight: 500; text-align: center; }
.status-delivered { background: #e8f5e9; color: var(--green); }
.status-shipped { background: #e3f2fd; color: var(--info); }
.status-cancelled { background: #ffebee; color: var(--danger); }
.form-container { background: white; border-radius: 8px; padding: 30px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
.form-row { display: flex; gap: 20px; }
.form-group { flex: 1; margin-bottom: 20px; }
.form-group label { display: block; margin-bottom: 8px; font-weight: 600; }
.form-group input, .form-group textarea { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; }
.form-actions { text-align: right; margin-top: 20px; }
.btn-primary { padding: 12px 25px; background: var(--primary); color: white; border: none; border-radius: 5px; cursor: pointer; }

/* Footer */
footer {
	background: #1e1f21;
	color: white;
	padding: 40px 0;
	margin-top: 80px;
}
.copyright {
	text-align: center;
	padding-top: 30px;
	margin-top: 30px;
	border-top: 1px solid #2c3e50;
	color: #bdc3c7;
}
</style>
</head>
<body>
	<header>
		<a href="#" class="logo nav-link" data-page="products-page">
            <i class="fas fa-seedling" style="margin-right: 8px;"></i> Kisan<span class="mate">Mate</span>
		</a>
		<nav>
			<a class="nav-link active" data-page="products-page">Store</a> 
            <a href="govt_schemes">Government Schemes</a> 
            <a href="#">About</a> 
            <a href="#">Contact</a>
			<div class="user-actions">
                <div class="cart-icon-wrapper">
                    <div class="cart-icon">
                        <i class="fas fa-shopping-cart"></i> <span class="cart-count">0</span>
                    </div>
                </div>
                <div class="account-menu">
                  <button class="account-menu-btn"><i class="fas fa-user-circle"></i></button>
                  <div class="dropdown-content">
                    <a href="#" class="nav-link" data-page="my-profile"><i class="fas fa-user-edit"></i> My Profile</a>
                    <a href="#" class="nav-link" data-page="my-orders"><i class="fas fa-box"></i> My Orders</a>
                    <a href="#"><i class="fas fa-sign-out-alt"></i> Logout</a>
                  </div>
                </div>
			</div>
		</nav>
	</header>

	<div class="container">
        <div id="products-page" class="page active">
            <div class="page-title">
                <h1>KisanMate Store</h1>
                <p>Your one-stop shop for quality agricultural supplies in Maharashtra.</p>
            </div>
            <div class="categories">
                <button class="category-btn active" data-category="all"><i class="fas fa-store"></i> All Products</button>
                <button class="category-btn" data-category="seeds"><i class="fas fa-seedling"></i> Seeds</button>
                <button class="category-btn" data-category="tools"><i class="fas fa-tools"></i> Tools</button>
                <button class="category-btn" data-category="fertilizers"><i class="fas fa-flask"></i> Fertilizers</button>
                <button class="category-btn" data-category="pesticides"><i class="fas fa-spray-can"></i> Pesticides</button>
            </div>
            <div class="product-controls">
                <div class="search-bar">
                    <i class="fas fa-search"></i> <input type="text" id="product-search" placeholder="Search for products...">
                </div>
                <div class="sort-options">
                    <select id="sort-by" class="form-control">
                        <option value="default">Sort by Default</option>
                        <option value="price-asc">Price: Low to High</option>
                        <option value="price-desc">Price: High to Low</option>
                        <option value="name-asc">Name: A-Z</option>
                    </select>
                </div>
            </div>
            <div class="products-grid">
                <div class="product-card" data-category="seeds" data-price="750" data-name="Hybrid Cotton Seeds">
                    <div class="product-img"><img src="https://i.imgur.com/8xLqV3L.jpeg" alt="Cotton Seeds"></div>
                    <div class="product-info">
                        <div class="product-category">Seeds</div>
                        <h3 class="product-title">Hybrid Cotton Seeds</h3>
                        <p class="product-description">High-yield BT cotton seeds, ideal for the soil conditions in the Khandesh region.</p>
                        <div class="product-price">₹750 / pack</div>
                        <div class="product-actions">
                            <button class="add-to-cart">Add to Cart</button>
                            <div class="wishlist"><i class="far fa-heart"></i></div>
                        </div>
                    </div>
                </div>
                <div class="product-card" data-category="tools" data-price="18500" data-name="Tractor Plough Attachment">
                    <div class="product-img"><img src="https://i.imgur.com/uEMa03N.jpeg" alt="Tractor Plough"></div>
                    <div class="product-info">
                        <div class="product-category">Tools</div>
                        <h3 class="product-title">Tractor Plough Attachment</h3>
                        <p class="product-description">Durable steel plough attachment for medium to heavy-duty tractors.</p>
                        <div class="product-price">₹18,500</div>
                        <div class="product-actions">
                            <button class="add-to-cart">Add to Cart</button>
                            <div class="wishlist"><i class="far fa-heart"></i></div>
                        </div>
                    </div>
                </div>
                <div class="product-card" data-category="fertilizers" data-price="350" data-name="Urea Fertilizer">
                    <div class="product-img"><img src="https://i.imgur.com/w2Y7h0k.jpeg" alt="Urea Fertilizer"></div>
                    <div class="product-info">
                        <div class="product-category">Fertilizers</div>
                        <h3 class="product-title">Urea Fertilizer</h3>
                        <p class="product-description">High-quality granulated urea (46% N) for promoting healthy plant growth.</p>
                        <div class="product-price">₹350 / 50kg bag</div>
                        <div class="product-actions">
                            <button class="add-to-cart">Add to Cart</button>
                            <div class="wishlist"><i class="far fa-heart"></i></div>
                        </div>
                    </div>
                </div>
                <div class="product-card" data-category="pesticides" data-price="1800" data-name="Neem Oil Pesticide">
                    <div class="product-img"><img src="https://i.imgur.com/C3fP0zY.jpeg" alt="Neem Oil"></div>
                    <div class="product-info">
                        <div class="product-category">Pesticides</div>
                        <h3 class="product-title">Neem Oil Pesticide</h3>
                        <p class="product-description">Organic and effective neem-based pesticide for controlling common farm pests.</p>
                        <div class="product-price">₹1,800 / 5L can</div>
                        <div class="product-actions">
                            <button class="add-to-cart">Add to Cart</button>
                            <div class="wishlist"><i class="far fa-heart"></i></div>
                        </div>
                    </div>
                </div>
                <div class="product-card" data-category="seeds" data-price="550" data-name="Hybrid Jowar Seeds">
                    <div class="product-img"><img src="https://i.imgur.com/7g6eS1q.jpeg" alt="Jowar Seeds"></div>
                    <div class="product-info">
                        <div class="product-category">Seeds</div>
                        <h3 class="product-title">Hybrid Jowar Seeds</h3>
                        <p class="product-description">Drought-resistant hybrid jowar (sorghum) seeds for consistent yield.</p>
                        <div class="product-price">₹550 / kg</div>
                        <div class="product-actions">
                            <button class="add-to-cart">Add to Cart</button>
                            <div class="wishlist"><i class="far fa-heart"></i></div>
                        </div>
                    </div>
                </div>
                <div class="product-card" data-category="fertilizers" data-price="1200" data-name="DAP Fertilizer">
                    <div class="product-img"><img src="https://i.imgur.com/3p8Y0R9.jpeg" alt="DAP Fertilizer"></div>
                    <div class="product-info">
                        <div class="product-category">Fertilizers</div>
                        <h3 class="product-title">DAP Fertilizer</h3>
                        <p class="product-description">Di-Ammonium Phosphate fertilizer, a rich source of phosphorus and nitrogen.</p>
                        <div class="product-price">₹1,200 / 50kg bag</div>
                        <div class="product-actions">
                            <button class="add-to-cart">Add to Cart</button>
                            <div class="wishlist"><i class="far fa-heart"></i></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="my-orders" class="page">
            <div class="page-header"><h1>My Orders</h1></div>
            <div class="data-table">
                <table>
                    <thead><tr><th>Order ID</th><th>Date</th><th>Total</th><th>Status</th><th>Action</th></tr></thead>
                    <tbody>
                        <%-- BACKEND INTEGRATION: Loop through user's orders here --%>
                        <tr>
                            <td>#ORD-7015</td><td>13 Oct 2025</td><td>₹1,300.00</td>
                            <td><span class="status status-shipped">Shipped</span></td>
                            <td><a href="#" class="btn-primary" style="text-decoration: none; padding: 5px 10px; font-size: 14px;">View Details</a></td>
                        </tr>
                        <tr>
                            <td>#ORD-7012</td><td>11 Oct 2025</td><td>₹3,600.00</td>
                            <td><span class="status status-delivered">Delivered</span></td>
                            <td><a href="#" class="btn-primary" style="text-decoration: none; padding: 5px 10px; font-size: 14px;">View Details</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        
        <div id="my-profile" class="page">
            <div class="page-header"><h1>My Profile</h1></div>
            <div class="form-container">
                <form id="profile-form">
                     <%-- BACKEND INTEGRATION: Populate values from user object here --%>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="fullName">Full Name</label>
                            <input type="text" id="fullName" value="Ramesh Kumar">
                        </div>
                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" id="email" value="ramesh.k@example.com" readonly style="background: #eee;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="address">Delivery Address</label>
                        <textarea id="address" rows="4">At Post Shirpur, Dist. Dhule, Maharashtra - 425405</textarea>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn-primary">Update Profile</button>
                    </div>
                </form>
            </div>
        </div>
	</div>

	<footer>
		<div class="copyright">
			<p>&copy; 2025 KisanMate. All rights reserved.</p>
		</div>
	</footer>

	<script>
    document.addEventListener('DOMContentLoaded', function() {
        // --- DOM ELEMENT CACHING ---
        const navLinks = document.querySelectorAll('.nav-link');
        const pages = document.querySelectorAll('.page');
        const productsPage = document.getElementById('products-page');
        const categoryButtons = document.querySelectorAll('.category-btn');
        const productSearch = document.getElementById('product-search');
        const sortBy = document.getElementById('sort-by');
        const productsGrid = document.querySelector('.products-grid');
        const cartCountElement = document.querySelector('.cart-count');
        let cartItemCount = 0;
        
        // This is the crucial fix: Store the product cards on load.
        const allProductCards = Array.from(productsGrid.querySelectorAll('.product-card'));

        // --- MASTER FUNCTION TO FILTER AND SORT PRODUCTS ---
        const filterAndSortProducts = () => {
            const activeCategory = document.querySelector('.category-btn.active').dataset.category;
            const searchTerm = productSearch.value.toLowerCase();
            const sortValue = sortBy.value;

            // 1. Filter from the original list of cards
            let filteredProducts = allProductCards.filter(card => {
                const isInCategory = activeCategory === 'all' || card.dataset.category === activeCategory;
                const matchesSearch = card.textContent.toLowerCase().includes(searchTerm);
                return isInCategory && matchesSearch;
            });

            // 2. Sort
            filteredProducts.sort((a, b) => {
                const nameA = a.dataset.name.toLowerCase();
                const nameB = b.dataset.name.toLowerCase();
                const priceA = parseFloat(a.dataset.price);
                const priceB = parseFloat(b.dataset.price);

                switch (sortValue) {
                    case 'price-asc': return priceA - priceB;
                    case 'price-desc': return priceB - priceA;
                    case 'name-asc': return nameA.localeCompare(nameB);
                    default: return 0;
                }
            });
            
            // 3. Display
            productsGrid.innerHTML = ''; // Clear grid
            filteredProducts.forEach(card => productsGrid.appendChild(card)); // Add the sorted/filtered cards back
        };

        // --- EVENT LISTENERS for Filtering/Sorting ---
        categoryButtons.forEach(button => {
            button.addEventListener('click', () => {
                categoryButtons.forEach(btn => btn.classList.remove('active'));
                button.classList.add('active');
                filterAndSortProducts();
            });
        });
        productSearch.addEventListener('keyup', filterAndSortProducts);
        sortBy.addEventListener('change', filterAndSortProducts);

        // --- INTERACTIVE BUTTONS (Add to Cart, Wishlist) ---
        productsGrid.addEventListener('click', function(e) {
            if (e.target.closest('.wishlist')) {
                const icon = e.target.closest('.wishlist').querySelector('i');
                const isWished = icon.classList.toggle('fas');
                icon.classList.toggle('far');
                showToast(isWished ? 'Added to your wishlist!' : 'Removed from wishlist.');
            }
            if (e.target.closest('.add-to-cart')) {
                const productTitle = e.target.closest('.product-info').querySelector('.product-title').textContent;
                cartItemCount++;
                cartCountElement.textContent = cartItemCount;
                showToast(`${productTitle} added to cart!`);
            }
        });

        // --- PAGE NAVIGATION LOGIC ---
        navLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                const pageId = this.dataset.page;
                if (!pageId) return;

                // Show the target page and hide others
                pages.forEach(page => page.classList.remove('active'));
                const targetPage = document.getElementById(pageId);
                if(targetPage) {
                    targetPage.classList.add('active');
                }

                // Update the active state on navigation links
                navLinks.forEach(a => a.classList.remove('active'));
                // Add active class to all links pointing to the same page
                document.querySelectorAll(`.nav-link[data-page="${pageId}"]`).forEach(activeLink => {
                    activeLink.classList.add('active');
                });
            });
        });

        // --- Profile Form Submission ---
        document.getElementById('profile-form').addEventListener('submit', function(e) {
            e.preventDefault();
            Swal.fire('Success!', 'Your profile has been updated.', 'success');
        });

        // --- Helper function for Toast Notifications ---
        const showToast = (title) => {
            const Toast = Swal.mixin({
                toast: true,
                position: 'bottom-end',
                showConfirmButton: false,
                timer: 3000,
                timerProgressBar: true,
                didOpen: (toast) => {
                    toast.addEventListener('mouseenter', Swal.stopTimer);
                    toast.addEventListener('mouseleave', Swal.resumeTimer);
                }
            });
            Toast.fire({ icon: 'success', title: title });
        };
    });
	</script>
</body>
</html>