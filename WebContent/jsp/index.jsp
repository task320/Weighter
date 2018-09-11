<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
	<link href="css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
	<link href="css/WeighterCommonCSS.css" type="text/css" rel="stylesheet"/>
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
	<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
	<script src="js/materialize.js"></script>
	<script src="js/init.js"></script>
	<title>ログイン</title>
</head>
<body>
	<nav>
	  <div class="nav-wrapper">
	    <div class="brand-logo center">Weighter</div>
	  </div>
	</nav>
	<div class="row center title-margin">
		<div class="col s12 m8 offset-m2 l6 offset-l3">
			<div class="card z-depth-2 grey lighten-4">
				<div class="card-content">
					<h5>ユーザーID・パスワードを入力してください</h5>
					<form action="/Weighter/Login" method="post">
						<div class="row">
							<div class="input-field input-text-style col s12 m8 offset-m2 l6 offset-l3">
								<input class="validate input-font-32px center" type="text" name="userName" id="userName" size="30" />
								<label for="userName" class="input-label">ユーザーID</label>
							</div>
						</div>
							<div class="row">
								<div class="input-field col s12 m8 offset-m2 l6 offset-l3">
									<input class="validate input-font-32px center" type="password" name="password" id="password" />
									<label for="password" class="input-label">パスワード</label>
								</div>
							</div>
						<div class="row">
							<button class="btn btn-large waves-effect bold button-style" type="submit">ログイン</button>
						</div>
						<input type="hidden" value="${loginType}" />
					</form>
					<div class="row">
						<c:if test="${not empty failMsg}">
							<div class="col s12">
								<div class="red lighten-1">
									<div class="white-text">
										${failMsg}
									</div>
								</div>
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
		<br />
		<div class="row center">
			<h5>ユーザーIDをお持ちでない方は、<a href="/Weighter/CreateAccount">こちら</a>から登録</h5>
		</div>
</body>
</html>