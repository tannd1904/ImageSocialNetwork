<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title>${category.user.firstName}</title>
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

.textUserName {
	color: #8BC34A;
	font-style: normal;
	font-size: 20px;
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

.tenUserOfPost {
	margin: 6px 0px 3px 0px;
	width: 230px;
}

.avatar {
	width: 50px;
	height: 50px
}

.divChon {
	position: absolute;
	right: 18px;
	top: 25px;
}

.btnChon {
	padding: 0;
	width: 30px;
	border-radius: 5px;
	height: 30px;
}

._card {
	font-size: 23px;
	display: flex;
}

._collapse .collapse {
	transition: ease-in-out 0.5s;
}

.bieutuong {
	/* float: left; */
	margin-right: 10px;
	margin-top: -20px;
}

.like:hover {
	color: #f34040ed;
}

.comment {
	color: #92c450;
}

.comment:hover {
	color: #4ac6e4e0;
}

.save:hover {
	color: #e4cb4a;
}

.binhluan {
	font-size: 12px;
	font-weight: bold;
	margin-bottom: 12px;
}

.btnSend {
	height: 38px;
	width: 43px;
	padding: 0px 1px 0px 0px;
}

.inputCmt {
	width: 78%;
	float: left;
	margin-right: 20px;
}

.avaCmt {
	float: left;
	margin-right: 10px;
}

.contentCmt {
	position: relative;
	width: 80.5%;
	float: left;
	margin-right: 20px;
	padding: 6px;
	background: #80808014;
	border-radius: 10px;
	margin-bottom: 5px;
}

.contentName {
	font-weight: bold;
}

.contentName:hover {
	color: #8bc34a;
	text-decoration: none;
}

.contentDivPost {
padding: 0px 15px 0px 15px;
    margin: -5px 0px 5px 0px;
}

.btnChon1 {
	position: absolute;
	top: 0;
	right: -52px;
}

.formSuaPost {
	width: 30%;
}

.suaPost {
	padding: 10px;
}
.nutXoaPost{
position: absolute;
    bottom: 10px;
    left: 100px;
}
.btnXoaNe{
border: 1px gray solid;
background: gray;
}
.btnXoaNe:hover{
border: 1px red solid;
background: red;
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


		<section class="bg-gray200 pt-5 pb-5">
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-md-7">
						<article class="card">
							<div style="position: relative;">
								<div>
									<a class="nav-link tenUserOfPost"
										href="${category.user.userName}.htm"><img
										class="rounded-circle mr-2 avatar"
										src="${pageContext.request.contextPath}${category.user.avatar}"
										width="30" height="30"><span
										class="align-middle textUserName">${category.user.firstName}</span></a>
								</div>
								<div class="contentDivPost">${post.contentPost }</div>
								<c:if
									test="${sessionScope.loginSuccess.getUserName().equals(category.user.userName)}">
									<div class="btn-group divChon">


										<!-- Button to Open the Modal -->
										<button type="button" class="btn btn-primary btnChon"
											data-toggle="modal" data-target="#modal-post">
											<i class="fa fa-pencil"></i>
										</button>

										<!-- The Modal -->
										<div class="modal fade" id="modal-post">
											<div class="modal-dialog modal-lg formSuaPost">
												<div class="modal-content">

													<form:form action="post/update/${category.categoryId}/${post.postId}.htm"
														modelAttribute="post" class="suaPost">

														<div class="form-group">
															<label class="label-edit">Nội dung bài viết</label>
															<textarea class="form-control" rows="3" cols="5"
																name="ContentPost">${post.contentPost}</textarea>
														</div>
														<div class="custom-control custom-checkbox mb-3 cmt">
															<input name="OnlyMe" value="true" type="checkbox"
																class="custom-control-input" id="customCheck"> <label
																class="custom-control-label" for="customCheck">Chỉ
																mình tôi</label>
														</div>
														<div>
															<button class="btn btn-primary">SỬA</button>
														</div>

													</form:form>
													<div class="nutXoaPost">
														<a class="btn btn-primary btnXoaNe" href="post/delete/${post.postId}.htm">XÓA</a>
													</div>
												</div>
											</div>


										</div>
									</div>
								</c:if>
							</div>
							<img class="card-img-top mb-2"
								src="${pageContext.request.contextPath}${post.photo}"
								alt="${post.contentPost}">
							<div class="card-body _collapse">
								<div class="_card">
									<c:if test="${userLike.isEmpty() == true}">
										<div class="bieutuong">
											<a
												href="like/insert/${category.categoryId}/${post.postId}.htm"
												class="like"><i class="fa fa-heart"></i></a>
										</div>
									</c:if>
									<c:if test="${userLike.isEmpty() == false}">
										<div class="bieutuong">
											<a
												href="like/delete/${category.categoryId}/${post.postId}.htm"
												class="like"><i class="fa fa-heart"
												style="color: #f34040ed"></i></a>
										</div>
									</c:if>
									<div class=" bieutuong comment" data-toggle="collapse"
										data-target="#demo">
										<i class="fa fa-comments-o" style="font-size: 25px;"></i>

									</div>

									<div class="bieutuong">
										<a href="" class="save"><i class="fa fa-clone"></i></a>
									</div>
								</div>
								<div class="binhluan">${amountLike} yêu thích</div>



								<div id="demo" class="collapse">
									<form
										action="comment/insert/${category.categoryId}/${post.postId}.htm">
										<div class="avaCmt">
											<a href=""></a> <img class="rounded-circle mr-2"
												src="${pageContext.request.contextPath}${sessionScope.loginSuccess.getAvatar()}"
												width="35" height="35">
										</div>
										<div class="form-group input-group inputCmt">
											<input class="form-control" placeholder="Viết bình luận..."
												type="text" name="ContentCmt">
										</div>
										<button class="btn btn-outline-primary btnSend">
											<i class="fa fa-paper-plane"></i>
										</button>
									</form>
								</div>
								<hr>
								<c:forEach var="c" items="${listCmt}">
									<div style="height: 38px; margin-bottom: 10px;">
										<div class="avaCmt">
											<a href="${c.user.userName}.htm"> <img
												class="rounded-circle mr-2"
												src="${pageContext.request.contextPath}${c.user.avatar}"
												width="35" height="35">
											</a>

										</div>
										<div class="contentCmt">
											<a href="${c.user.userName}.htm" class="contentName">${c.user.firstName}</a>
											<div>${c.contentCmt}</div>
											<!-- Button to Open the Modal -->
											<c:if
									test="${sessionScope.loginSuccess.getUserName().equals(c.user.userName) == false}">
											<button type="button" disabled="disabled"
												class="btn btn-primary btnChon btnChon1"
												style="margin-top: 3px;" data-toggle="modal"
												data-target="#modal-comment${c.cmtId}">
												<i class="fa fa-caret-down"></i>
											</button>
											</c:if>
											<c:if
									test="${sessionScope.loginSuccess.getUserName().equals(c.user.userName)}">
											<button type="button"
												class="btn btn-primary btnChon btnChon1"
												style="margin-top: 3px;" data-toggle="modal"
												data-target="#modal-comment${c.cmtId}">
												<i class="fa fa-caret-down"></i>
											</button>
											</c:if>

											<!-- The Modal -->
											<div class="modal fade" id="modal-comment${c.cmtId}">
												<div class="modal-dialog modal-lg formSuaPost">
													<div class="modal-content">

														<form:form action="comment/update/${category.categoryId}/${post.postId}/${c.cmtId}.htm"
														modelAttribute="cmt" class="suaPost">

														<div class="form-group">
															<label class="label-edit">Nội dung bình luận</label>
															<textarea class="form-control" rows="3" cols="5"
																name="ContentComment">${c.contentCmt}</textarea>
														</div>
														<div>
															<button class="btn btn-primary">SỬA</button>
														</div>

													</form:form>
													<div class="nutXoaPost">
														<a class="btn btn-primary btnXoaNe" href="comment/delete/${category.categoryId}/${post.postId}/${c.cmtId}.htm">XÓA</a>
													</div>

													</div>
												</div>


											</div>
										</div>

									</div>
								</c:forEach>
							</div>
						</article>
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