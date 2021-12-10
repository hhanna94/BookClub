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
	<title>Book Lender Dashboard</title>
  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body class="bg-dark">
	<div class="container w-50 mt-2 bg-dark text-white">
		<div class="d-flex justify-content-between align-items-end">
			<h6>Hello, <c:out value="${user.name}"></c:out>. Welcome to...</h6>
			<a href="/books">back to the shelves</a>
		</div>
		<h2 class="mb-3">The Book Broker!</h2>
		<p>Available Books to Borrow</p>
		<table class="table table-dark table-striped text-white mt-3 border border-secondary">
			<thead>
				<tr>
					<th class="col-1">ID</th>
					<th class="col-3">Title</th>
					<th class="col-2">Author Name</th>
					<th class="col-1">Owner</th>
					<th class="col-3">Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="book" items="${availableBooks}">
					<tr>
						<td><c:out value="${book.id}"/></td>
						<td><c:out value="${book.title}"/></td>
						<td><c:out value="${book.author}"/></td>
						<td><c:out value="${book.user.name}"/></td>
						<td class="d-flex">
							<c:if test="${book.user.id == user.id}">
								<a class="btn btn-primary d-inline me-3" href="/books/${book.id}/edit">edit book</a>
								<form action="/books/${book.id}" method="post">
									<input type="hidden" name="_method" value="delete" />
									<input class="btn btn-danger" type="submit" value="delete" />
								</form>
							</c:if>
							<c:if test="${book.user.id != user.id }">
								<form action="/books/${book.id}/borrow" method="post">
									<input type="hidden" name="_method" value="put" />
									<input type="hidden" name="userID" value="${user.id}"/>
									<input class="btn btn-success" type="submit" value="borrow" />
								</form>
							</c:if>
							</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<p class="my-3">Books I'm Borrowing...</p>
		<table class="table table-dark table-striped text-white mt-3 border border-secondary">
			<thead>
				<tr>
					<th class="col-1">ID</th>
					<th class="col-3">Title</th>
					<th class="col-2">Author Name</th>
					<th class="col-1">Owner</th>
					<th class="col-3">Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="book" items="${borrowedBooks}">
					<tr>
						<td><c:out value="${book.id}"/></td>
						<td><c:out value="${book.title}"/></td>
						<td><c:out value="${book.author}"/></td>
						<td><c:out value="${book.user.name }"/></td>
						<td>
							<form action="/books/${book.id}/return" method="post">
								<input type="hidden" name="_method" value="put" />
								<input type="hidden" name="userID"/>
								<input class="btn btn-success" type="submit" value="return" />
							</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>