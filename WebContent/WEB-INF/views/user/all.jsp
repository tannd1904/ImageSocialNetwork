<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>ALL USER</title>
<base href="${pageContext.servletContext.contextPath}/">
</head>
<body>
	<h1>Thông tin tất cả người dùng</h1>
	<table border="1" style="width: 100%;">
		<tr>
			<th>ID</th>
			<th>Avatar</th>
			<th>Last name</th>
			<th>First name</th>
			<th>Username</th>
			<th>Email</th>
			<th>Gender</th>
			<th>Birthday</th>
		</tr>
		<c:forEach var="user" items="${users}">
			<tr>
				<td>${user.userId}</td>
				<td>${user.avatar}</td>
				<td>${user.lastName}</td>
				<td>${user.firstName}</td>
				<td>${user.userName}</td>
				<td>${user.email}</td>
				<td>${user.gender}</td>
				<td>${user.birthday}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>