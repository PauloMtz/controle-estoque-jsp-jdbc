<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="pt-br">
<head>
	<c:import url="../../template/header.jsp" />
</head>
<body>
	<c:import url="../../template/navbar.jsp" />

	<div class="container" style="min-height:630px;margin-top:60px">
		<h3 style="margin-top:50px">Alterar Senha</h3><hr>	
			
		<form action="usuario?acao=altera_senha" method="post">
			<input type="hidden" name="id" value="${dadosUsuario.id}">
			
			<div class="row">
				<div class="form-group col-md-4">
					<label>Nome</label>
					<input type="text" class="form-control" name="nome" disabled
						value="<c:out value='${dadosUsuario.nome}'/>">
				</div>

				<div class="form-group col-md-4">
					<label>Matrícula</label>
					<input type="text" class="form-control" name="matricula" disabled
						value="<c:out value='${dadosUsuario.matricula}'/>">
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-4">
					<label>Senha</label>
					<input type="password" class="form-control" name="senha" required
						value="<c:out value='${dadosUsuario.senha}'/>">
				</div>

				<div class="form-group col-md-4">
					<label>E-mail</label>
					<input type="email" class="form-control" name="email" disabled
						value="<c:out value='${dadosUsuario.email}'/>">
				</div>
			</div><hr>

			<button type="submit" name="submit" class="btn btn-primary">Salvar</button>
			<span style="margin-left:10px"></span>
			<a href="inicial" class="btn btn-warning">Cancelar</a>
		</form>
	</div>
	
	<c:import url="../../template/footer.jsp" />
