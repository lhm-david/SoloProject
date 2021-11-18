<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>payment</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/style.css"/>
</head>
<body>
<div class="container">
	<div class="row header">
		<div class="col-7">
			<h1>Payment</h1>
			<h4>Select your payment card or Create a new payment</h4>
		</div>
		<div class="col-md-auto"><a href="/EasyOrder.com">Home</a></div>
			<div class="col-md-auto"><a href="/logout">Logout</a></div>
			<div class="col-md-auto">
				<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
  					<path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l1.313 7h8.17l1.313-7H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
				</svg>
				<a href="/EasyOrder.com/${order.id}/CheckOut">View Your Cart (<c:out value="${order.orderItems.size()}"/>)</a></div>
		<hr>
	</div>
	<div class="row body">
		<form:form action="/EasyOrder.com/${order.id}/checkout/payment" method="POST" modelAttribute="payment" class="row g-3">
		 	<div class="row" style="color:red; margin-bottom:20px;">
			 	<form:errors path="cardHolderName"/>
			 	<form:errors path="cardNumber"/>
			 	<form:errors path="cnv"/>
			 	<form:errors path="expMonth"/>
			 	<form:errors path="expYear"/>
			 	<form:errors path="cardType"/>
		 	</div>
		 	<div class="row">
				<p>
					<form:label path="cardHolderName" class="form-label"> Card Holder Name</form:label>
					<form:input type="text" path="cardHolderName" class="form-control"/>
				</p>
				<p>
					<form:label path="cardNumber" class="form-label">Card Number</form:label>
					<form:input type="text" path="cardNumber" class="form-control"/>
				</p>
				<div class="col-3">
					<p>
						<form:label path="cnv" class="form-label"> Card Security Code</form:label>
						<form:input type="text" path="cnv" class="form-control"/>
					</p>
				</div>
			</div> 
			<div class ="row">
			<div class="col">
				<form:label path="expMonth" class="form-label">Expiration Month</form:label>
				<form:select path="expMonth" class="form-select" aria-label="Default select example">
					<option value="">Select Month</option>
					<option value="01">January </option>
					<option value="02">February </option>
					<option value="03">March </option>	
					<option value="04">April </option>
					<option value="05">May </option>
					<option value="06">June </option>
					<option value="07">July </option>
					<option value="08">August </option>
					<option value="09">September </option>
					<option value="10">October </option>
					<option value="11">November </option>
					<option value="12">December </option>
				</form:select>
			</div>
			<div class ="col">
				<form:label path="expYear" class="form-label">Expiration Year</form:label>
				<form:select path="expYear" class="form-select" aria-label="Default select example">
					<option value="">Select Year</option>
					<option value="2021">2021 </option>	
					<option value="2022">2022 </option>
					<option value="2023">2023 </option>
					<option value="2024">2024 </option>
					<option value="2025">2025 </option>
					<option value="2026">2026 </option>
					<option value="2027">2027 </option>
				</form:select>
			</div>
			<div class ="col">
				<form:label path="cardType" class="form-label">Card Type</form:label>
				<form:select path="cardType" class="form-select" aria-label="Default select example">
					<option value="">Select Card Type</option>
					<option value="Visa">VISA </option>
					<option value="Master">MasteCard </option>
					<option value="American Express">American Express </option>	
					<option value="Discover">Discover </option>
				</form:select>
			</div>
		</div>
		<div class="d-grid gap-2 d-md-flex justify-content-md-center">
		 	<button type="submit" class="btn btn-primary">Save This Card</button>
		</div>
		<form:hidden path="paymentForUser" value="${user.id}"/>
		</form:form>
		
		<div class="row" style="text-align:center;margin-top:20px;">
			<c:choose>
				<c:when test="${!empty user.userPayments}">
					<h3>Saved card:</h3>
					<c:forEach items="${payments}" var="payment">
						<div class="row justify-content-center">
							<div class="col-5" style="border:2px solid black; padding:5px; width:240px; text-align:center; margin-bottom:5px;">
								<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-credit-card" viewBox="0 0 16 16">
	  								<path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4zm2-1a1 1 0 0 0-1 1v1h14V4a1 1 0 0 0-1-1H2zm13 4H1v5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V7z"/>
	  								<path d="M2 10a1 1 0 0 1 1-1h1a1 1 0 0 1 1 1v1a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-1z"/>
								</svg>
								<p>${payment.cardHolderName}</p>
								<p>${payment.expMonth} / ${payment.expYear}</p>
								<p>${payment.cardType}</p>
							</div>
						</div>
						<div class="row justify-content-center" style="margin-bottom:20px;">
							<div style="margin-bottom:5px;"><a class="btn btn-success" role="button" href="/EasyOrder.com/${order.id}/checkout/savedCard/${payment.id}">Use this card </a></div>	
							<%--<div><a class="btn btn-danger" role="button" href="/EasyOrder.com/${order.id}/deletePayment/${payment.id}">Delete</a></div>--%>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div style="padding-top:20px; text-align:center; color:red;">
						<h3>You have no saved payment card yet, please create one</h3>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
</body>
</html> 