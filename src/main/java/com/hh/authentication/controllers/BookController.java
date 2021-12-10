package com.hh.authentication.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hh.authentication.models.Book;
import com.hh.authentication.models.User;
import com.hh.authentication.services.BookService;
import com.hh.authentication.services.UserService;

@Controller
public class BookController {
	@Autowired
	private UserService userService;
	@Autowired
	private BookService bookService;
	
	@GetMapping("/books")
	public String showBooks(HttpSession session, Model model) {
		Long userID = (Long) session.getAttribute("user_id");
		if (userID != null) {
			User user = userService.findUser(userID);
			model.addAttribute("user", user);
		}
		
		List<Book> books = bookService.getAllBooks();
		model.addAttribute("books", books);
		return "allBooks.jsp";
	}
	
	@GetMapping("/books/new")
	public String newBook(@ModelAttribute("book") Book book, Model model, HttpSession session) {
		Long userID = (Long) session.getAttribute("user_id");
		if (userID != null) {
			User user = userService.findUser(userID);
			model.addAttribute("user", user);
		} else {
			return "redirect:/";
		}
		return "createBook.jsp";
	}
	
	@PostMapping("/books")
	public String createBook(@Valid @ModelAttribute("book") Book book, BindingResult result, Model model) {
		bookService.createBook(book, result);
		if (result.hasErrors()) {
			model.addAttribute("thoughts", new Book());
			return "createBook.jsp";
		} else {
			return "redirect:/books";
		}
	}
	
	@GetMapping("/books/{id}")
	public String viewBook(@PathVariable("id") Long id, Model model, HttpSession session) {
		Book book = bookService.getOneBook(id);
		model.addAttribute("book", book);
		Long userID = (Long) session.getAttribute("user_id");
		model.addAttribute("userID", userID);
		return "oneBook.jsp";
	}
	
	@GetMapping("/books/{id}/edit")
	public String editBook(@PathVariable("id") Long id, Model model) {
		Book book = bookService.getOneBook(id);
		model.addAttribute("book", book);
		return "editBook.jsp";
	}
	
	@PutMapping("/books/{id}")
	public String edit(@Valid @ModelAttribute("book") Book book, BindingResult result, Model model) {
		bookService.editBook(book, result);
		if (result.hasErrors()) {
			model.addAttribute("thoughts", new Book());
			return "editBook.jsp";
		} else {
			return "redirect:/books";
		}
	}
	
	@GetMapping("/bookmarket")
	public String bookMarket(Model model, HttpSession session) {
		Long userID = (Long) session.getAttribute("user_id");
		if (userID != null) {
			User user = userService.findUser(userID);
			model.addAttribute("user", user);
			
			List<Book> borrowedBooks = user.getBorrowedBooks();
			model.addAttribute("borrowedBooks", borrowedBooks);
		} else {
			return "redirect:/";
		}
		
		List<Book> availableBooks = bookService.getAvailableBooks();
		model.addAttribute("availableBooks", availableBooks);
		
		return "lenderDashboard.jsp";
	}
	
	@DeleteMapping("/books/{id}")
	public String delete(@PathVariable("id") Long id) {
		bookService.deleteBook(id);
		return "redirect:/books";
	}
	
	@PutMapping("/books/{id}/borrow")
	public String borrowBook(@RequestParam(name="userID") Long userID, @PathVariable("id") Long bookID) {
		User user = userService.findUser(userID);
		bookService.borrowBook(bookID, user);
		return "redirect:/bookmarket";
	}
	
	@PutMapping("/books/{id}/return")
	public String returnBook(@PathVariable("id") Long bookID) {
		bookService.returnBook(bookID);
		return "redirect:/bookmarket";
	}
}
