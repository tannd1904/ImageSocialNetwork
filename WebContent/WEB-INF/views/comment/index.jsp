<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<base href="${pageContext.servletContext.contextPath}/">
<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
</head>
<body>
	<table class="table table-hover">
		<tr>
			<th>Id</th>
			<th>Cmt</th>
			<th>Date</th>
			<th>User</th>
			<th>Post</th>
			<th>Sửa</th>
			<th>Xóa</th>
		</tr>
		<c:forEach var="l" items="${comment}">
			<tr>
				<td>${l.commentId}</td>
				<td>${l.contentCmt}</td>
				<td>${l.dateCreated}</td>
				<td>${l.user.userId}</td>
				<td>${l.post.postId}</td>
				<td><a href="comment/update/${l.commentId}.htm">Cập nhật</a></td>
				<td><a href="comment/delete/${l.commentId}.htm">Xóa</a></td>
			</tr>
		</c:forEach>
	</table>
	<hr>
	<a class="btn btn-primary" href="comment/insert/${l.post.postId}.htm">Thêm</a>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>