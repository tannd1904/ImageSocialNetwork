<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Thêm hình</title>
<base href="${pageContext.servletContext.contextPath}/">
<link rel="stylesheet" type="text/css"
	href="bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="bootstrap/css/app.css">
<link rel="stylesheet" href="bootstrap/css/theme.css">
<link rel="stylesheet" type="text/css" href="bootstrap/css/post.css">
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
.err {
	color: red;
    font-style: italic;
    position: absolute;
    top: 18px;
    text-align: center;
    left: 38%;
}
</style>

<script type="text/javascript" src="bootstrap/js/jquery.min.js"></script>
<script type="text/javascript" src="bootstrap/js/popper.min.js"></script>
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
	<div class="container">
		<div class="col-md-8 khungPost">
			<div class="err">${err}</div>
			<form:form id="formPost" action="post/insert.htm"
				modelAttribute="post" method="post" enctype="multipart/form-data">
				<div class="input-group mb-3 bang">
					<div class="input-group-prepend">
						<label class="input-group-text" for="labelBang">Bảng</label>
					</div>
					<form:select path="category.categoryId" class="custom-select"
						id="labelBang" items="${category}" itemValue="categoryId"
						itemLabel="categoryName" />
				</div>
				<!-- <div class="noidung">
					<label>Nội dung</label> <br> <input name="ContentPost" />
				</div> -->
				<div class="form-group noidung">
					<label class="label-edit">Nội dung</label>
					<textarea class="form-control" rows="10" cols="34"
						name="ContentPost">${cont}</textarea>
				</div>

				<div class="chonHinh">
					<img class="logoUpload" src="bootstrap/images/logoUpload.png">
					<h6 id="textUpload">Chọn hình</h6>
					<input class="photoInput" name="photoPost" type="file"
						accept="image/bmp,image/gif,image/jpeg,image/png,image/tiff,image/webp">
				</div>

				<div class="custom-control custom-checkbox mb-3 cmt">
					<input name="OnlyMe" value="true" type="checkbox"
						class="custom-control-input" id="customCheck"> <label
						class="custom-control-label" for="customCheck">Chỉ mình
						tôi</label>
				</div>
				<div class="btnThem">
					<button class="btn btn-primary">Thêm</button>
				</div>
			</form:form>
		</div>
	</div>

	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>