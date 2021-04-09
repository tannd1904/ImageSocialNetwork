<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title>${user.firstName}</title>
<base href="${pageContext.servletContext.contextPath}/">
<link rel="stylesheet" type="text/css"
	href="bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script type="text/javascript" src="bootstrap/js/jquery.min.js"></script>
<script type="text/javascript" src="bootstrap/js/popper.min.js"></script>
<link rel="stylesheet" href="bootstrap/css/app.css">
<link rel="stylesheet" href="bootstrap/css/theme.css">
<link rel="stylesheet" href="bootstrap/css/author.css">
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
			<!-- ======================= START firstname + avatar + thêm bảng + thêm hình ========================== -->
				<div class="row rowtren">
					<div class="col-md-7 bentrai">
						<div class="bentrai-trong">
							<div class="luachon">
								<nav class="navbar navbar-expand-sm bg-light">
									<ul class="navbar-nav">
										<c:if
											test="${sessionScope.loginSuccess.getUserName().equals(user.userName)}">
											<li class="nav-item thembang" style="float: left"><a
												class="nav-link" href="category/insert.htm">Thêm bảng</a></li>
											<li class="nav-item themhinh"><a class="nav-link"
												href="post/insert.htm">Thêm hình</a></li>
										</c:if>

									</ul>
								</nav>
								<!-- Links -->

							</div>
							<div class="tenauthor">${user.firstName}</div>
						</div>

					</div>
					<div class="col-md-5 benphai">
						<img class="rounded-circle mr-2 authoravatar"
							src="${pageContext.request.contextPath}${user.avatar}">
					</div>
				</div>
				<!-- ======================= END firstname + avatar + thêm bảng + thêm hình ========================== -->
				
				<!-- ======================= START tất cả bảng + tất cả hình ========================== -->
				<div class="row rowduoi">
					<!-- Nav pills -->
					<ul class="nav nav-pills">
						<li class="nav-item"><a class="nav-link active"
							data-toggle="pill" href="#home">Bảng</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="pill"
							href="#menu1">Tất cả hình</a></li>
					</ul>
				</div>
				<!-- ======================= END tất cả bảng + tất cả hình ========================== -->
			</div>

			<!-- Tab panes của tất cả bảng + tất cả hình -->
			<div class="tab-content">
				<!-- ======================= START tất cả bảng ========================== -->
				<div class="tab-pane container-fluid active" id="home">

					<div class="row">
						<c:forEach var="c" items="${allcategorysUser}">
							<div class="col-md-3">
								<a href="category/${c.categoryId}.htm"
									style="color: #8bc34a; text-decoration: none;">
									<div class="card mb-3 divBu" style="max-width: 18rem;">
										<div class="card-header cName">${c.categoryName}</div>
										<div class="text-success div-bang">

											<img class="imgTable" src="bootstrap/images/logoTable.png"
												alt="Card image">

										</div>

									</div>
								</a>
							</div>
						</c:forEach>

					</div>
				</div>
				<!-- ======================= END tất cả bảng ========================== -->
				
				<!-- ======================= START tất cả hình ========================== -->
				<div class="tab-pane container fade container-fluid" id="menu1">
					<div class="card-columns">
						<c:forEach var="p" items="${allpostsUser}">

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
				<!-- ======================= END tất cả hình ========================== -->
			</div>
		</section>

	</main>

	<!--container end.//-->
	<script src="bootstrap/js/app.js"></script>
	<script src="bootstrap/js/theme.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</body>

</html>