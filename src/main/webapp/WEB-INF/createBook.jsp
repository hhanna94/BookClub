<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <!-- c:out ; c:forEach ; c:if -->
 <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
   <!-- Formatting (like dates) -->
 <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
   <!-- form:form -->
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
   <!-- for rendering errors on PUT routes -->
 <%@ page isErrorPage="true" %>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Add Book to Shelf</title>
  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body class="bg-dark">
	<div class="container w-50 mt-2 bg-dark text-white">
		<div class="d-flex justify-content-between align-items-end">
			<h3>Add a Book to Your Shelf!</h3>
			<a href="/books">back to the shelves</a>
		</div>
		<form:form action="/books" method="post" modelAttribute="book" >
	        <div class="form-group mb-3">
	            <label>Title:</label>
	            <form:input path="title" class="form-control" />
	            <form:errors path="title" class="text-danger" />
	        </div>
	        <div class="form-group mb-3">
	            <label>Author:</label>
	            <form:input path="author" class="form-control" />
	            <form:errors path="author" class="text-danger" />
	        </div>
	        <div class="form-group mb-3">
	            <label>Thoughts:</label>
	            <form:input path="thoughts" class="form-control" />
	            <form:errors path="thoughts" class="text-danger" />
	        </div>
	        <form:hidden path="user" value="${user.id}"/>
	        <input type="submit" value="Submit" class="btn btn-primary" />
	    </form:form>
	</div>
</body>
</html>