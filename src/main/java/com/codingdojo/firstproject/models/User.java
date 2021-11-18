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
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Entity
@Table(name="users")
public class User {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	@Email(message="Email must be valid")
	@NotBlank
	private String email;
	
	@Size(min=3, message="First Name should be at least 3 characters")
	private String firstName;
	
	@Size(min=3, message="Last Name should be at least 3 characters")
	private String lastName;

	@Size(min=8, message="Password must be at least 8 characters")
	private String password;
	@Transient
	private String confirmPassword;
	
	@Column(updatable=false)
    private Date createdAt;
    private Date updatedAt;
    
    @OneToMany(mappedBy="orderByUser", fetch = FetchType.LAZY)
    private List<Order> orders;
    
    @OneToMany(mappedBy="commentByUser", fetch = FetchType.LAZY)
    private List<Comment> comments;
    
    @OneToMany(mappedBy="paymentForUser", fetch = FetchType.LAZY)
    private List<Payment> userPayments;
    
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
	        name = "user_comment", 
	        joinColumns = @JoinColumn(name = "user_id"), 
	        inverseJoinColumns = @JoinColumn(name = "comment_id")
	    )
    private List<Comment> userLikes;
    
    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
	public User() {
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getConfirmPassword() {
		return confirmPassword;
	}
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
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
	public List<Order> getOrders() {
		return orders;
	}
	public void setOrders(List<Order> orders) {
		this.orders = orders;
	}
	public List<Comment> getComments() {
		return comments;
	}
	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}
	public List<Payment> getUserPayments() {
		return userPayments;
	}
	public void setUserPayments(List<Payment> userPayments) {
		this.userPayments = userPayments;
	}
	public List<Comment> getUserLikes() {
		return userLikes;
	}
	public void setUserLikes(List<Comment> userLikes) {
		this.userLikes = userLikes;
	}    
}
