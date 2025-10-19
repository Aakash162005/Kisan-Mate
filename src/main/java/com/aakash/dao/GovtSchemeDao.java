package com.aakash.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.aakash.model.GovtScheme;

@Repository
public class GovtSchemeDao {
	
	@Autowired
	private HibernateTemplate hibernateTemplate;

	// create account of GovtScheme
	@Transactional
	public int insertGovtScheme(GovtScheme govtScheme) {
		Integer id = (Integer) this.hibernateTemplate.save(govtScheme);
		System.out.println("GovtScheme inserted successfully: " + govtScheme.getsName());
		return id;

	}

	// read by help of govtScheme id
	public GovtScheme getGovtScheme(int sId) {
		GovtScheme govtScheme = this.hibernateTemplate.get(GovtScheme.class, sId);
		return govtScheme;
	}

	// read by help of Category of GovtScheme
	public GovtScheme getGovtScheme(String sCategory) {
		String hql = "from User where sCategory = ?";
		List<GovtScheme> list = (List<GovtScheme>) hibernateTemplate.find(hql, sCategory);
		return list.isEmpty() ? null : list.get(0);
	}


	// read the all GovtSchemes
	public List<GovtScheme> getAllGovtSchemes() {
		List<GovtScheme> govtSchemes = this.hibernateTemplate.loadAll(GovtScheme.class);
		return govtSchemes;
	}

	// Update GovtScheme
	@Transactional
	public void updateGovtScheme(GovtScheme govtScheme) {
		this.hibernateTemplate.update(govtScheme);
	}

	// Delete GovtScheme by help of GovtScheme id (sId)
	@Transactional
	public void deleteGovtSchemer(int sId) {
		GovtScheme govtScheme = this.hibernateTemplate.get(GovtScheme.class, sId);
	}

	// getter and setter for HibernateTemplate
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernatetemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	

}
