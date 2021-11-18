package com.codingdojo.firstproject.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.firstproject.models.Item;

@Repository
public interface ItemRepo extends CrudRepository<Item, Long> {
	List<Item> findAll();
	//Add by Anna
	@Query(value = "select * from items Order by price asc", nativeQuery = true)
	List<Item> findByPriceOrderAscended();
		
	@Query(value = "select * from items Order by price desc", nativeQuery = true)
	List<Item> findByPriceOrderDescended();
		
	@Query(value = "select * from items Order by category asc", nativeQuery = true)
	List<Item> OrderByCategoryAscended();
		
	@Query(value = "Select * from items where id in (1, 2, 3, 4, 5)", nativeQuery = true)
	List<Item> weekdaySpecialsList();
}
