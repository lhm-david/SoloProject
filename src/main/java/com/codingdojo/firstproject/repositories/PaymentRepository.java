package com.codingdojo.firstproject.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.firstproject.models.Payment;

@Repository
public interface PaymentRepository extends CrudRepository<Payment,Long> {
	
	List<Payment> findAll();

}
