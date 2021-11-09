package com.codingdojo.firstproject.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.firstproject.models.Comment;

@Repository
public interface CommentRepo extends CrudRepository<Comment, Long> {
	List<Comment> findAll();
}
