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
			</div>
			<div class="col">
				<c:choose>
					<c:when test="${order.deliveryOption == 'delivery'}">
						<h3>Delivery Detail</h3>
						<p>~~~~~~~~~~~~~~~~~</p>
						<h4>
							<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-truck" viewBox="0 0 16 16">
 								<path d="M0 3.5A1.5 1.5 0 0 1 1.5 2h9A1.5 1.5 0 0 1 12 3.5V5h1.02a1.5 1.5 0 0 1 1.17.563l1.481 1.85a1.5 1.5 0 0 1 .329.938V10.5a1.5 1.5 0 0 1-1.5 1.5H14a2 2 0 1 1-4 0H5a2 2 0 1 1-3.998-.085A1.5 1.5 0 0 1 0 10.5v-7zm1.294 7.456A1.999 1.999 0 0 1 4.732 11h5.536a2.01 2.01 0 0 1 .732-.732V3.5a.5.5 0 0 0-.5-.5h-9a.5.5 0 0 0-.5.5v7a.5.5 0 0 0 .294.456zM12 10a2 2 0 0 1 1.732 1h.768a.5.5 0 0 0 .5-.5V8.35a.5.5 0 0 0-.11-.312l-1.48-1.85A.5.5 0 0 0 13.02 6H12v4zm-9 1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm9 0a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"/>
							</svg> 
								Your order had delivered on <fmt:formatDate type = "date" dateStyle = "long" value = "${order.scheduleDate}" />
						</h4>
						<hr>
						<h3>Receipt</h3>
						<h5>Card: ${order.orderPayment.cardHolderName}</h5>
						<h5>Expiration Date: ${order.orderPayment.expMonth} / ${order.orderPayment.expYear}</h5>
						<h5>Card Type: ${order.orderPayment.cardType} </h5>						
					</c:when>
					<c:when test="${order.deliveryOption == 'pickUp'}">
						<h3>Self Pick Up Order</h3>
						<p>~~~~~~~~~~~~~~~~~~~~~~</p>
						<h4>
						<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-pin-map" viewBox="0 0 16 16">
  							<path fill-rule="evenodd" d="M3.1 11.2a.5.5 0 0 1 .4-.2H6a.5.5 0 0 1 0 1H3.75L1.5 15h13l-2.25-3H10a.5.5 0 0 1 0-1h2.5a.5.5 0 0 1 .4.2l3 4a.5.5 0 0 1-.4.8H.5a.5.5 0 0 1-.4-.8l3-4z"/>
  							<path fill-rule="evenodd" d="M8 1a3 3 0 1 0 0 6 3 3 0 0 0 0-6zM4 4a4 4 0 1 1 4.5 3.969V13.5a.5.5 0 0 1-1 0V7.97A4 4 0 0 1 4 3.999z"/>
						</svg>
						Your order was picked Up on <fmt:formatDate type = "date" dateStyle = "long" value = "${order.scheduleDate}" /></h4>
						<hr>
						<h3>Receipt</h3>
						<h5>Card: ${order.orderPayment.cardHolderName}</h5>
						<h5>Expiration Date: ${order.orderPayment.expMonth} / ${order.orderPayment.expYear}</h5>
						<h5>Card Type: ${order.orderPayment.cardType} </h5>
					</c:when>
				</c:choose>
			</div>
		</div>
		<div class="row">
			<c:choose>
				<c:when test="${order.hasSpecial.equals(true)}">
					<h3 style="color:red;">Discount Applied !!!</h3>
					<h4>Total (after discount): $${total}</h4>
				</c:when>
				<c:otherwise>
					<h4>Total: $${total}</h4>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>