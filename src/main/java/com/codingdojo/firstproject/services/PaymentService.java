package com.codingdojo.firstproject.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.firstproject.models.Payment;
import com.codingdojo.firstproject.repositories.PaymentRepository;

@Service
public class PaymentService {
	
	@Autowired
	private PaymentRepository payRepo;
	
	// get AllPayment
	public List<Payment> getAllPayment(){
		return this.payRepo.findAll();
	}
	
	// createPayment
	public Payment createPayment(Payment payment) {
		return this.payRepo.save(payment);
		
	}
	
	// getOnepayment
	
	public Payment getOnePayment(Long id) {
		return this.payRepo.findById(id).orElse(null);
	}
	
	// update payment 
	public Payment updatePayment(Payment payment) {
		return this.payRepo.save(payment);
	}
	
	

}
