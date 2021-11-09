<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Success!</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/style.css"/>
</head>
<body>
	<div class="container">
		<div class="row header">
			<div class="col-8">
				<h1>Check Out</h1>
			</div>
			<div class="col-md-auto"><c:out value="${user.firstName}"/></div>
			<div class="col-md-auto"><a href="/EasyOrder.com">Home</a></div>
			<div class="col-md-auto"><a href="/logout">Logout</a></div>
		</div>
		<hr>
		<div class="row">
			<h1>Thank You!</h1>
		</div>
		<div class="row">	
			<h2>Your Order has been placed!</h2>
		</div>
		<div class="row">
			<h3>Order Number: #<a href="/EasyOrder.com/order/${order.id}"><c:out value="${orderNumber}"/></a> </h3>
		</div>
		<div class="col">
			<h4> Please <a href="/EasyOrder.com/commentWall">give us a feedback!</a> </h4>
		</div>
	</div>
</body>
</html>