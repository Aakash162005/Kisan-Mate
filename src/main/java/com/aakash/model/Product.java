package com.aakash.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.springframework.stereotype.Controller;

@Entity
@Controller
public class Product {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // auto pId
	private int pId;
	private String vEmail;
	private String pName;
	private String pPrice;
	private String pCategory;
	private String pInitialStock;
	private String Description;
	private String pImage;
	public int getpId() {
		return pId;
	}
	public void setpId(int pId) {
		this.pId = pId;
	}
	public String getvEmail() {
		return vEmail;
	}
	public void setvEmail(String vEmail) {
		this.vEmail = vEmail;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getpPrice() {
		return pPrice;
	}
	public void setpPrice(String pPrice) {
		this.pPrice = pPrice;
	}
	public String getpCategory() {
		return pCategory;
	}
	public void setpCategory(String pCategory) {
		this.pCategory = pCategory;
	}
	public String getpInitialStock() {
		return pInitialStock;
	}
	public void setpInitialStock(String pInitialStock) {
		this.pInitialStock = pInitialStock;
	}
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
	}
	public String getpImage() {
		return pImage;
	}
	public void setpImage(String pImage) {
		this.pImage = pImage;
	}
	@Override
	public String toString() {
		return "Product [pId=" + pId + ", vEmail=" + vEmail + ", pName=" + pName + ", pPrice=" + pPrice + ", pCategory="
				+ pCategory + ", pInitialStock=" + pInitialStock + ", Description=" + Description + ", pImage=" + pImage
				+ "]";
	}
	public Product(int pId, String vEmail, String pName, String pPrice, String pCategory, String pInitialStock,
			String description, String pImage) {
		super();
		this.pId = pId;
		this.vEmail = vEmail;
		this.pName = pName;
		this.pPrice = pPrice;
		this.pCategory = pCategory;
		this.pInitialStock = pInitialStock;
		Description = description;
		this.pImage = pImage;
	}
	public Product() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
