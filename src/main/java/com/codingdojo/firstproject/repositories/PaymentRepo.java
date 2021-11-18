package com.codingdojo.firstproject.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.codingdojo.firstproject.models.Payment;

public interface PaymentRepo extends CrudRepository <Payment,Long> {
	List<Payment> findAll();
}
