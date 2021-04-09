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
			<th>Thuộc bảng</th>
			<th>Mã bài viết</th>
			<th>Nội dung</th>
			<th>Ảnh</th>
			<th>Ngày tạo</th>
			<th>Chỉ mình tôi</th>
			<th>Sửa</th>
			<th>Xóa</th>
		</tr>
		<c:forEach var="p" items="${posts}">
			<tr>
				<td>${p.category.categoryName}</td>
				<td>${p.postId}</td>
				<td>${p.contentPost}</td>
				<td>${p.photo}</td>
				<td>${p.dayCreated}</td>
				<td>${p.onlyMe}</td>
				<td><a href="post/update/${p.postId}.htm">Cập nhật</a></td>
				<td><a href="post/delete/${p.postId}.htm">Xóa</a></td>
			</tr>
		</c:forEach>
	</table>
	<hr>
	<a class="btn btn-primary" href="post/insert.htm">Thêm</a>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>