package com.aakash.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.springframework.stereotype.Component;

@Component
@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // auto uId
	private int uId;
	private String uName;
	private String uEmail;
	private String uPass;
	private String uType;
	private String uActions;
	public int getuId() {
		return uId;
	}
	public void setuId(int uId) {
		this.uId = uId;
	}
	public String getuName() {
		return uName;
	}
	public void setuName(String uName) {
		this.uName = uName;
	}
	public String getuEmail() {
		return uEmail;
	}
	public void setuEmail(String uEmail) {
		this.uEmail = uEmail;
	}
	public String getuPass() {
		return uPass;
	}
	public void setuPass(String uPass) {
		this.uPass = uPass;
	}
	public String getuType() {
		return uType;
	}
	public void setuType(String uType) {
		this.uType = uType;
	}
	public String getuActions() {
		return uActions;
	}
	public void setuActions(String uActions) {
		this.uActions = uActions;
	}
	public User(int uId, String uName, String uEmail, String uPass, String uType, String uActions) {
		super();
		this.uId = uId;
		this.uName = uName;
		this.uEmail = uEmail;
		this.uPass = uPass;
		this.uType = uType;
		this.uActions = uActions;
	}
	@Override
	public String toString() {
		return "User [uId=" + uId + ", uName=" + uName + ", uEmail=" + uEmail + ", uPass=" + uPass + ", uType=" + uType
				+ ", uActions=" + uActions + "]";
	}
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	

}
