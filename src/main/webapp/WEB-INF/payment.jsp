<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>payment Page</title>
</head>
<body>

<form:form action="/EasyOrder.com/${order.id}/checkout/payment" method="POST" modelAttribute="payment">
 	<div class="paymentcontainer">
		<form:label path="cardHolderName"> Cardholder Name</form:label>
		<form:errors path="cardHolderName"></form:errors>
		<form:input type="text" path="cardHolderName"/>
	</div> 
	<div class="paymentcontainer">
		<form:label path="cardNumber"> Card Number</form:label>
		<form:errors path="cardNumber"></form:errors>
		<form:input type="Integer" path="cardNumber"/>
	</div> 
	<div class="paymentcontainer">
		<form:label path="cnv"> cnv</form:label>
		<form:errors path="cnv"></form:errors>
		<form:input type="Integer" path="cnv"/>
	</div> 
	<div class ="paymentcontainer">
		<select name="expirationMonth">
			<option value="1">January </option>
			<option value="2">February </option>
			<option value="3">March </option>	
			<option value="4">April </option>
			<option value="5">May </option>
			<option value="6">June </option>
			<option value="7">July </option>
			<option value="8">August </option>
			<option value="9">September </option>
			<option value="10">October </option>
			<option value="11">November </option>
			<option value="12">December </option>
		</select>
	</div>
	<div class ="paymentcontainer">
		<select name="expirationYear">
			<option value="2">2020 </option>
			<option value="3">2021 </option>	
			<option value="4">2022 </option>
			<option value="5">2023 </option>
			<option value="6">2024 </option>
			<option value="7">2025 </option>
			<option value="8">2026 </option>
			<option value="9">2027 </option>
			<option value="10">2028 </option>
			<option value="11">2029 </option>
			<option value="12">2030 </option>
		</select>
	</div>
	
	<div class ="paymentcontainer">
		<select name="cardType">
			<option value="1">VISA </option>
			<option value="2">MasteCard </option>
			<option value="3">March </option>	
			<option value="4">PaYtm </option>
		</select>
	</div>
<%--  <a href="/orders/checkout/payment/${checoutoneorder.id}">Make Payment</a>
 --%>
 <button>MakePayment</button>
 <form:hidden path="makePayment" value="${user.id}"/>
<a href="/orders/continue">Continue</a>
</form:form>
	<div class="success">
	
	<c:forEach items="${payments}" var="payment">
	<p>${payment.cardNumber}</p>
	
	<a href="/EasyOrder.com/${order.id}/success">Use this card </a>
	
	
	
	</c:forEach>
	</div>



</body>
</html>