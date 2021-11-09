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
						<a href="/EasyOrder.com/${order.id}/CheckOut">View Your Cart (<c:out value="${order.orderItems.size()}"/>)</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<hr>
		<div class="middle">
			<div class="col-3">
				<c:choose>
					<c:when test="${empty order.id}">
						<form:form method="POST" action="/EasyOrder.com/newOrder" modelAttribute="newOrder" >
						<button class="btn btn-primary" type="submit">Start a New Order</button>
						<form:hidden path="orderByUser" value="${user.id}"/>
						<form:hidden path="paid" value="false"/>
						</form:form>
					</c:when>
					<c:otherwise>
						<a class="btn btn-primary" role="button" href="/EasyOrder.com/newOrder/${order.id}">Resume Your Order</a>
						<p>We can only process one order at a time.</p>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="col-3">
				<a class="btn btn-warning" role="button" href="/EasyOrder.com/commentWall">See Comments</a>
			</div>
			<div class="col-3">
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