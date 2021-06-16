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
		<h3 style="margin-top:50px">Saída de Material</h3><hr>
		
		<c:if test="${mensagemSucesso != null}">
		<div class="alert alert-success" role="alert">${mensagemSucesso}</div>
		</c:if>
		
		<c:if test="${mensagemErro != null}">
		<div class="alert alert-danger" role="alert">${mensagemErro}</div>
		</c:if>

		<div class="row">
			<form action="inicial" style="position:relative;float:right">
				<div class="form-group">
					<div class="row">
						<div class="col-md-12">
							<input type="text" name="pesquisar" class="form-control pesquisar-item" size="50"
								placeholder="Pesquisar item para retirada...">
						</div>
					</div>
				</div>
			</form>
		</div>
			
		<div class="row">
			<form id="form-saida" action="saida" method="post">
				<div class="row">
					<div class="form-group col-md-3">
						<label>Descrição</label>
						<input type="text" class="form-control" name="sai_descricao" 
							id="sai_descricao" disabled>
					</div>

					<div class="form-group col-md-3">
						<label>Código</label>
						<input type="text" class="form-control" name="sai_codigo" 
							id="sai_codigo" disabled>
					</div>

					<div class="form-group col-md-3">
						<label>Part Number</label>
						<input type="text" class="form-control" name="sai_number"
							id="sai_number" disabled>
					</div>

					<div class="form-group col-md-3">
						<label>Dimensões</label>
						<input type="text" class="form-control" name="sai_dimensoes"
							id="sai_dimensoes" disabled>
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-4">
						<label>Solicitante</label>
						<input type="text" class="form-control" name="sai_solic" id="sai_solic"
							value="<c:out value='${sessionScope.session_nomeUsuario}' />">
					</div>
					
					<div class="form-group col-md-2">
						<label>Quantidade</label>
						<input type="text" class="form-control" name="sai_qtde"
							id="sai_qtde" onblur="calcula_saida()" onkeypress="return validaNumero(event)">
					</div>

					<div class="form-group col-md-2">
						<label>Finalidade</label>
						<select class="form-control" name="sai_fin">
							<option value="null">Selecione...</option>
							<c:forEach var="option" items="${listaFinalidade}">
								<option value="${option.descricao}">${option}</option>
							</c:forEach>
						</select>
					</div>

					<div class="form-group col-md-4">
						<label>Observação</label>
						<input type="text" class="form-control" name="sai_obs">
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-1">
						<input type="hidden" class="form-control" name="sai_id" 
							id="sai_id">
					</div>

					<div class="form-group col-md-1">
						<input type="hidden" class="form-control" name="sai_total" 
							id="sai_total">
					</div>

					<div class="form-group col-md-1">
						<input type="hidden" class="form-control" name="sai_unit" 
							id="sai_unit">
					</div>
				</div>

				<button type="submit" class="btn btn-primary" name="sai_submit">Cadastrar</button>
				<span style="margin-left:10px"></span>
				<a href="inicial" class="btn btn-warning">Cancelar</a>
			</form>
		</div>
	</div>
	
	<c:import url="../../template/footer.jsp" />
