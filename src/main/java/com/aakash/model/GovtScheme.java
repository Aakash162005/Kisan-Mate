package com.aakash.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.springframework.stereotype.Component;

@Entity
@Component
public class GovtScheme {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // auto sId
	private int sId;
	private String sName;
	private String sCategory;
	private String sShortDescription;
	private String sEligibilityCriteria;
	private String sBenefits;
	private String sRequiredDocuments;
	private String sLink;
	private String sStartDate;
	private String sEndDate;
	public int getsId() {
		return sId;
	}
	public void setsId(int sId) {
		this.sId = sId;
	}
	public String getsName() {
		return sName;
	}
	public void setsName(String sName) {
		this.sName = sName;
	}
	public String getsCategory() {
		return sCategory;
	}
	public void setsCategory(String sCategory) {
		this.sCategory = sCategory;
	}
	public String getsShortDescription() {
		return sShortDescription;
	}
	public void setsShortDescription(String sShortDescription) {
		this.sShortDescription = sShortDescription;
	}
	public String getsEligibilityCriteria() {
		return sEligibilityCriteria;
	}
	public void setsEligibilityCriteria(String sEligibilityCriteria) {
		this.sEligibilityCriteria = sEligibilityCriteria;
	}
	public String getsBenefits() {
		return sBenefits;
	}
	public void setsBenefits(String sBenefits) {
		this.sBenefits = sBenefits;
	}
	public String getsRequiredDocuments() {
		return sRequiredDocuments;
	}
	public void setsRequiredDocuments(String sRequiredDocuments) {
		this.sRequiredDocuments = sRequiredDocuments;
	}
	public String getsLink() {
		return sLink;
	}
	public void setsLink(String sLink) {
		this.sLink = sLink;
	}
	public String getsStartDate() {
		return sStartDate;
	}
	public void setsStartDate(String sStartDate) {
		this.sStartDate = sStartDate;
	}
	public String getsEndDate() {
		return sEndDate;
	}
	public void setsEndDate(String sEndDate) {
		this.sEndDate = sEndDate;
	}
	public GovtScheme(int sId, String sName, String sCategory, String sShortDescription, String sEligibilityCriteria,
			String sBenefits, String sRequiredDocuments, String sLink, String sStartDate, String sEndDate) {
		super();
		this.sId = sId;
		this.sName = sName;
		this.sCategory = sCategory;
		this.sShortDescription = sShortDescription;
		this.sEligibilityCriteria = sEligibilityCriteria;
		this.sBenefits = sBenefits;
		this.sRequiredDocuments = sRequiredDocuments;
		this.sLink = sLink;
		this.sStartDate = sStartDate;
		this.sEndDate = sEndDate;
	}
	public GovtScheme() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "GovtScheme [sId=" + sId + ", sName=" + sName + ", sCategory=" + sCategory + ", sShortDescription="
				+ sShortDescription + ", sEligibilityCriteria=" + sEligibilityCriteria + ", sBenefits=" + sBenefits
				+ ", sRequiredDocuments=" + sRequiredDocuments + ", sLink=" + sLink + ", sStartDate=" + sStartDate
				+ ", sEndDate=" + sEndDate + "]";
	}
	
	
}
