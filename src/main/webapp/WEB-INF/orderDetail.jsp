<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Order Detail</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/style.css"/>
</head>
<body>
	<div class="container">
		<div class="row header">
			<div class="col-8">
				<h1>Order #<c:out value="${order.orderNumber}"/></h1>
			</div>
			<div class="col-md-auto">
				<c:out value="${user.firstName}"/>
			</div>
			<div class="col-md-auto"><a href="/EasyOrder.com">Home</a></div>
			<div class="col-md-auto"><a href="/logout">Logout</a></div>
		</div>
		<hr>
		<div class="row">
			<div class="detail">
				<div>
					<h3>Order Detail:</h3>
					<ul class="list-group">
						<c:forEach items = "${countMap.keySet()}" var ="item">
								<li class="list-group-item"><img src= "${item.url}" class="img-thumbnail img"/></li>
								<li class="list-group-item">(${countMap.get(item)}) x ${item.name} ($${item.price * countMap.get(item)})</li>
						</c:forEach>
					</ul>
				</div>
				<br>
				<h3>Total: $${order.total}</h3>
			</div>
			<div class="col">
				<c:choose>
					<c:when test="${order.deliveryOption == 'delivery'}">
						<h3>Delivery Detail</h3>
						<h4>Your order has delivered on <fmt:formatDate type = "date" dateStyle = "long" value = "${order.scheduleDate}" /></h4>
					</c:when>
					<c:when test="${order.deliveryOption == 'pickUp'}">
						<h3>Self Pick Up Order</h3>
					</c:when>
				</c:choose>
			</div>
		</div>
	</div>
</body>
</html>