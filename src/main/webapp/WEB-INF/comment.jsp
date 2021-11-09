<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>CommentWall</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/style.css"/>
</head>
<body>
	<div class="container">
		<div class="row header">
			<div class="col-8">
				<h1>How you like it?</h1>
			</div>
			<div class="col-md-auto"><c:out value="${user.firstName}"/></div>
			<div class="col-md-auto"><a href="/EasyOrder.com">Home</a></div>
			<div class="col-md-auto"><a href="/logout">Logout</a></div>
		</div>
		<hr>
		<h2>Comment Wall</h2>
		<div>
			<c:forEach items="${allComments}" var="comment">
				<div class="comment">
					<div class="row">
						<p>${comment.content}</p>
					</div>
					<div class="row">
						<p>Posted By ${comment.commentByUser.firstName}</p>
					</div>
					<div class="row">
						<div class="col-4"><p><c:out value="${comment.likeByUsers.size()}"/> likes</p></div>
						<c:choose>
							<c:when test="${comment.likeByUsers.contains(user)}">
								<div class="col-2"><p>Liked</p></div>
								<div class="col-2"><p><a type="button" class="btn btn-warning" href="/EasyOrder.com/${comment.id}/cancelLike">Unlike</a></p></div>
							</c:when>
							<c:when test="${comment.commentByUser.equals(user)}">
								<div class="col"><a class="btn btn-danger" role="button" href="/EasyOrder.com/${comment.id}/delete">Delete Comment</a></div>
							</c:when>
							<c:otherwise>
								<div class="col">
									<a class="btn btn-success" role="button" href="/EasyOrder.com/${comment.id}/like">Like</a>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</c:forEach>
		</div>
		<h3>Post your comment:</h3>
		<div class="form-floating">
			<form:form method="POST" action="/EasyOrder.com/commentWall" modelAttribute="newComment">
		        <form:textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea2" style="width: 400px" path="content"/>
		        <form:hidden path="commentByUser" value="${user.id}"/>
		        <br>
		        <button type="submit" class="btn btn-primary">Submit</button>
		</form:form>
	</div>
	</div>
</body>
</html>