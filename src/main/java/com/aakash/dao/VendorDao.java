package com.aakash.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.aakash.model.Vendor;

@Repository
public class VendorDao {
	
	@Autowired
	private HibernateTemplate hibernateTemplate;
	
	
	//create account of vendor
	@Transactional
	public int insertVendor(Vendor vendor)
	{
		Integer id = (Integer) this.hibernateTemplate.save(vendor);
		return id;
	}
	
	//read by help of vendor id
		public Vendor getVendor(int vId)
		{
			Vendor vendor = this.hibernateTemplate.get(Vendor.class, vId);
			return vendor;
		}
		
		//read by help of email of vendor 
		public Vendor getVendor(String vEmail) {
			String hql = "from Vendor where vEmail = ?";
			List<Vendor> list = (List<Vendor>) hibernateTemplate.find(hql, vEmail);
		    return list.isEmpty() ? null : list.get(0);
		}

		
		//read the all vendors 
		public List<Vendor> getAllVendor()
		{
			List<Vendor> vendors = this.hibernateTemplate.loadAll(Vendor.class);
			return vendors;
		}
		
		// Update vendor
		@Transactional
		public void updateVendor(Vendor vendor)
		{
			this.hibernateTemplate.update(vendor);
		}
		
		//Delete vendor by help of vendor id (vId)
		@Transactional
		public void deleteVendor(int vId)
		{
			Vendor vendor = this.hibernateTemplate.get(Vendor.class, vId);
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
