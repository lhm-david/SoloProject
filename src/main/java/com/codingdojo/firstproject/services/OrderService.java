package com.codingdojo.firstproject.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.codingdojo.firstproject.models.Item;
import com.codingdojo.firstproject.models.Order;
import com.codingdojo.firstproject.repositories.OrderRepo;

@Service
public class OrderService {
	private final OrderRepo orderRepo;
	
	public OrderService(OrderRepo orderRepo) {
		this.orderRepo=orderRepo;
	}
	
	public List<Order> allOrders(){
		return this.orderRepo.findAll();
	}
	public Order createOrder(Order order) {
		return this.orderRepo.save(order);
	}
	
	public Order updateOrder(Order order) {
		order.setPaid(true);
		return this.orderRepo.save(order);
	}
	
	public Order getOne(Long id) {
		return this.orderRepo.findById(id).orElse(null);
	}
	
	public void addItemInOrder(Order order, Item item) {
		List<Item> itemOrder = order.getOrderItems();
		itemOrder.add(item);
		Integer Q = item.getQuantities();
		Q++;
		item.setQuantities(Q);
		Double total = Math.round((order.getTotal()+item.getPrice())*100.0)/100.0;
		order.setTotal(total);
		this.orderRepo.save(order);
	}
	
	public void removeItemInOrder(Order order, Item item) {
		List<Item> itemOrder = order.getOrderItems();
		itemOrder.remove(item);
		Integer Q = item.getQuantities();
		Q--;
		item.setQuantities(Q);
		Double total = Math.round((order.getTotal()-item.getPrice())*100.0)/100.0;
		order.setTotal(total);
		this.orderRepo.save(order);
	}
	
	public void removeAllItemsInOrder(Order order) {
		order.setOrderItems(null);
		order.setTotal(0.00);
		this.orderRepo.save(order);
	}
	
	public void deleteOrder(Long id) {
		this.orderRepo.deleteById(id);
	}
}
