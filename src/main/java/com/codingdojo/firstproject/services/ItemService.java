package com.codingdojo.firstproject.services;

import java.time.DayOfWeek;
import java.time.LocalDate;
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
	
	//Added code by Anna
	public List<Item> byPriceAscended(){
		return this.itemRepo.findByPriceOrderAscended();
	}
	
	public List<Item> byPriceDescended(){
		return this.itemRepo.findByPriceOrderDescended();
	}
		
	public List<Item> byCategory(){
		return this.itemRepo.OrderByCategoryAscended();
	}
		
	//Added code by Anna	
	public List<Item> weekdaySpecials(){
		return this.itemRepo.weekdaySpecialsList();
	}	
	public String currDay() {
		DayOfWeek currentDay = LocalDate.now().getDayOfWeek();
	    String dayOfWeek = null;
	    switch(currentDay.getValue()) {
	        case 1:
	        	dayOfWeek = "Monday";
	        	break;
	        case 2:
	            dayOfWeek = "Tuesday";
	            break;
	        case 3:
	            dayOfWeek = "Wednesday";
	            break;
	        case 4:
	            dayOfWeek = "Thursday";
	            break;
	        case 5:
	            dayOfWeek = "Friday";
	            break;        
	        }
	        return dayOfWeek;
	}
}
