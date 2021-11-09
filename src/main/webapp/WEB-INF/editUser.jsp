<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update your Account</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/style.css"/>
</head>
<body>
<div class="container">
		<div class="row header">
			<div class="col-8">
				<h1>Edit Profile</h1>
			</div>
			<div class="col-md-auto"><c:out value="${user.firstName}"/></div>
			<div class="col-md-auto"><a href="/EasyOrder.com">Home</a></div>
			<div class="col-md-auto"><a href="/logout">Logout</a></div>
		</div>
		<hr>
		<form:form method="POST" action="/EasyOrder.com/editUser/${user.id}" modelAttribute="user" class="row g-3 login">
			<div class="row">
		        <p>
		            <form:label path="firstName" class="form-label">First Name: </form:label>
		            <form:input type="firstName" path="firstName" class="form-control" placeholder="First Name"/>
		            <form:errors path="firstName"/>
		        </p>
	        </div>
	        <div class="row">
		        <p>
		            <form:label path="lastName" class="form-label">Last Name: </form:label>
		            <form:input type="lastName" path="lastName" class="form-control" placeholder="Last Name"/>
		            <form:errors path="lastName"/>
		        </p>
	        </div>
		            <form:hidden path="email" value="${user.email}"/>
		            <form:hidden path="password" value="${user.password}"/>
		        
	        <div class="d-grid gap-2 d-md-flex justify-content-md-center">
	        	<button type="submit" class="btn btn-primary">Confirm and Update</button>
	        </div>
		</form:form>
</div>
</body>
</html>