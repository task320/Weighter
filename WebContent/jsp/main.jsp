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

	<title>Weighter</title>

  	<!-- JS -->
	<script  type="text/javascript">
  	function Init(){
  		//体重上書き確認用ダイアログセット
  		$(document).ready(function(){$("#modal_confirm-update").modal();});
  	}

  	//体重上書き確認
  	function ConfirmUpdateWeight(){
  		//体重登録済みであれば、上書き確認を行う
  		if($("#registFlg").val() == 1){
  				//上書き確認を行う
  				$("#modal_confirm-update").modal("open");
  			}
  		else{
  				SubmitForm();
  			}
  	}

	//上書き確認ダイアログにて「はい」なら体重の上書きを実行する。
  	function ExequteUpdate(){
  		SubmitForm();
  	}

	//フォームを送信する。
	function SubmitForm(){
		//$('#weightData').submit()
		document.weightData.submit();
	}

  	//初期化
  	Init();
  </script>
</head>
<body>
	<div id="header">
		<nav>
		  <div class="nav-wrapper">
		    <div class="brand-logo center">Weighter</div>
		  </div>
		</nav>
	</div>
	<div id="content">
		<div class="row center">
			<div class="col s12 m10 offset-m1 l10 offset-l1">
				<div class="card">
					<div class="card-content">
						<span class="card-title">今日の体重</span><br />
						<H2>${todayWeight}</H2>
					</div>
					<div class="card-action">
						<form onsubmit="return false;" action="/Weighter/Main" method = "post" id="weightData" name="weightData">
							<div class="row"></div>
							<div class="row">
								<div class="input-field col s8 offset-s2">
									<input type="text"  id="weight" name="weight" class="validate input-font-32px center">
									<label for="weight" class="input-label">体重(Kg)</label>
								</div>
							</div>
							<input type="hidden" id="registFlg" name="registFlg" value="${registFlg}">
							<button class="btn waves-effect waves-light" type="button" onclick="ConfirmUpdateWeight();"><i class="material-icons left medium">mode_edit</i>記録</button>
						</form>
						<div class="row">
							<c:if test="${not empty failMsg}">
								<div class="col offset-s2 s8">
									<div class="red lighten-1">
										<div class="white-text">
											<p>${failMsg}</p>
										</div>
									</div>
								</div>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
			<div class="row center">
				<div class="col s12 m10 offset-m1 l10 offset-l1">
					<div class="card">
						<div class="card-content">
							<span class="card-title"><h4>過去30日分の体重</h4></span>
							<div class="row">
								<div class="col s12 m10 offset-m1 l10 offset-l1">
								<table class="bordered striped centered weight-data">
									<thead>
										<tr><th>日付</th><th>体重(Kg)</th></tr>
									</thead>
									<tbody>
										<c:forEach var="weightData" items="${past30Days}" varStatus="status">
											<tr><td><c:out value="${weightData.GetDataFormat1()}"/></td><td><c:out value="${weightData.GetDisplayWeight()}"/></td></tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	<!-- モーダル設定  -->
	<div id="modal_confirm-update" class="modal">
		<div class="modal-content">
			<h3>確認</h3>
			<p>
				すでに今日の体重は登録されています。<br />
				上書きしますか?
			</p>
		</div>
		<div class="modal-footer">
			<a onClick="return false;" class="modal-action modal-close waves-effect waves-green btn-flat">いいえ</a>
			<a onClick="ExequteUpdate();" class="modal-action modal-close waves-effect waves-green btn-flat">はい</a>
		</div>
	</div>
</body>
</html>