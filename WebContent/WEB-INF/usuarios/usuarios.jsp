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
	<div class="container" style="min-height: 630px; margin-top: 60px">
		<h3 style="margin-top: 50px">Usuários</h3><hr>
		
		<c:if test="${mensagemSucesso != null}">
		<div class="alert alert-success" role="alert">${mensagemSucesso}</div>
		</c:if>
		
		<c:if test="${mensagemErro != null}">
		<div class="alert alert-danger" role="alert">${mensagemErro}</div>
		</c:if>
		
		<div class="row">
			<form action="usuario" class="form-inline" style="float: right; margin-bottom: 30px">
				<div class="form-group">
					<input type="text" name="pesquisar" class="form-control" size="40"
						placeholder="Pesquisar..."> <select class="form-control"
						name="campo">
						<option value="null">Selecione...</option>
						<option value="nome">Nome</option>
						<option value="email">E-mail</option>
						<option value="matricula">Matrícula</option>
					</select> <input type="submit" value="Buscar" class="btn btn-primary">
				</div>
			</form>
		</div>
		
		<div class="row">
			<span style="float:right"><c:out value="${totalRegistros}"/> registros</span>
		</div>
		
		<table class="table table-striped"
			style="border-bottom: 1px solid #ccc">
			<thead>
				<tr>
					<th scope="col">Nome</th>
					<th scope="col">Matrícula</th>
					<th scope="col">E-mail</th>
					<th scope="col">Ativo</th>
					<th colspan="2"></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="u" items="${lista}">
				<tr>
					<td><c:out value="${u.nome}" /></td>
					<td><c:out value="${u.matricula}" /></td>
					<td><c:out value="${u.email}" /></td>
					<td>${u.ativo == true ? 'S' : 'N'}</td>
					<td>
						<a href="usuario?acao=editar&id=<c:out value="${u.id}" />"> 
							<img src="resources/img/edit.png" alt="editar" title="Editar">
						</a>
					</td>
					<td>
						<a href="usuario?acao=excluir&id=<c:out value="${u.id}" />"
							onclick="return confirm('Deseja realmente excluir esse registro?')"> 
							<img src="resources/img/remove.png" alt="excluir" title="Excluir">
						</a>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<!-- jsp: include page -->
		<jsp:include page="../../template/paginacao2.jsp" />
		
	</div>
	</c:when>
	<c:otherwise>
		<script type="text/javascript">
			window.location.href='inicial';
		</script>
	</c:otherwise>
	</c:choose>

	<!-- c: import url -->
	<c:import url="../../template/footer.jsp" />
