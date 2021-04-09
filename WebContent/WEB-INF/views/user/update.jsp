<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title>Chỉnh sửa thông tin cá nhân</title>
<base href="${pageContext.servletContext.contextPath}/">
<link rel="stylesheet" type="text/css"
	href="bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script type="text/javascript" src="bootstrap/js/jquery.min.js"></script>
<script type="text/javascript" src="bootstrap/js/popper.min.js"></script>
<link rel="stylesheet" href="bootstrap/css/app.css">
<link rel="stylesheet" href="bootstrap/css/theme.css">
	<style>
    .ho {
      float: left;
      width: 48%;
      margin-right: 21px;
    }

    .ten {
      float: left;
      width: 47.5%;
    }
    .gender-select {
      border-radius: 5px;
    height: 38px;
    width: 70px;
    }
    .sdt {
      float: left;
    width: 65%;
    }
    .gioitinh {
      float: left;
    margin-right: 21px;
    }
    .label-edit {
    	font-weight: bold;
    }
    .btnha {
    padding: 3px;
    }

	span {
		color: red;
		font-style: italic;
	}
	
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
	}
	
	.err1 {
		margin-left: 171px;
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

					</div></li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<div class="col-md-3">
				<img alt="Ảnh đại diện" src="${pageContext.request.contextPath}${sessionScope.loginSuccess.getAvatar()}">
				<p style="text-align: center;">Ảnh đại diện</>
			</div>
			<div class="col-md-6" style="margin: 0 auto;">
			<h3 style="font-style: italic; text-align: center;">Chỉnh sửa thông tin cá nhân</h3>
				<form:form action="user/update.htm" method="post" enctype="multipart/form-data" modelAttribute="user">
				<div class="form-group  hinhanh">
							<label class="label-edit">Thay ảnh đại diện</label>
							<input class="form-control btnha" type="file" name="Avatar" value="${user.getAvatar()}"/>
						</div>
					<div>
						<div class="form-group  ho">
							<label class="label-edit">Họ</label>
							<input class="form-control" type="text" name="LastName" value="${user.getLastName()}"/>
						</div>
						<div class="form-group ten">
							<label class="label-edit">Tên</label>
							<input class="form-control" type="text" name="FirstName" value="${user.getFirstName()}"/>
						</div>
					</div>
					<div class="err">${errLFName}</div>

					<div class="form-group">
						<label class="label-edit">Ngày sinh</label>
						<input class="form-control" type="date" name="Birthday"
							 value="${user.getBirthday()}"/>
					</div>
					<div class="err">${errBirthday}</div>
					<div>
						<div class="form-group gioitinh">
						<label class="label-edit">Giới tính</label>
						<div style="padding-top: 6px;">
							<label>
							<input name="Gender" type="radio" value="1" 
							${user.getGender() == '1'?'checked':''}>
							Nam
						</label>
						<label>
							<input name="Gender" type="radio" value="2" 
							${user.getGender() == '2'?'checked':''}>
							Nữ
						</label>
						<label>
							<input name="Gender" type="radio" value="0" 
							${user.getGender() == '0'?'checked':''}>
							Khác
						</label>
						</div>
						
						</div>
						<div class="form-group sdt">
							<label class="label-edit">Số điện thoại</label>
							<input class="form-control" type="text" name="Phone" value="${user.getPhone()}"/>
						</div>
					</div>
					<div class="err err1">${errPhone}</div>

					<div class="form-group">
						<label class="label-edit">Giới thiệu bản thân</label>
						<textarea class="form-control" rows="5" name="Story">${user.getStory()}</textarea>
					</div>

					<button class="btn btn-primary" type="submit">Lưu thay đổi</button>
				</form:form>
			</div>

		</div>
	</div>
	<!--container end.//-->
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</body>

</html>