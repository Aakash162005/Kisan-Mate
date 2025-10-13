package com.aakash.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.aakash.model.Product;
import com.aakash.model.Vendor;

@Repository
public class ProductDao {

	@Autowired
	HibernateTemplate hibernateTemplate;
	
	// add product in database
	@Transactional
	public int insertProduct(Product product)
	{
		Integer id = (Integer) this.hibernateTemplate.save(product);
		return id;
	}
	
	//read the product by pId
	public Product getProduct(int pId)
	{
		Product product = this.hibernateTemplate.get(Product.class, pId);
		return product;
	}
	
	//read by help of email of vendor 
	public Product getVendor(String vEmail)
	{
		String hql = "from Vendor where vEmail = ?";
		List<Product> list = (List<Product>) hibernateTemplate.find(hql, vEmail);
	    return list.isEmpty() ? null : list.get(0);
	}
	
	//read the all products
	public List<Product> getAllProducts()
	
	{
		List<Product> products = this.hibernateTemplate.loadAll(Product.class);
		return products;
	}
	
	//update product
	@Transactional
	public void updateProduct(Product product)
	{
		this.hibernateTemplate.update(product);
	}
	
	@Transactional
	public void deleteProduct(int pId)
	{
		Product product = this.hibernateTemplate.get(Product.class, pId);
	}
	
	//getter and setter for HibernateTemplate
	public HibernateTemplate getHibernateTemplate()
	{
		return hibernateTemplate;
	}
	
	public void setHibernatetemplate(HibernateTemplate hibernateTemplate)
	{
		this.hibernateTemplate = hibernateTemplate;
	}
	
}
