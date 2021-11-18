<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome Back</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/style.css"/>
</head>
<body>
	<div class="container">
		<div class="row header">
			<div class="col-8">
				<h1>Hello <c:out value="${user.firstName}"/> How are you today?</h1>
			</div>
			<div class="col-md-auto"><a href="/logout">Logout</a></div>
			<div class="col-md-auto">
				<c:choose>
					<c:when test="${empty order.id}">
						<p>Your cart was empty</p>
					</c:when>
					<c:otherwise>
						<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
  							<path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l1.313 7h8.17l1.313-7H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
						</svg>
						<a href="/EasyOrder.com/${order.id}/CheckOut">View Your Cart (<c:out value="${order.orderItems.size()}"/>)</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<hr>
		<div class="middle row">
			<div class="col-6">
				<c:choose>
					<c:when test="${empty order.id}">
						<form:form method="POST" action="/EasyOrder.com/newOrder" modelAttribute="newOrder" >
						<div class="row">
							<div class="col-3">
								<button class="btn btn-primary" type="submit">Start a New Order</button>
							</div>
							<div class="col-4">
								<form:label path="scheduleDate" class="form-label">Order for : </form:label>
								<form:input type="date" path="scheduleDate" min="2021-11-18" max="2021-11-30"/>
							</div>
							<div class="col-2">
								<form:radiobutton path="deliveryOption" value="delivery"/>
								<form:label path="deliveryOption" class="form-label">Delivery </form:label>
								<form:radiobutton path="deliveryOption" value="pickUp"/>
								<form:label path="deliveryOption" class="form-label">Pick Up </form:label>
							</div>
							<form:hidden path="orderByUser" value="${user.id}"/>
							<form:hidden path="paid" value="false"/>
						</div>
						</form:form>
						
					</c:when>
					<c:otherwise>
						<a class="btn btn-primary" role="button" href="/EasyOrder.com/${order.id}/CheckOut">Resume Your Order</a>
						<p>We can only process one order at a time.</p>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="col-3">
				<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-chat-square-dots-fill" viewBox="0 0 16 16">
  					<path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2h-2.5a1 1 0 0 0-.8.4l-1.9 2.533a1 1 0 0 1-1.6 0L5.3 12.4a1 1 0 0 0-.8-.4H2a2 2 0 0 1-2-2V2zm5 4a1 1 0 1 0-2 0 1 1 0 0 0 2 0zm4 0a1 1 0 1 0-2 0 1 1 0 0 0 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
				</svg>
				<a class="btn btn-warning" role="button" href="/EasyOrder.com/commentWall">See Comments</a>
			</div>
			<div class="col-3">
				<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-person-lines-fill" viewBox="0 0 16 16">
  					<path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm-5 6s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zM11 3.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5zm.5 2.5a.5.5 0 0 0 0 1h4a.5.5 0 0 0 0-1h-4zm2 3a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1h-2zm0 3a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1h-2z"/>
				</svg>
				<a class="btn btn-info" role="button" href="/EasyOrder.com/editUser/${user.id}">Edit your account</a>
			</div>
		</div>
		<div class="row">
			<h4>Your recent order:</h4>
			<table class="table table-hover">
				<thead class="table-dark">
					<tr>
						<th>Order Number</th>
						<th>Order Date</th>
						<th>Status</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${user.orders}" var="order">
						<tr>
							<c:choose>
								<c:when test="${order.paid.equals(true)}">
									<td><a href="/EasyOrder.com/order/${order.id}">${order.orderNumber}</a></td>
								</c:when>
								<c:otherwise>
									<td><a href="/EasyOrder.com/${order.id}/CheckOut">${order.orderNumber}</a></td>
								</c:otherwise>
							</c:choose>
							<td><fmt:formatDate pattern="MMMM dd, yyy" value="${order.createdAt}"/></td>
							<c:choose>
								<c:when test="${order.paid.equals(true)}">
									<td>Paid</td>
								</c:when>
								<c:otherwise>
									<td>Not Paid</td>
								</c:otherwise>
							</c:choose>
							<td><a class="btn btn-danger" role="button" href="/EasyOrder.com/delete/${order.id}">Delete</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>