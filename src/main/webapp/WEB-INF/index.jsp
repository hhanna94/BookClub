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
	<title>Login & Registration</title>
  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body class="bg-dark">
	<div class="container w-50 mt-2 bg-dark text-white">
		<h1 class="text-info">Book Club</h1>
		<p>A place for friends to share thoughts on books.</p>
		<hr />
		<div class="d-flex justify-content-between mt-3">
			<form:form action="/register" method="post" modelAttribute="newUser" >
				<h3 class="mb-3">Registration</h3>
		        <div class="form-group mb-3">
		            <label>Name:</label>
		            <form:input path="name" class="form-control" />
		            <form:errors path="name" class="text-danger" />
		        </div>
		        <div class="form-group mb-3">
		            <label>Email:</label>
		            <form:input path="email" class="form-control" />
		            <form:errors path="email" class="text-danger" />
		        </div>
		        <div class="form-group mb-3">
		            <label>Password:</label>
		            <form:password path="password" class="form-control" />
		            <form:errors path="password" class="text-danger" />
		        </div>
		        <div class="form-group mb-3">
		            <label>Confirm Password:</label>
		            <form:password path="confirmPassword" class="form-control" />
		            <form:errors path="confirmPassword" class="text-danger" />
		        </div>
		        <input type="submit" value="Register" class="btn btn-primary" />
		    </form:form>
		    
		    <form:form action="/login" method="post" modelAttribute="newLogin">
		    	<h3 class="mb-3">Login</h3>
		        <div class="form-group mb-3">
		            <label>Email:</label>
		            <form:input path="email" class="form-control" />
		            <form:errors path="email" class="text-danger" />
		        </div>
		        <div class="form-group mb-3">
		            <label>Password:</label>
		            <form:password path="password" class="form-control" />
		            <form:errors path="password" class="text-danger" />
		        </div>
		        <input type="submit" value="Login" class="btn btn-success" />
		    </form:form>
		</div>
	</div>
</body>
</html>