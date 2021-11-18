package com.codingdojo.firstproject.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="payments")

public class Payment {
		@Id
		@GeneratedValue(strategy=GenerationType.IDENTITY)
		private Long id;

		@Size(min=3, message="Card Holder Name must be at least 3 characters")
		private String cardHolderName;
		
		@Size(min=16, max=16, message="Please enter the correct 16 degits Card Number")
		private String cardNumber;
		
		@Size(min=3, max=3, message="Card Security Code must be enter and should be 3 characters")
		private String cnv;
		@NotBlank(message="Expiration Month must be select")
		private String expMonth;
		
		@NotBlank(message="Expiration Year must be select")
		private String expYear;
		
		@NotBlank(message="Card Type is not supported")
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
		
		@OneToMany(mappedBy="orderPayment", fetch=FetchType.LAZY)
		private List<Order> paymentForOrder;
		
		@ManyToOne(fetch=FetchType.LAZY)
		@JoinColumn(name="user_id")
		private User paymentForUser;

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

		public String getCnv() {
			return cnv;
		}

		public void setCnv(String cnv) {
			this.cnv = cnv;
		}

		public String getExpMonth() {
			return expMonth;
		}

		public void setExpMonth(String expMonth) {
			this.expMonth = expMonth;
		}

		public String getExpYear() {
			return expYear;
		}

		public void setExpYear(String expYear) {
			this.expYear = expYear;
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

		public User getPaymentForUser() {
			return paymentForUser;
		}

		public void setPaymentForUser(User paymentForUser) {
			this.paymentForUser = paymentForUser;
		}

		public List<Order> getPaymentForOrder() {
			return paymentForOrder;
		}

		public void setPaymentForOrder(List<Order> paymentForOrder) {
			this.paymentForOrder = paymentForOrder;
		}		
}
