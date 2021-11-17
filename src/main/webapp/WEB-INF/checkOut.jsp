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
		<div class="row">
				<c:choose>
					<c:when test="${empty order.orderItems}">
						<div class="row">
							<div class="col-6">
								<a type="button" class="btn btn-secondary" href="/EasyOrder.com/newOrder/${order.id}">Edit Order</a>
							</div>
							<div class="col-6">
								<h3><span>Your cart was empty</span></h3>
							</div>
						</div>
					</c:when>
					<c:when test="${!empty order.orderItems}">
						<div class="col-5 detail">
							<h2>Order Number #<c:out value="${orderNumber}"/></h2>
								<ul class="list-group">
									<c:forEach items = "${countMap.keySet()}" var ="item">
										<li class="list-group-item"><img src= "${item.url}" class="img-thumbnail img"/></li>
										<li class="list-group-item">(${countMap.get(item)}) x ${item.name} ------- $${item.price * countMap.get(item)}</li>
									</c:forEach>
								</ul>
							<div class="row">
								<h3>Total: $${total}</h3>
							</div>
							<div class="row">
								<div class="col-6">
									<a type="button" class="btn btn-secondary" href="/EasyOrder.com/newOrder/${order.id}">Edit Order</a>
								</div>
								<div class="col">
									<form method="post" action="/EasyOrder.com/${order.id}/CheckOut" class="col">
										<button type="submit" class="btn btn-primary">Check Out</button>
									</form>
								</div>
							</div>
						</div>
						<div class="col-5">
							<h3>People who order this also order:</h3>
							<c:set var="i" value="${0}"/>
								<c:forEach items="${countMap.keySet()}" var="item">
									<c:choose>
										<c:when test="${countMap.get(item) > i}">
											<c:set var="i" value="${countMap.get(item)}"/>
											<c:set var ="cat" value="${item.catergory}"/>
										</c:when>
									</c:choose>
								</c:forEach>
								<table class="table table-hover align-middle">
									<thead class="table-dark">
										<tr>
											<th></th>
											<th>Name</th>
											<th>Price</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${allItems}" var="item">
											<c:choose>
												<c:when test="${!order.orderItems.contains(item)}">
													<c:choose>
														<c:when test="${item.catergory.equals(cat)}">
															<tr>
																<td>
																	<img src= "${item.url}" class="img-thumbnail img"/>
																</td>	
																<td>${item.name}</td>
																<td>$${item.price}</td>
																<c:choose>
																	<c:when test="${order.orderItems.contains(item)}">
																		<td><a class="btn btn-danger" role="button" href="/EasyOrder.com/newOrder/${order.id}/remove/${item.id}">Remove</a> ( ${item.quantities} ) <a class="btn btn-success" role="button" href="/EasyOrder.com/newOrder/${order.id}/${item.id}">Add</a></td>
																	</c:when>
																	<c:otherwise>
																		<td><a class="btn btn-primary" role="button" href="/EasyOrder.com/newOrder/${order.id}/${item.id}">Add</a></td>
																	</c:otherwise>
																</c:choose>
															</tr>
														</c:when>
													</c:choose>
												</c:when>
											</c:choose>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</c:when>
					</c:choose>
				<br>
				</div>
	</div>
</body>
</html>