<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/style.css"/>
</head>
<body>
	<div class="container">
		<div class="row header">
			<div class="col-7">
				<h1>Welcome Back</h1>
			</div>
			<div class="col"><a href = "/EasyOrder/createUser">Need an account? Sign Up</a></div>
			<div class="col"><a href="/">Home</a></div>
			<hr>
			<div class="row login">
				<p>${error}</p>
				<h2>Log in</h2>
		    	<form method="post" action="/EasyOrder/loginUser" class="row g-3">
		        	<div class="col-12">
			        	<p>
			           		<label for="email" class="form-label">Email:</label>
			            	<input type="email" name="email" class="form-control" placeholder="example@example.com"/>
			        	</p>
		        	</div>
		        	<div class="col-12">
				        <p>
				            <label for="password" class="form-label">Password:</label>
				            <input type="password" name="password" class="form-control" placeholder="password"/>
				        </p>
			        </div>
		        	<div class="d-grid gap-2 d-md-flex justify-content-md-center">
	        			<button type="submit" class="btn btn-primary">Login</button>
	        		</div>
		    	</form>
			</div>
		</div>
	</div>
</body>
</html>