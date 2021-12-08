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
	<title><c:out value="${book.title}"/></title>
  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body class="bg-dark">
	<div class="container w-50 mt-2 bg-dark text-white">
		<div class="d-flex justify-content-between align-items-end">
			<h1><em><c:out value="${book.title}"/></em></h1>
			<a href="/books">back to the shelves</a>
		</div>
		<h4><span class="text-danger"><c:out value="${book.user.id == userID? 'You' : book.user.name}"/></span> read <span class="text-primary"><c:out value="${book.title}"/></span> by <span class="text-success"><c:out value="${book.author}"/></span>.</h4>
		<h5>Here are <c:out value="${book.user.id == userID? 'your' : 'their'}"/> thoughts:</h5>
		<div class="w-50">
			<hr />
			<p><em><c:out value="${book.thoughts}"/></em></p>
			<hr />
		</div>
		<c:if test="${book.user.id == userID}">
			<a href="/books/${id}/edit">edit book</a>
		</c:if>
	</div>
</body>
</html>