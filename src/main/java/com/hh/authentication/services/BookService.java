package com.hh.authentication.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.hh.authentication.models.Book;
import com.hh.authentication.models.User;
import com.hh.authentication.repositories.BookRepo;

@Service
public class BookService {
	private final BookRepo bookRepo;
	public BookService(BookRepo bookRepo) {
		this.bookRepo = bookRepo;
	}
	
	// Create a book
	public Book createBook(Book book, BindingResult result) {
		if (book.getThoughts().length() > 1000) {
			result.rejectValue("thoughts", "Length", "Thoughts cannot be more than 1000 characters. Sorry!");
		}
		if (result.hasErrors()) {
			return null;
		}
		return bookRepo.save(book);
	}
	
	// Update a book
	public Book editBook(Book book, BindingResult result) {
		if (book.getThoughts().length() > 1000) {
			result.rejectValue("thoughts", "Length", "Thoughts cannot be more than 1000 characters. Sorry!");
		}
		if (result.hasErrors()) {
			return null;
		}
		return bookRepo.save(book);
	}
	
	// Get all books
	public List<Book> getAllBooks() {
		return bookRepo.findAll();
	}
	
	// Get one book
	public Book getOneBook(Long id) {
		Optional<Book> book = bookRepo.findById(id);
		if (book.isPresent()) {
			return book.get();
		} else {
			return null;
		}
	}
	
	// Find books that haven't been borrowed
	public List<Book> getAvailableBooks() {
		List<Book> availableBooks = bookRepo.findByBorrowerIsNull();
		return availableBooks;
	}
	
	// Delete book
	public void deleteBook(Long id) {
		Book book = getOneBook(id);
		bookRepo.delete(book);
	}
	
	// Borrow a book
	public void borrowBook(Long bookID, User user) {
		Book book = getOneBook(bookID);
		book.setBorrower(user);
		bookRepo.save(book);
	}
	
	
	//Return a book
	public void returnBook(Long bookID) {
		Book book = getOneBook(bookID);
		book.setBorrower(null);
		bookRepo.save(book);
	}
	
	
	
	
}
