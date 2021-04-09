<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title>Quên mật khẩu</title>
<base href="${pageContext.servletContext.contextPath}/">
<link rel="stylesheet" type="text/css"
	href="bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="bootstrap/css/home.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script type="text/javascript" src="bootstrap/js/jquery.min.js"></script>
<script type="text/javascript" src="bootstrap/js/popper.min.js"></script>
</head>

<body>
	<div class="container">
		<div class="card123">
			<!-- Modal body -->
			<div class="login-form">
				<img class="logoUI" src="bootstrap/images/onepiecelogo.png" alt="">
				<h5 class="login-title">Bạn gặp sự cố khi đăng nhập?</h5>
				<div  style="color: blue">${message}</div>
				<form:form action="mailer/send.htm">
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fa fa-envelope"></i></span>
						</div>
						<input type="text" class="form-control" name="toEmail"
							placeholder="Email của bạn">
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-primary btn-block">
							Gửi mật khẩu mới</button>
					</div>
					<div class="form-group">
						<a class="hover-a" href="user/sign-in.htm">Đăng nhập</a>
					</div>
					<!-- form-group// -->
				</form:form>

			</div>
		</div>
	</div>
	<!--container end.//-->
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</body>

</html>