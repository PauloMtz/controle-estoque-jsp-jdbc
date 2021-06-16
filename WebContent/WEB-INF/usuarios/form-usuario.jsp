<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="pt-br">
<head>
	<c:import url="../../template/header.jsp" />
</head>
<body>
	<c:import url="../../template/navbar.jsp" />
	
	<c:choose>
	<c:when test="${session_perfilUsuario == 'admin'}">		
	<div class="container" style="min-height:630px;margin-top:60px">
		<h3 style="margin-top:50px">Dados do Usuário</h3><hr>
		
		<c:if test="${mensagemSucesso != null}">
		<div class="alert alert-success" role="alert">${mensagemSucesso}</div>
		</c:if>
		
		<c:if test="${mensagemErro != null}">
		<div class="alert alert-danger" role="alert">${mensagemErro}</div>
		</c:if>	
			
		<form action="usuario" method="post">
			<input type="hidden" name="id" value="${dadosUsuario.id}">
			
			<div class="row">
				<div class="form-group col-md-5">
					<label>Nome</label>
					<input type="text" class="form-control" name="nome" required
						value="<c:out value='${dadosUsuario.nome}'/>">
				</div>

				<div class="form-group col-md-3">
					<label>Perfil</label>
					<select class="form-control" name="perfil">
						<option value="0">Selecione...</option>
						<option value="admin"
							<c:if test="${dadosUsuario.perfil == 'admin'}">selected="selected"</c:if>
							>Admin
						</option>
						<option value="user"
							<c:if test="${dadosUsuario.perfil == 'user'}">selected="selected"</c:if>
							>User
						</option>
					</select>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-4">
					<label>Matrícula</label>
					<c:choose>
					<c:when test="${dadosUsuario.matricula != null}">	
					<input type="text" class="form-control" name="matricula" disabled
						value="<c:out value='${dadosUsuario.matricula}'/>">
					<input type="hidden" name="matricula" value="<c:out value='${dadosUsuario.matricula}'/>">
					</c:when>
					<c:otherwise>
						<input type="text" class="form-control" name="matricula" required>
					</c:otherwise>
					</c:choose>
				</div>

				<div class="form-group col-md-4">
					<label>E-mail</label>
					<input type="email" class="form-control" name="email" required
						value="<c:out value='${dadosUsuario.email}'/>">
				</div>
			</div>

			<div class="checkbox" style="margin-bottom:20px">
			    <label>
			      <input type="checkbox" name="ativo" value="true"
			      	<c:if test="${dadosUsuario.ativo.equals(true)}">checked="checked"</c:if>> Ativo
			    </label>
			</div><hr>
			
			<button type="submit" name="submit" class="btn btn-primary">Salvar</button>
			<span style="margin-left:10px"></span>
			<a href="usuario" class="btn btn-warning">Cancelar</a>
		</form>
	</div>
	</c:when>
	<c:otherwise>
		<script type="text/javascript">
			window.location.href='inicial';
		</script>
	</c:otherwise>
	</c:choose>
	
	<c:import url="../../template/footer.jsp" />
