<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title>Trang chủ</title>
<base href="${pageContext.servletContext.contextPath}/">
<link rel="stylesheet" type="text/css"
	href="bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script type="text/javascript" src="bootstrap/js/jquery.min.js"></script>
<script type="text/javascript" src="bootstrap/js/popper.min.js"></script>
<link rel="stylesheet" href="bootstrap/css/app.css">
<link rel="stylesheet" href="bootstrap/css/theme.css">
<style type="text/css">
.textTieuDe {
	color: #fff;
	font-style: normal;
	font-size: 15px;
}

.nav-item:hover {
	border-radius: 5px;
	background: #fff3ef8c;
}

.arrow-down {
	width: 0;
	height: 0;
	border-left: 10px solid transparent;
	border-right: 10px solid transparent;
	border-top: 10px solid #fff;
}

.btnDown {
	width: 30px;
	height: 20px;
	padding-top: 5px;
	padding-left: 5px;
}
</style>
</head>

<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top">
		<a class="navbar-brand font-weight-bolder mr-3" href="home.htm"><img
			class="logo-one-piece" src="bootstrap/images/logoOP.png"></a>

		<div class="collapse navbar-collapse" id="navbarsDefault">
			<ul class="navbar-nav mr-auto align-items-center">
				<form class="form-inline">
					<input class="form-control mr-sm-2" type="search"
						placeholder="Tìm kiếm" aria-label="Search">
				</form>
			</ul>
			<ul class="navbar-nav ml-auto align-items-center">
				<li class="nav-item"><a class="nav-link active" href="home.htm"><span
						class="textTieuDe">Trang chủ</span></a></li>

				<li class="nav-item"><a class="nav-link active" href="#"><span
						class="textTieuDe">Đang theo dõi</span></a></li>

				<li class="nav-item"><a class="nav-link"
					href="${sessionScope.loginSuccess.getUserName()}.htm"><img
						class="rounded-circle mr-2"
						src="${pageContext.request.contextPath}${sessionScope.loginSuccess.getAvatar()}"
						width="30" height="30"><span class="align-middle textTieuDe">${sessionScope.loginSuccess.getFirstName()}</span></a></li>
				<li class="nav-item dropdown btnDown">
					<div class="arrow-down" id="dropdown02" data-toggle="dropdown"></div>

					<div class="dropdown-menu dropdown-menu-right shadow-lg"
						aria-labelledby="dropdown02">
						<a class="dropdown-item"
							href="user/update/${sessionScope.loginSuccess.getUserName()}.htm">Chỉnh
							sửa thông tin</a> <a class="dropdown-item"
							href="user/change-pass/${sessionScope.loginSuccess.getUserName()}.htm">Đổi
							mật khẩu</a> <a class="dropdown-item" href="user/sign-out.htm">Đăng
							xuất</a>

					</div>
				</li>
			</ul>
		</div>
	</nav>
	<main role="main">
		<section class="mt-4 mb-5">

			<div class="container-fluid">
				<div class="row">
					<div class="card-columns">
						<c:forEach var="p" items="${allposts}">
							<div class="card card-pin">
								<img class="card-img"
									src="${pageContext.request.contextPath}${p.photo}"
									alt="Card image"> <a
									href="post/${p.category.categoryId}/${p.postId}.htm">
									<div class="overlay">
										<h2 class="card-title title">${p.category.user.firstName}</h2>
										
									</div>
								</a>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</section>

	</main>
	<!--container end.//-->
	<script src="bootstrap/js/app.js"></script>
	<script src="bootstrap/js/theme.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</body>

</html>