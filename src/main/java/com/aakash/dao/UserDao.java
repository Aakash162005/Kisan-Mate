package com.aakash.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.aakash.model.User;

@Repository
public class UserDao {

	@Autowired
	private HibernateTemplate hibernateTemplate;

	// create account of user
	@Transactional
	public int insert(User user) {
		Integer id = (Integer) this.hibernateTemplate.save(user);
		return id;

	}

	// read by help of user id
	public User getuser(int uId) {
		User user = this.hibernateTemplate.get(User.class, uId);
		return user;
	}

	// read by help of email of user
	public User getUser(String uEmail) {
		String hql = "from User where uEmail = ?";
		List<User> list = (List<User>) hibernateTemplate.find(hql, uEmail);
		return list.isEmpty() ? null : list.get(0);
	}

	// read by help of uActions of user
	public User getUsers(String uActions) {
	    String hql = "from User where uActions = ?"; // Changed from uEmail
	    List<User> list = (List<User>) hibernateTemplate.find(hql, uActions);
	    return list.isEmpty() ? null : list.get(0);
	}

	// read the all users
	public List<User> getAllUsers() {
		List<User> users = this.hibernateTemplate.loadAll(User.class);
		return users;
	}

	// Update user
	@Transactional
	public void updateUser(User user) {
		this.hibernateTemplate.update(user);
	}

	// Delete user by help of user id (uId)
	@Transactional
	public void deleteUser(int uId) {
	    User user = this.hibernateTemplate.get(User.class, uId);
	    if (user != null) {
	        this.hibernateTemplate.delete(user); // Add this line
	    }
	}

	// getter and setter for HibernateTemplate
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernatetemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

}
