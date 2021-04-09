<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<base href="${pageContext.servletContext.contextPath}/">
<link rel="stylesheet" type="text/css"
	href="bootstrap/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<div class="col-md-6">
			${message}
			<form:form action="category/update/${category.categoryId }.htm" modelAttribute="category">
				<div>
					<label>Tên bảng</label> <br>
					<input name="CategoryName" value="${category.categoryName}"/>
				</div>
				<div>
					<button class="btn btn-primary">SỬA</button>
				</div>
			</form:form>
		</div>
	</div>

	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>