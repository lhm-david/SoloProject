package com.codingdojo.firstproject.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.codingdojo.firstproject.models.Item;
import com.codingdojo.firstproject.repositories.ItemRepo;

@Service
public class ItemService {
	private final ItemRepo itemRepo;
	
	public ItemService(ItemRepo itemRepo) {
		this.itemRepo=itemRepo;
	}
	
	public List<Item> allItems(){
		return this.itemRepo.findAll();
	}
	
	public Item getOne(Long id) {
		return this.itemRepo.findById(id).orElse(null);
	}
	
	public void defaultingItemQ(Item item) {
		item.setQuantities(0);
		this.itemRepo.save(item);
	}
}
