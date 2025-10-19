package com.aakash.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aakash.dao.GovtSchemeDao;
import com.aakash.dao.ProductDao;
import com.aakash.dao.UserDao;
import com.aakash.dao.VendorDao;
import com.aakash.model.GovtScheme;
import com.aakash.model.Product;
import com.aakash.model.User;
import com.aakash.model.Vendor;

@Controller
public class HomeController {

	ApplicationContext context = new ClassPathXmlApplicationContext("Config.xml");
	User user = (User) context.getBean("user");
	UserDao userDao = (UserDao) context.getBean("userDao");
	Vendor vendor = (Vendor) context.getBean("vendor");
	VendorDao vendorDao = (VendorDao) context.getBean("vendorDao");
	Product product = (Product) context.getBean("product");
	ProductDao productDao = (ProductDao) context.getBean("productDao");
	GovtScheme govtScheme = (GovtScheme) context.getBean("govtScheme");
	GovtSchemeDao govtSchemeDao = (GovtSchemeDao) context.getBean("govtSchemeDao");

	@RequestMapping("/")
	public String home() {
		System.out.println("Opening index.jsp");
		return "index"; // /WEB-INF/views/index.jsp
	}
	
	
	// -------------------------------------------------------------------------------------------------------------------------------------

	// Open user registration form
	@RequestMapping("/registration")
	public String userRegist() {
		System.out.println("Opening User Regist.jsp page...");
		return "regist"; // regist.jsp page name
	}

	// Handle Registration data and submission
	@RequestMapping(path = "/addUser", method = RequestMethod.POST)
	public String adduser(HttpServletRequest request) {

		String uEmail = request.getParameter("uEmail");
		// user.setuId(Integer.parseInt(request.getParameter("uId")));
		user.setuName(request.getParameter("uName"));
		user.setuEmail(request.getParameter("uEmail"));
		user.setuPass(request.getParameter("uPass"));
		user.setuType("Farmer");
		user.setuActions("Unblock");

		User exist = userDao.getUser(uEmail);

		if (exist == null) {
			System.out.println("User registration successful!");
			userDao.insert(user); // save this data into database by help of
									// UserDao class

			return "login"; // after regist.. go to login.jsp page
		} else {
			System.err.println("Account Allready Exist...");
			return "regist"; // regist.jsp page not go on login page
		}

	}

	// -------------------------------------------------------------------------------------------------------------------------------------

	// Open Login page
	@RequestMapping("/userLogin")
	public String userLogin() {
		System.out.println("Opening User login.jsp page ");
		return "login"; // login.jsp page
	}

	// Handle the user login by email and pass...
	@RequestMapping(path = "/checkUserLogin", method = RequestMethod.POST)
	public String checkUserLogin(HttpServletRequest request, Model model) {

		String uEmail = request.getParameter("uEmail");
		String uPass = request.getParameter("uPass");

		User us = userDao.getUser(uEmail);

		if (user != null && us.getuPass().equals(uPass)) {
			return "userHome"; // redirect to user home page
		} else {
			System.err.println("Invalid email or password.");
			return "login"; // Show login page again
		}

	}

	// -------------------------------------------------------------------------------------------------------------------------------------

	@RequestMapping("/userHome")
	public String userHome() {
		return "userHome";
	}

	// -------------------------------------------------------------------------------------------------------------------------------------

	// add the vendor in database by registration
	@RequestMapping(path = "/addVendor", method = RequestMethod.POST)
	public String addVendor(HttpServletRequest request) {

		String vEmail = request.getParameter("vEmail");
		// user.setuId(Integer.parseInt(request.getParameter("uId")));
		vendor.setvName(request.getParameter("vName"));
		vendor.setvBusinessName(request.getParameter("vBusinessName"));
		vendor.setvEmail(request.getParameter("vEmail"));
		vendor.setvPhoneNo(request.getParameter("vPhoneNo"));
		vendor.setvType(request.getParameter("vType"));
		vendor.setvPass(request.getParameter("vPass"));
		vendor.setvAddress(request.getParameter("vAddress"));
		vendor.setvBusDescrip(request.getParameter("vBusDescrip"));
		vendor.setvActions("Disapprove");

		Vendor exist = vendorDao.getVendor(vEmail);

		if (exist == null) {
			System.out.println("Vendor registration successful...!");
			vendorDao.insertVendor(vendor); // save this data into database by
											// help of UserDao class

			return "login"; // after regist.. go to login.jsp page
		} else {
			System.err.println("Account Allready Exist...");
			return "regist"; // regist.jsp page not go on login page
		}
	}

	// -------------------------------------------------------------------------------------------------------------------------------------

	// Handle the vendor login by email and pass...
	@RequestMapping(path = "/checkVendorLogin", method = RequestMethod.POST)
	public String checkVendorLogin(HttpServletRequest request, Model model) {

		String vEmail = request.getParameter("vEmail");
		String vPass = request.getParameter("vPass");

		Vendor us = vendorDao.getVendor(vEmail);

		if (vendor != null && us.getvPass().equals(vPass)) {
			return "vendorHome"; // redirect to user home page
		} else {
			System.err.println("Invalid email or password.");
			return "login"; // Show login page again
		}

	}

	// -------------------------------------------------------------------------------------------------------------------------------------

	@RequestMapping("/vendorHome")
	public String vendorHome() {
		return "vendorHome";
	}

	// -------------------------------------------------------------------------------------------------------------------------------------

	@RequestMapping("/adminHome")
	public String adminHome(Model model) { // Use Model to pass data
		
		// Get the list of all users from the DAO
		List<User> users = this.userDao.getAllUsers();
		
		// Add the user list and the count to the model
		// We use the name "users" because that's what your JSP expects
		model.addAttribute("users", users);
		model.addAttribute("userCount", users.size());
		
		System.out.println("Sending " + users.size() + " users to adminHome.jsp");

		return "adminHome";
	}

	// -------------------------------------------------------------------------------------------------------------------------------------

	// Handle the admin login by email and pass...
	@RequestMapping(path = "/checkAdminLogin", method = RequestMethod.POST)
	public String checkAdminLogin(HttpServletRequest request, Model model) {

		String aEmail = request.getParameter("aEmail");
		String aPass = request.getParameter("aPass");

		if (aPass.equals("admin") && aEmail.equals("admin@gmail.com")) {
			return "adminHome"; // redirect to user home page
		} else {
			System.err.println("Invalid email or password.");
			return "login"; // Show login page again
		}
	}

	// -------------------------------------------------------------------------------------------------------------------------------------

	// Product ADD in Database

	@RequestMapping(path = "/addProduct", method = RequestMethod.POST)
	public void addProduct(HttpServletRequest request, Model model) {

		product.setpName(request.getParameter("pName"));
		product.setpCategory(request.getParameter("pCategory"));
		product.setpPrice(request.getParameter("pPrice"));
		product.setDescription(request.getParameter("Description"));
		product.setpInitialStock(request.getParameter("pInitialStock"));
		product.setpImage(request.getParameter("pImage"));
		product.setvEmail(request.getParameter("vEmail"));
		productDao.insertProduct(product);

	}

	// -------------------------------------------------------------------------------------------------------------------------------------

	
}
