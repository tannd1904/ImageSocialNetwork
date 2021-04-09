<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title>Đăng nhập</title>
<base href="${pageContext.servletContext.contextPath}/">
<link rel="stylesheet" type="text/css"
	href="bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="bootstrap/css/home.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script type="text/javascript" src="bootstrap/js/jquery.min.js"></script>
<script type="text/javascript" src="bootstrap/js/popper.min.js"></script>
<style type="text/css">
.hover-a {
	color: #65a5d4;
}

.hover-a:hover {
	color: #8BC34A;
	text-decoration: none;
}
</style>
</head>

<body>
	<div class="container">
		<div class="card123">
			<!-- Modal body -->
			<div class="login-form">
				<img class="logoUI" src="bootstrap/images/onepiecelogo.png" alt="">
				<h5 class="login-title">Cùng mình đăng nhập nào</h5>
				<div style="color: red;">${message}</div>
				<form:form action="user/sign-in.htm">
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fa fa-user"></i></span>
						</div>
						<input type="text" class="form-control" name="UserName"
							placeholder="Tên đăng nhập">

					</div>
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fa fa-lock"></i></span>
						</div>
						<input type="password" class="form-control" name="Password"
							placeholder="Mật khẩu">
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-primary btn-block">
							Đăng nhập</button>
					</div>
					<!-- form-group// -->

					<div class="form-group">
						<a class="hover-a" href="user/sign-up.htm">Bạn chưa có tài khoản?</a>
					</div>
					<!-- form-group// -->
					<div class="form-group">
						<a class="hover-a" href="mailer/reset.htm">Quên mật khẩu?</a>
					</div>
				</form:form>

			</div>
		</div>
	</div>
	<!--container end.//-->
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</body>

</html>