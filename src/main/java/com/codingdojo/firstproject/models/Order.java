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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="orders")
public class Order {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	private Number orderNumber;
	@NotBlank
	private String deliveryOption;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date scheduleDate;
	private Boolean paid = false;
	private Boolean hasSpecial = false;
	private Double total = 0.00;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="payment_id")
	private Payment orderPayment;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="user_id")
	private User orderByUser;
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
	        name = "items_orders", 
	        joinColumns = @JoinColumn(name = "order_id"), 
	        inverseJoinColumns = @JoinColumn(name = "item_id")
	    )
	private List<Item> orderItems;
	
	@Column(updatable=false)
    private Date createdAt;
    private Date updatedAt;
	
	@PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
	public Order() {
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Number getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(Number orderNumber) {
		this.orderNumber = orderNumber;
	}
	
	public User getOrderByUser() {
		return orderByUser;
	}
	public void setOrderByUser(User orderByUser) {
		this.orderByUser = orderByUser;
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
	public List<Item> getOrderItems() {
		return orderItems;
	}
	public void setOrderItems(List<Item> orderItems) {
		this.orderItems = orderItems;
	}
	public Boolean getPaid() {
		return paid;
	}
	public void setPaid(Boolean paid) {
		this.paid = paid;
	}
	public Double getTotal() {
		return total;
	}
	public void setTotal(Double total) {
		this.total = total;
	}
	public Date getScheduleDate() {
		return scheduleDate;
	}
	public void setScheduleDate(Date scheduleDate) {
		this.scheduleDate = scheduleDate;
	}
	public void setDeliveryOption(String deliveryOption) {
		this.deliveryOption = deliveryOption;
	}
	public String getDeliveryOption() {
		return deliveryOption;
	}
	public Boolean getHasSpecial() {
		return hasSpecial;
	}
	public void setHasSpecial(Boolean hasSpecial) {
		this.hasSpecial = hasSpecial;
	}
	public Payment getOrderPayment() {
		return orderPayment;
	}
	public void setOrderPayment(Payment orderPayment) {
		this.orderPayment = orderPayment;
	}
	
}
