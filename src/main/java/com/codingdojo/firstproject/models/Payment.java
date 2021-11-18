package com.codingdojo.firstproject.models;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="payments")

public class Payment {
	
		@Id
		@GeneratedValue(strategy=GenerationType.IDENTITY)
		
		private Long id;
		
		@NotEmpty 
		private String cardHolderName;
		@NotNull
		
		
		private String cardNumber;
		@NotNull
		private Integer cnv;
		private String  expirationMonth;
		
		private String  expirationYear;
		private String cardType;
		
		@Column(updatable=false)
		@DateTimeFormat(pattern="YYYY-MM-dd  hh:mm:ss")
		private Date createdAt;
		@DateTimeFormat(pattern="YYYY-MM-dd  hh:mm:ss")
		private Date updatedAt;
		
		@PrePersist
		protected void onCreate() {
			this.createdAt=new Date();
		}
		
		@PreUpdate
		protected void onUpdate() {
			this.updatedAt=new Date();
		}
		
		@ManyToOne(fetch=FetchType.LAZY)
		@JoinColumn(name="user_id")
		private User makePayment;
		
		public Payment() {
			
		}

		public Long getId() {
			return id;
		}

		public void setId(Long id) {
			this.id = id;
		}

		public String getCardHolderName() {
			return cardHolderName;
		}

		public void setCardHolderName(String cardHolderName) {
			this.cardHolderName = cardHolderName;
		}

		public String getCardNumber() {
			return cardNumber;
		}

		public void setCardNumber(String cardNumber) {
			this.cardNumber = cardNumber;
		}

		public Integer getCnv() {
			return cnv;
		}

		public void setCnv(Integer cnv) {
			this.cnv = cnv;
		}

		public String getExpirationMonth() {
			return expirationMonth;
		}

		public void setExpirationMonth(String expirationMonth) {
			this.expirationMonth = expirationMonth;
		}

		public String getExpirationYear() {
			return expirationYear;
		}

		public void setExpirationYear(String expirationYear) {
			this.expirationYear = expirationYear;
		}

		public String getCardType() {
			return cardType;
		}

		public void setCardType(String cardType) {
			this.cardType = cardType;
		}

		public Date getCreatedAt() {
			return createdAt;
		}

		public void setCreatedAt(Date createdAt) {
			this.createdAt = createdAt;
		}

		public Date getUpdatedAt() {
			return updatedAt;
		}

		public void setUpdatedAt(Date updatedAt) {
			this.updatedAt = updatedAt;
		}

		public User getMakePayment() {
			return makePayment;
		}

		public void setMakePayment(User makePayment) {
			this.makePayment = makePayment;
		}

}
