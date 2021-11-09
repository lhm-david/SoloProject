package com.codingdojo.firstproject.validation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.codingdojo.firstproject.models.User;
import com.codingdojo.firstproject.repositories.UserRepo;

@Component
public class UserValidator implements Validator{
	@Autowired
	private UserRepo userRepo;
	
	@Override
	public boolean supports(Class<?> clazz) {
		return User.class.equals(clazz);
	}
	@Override
	public void validate(Object target, Errors errors) {
		User user = (User) target;
		if(!user.getPassword().equals(user.getConfirmPassword())) {
			errors.rejectValue("confirmPassword", "Match","Password Not Match.");
		}
		if(this.userRepo.existsByEmail(user.getEmail())) {
			errors.rejectValue("email", "Unique","This Email was already registered.");
		}
	}
}
