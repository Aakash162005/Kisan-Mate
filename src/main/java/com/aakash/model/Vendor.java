package com.aakash.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.springframework.stereotype.Component;

@Component
@Entity
public class Vendor {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // auto uId
	private int vId;
	private String vName;
	private String vBusinessName;
	private String vEmail;
	private String vPhoneNo;
	private String vType;
	private String vPass;
	private String vAddress;
	private String vBusDescrip;
	private String vActions;
	public int getvId() {
		return vId;
	}
	public void setvId(int vId) {
		this.vId = vId;
	}
	public String getvName() {
		return vName;
	}
	public void setvName(String vName) {
		this.vName = vName;
	}
	public String getvBusinessName() {
		return vBusinessName;
	}
	public void setvBusinessName(String vBusinessName) {
		this.vBusinessName = vBusinessName;
	}
	public String getvEmail() {
		return vEmail;
	}
	public void setvEmail(String vEmail) {
		this.vEmail = vEmail;
	}
	public String getvPhoneNo() {
		return vPhoneNo;
	}
	public void setvPhoneNo(String vPhoneNo) {
		this.vPhoneNo = vPhoneNo;
	}
	public String getvType() {
		return vType;
	}
	public void setvType(String vType) {
		this.vType = vType;
	}
	public String getvPass() {
		return vPass;
	}
	public void setvPass(String vPass) {
		this.vPass = vPass;
	}
	public String getvAddress() {
		return vAddress;
	}
	public void setvAddress(String vAddress) {
		this.vAddress = vAddress;
	}
	public String getvBusDescrip() {
		return vBusDescrip;
	}
	public void setvBusDescrip(String vBusDescrip) {
		this.vBusDescrip = vBusDescrip;
	}
	public String getvActions() {
		return vActions;
	}
	public void setvActions(String vActions) {
		this.vActions = vActions;
	}
	public Vendor(int vId, String vName, String vBusinessName, String vEmail, String vPhoneNo, String vType,
			String vPass, String vAddress, String vBusDescrip, String vActions) {
		super();
		this.vId = vId;
		this.vName = vName;
		this.vBusinessName = vBusinessName;
		this.vEmail = vEmail;
		this.vPhoneNo = vPhoneNo;
		this.vType = vType;
		this.vPass = vPass;
		this.vAddress = vAddress;
		this.vBusDescrip = vBusDescrip;
		this.vActions = vActions;
	}
	public Vendor() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "Vendor [vId=" + vId + ", vName=" + vName + ", vBusinessName=" + vBusinessName + ", vEmail=" + vEmail
				+ ", vPhoneNo=" + vPhoneNo + ", vType=" + vType + ", vPass=" + vPass + ", vAddress=" + vAddress
				+ ", vBusDescrip=" + vBusDescrip + ", vActions=" + vActions + "]";
	}
	
	
}
