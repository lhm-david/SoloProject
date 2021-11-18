package com.codingdojo.firstproject.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.firstproject.models.Payment;
import com.codingdojo.firstproject.repositories.PaymentRepo;

@Service
public class PaymentService {
	@Autowired
	private PaymentRepo paymentRepo;

	// get AllPayment
	public List<Payment> getAllPayment(){
		return this.paymentRepo.findAll();
	}

	// createPayment
	public Payment createPayment(Payment payment) {
		return this.paymentRepo.save(payment);

	}
	
	//getOnePayment
	public Payment getOne(Long id) {
		return this.paymentRepo.findById(id).orElse(null);
	}
	
	//delete payment
	public void deletePayment(Long id) {
		this.paymentRepo.deleteById(id);
	}
}
