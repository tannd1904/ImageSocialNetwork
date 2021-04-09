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
			<th>Mã bảng</th>
			<th>Tên bảng</th>
			<th>Tạo bởi</th>
			<th>Sửa</th>
			<th>Xóa</th>
		</tr>
		<c:forEach var="c" items="${categorys}">
			<tr>
				<td>${c.categoryId}</td>
				<td>${c.categoryName}</td>
				<td>${c.user.firstName}</td>
				<td><a href="category/update/${c.categoryId}.htm">Cập nhật</a></td>
				<td><a href="category/delete/${c.categoryId}.htm">Xóa</a></td>
			</tr>
		</c:forEach>
	</table>
	<hr>
	<a class="btn btn-primary" href="category/insert.htm">Thêm</a>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>