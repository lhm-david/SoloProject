package com.codingdojo.firstproject.services;
import java.util.List;

import org.springframework.stereotype.Service;

import com.codingdojo.firstproject.models.Comment;
import com.codingdojo.firstproject.models.User;
import com.codingdojo.firstproject.repositories.CommentRepo;

@Service
public class CommentService {
	private final CommentRepo commentRepo;
	
	public CommentService(CommentRepo commentRepo) {
		this.commentRepo=commentRepo;
	}
	
	public List<Comment> allComments(){
		return this.commentRepo.findAll();
	}
	
	public Comment getOne(Long id) {
		return this.commentRepo.findById(id).orElse(null);
	}
	
	public Comment createComment(Comment comment) {
		return this.commentRepo.save(comment);
	}

	public void likeComment(Comment comment, User user) {
		List<User> userWhoLike = comment.getLikeByUsers();
		userWhoLike.add(user);
		this.commentRepo.save(comment);
	}
	
	public void cancelLike(Comment comment, User user) {
		List<User> userWhoLike = comment.getLikeByUsers();
		userWhoLike.remove(user);
		this.commentRepo.save(comment);
	}
	
	public void deleteComment(Long id) {
		this.commentRepo.deleteById(id);
	}
}
