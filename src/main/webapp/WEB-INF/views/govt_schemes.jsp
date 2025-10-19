<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>KisanMate - Government Schemes</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
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
    
    /* Main Content */
    .container {
      max-width: 1300px;
      margin: 100px auto 40px;
      padding: 0 20px;
    }
    
    .page-title { text-align: center; margin-bottom: 40px; }
    .page-title h1 { font-size: 2.5rem; color: var(--dark); margin-bottom: 10px; }
    .page-title p { font-size: 1.2rem; color: #7f8c8d; }

    /* Schemes Grid */
    .schemes-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
      gap: 30px;
    }
    
    .scheme-card {
      background: white;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
      transition: transform 0.3s, box-shadow 0.3s;
      display: flex;
      flex-direction: column;
    }
    
    .scheme-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    }
    
    .scheme-info { padding: 25px; flex-grow: 1; }
    
    .scheme-title { 
        font-size: 1.5rem; 
        margin-bottom: 15px; 
        color: var(--dark);
        display: flex;
        align-items: center;
    }

    .scheme-title i {
        color: var(--green);
        margin-right: 15px;
        font-size: 1.8rem;
    }
    .scheme-description { 
        color: #7f8c8d; 
        font-size: 1rem; 
        margin-bottom: 20px; 
        line-height: 1.6;
    }
    
    .scheme-actions { 
        padding: 0 25px 25px;
    }
    
    .learn-more-btn {
      display: inline-block;
      padding: 12px 25px;
      background: var(--secondary);
      color: white;
      text-decoration: none;
      border-radius: 5px;
      font-weight: 600;
      cursor: pointer;
      transition: background 0.3s;
    }
    
    .learn-more-btn:hover { background: #e65100; }

    /* --- MODAL STYLES START --- */
    .modal {
      display: none; 
      position: fixed; 
      z-index: 2000; 
      left: 0;
      top: 0;
      width: 100%; 
      height: 100%; 
      overflow: auto; 
      background-color: rgba(0,0,0,0.5);
      animation-name: fadeIn;
      animation-duration: 0.4s;
    }
    .modal-content {
      background-color: #fefefe;
      margin: 8% auto;
      padding: 30px 40px;
      border-radius: 10px;
      width: 90%;
      max-width: 700px;
      position: relative;
      box-shadow: 0 5px 20px rgba(0,0,0,0.2);
      animation-name: slideIn;
      animation-duration: 0.5s;
    }
    
    @keyframes fadeIn { from {opacity: 0} to {opacity: 1} }
    @keyframes slideIn { from {top: -300px; opacity: 0} to {top: 0; opacity: 1} }

    .close-btn {
      color: #aaa;
      position: absolute;
      top: 10px;
      right: 25px;
      font-size: 28px;
      font-weight: bold;
    }
    .close-btn:hover,
    .close-btn:focus {
      color: black;
      text-decoration: none;
      cursor: pointer;
    }
    
    #modalTitle { font-size: 2.2rem; color: var(--dark); margin-bottom: 10px; }
    #modalShortDescription { font-size: 1.1rem; color: #7f8c8d; margin-bottom: 30px; border-bottom: 1px solid #eee; padding-bottom: 20px; }
    
    .details-section { margin-bottom: 25px; }
    .details-section h3 { font-size: 1.4rem; color: var(--green); margin-bottom: 15px; display: flex; align-items: center; }
    .details-section h3 i { margin-right: 12px; width: 25px; }
    .details-section ul { list-style-type: none; padding-left: 37px; }
    .details-section ul li { margin-bottom: 10px; font-size: 1rem; line-height: 1.6; position: relative; }
    .details-section ul li::before { content: '\f058'; font-family: 'Font Awesome 6 Free'; font-weight: 900; color: var(--secondary); position: absolute; left: -25px; top: 5px; }
    
    .apply-button-container { text-align: center; margin-top: 40px; }
    .apply-btn { display: inline-block; padding: 15px 40px; background: var(--green); color: white; text-decoration: none; border-radius: 30px; font-weight: 700; font-size: 1.1rem; transition: all 0.3s; }
    .apply-btn:hover { background: #2e7d32; transform: translateY(-2px); box-shadow: 0 4px 15px rgba(0,0,0,0.15); }
    /* --- MODAL STYLES END --- */
    
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
      <a href="#">Store</a>
      <a href="#" class="active">Government Schemes</a>
      <a href="#">About</a>
      <a href="#">Contact</a>
    </nav>
  </header>

  <div class="container">
    <div class="page-title">
      <h1>Government Schemes for Farmers</h1>
      <p>Explore various schemes from the government to support your agricultural needs.</p>
    </div>
    
    <div class="schemes-grid">
      <div class="scheme-card" 
         data-title="Pradhan Mantri Kisan Samman Nidhi"
         data-description="An income support scheme for all landholding farmer families."
         data-eligibility="Must be an Indian citizen.|All landholding farmer families are eligible.|Must possess cultivable land as per the land records."
         data-benefits="Direct income support of ₹6,000 per year.|Amount is transferred directly to the bank account in three equal installments."
         data-documents="Aadhaar card.|Citizenship certificate.|Landholding papers.|Bank account details."
         data-link="https://pmkisan.gov.in/">
        <div class="scheme-info">
          <h3 class="scheme-title"><i class="fas fa-hand-holding-usd"></i> Pradhan Mantri Kisan Samman Nidhi</h3>
          <p class="scheme-description">An income support scheme for all landholding farmer families. The scheme provides a financial benefit of ₹6000 per year.</p>
        </div>
        <div class="scheme-actions">
            <a href="#" class="learn-more-btn">Learn More</a>
        </div>
      </div>
      
      <div class="scheme-card"
         data-title="Pradhan Mantri Fasal Bima Yojana"
         data-description="A crop insurance scheme against crop failure."
         data-eligibility="All farmers including sharecroppers and tenant farmers growing notified crops in the notified areas are eligible."
         data-benefits="Provides comprehensive insurance cover against failure of the crop.|Helps in stabilising the income of the farmers."
         data-documents="Land records.|Bank Passbook.|Aadhaar Card.|Sowing declaration."
         data-link="#">
        <div class="scheme-info">
          <h3 class="scheme-title"><i class="fas fa-shield-alt"></i> Pradhan Mantri Fasal Bima Yojana</h3>
          <p class="scheme-description">A crop insurance scheme to provide comprehensive insurance cover against failure of the crop thus helping in stabilising the income of the farmers.</p>
        </div>
         <div class="scheme-actions">
            <a href="#" class="learn-more-btn">Learn More</a>
        </div>
      </div>
      
       <div class="scheme-card"
         data-title="Kisan Credit Card (KCC)"
         data-description="A scheme that provides farmers with timely access to credit."
         data-eligibility="All farmers - individuals/joint borrowers who are owner cultivators.|Tenant farmers, oral lessees & sharecroppers.|Self Help Groups (SHGs) or Joint Liability Groups (JLGs) of farmers."
         data-benefits="Flexible repayment options and simplified loan application process.|Provides credit for cultivation, post-harvest expenses, and consumption requirements."
         data-documents="Duly filled application form.|Identity proof (Aadhaar card, PAN card, Voter ID, etc.).|Address proof.|Land documents."
         data-link="#">
        <div class="scheme-info">
          <h3 class="scheme-title"><i class="fas fa-tractor"></i> Kisan Credit Card (KCC)</h3>
          <p class="scheme-description">A scheme that provides farmers with timely access to credit for their cultivation and other needs.</p>
        </div>
        <div class="scheme-actions">
            <a href="#" class="learn-more-btn">Learn More</a>
        </div>
      </div>

       <c:forEach var="scheme" items="${schemes}">
          <div class="scheme-card"
             data-title="${scheme.name}"
             data-description="${scheme.shortDescription}"
             data-eligibility="${scheme.eligibility}"
             data-benefits="${scheme.benefits}"
             data-documents="${scheme.documents}"
             data-link="${scheme.link}">
            <div class="scheme-info">
              <h3 class="scheme-title"><i class="fas fa-landmark"></i> ${scheme.name}</h3>
              <p class="scheme-description">${scheme.description}</p>
            </div>
            <div class="scheme-actions">
                <a href="#" class="learn-more-btn">Learn More</a>
            </div>
          </div>
       </c:forEach>

    </div>
  </div>
  
  <div id="schemeModal" class="modal">
    <div class="modal-content">
      <span class="close-btn">&times;</span>
      <div id="modalSchemeDetails">
        <h1 id="modalTitle"></h1>
        <p id="modalShortDescription"></p>
        
        <div class="details-section">
          <h3><i class="fas fa-check-circle"></i>Eligibility Criteria</h3>
          <ul id="modalEligibility"></ul>
        </div>
  
        <div class="details-section">
          <h3><i class="fas fa-gift"></i>Benefits</h3>
          <ul id="modalBenefits"></ul>
        </div>
  
        <div class="details-section">
          <h3><i class="fas fa-file-alt"></i>Required Documents</h3>
          <ul id="modalDocuments"></ul>
        </div>
        
        <div class="apply-button-container">
          <a id="modalApplyBtn" href="#" class="apply-btn" target="_blank">Apply on Official Website <i class="fas fa-external-link-alt"></i></a>
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
      // Get modal elements
      const modal = document.getElementById('schemeModal');
      const closeBtn = document.querySelector('.close-btn');
      const learnMoreBtns = document.querySelectorAll('.learn-more-btn');

      // Get modal content elements
      const modalTitle = document.getElementById('modalTitle');
      const modalShortDescription = document.getElementById('modalShortDescription');
      const modalEligibility = document.getElementById('modalEligibility');
      const modalBenefits = document.getElementById('modalBenefits');
      const modalDocuments = document.getElementById('modalDocuments');
      const modalApplyBtn = document.getElementById('modalApplyBtn');
      
      // Function to populate and show modal
      learnMoreBtns.forEach(btn => {
        btn.addEventListener('click', function(e) {
          e.preventDefault(); // Prevent default link behavior
          
          const card = this.closest('.scheme-card');
          
          // Populate the modal with data from data-* attributes
          modalTitle.textContent = card.dataset.title || 'N/A';
          modalShortDescription.textContent = card.dataset.description || 'No description available.';
          modalApplyBtn.href = card.dataset.link || '#';
          
          // Helper function to create list items
          const createListItems = (container, dataString) => {
            container.innerHTML = ''; // Clear previous items
            if (dataString) {
              const items = dataString.split('|');
              items.forEach(itemText => {
                const li = document.createElement('li');
                li.textContent = itemText;
                container.appendChild(li);
              });
            }
          };
          
          createListItems(modalEligibility, card.dataset.eligibility);
          createListItems(modalBenefits, card.dataset.benefits);
          createListItems(modalDocuments, card.dataset.documents);
          
          // Display the modal
          modal.style.display = 'block';
        });
      });

      // Close modal when 'x' is clicked
      closeBtn.addEventListener('click', function() {
        modal.style.display = 'none';
      });

      // Close modal when clicked outside of the content
      window.addEventListener('click', function(e) {
        if (e.target == modal) {
          modal.style.display = 'none';
        }
      });
    });
  </script>

</body>
</html>
