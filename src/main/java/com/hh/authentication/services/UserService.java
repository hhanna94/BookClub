package com.hh.authentication.services;

import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.hh.authentication.models.LoginUser;
import com.hh.authentication.models.User;
import com.hh.authentication.repositories.UserRepo;

@Service
public class UserService {
	@Autowired
	private UserRepo userRepo;
	
	// Get a user
	public User findUser(Long id) {
		Optional<User> user = userRepo.findById(id);
		if (user.isPresent()) {
			return user.get();
		} else {
			return null;
		}
	}
	
	// Register a new user with a hashed password after first making sure that the email doesn't exist and that the passwords match.
	public User register(User newUser, BindingResult result) {
		String regex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&+=])(?=\\S+$).{8,}$";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(newUser.getPassword());
		
		if (userRepo.findByEmail(newUser.getEmail()).isPresent()) {
			result.rejectValue("email", "Unique", "This email is already in use!");
		}
		if (!newUser.getPassword().equals(newUser.getConfirmPassword())) {
			result.rejectValue("confirmPassword", "Matches", "Passwords must match!");
		}
		if (!m.matches()) {
			result.rejectValue("password", "Secure", "Password must have at least one lowercase letter, uppercase letter, number and special character, and be at least 8 characters long.");
		}
		if (result.hasErrors()) {
			return null;
		} else {
			String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
			newUser.setPassword(hashed);
			return userRepo.save(newUser);
		}
	}
	
	// Login in the user if the email is valid and the given password matches the user's password.
	public User login(LoginUser newLogin, BindingResult result) {
		if(result.hasErrors()) {
			return null;
		}
		Optional<User> potentialUser = userRepo.findByEmail(newLogin.getEmail());
		if (!potentialUser.isPresent()) {
			result.rejectValue("email", "Unique", "Invalid email or password");
		}
		User user = potentialUser.get();
		if(!BCrypt.checkpw(newLogin.getPassword(), user.getPassword())) {
			result.rejectValue("password", "Matches", "Invalid email or password");
		}
		if(result.hasErrors()) {
			return null;
		} else {
			return user;
		}
	}
}
