<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New Order</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/style.css"/>
</head>
<body>
	<div class="container">
		<div class="row header">
			<div class="col-8">
				<h1>Start a new order</h1>
			</div>
			<div class="col-md-auto">
				<c:out value="${user.firstName}"/>
			</div>
			<div class="col-md-auto"><a href="/EasyOrder.com">Home</a></div>
			<div class="col-md-auto"><a href="/logout">Logout</a></div>
			<div class="col-md-auto"><a href="/EasyOrder.com/${order.id}/CheckOut">View Your Cart (<c:out value="${order.orderItems.size()}"/>)</a></div>
		</div>
		<hr>
		
		<div>
		
<%-- 		<!-- Added code by Anna -->
		<h3>Weekday Specials</h3><br>
		<div style="display:flex; justify-content: space-evenly;">
			<c:forEach items="${weekdaySpecials}" begin = "0" var="special" varStatus="theCount">
				<c:choose>
					<c:when test="${weekday[theCount.index] == currentDay}">
						<div style="flex-direct:row; border-style:dashed; border-width:5px; border-color:blue;">												
							<div id="divIDNo${theCount.index}"> 
							 	<span style="font-weight:bold; margin-left:50px;">
							 		  ${weekday[theCount.index]}
							    </span>
							</div>							
						  	<img src= "${special.url}" style="width:170px; height:170px;"/><br>												
							<span style="font-weight:bold;"> ${special.name} - $${special.price}</span>						
					   </div>	
					</c:when>
			        <c:otherwise>
						 <div style="flex-direct:row; border-color:transparent;">												
							<div id="divIDNo${theCount.index}"> 
							 	<span style="font-weight:bold; margin-left:50px; ">
							 		  ${weekday[theCount.index]}
							    </span>
							</div>							
						  	<img src= "${special.url}" style="width:170px; height:170px;"/><br>												
							<span style="font-weight:bold;"> ${special.name} - $${special.price}</span>						
						</div>	
					</c:otherwise>
				</c:choose>
			</c:forEach>	
	   </div>

		
		<br><br> --%>
		<div class="row">
			<h3>Menu</h3>

            <!-- Added code by Anna -->
		    <div style="display:flex; justify-content: flex-end; margin-left: -160px;">	
			    <div style="flex-direct:row; margin-right: 40px;"><a href="/EasyOrder.com/newOrder/${order.id}/priceDesc">Price (H to L)</a></div>
				<div style="flex-direct:row; margin-right: 40px;"><a href="/EasyOrder.com/newOrder/${order.id}/priceAsc">Price (L to H)</a></div>
				<%-- <div style="flex-direct:row; margin-right: 40px;"><a href="/EasyOrder.com/newOrder/${order.id}/category">View By Category</a></div> --%>
				<div style="flex-direct:row;"><a href="/EasyOrder.com/newOrder/${order.id}">Reset View</a></div>
		    </div>			
			
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
									<td><a class="btn btn-primary" role="button" href="/EasyOrder.com/newOrder/${order.id}/${item.id}">Add to cart</a></td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="middle">
			<a class="btn btn-danger" role="button" href="/EasyOrder.com/newOrder/${order.id}/starOver">Start Over</a>
			<a class="btn btn-primary" role="button" href="/EasyOrder.com/${order.id}/CheckOut">Check Out</a>
		</div>
	</div>
</body>
</html>