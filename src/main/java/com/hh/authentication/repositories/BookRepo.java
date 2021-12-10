package com.hh.authentication.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.hh.authentication.models.Book;

@Repository
public interface BookRepo extends CrudRepository<Book, Long>{
	List<Book> findAll();
	
	List<Book> findByBorrowerIsNull();
	
	List<Book> findByBorrower(Long id);
}
