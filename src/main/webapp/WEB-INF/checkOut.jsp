<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Check Out</title>
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
		<div class="row detail">
			<c:choose>
				<c:when test="${!empty order.orderItems}">
					<h2>Order Number #<c:out value="${orderNumber}"/></h2>
						<ul class="list-group">
							<c:forEach items = "${countMap.keySet()}" var ="item">
								<li class="list-group-item"><img src= "${item.url}" class="img-thumbnail img"/></li>
								<li class="list-group-item">(${countMap.get(item)}) x ${item.name} ------- $${item.price * countMap.get(item)}</li>
							</c:forEach>
						</ul>
				</c:when>
			</c:choose>
		</div>
		<br>
		<div class="row">
			<h3>Total: $${total}</h3>
		</div>
		<br>
		<div class="row">
			<div class="col-3"><a type="button" class="btn btn-secondary" href="/EasyOrder.com/newOrder/${order.id}">Edit Order</a></div>
			<c:choose>
				<c:when test="${empty order.orderItems}">
					<div class="col">
						<h3><span class="badge bg-primary rounded-pill">Your cart was empty</span></h3>
					</div>
				</c:when>
				<c:otherwise>
					<form:form method="POST" action="/EasyOrder.com/${order.id}/CheckOut" class="col">
						<button type="submit" class="btn btn-primary">Check Out</button>
					</form:form>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>