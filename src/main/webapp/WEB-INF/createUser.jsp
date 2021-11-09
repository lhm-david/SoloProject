<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create An Account</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/style.css"/>
</head>
<body>
<div class="container">
	<div class="row header">
		<div class="col-7">
			<h1>Welcome to EasyOrder</h1>
		</div>
		<div class="col"><a href = "/EasyOrder/loginUser">Already have an account? Login </a></div>
		<div class="col"><a href="/">Home</a></div>
		<hr>
	</div>
	<div class="row body">
	    <form:form method="POST" action="/EasyOrder/createUser" modelAttribute="user" class="row g-3">
	        <div class="col-md-6">
		        <p>
		            <form:label path="firstName" class="form-label">First Name: </form:label>
		            <form:input type="firstName" path="firstName" class="form-control" placeholder="First Name"/>
		            <form:errors path="firstName"/>
		        </p>
	        </div>
	        <div class="col-md-6">
		        <p>
		            <form:label path="lastName" class="form-label">Last Name: </form:label>
		            <form:input type="lastName" path="lastName" class="form-control" placeholder="Last Name"/>
		            <form:errors path="lastName"/>
		        </p>
	        </div>
	        <div class="col-12">
	        <p>
	            <form:label path="email" class="form-label">Email: </form:label>
	            <form:input type="email" path="email" class="form-control" placeholder="example@example.com"/>
	            <form:errors path="email"/>
	        </p>
	        </div>
	        <div class="col-12">
	        <p>
	            <form:label path="password" class="form-label">Password: </form:label>
	            (Password must be at least 8 characters.)
	            <form:password path="password" class="form-control"/>
	            <form:errors path="password"/>
	        </p>
	        </div>
			<div class="col-12">
	        <p>
	            <form:label path="confirmPassword" class="form-label">Password Confirmation: </form:label>
	            <form:password path="confirmPassword" class="form-control"/>
	            <form:errors path="confirmPassword"/>
	        </p>
	        </div>
	        <div class="d-grid gap-2 d-md-flex justify-content-md-center">
	        	<button type="submit" class="btn btn-primary">Register</button>
	        </div>
	    </form:form>
	</div>
</div>
</body>
</html>