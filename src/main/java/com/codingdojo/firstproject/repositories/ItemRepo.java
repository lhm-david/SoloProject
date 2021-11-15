package com.codingdojo.firstproject.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.firstproject.models.Item;

@Repository
public interface ItemRepo extends CrudRepository<Item, Long> {
	List<Item> findAll();
	List<Item> findByCatergoryContaining(String search);
}
