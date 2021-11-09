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
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;

@Entity
@Table(name="comments")
public class Comment {
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	@NotBlank
	private String content;
	@Column(updatable=false)
    private Date createdAt;
    private Date updatedAt;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User commentByUser;
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
	        name = "user_comment", 
	        joinColumns = @JoinColumn(name = "comment_id"), 
	        inverseJoinColumns = @JoinColumn(name = "user_id")
	    )
    private List<User> likeByUsers;
    
	public Comment() {
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public User getCommentByUser() {
		return commentByUser;
	}
	public void setCommentByUser(User commentByUser) {
		this.commentByUser = commentByUser;
	}
	public List<User> getLikeByUsers() {
		return likeByUsers;
	}
	public void setLikeByUsers(List<User> likeByUsers) {
		this.likeByUsers = likeByUsers;
	}
}
