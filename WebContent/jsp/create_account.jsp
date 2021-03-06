<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
	<link href="css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
	<link href="css/WeighterCommonCSS.css" type="text/css" rel="stylesheet"/>
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
  	<script src="js/materialize.js"></script>
  	<script src="js/init.js"></script>

	<title>ユーザー登録</title>

  	<!-- JS -->
	<script  type="text/javascript">

	window.onload = function(){
		//ダイアログ初期化
		Init();
	}

	//初期化
  	function Init(){
  		//ダイアログセット

  		$(document).ready(function(){$("#modal_attention").modal();});
  		$(document).ready(function(){$("#modal_confirm-regist").modal();});
  	}

	//登録ボタンクリック
	function ClickRegist(){

		//入力文字数チェック
		if($("#userName").val().length > 12)
		{
			$("#attention-content").text("ユーザIDの入力文字が12文字を超えています。");
			$("#modal_attention").modal("open");
			return;
		}
		if($("#password").val().length > 255)
		{
			$("#attention-content").text("パスワードは256文字以上の設定はできません。");
			$("#modal_attention").modal("open");
			return;
		}
		//入力文字チェック
		if($("#userName").val().match(/[^a-zA-Z0-9\-\_]/)){
			$("#attention-content").text("ユーザIDに英数文字,_(アンダーバー)、-(ハイフン)以外の文字が使われています。");
			$("#modal_attention").modal("open");
			return;
		}
		if($("#password").val().match(/[^a-zA-Z0-9\-\_]/)){
			$("#attention-content").text("パスワードに英数文字,_(アンダーバー)、-(ハイフン)以外の文字が使われています。");
			$("#modal_attention").modal("open");
			return;
		}

		//ダイアログに入力したユーザIDを表示する
		$("#disp_account").html($("#userName").val());

		//確認ダイアログ
		$("#modal_confirm-regist").modal("open");
	}

	//確認ダイアログにて「はい」ならアカウント作成。
  	function ExequteCreateAccount()
  	{
  		$('#CreateAccount_form').submit();
  	}

	</script>
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
			<div class="row">
					<h5>登録するユーザーID、パスワードを入力してください</h5>
				<p>	英数文字、_(アンダーバー)、-(ハイフン)が使用可能です。<br />ユーザIDは最大12文字まで</p>
			</div>
			<form action="/Weighter/CreateAccount" method="post" id="CreateAccount_form" name="CreateAccount_form">
					<div class="input-field input-text-style  col s12 m8 offset-m2 l6 offset-l3">
						<input class="validate input-font-32px center" type="text" name="userName" id="userName" maxlength="12" />
						<label for="userName" class="input-label">ユーザーID</label>
					</div>
						<div class="row">
							<div class="input-field col s12 m8 offset-m2 l6 offset-l3">
								<input class="validate input-font-32px center" type="password" name="password" id="password" />
								<label for="password" class="input-label">パスワード</label>
							</div>
						</div>
				<div class="row">
					<button class="btn btn-large waves-effect bold button-style" type="button" onclick="ClickRegist();">ユーザーID登録</button>
				</div>
				<input type="hidden" name="loginType" id="loginType" value="0" />
			</form>
			<div class="row">
				<c:if test="${not empty failMsg}">
					<div class="col offset-s2 s8">
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

	<!-- モーダル設定  -->
	<!-- 登録確認 -->
	<div id="modal_confirm-regist" class="modal">
		<div class="modal-content">
			<h3>確認</h3>
			<p>
				ユーザーID:<span id="disp_account"></span>を登録します。<br />
				よろしいですか？
			</p>
		</div>
		<div class="modal-footer">
			<a onClick="return false;" class="modal-action modal-close waves-effect waves-green btn-flat">いいえ</a>
			<a onClick="ExequteCreateAccount();" class="modal-action modal-close waves-effect waves-green btn-flat">はい</a>
		</div>
	</div>

	<!-- 入力内容の注意  -->
	<div id="modal_attention" class="modal">
		<div class="modal-content">
			<h3>注意</h3>
			<p id="attention-content"></p>
		</div>
		<div class="modal-footer">
			<a onClick="return false;" class="modal-action modal-close waves-effect waves-green btn-flat">OK</a>
		</div>
	</div>
</body>
</html>