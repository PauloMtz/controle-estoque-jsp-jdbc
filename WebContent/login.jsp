<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<title>Controle de Estoque</title>
	<link rel="stylesheet" type="text/css" href="resources/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="resources/css/estilo.css">
	<link rel="icon" type="image/png" href="resources/img/favicon.png">
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top" style="min-height: 70px">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
					data-target="#navbar" aria-expanded="false" aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> 
					<span class="icon-bar"></span> 
					<span class="icon-bar"></span> 
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.php"> 
					<img src="resources/img/logo.png">
				</a>
			</div>
		</div>
	</nav>

	<div class="container col-md-offset-3" style="min-height: 500px; margin-top: 120px">
		<div class="row">
			<div class="col-md-6">
				<h3 align="center">Login</h3><hr>
			</div>
		</div>
		
		<div class="col-md-6">
			<c:if test="${mensagemErro != null}">
				<div class="alert alert-danger" role="alert">${mensagemErro}</div>
			</c:if>

			<form action="login" method="post">
				<div class="form-group">
					<label>Matrícula</label> 
					<input type="text" class="form-control" name="matricula" required>
				</div>
				<div class="form-group">
					<label>Senha</label> 
					<input type="password" class="form-control" name="senha" required>
				</div>
				<button type="submit" class="btn btn-primary" style="width: 140px">Entrar</button>
			</form>
		</div>
	</div>

	<div class="container-fluid" align="center">
		<footer class="footer" style="border-top: 1px solid #ccc">
			<small>&copy; Direitos Reservados - 2021</small>
		</footer>
	</div>

</body>
</html>
