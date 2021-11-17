<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Success!</title>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCQXBpv7Ucttk8AjbB7O-Pc40jecQY-LzQ&callback=myMap"></script>
<script>
var map;
function myMap() {
  var mapOptions = {
    zoom: 12,
    center: new google.maps.LatLng(37.30640, -121.89134)
  };
  var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  var marker = new google.maps.Marker({
	  position:{lat:37.30640,lng:-121.89134},
	  map: map
		  });
}

google.maps.event.addDomListener(window, 'load', initialize);
</script>
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
		
			<div class="col">
				<h1>Thank You!</h1>	
				<h2>Your Order has been placed!</h2>
				<h2>Order Status:</h2>
				<div class="row detail">
					<h4>Order Number #<a href="/EasyOrder.com/order/${order.id}"><c:out value="${orderNumber}"/></a> </h4>
					<div class="col">
						<div>
							<h3>Order Detail:</h3>
						</div>
						<ul class="list-group">
							<c:forEach items = "${countMap.keySet()}" var ="item">
								<li class="list-group-item"><img src= "${item.url}" class="img-thumbnail img"/></li>
								<li class="list-group-item">(${countMap.get(item)}) x ${item.name} ($${item.price * countMap.get(item)})</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="row">
					<h3>Total: $${order.total}</h3>
				</div>
			<div class="col">
				<h4> Please <a href="/EasyOrder.com/commentWall">give us a feedback!</a> </h4>
			</div>
				</div>
			
			<div class="col">
				<c:choose>
					<c:when test="${order.deliveryOption == 'delivery'}">
						<h3>Delivery Detail</h3>
						<h4>Your order is scheduling on <fmt:formatDate type = "date" dateStyle = "long" value = "${order.scheduleDate}" /></h4>
						<div id="map-canvas" style="height:300px; width:500px"></div>
					</c:when>
					<c:otherwise>
						<h3>Pick Up Detail</h3>
						<h4>Your order will be ready in 30 minutes</h4>
						<h5>Restaurant Address: 1455 Bird Ave, San Jose, CA 95125</h5>
						<div id="map-canvas" style="height:300px; width:500px"></div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		
	</div>
</body>
</html>