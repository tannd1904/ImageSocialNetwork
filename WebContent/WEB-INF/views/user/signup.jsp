<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title>Đăng ký</title>
<base href="${pageContext.servletContext.contextPath}/">
<link rel="stylesheet" type="text/css"
	href="bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="bootstrap/css/home.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script type="text/javascript" src="bootstrap/js/jquery.min.js"></script>
<script type="text/javascript" src="bootstrap/js/popper.min.js"></script>
<link rel="stylesheet prefetch"
	href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
<script type="text/javascript">
	$(function() {
		$("#datepicker").datepicker({
			autoclose : true,
			todayHighlight : true
		}).datepicker('update', new Date());
	});
</script>
<style type="text/css">
.hover-a {
	color: #65a5d4;
}

.hover-a:hover {
	color: #8BC34A;
	text-decoration: none;
}
span {
	color: red;
	font-style: italic;
}
.err {
		color: red;
		font-style: italic;
	}
</style>
</head>

<body>
	<div class="container">
		<div class="card123">
			<!-- Modal body -->
			<div class="sign-form">
				<img class="logoUI" src="bootstrap/images/onepiecelogo.png" alt="">
				<h5 class="sign-title">Đăng ký để xem ảnh từ bạn bè</h5>
				<form:form action="user/sign-up.htm" modelAttribute="user"
					method="post">
					<div>
						<div class="form-group input-group last-name">
							<div class="input-group-prepend">
								<span class="input-group-text"> <i class="fa fa-user"></i>
								</span>
							</div>
							<form:input path="LastName" class="form-control" placeholder="Họ"
								type="text" value="${user.getLastName()}"/>
							
						</div>
						<!-- form-group// -->
						<div class="form-group input-group fisrt-name">
							<form:input path="FirstName" class="form-control"
								placeholder="Tên" type="text" value="${user.getFirstName()}"/>
						</div>
						<!-- form-group// -->
					</div>
					<div class="err form-group">${errLFName}</div>

					<div class="form-group input-group email-input">
						<div class="input-group-prepend">
							<span class="input-group-text"> <i class="fa fa-envelope"></i>
							</span>
						</div>
						<form:input path="Email" class="form-control" placeholder="Email"
							type="email" value="${user.getEmail()}"/>
					</div>

					<div class="form-group input-group gender-input">
						<div class="input-group-prepend">
							<span class="input-group-text"> <i
								class="fas fa-venus-mars"></i>
							</span>
						</div>
						<form:select path="Gender" class="gender-select">
							<form:option value="1">Nam</form:option>
							<form:option value="2">Nữ</form:option>
							<form:option value="0">Khác</form:option>
						</form:select>
					</div>
					<div class="err form-group">${errEmail}</div>

					<div>
						<div class="form-group input-group last-name">
							<div class="input-group-prepend">
								<span class="input-group-text"> <i class="fa fa-phone"></i>
								</span>
							</div>
							<form:input path="Phone" class="form-control"
								placeholder="Số điện thoại" type="text" value="${user.getPhone()}"/>
						</div>
						<!-- form-group// -->
						<div class="form-group input-group fisrt-name">
							<div class="input-group-prepend">
								<span class="input-group-text"> <i
									class="far fa-calendar-alt"></i>
								</span>
							</div>
							<form:input path="Birthday" class="form-control" data-date-format="dd/mm/yyyy" id="datepicker"
								placeholder="Ngày sinh" type="text"/>
						</div>
						<!-- form-group// -->
					</div>
					<div class="err form-group">${errPD}</div>

					<!-- form-group// -->
					<div class="form-group input-group">
						<div class="input-group-prepend">
							<span class="input-group-text"> <i class="fa fa-user"></i>
							</span>
						</div>
						<form:input path="UserName" class="form-control"
							placeholder="Tên đăng nhập" type="text" value="${user.getUserName()}"/>
					</div>
					<div class="err form-group">${errUserName}</div>
					<!-- form-group// -->
					<div class="form-group input-group">
						<div class="input-group-prepend">
							<span class="input-group-text"> <i class="fa fa-lock"></i>
							</span>
						</div>
						<form:input path="Password" class="form-control"
							placeholder="Mật khẩu" type="password" value="${user.getPassword()}"/>
					</div>
					<div class="err form-group">${errPassword}</div>
					<!-- form-group// -->
					<div class="form-group input-group">
						<div class="input-group-prepend">
							<span class="input-group-text"> <i class="fa fa-lock"></i>
							</span>
						</div>
						<input name="Passwords" class="form-control"
							placeholder="Xác nhận mật khẩu" type="password" value="${Passwords}"/>
					</div>
					<div class="err form-group">${errPasswords}</div>
					<!-- form-group// -->
					
					<div class="form-group">
						<button type="submit" class="btn btn-primary btn-block">
							Đăng ký</button>
					</div>
					<div class="form-group">
						<a class="hover-a" href="user/sign-in.htm">Bạn đã có tài khoản?</a>
					</div>
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