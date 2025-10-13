<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>KisanMate - Products</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <style>
    :root {
      --primary: #1976d2;
      --secondary: #f57c00;
      --green: #388e3c;
      --dark: #2c3e50;
      --light-bg: #f4f7f6;
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
    .logo .mate { color: var(--secondary); }
    
    nav { display: flex; align-items: center; }
    
    nav a {
      margin-left: 25px;
      text-decoration: none;
      color: #333;
      font-weight: 500;
      transition: 0.3s;
      position: relative;
    }
    
    nav a:hover, nav a.active { color: var(--primary); }
    
    .user-actions {
      display: flex;
      align-items: center;
      margin-left: 20px;
    }
    
    .cart-icon {
      position: relative;
      font-size: 1.5rem;
      color: var(--dark);
      cursor: pointer;
    }
    .cart-count {
      position: absolute;
      top: -5px; right: -10px;
      background: var(--secondary);
      color: white;
      width: 20px; height: 20px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 0.8rem;
      font-weight: bold;
    }
    
    /* Main Content */
    .container {
      max-width: 1300px;
      margin: 100px auto 40px;
      padding: 0 20px;
    }
    
    .page-title { text-align: center; margin-bottom: 40px; }
    .page-title h1 { font-size: 2.5rem; color: var(--dark); margin-bottom: 10px; }
    .page-title p { font-size: 1.2rem; color: #7f8c8d; }
    
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
    #product-search:focus { outline: none; border-color: var(--primary); }
    .search-bar i {
      position: absolute;
      left: 18px; top: 50%;
      transform: translateY(-50%);
      color: #999;
    }

    .sort-options { min-width: 200px; }
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
    
    /* Products Grid */
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
    
    .add-to-cart {
      padding: 10px 20px;
      background: var(--secondary);
      color: white;
      border: none;
      border-radius: 5px;
      font-weight: 600;
      cursor: pointer;
      transition: background 0.3s;
    }
    
    .add-to-cart:hover { background: #e65100; }
    
    .wishlist {
      width: 40px; height: 40px;
      border-radius: 50%;
      border: 1px solid #ddd;
      display: flex; align-items: center; justify-content: center;
      cursor: pointer;
      transition: all 0.3s;
      font-size: 1.2rem;
    }
    
    .wishlist i.fas { color: #e74c3c; } /* Solid heart for active */
    
    .wishlist:hover { background: #f1f1f1; }
    
    /* Footer */
    footer { background: #1e1f21; color: white; padding: 40px 0; margin-top: 80px; }
    .copyright { text-align: center; padding-top: 30px; margin-top: 30px; border-top: 1px solid #2c3e50; color: #bdc3c7; }
  
  </style>
</head>
<body>
  <header>
    <a href="#" class="logo">
      <i class="fas fa-seedling" style="margin-right: 8px;"></i>
      Kisan<span class="mate">Mate</span>
    </a>
    <nav>
      <a href="#">Home</a>
      <a href="#" class="active">Store</a>
      <a href="#">About</a>
      <a href="#">Contact</a>
      <div class="user-actions">
        <div class="cart-icon">
          <i class="fas fa-shopping-cart"></i>
          <span class="cart-count">0</span>
        </div>
      </div>
    </nav>
  </header>

  <div class="container">
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
            <i class="fas fa-search"></i>
            <input type="text" id="product-search" placeholder="Search for products like 'cotton seeds' or 'plough'...">
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
  
  <footer>
    <div class="copyright">
      <p>&copy; 2025 KisanMate. All rights reserved.</p>
    </div>
  </footer>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
        const categoryButtons = document.querySelectorAll('.category-btn');
        const productSearch = document.getElementById('product-search');
        const sortBy = document.getElementById('sort-by');
        const productsGrid = document.querySelector('.products-grid');
        const productCards = Array.from(productsGrid.querySelectorAll('.product-card'));
        const cartCountElement = document.querySelector('.cart-count');
        let cartItemCount = 0;

        // --- Master Function to Filter and Sort Products ---
        const filterAndSortProducts = () => {
            const activeCategory = document.querySelector('.category-btn.active').dataset.category;
            const searchTerm = productSearch.value.toLowerCase();
            const sortValue = sortBy.value;

            // 1. Filter
            let filteredProducts = productCards.filter(card => {
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
                    default: return 0; // Default order
                }
            });
            
            // 3. Display
            productsGrid.innerHTML = ''; // Clear grid
            filteredProducts.forEach(card => productsGrid.appendChild(card));
        };

        // --- Event Listeners ---
        categoryButtons.forEach(button => {
            button.addEventListener('click', () => {
                categoryButtons.forEach(btn => btn.classList.remove('active'));
                button.classList.add('active');
                filterAndSortProducts();
            });
        });
        
        productSearch.addEventListener('keyup', filterAndSortProducts);
        sortBy.addEventListener('change', filterAndSortProducts);

        // --- Interactive Buttons (using event delegation for performance) ---
        productsGrid.addEventListener('click', function(e) {
            // Wishlist Button
            if (e.target.closest('.wishlist')) {
                const wishlistButton = e.target.closest('.wishlist');
                const icon = wishlistButton.querySelector('i');
                const isWished = icon.classList.toggle('fas');
                icon.classList.toggle('far');
                
                showToast(isWished ? 'Added to your wishlist!' : 'Removed from wishlist.');
            }

            // Add to Cart Button
            if (e.target.closest('.add-to-cart')) {
                const productTitle = e.target.closest('.product-info').querySelector('.product-title').textContent;
                cartItemCount++;
                cartCountElement.textContent = cartItemCount;
                showToast(`${productTitle} added to cart!`);
            }
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