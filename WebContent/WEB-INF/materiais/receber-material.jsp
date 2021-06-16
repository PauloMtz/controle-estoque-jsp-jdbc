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
		<h3 style="margin-top: 50px">Recebimento de Material</h3><hr>
		
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
								placeholder="Pesquisar item para recebimento...">
						</div>
					</div>
				</div>
			</form>
		</div>

		<div class="row">
			<form id="form-receber" action="receber" method="post">
				<div class="row">
					<div class="form-group col-md-3">
						<label>Descrição</label>
						<input type="text" class="form-control"
							name="rec_descricao" id="rec_descricao" disabled>
					</div>

					<div class="form-group col-md-3">
						<label>Código ERP</label> 
						<input type="text" class="form-control"
							name="rec_codigo" id="rec_codigo" disabled>
					</div>

					<div class="form-group col-md-3">
						<label>Part Number</label> 
						<input type="text" class="form-control" name="rec_number" 
							id="rec_number" disabled>
					</div>

					<div class="form-group col-md-3">
						<label>Dimensões</label> 
						<input type="text" class="form-control"
							name="rec_dimensoes" id="rec_dimensoes" disabled>
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-6">
						<label>Fornecedor</label> 
						<input type="text" class="form-control" name="rec_fornecedor">
					</div>

					<div class="form-group col-md-6">
						<label>Contrato</label> 
						<input type="text" class="form-control" name="rec_contrato">
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-3">
						<label>Quantidade</label> 
						<input type="text" class="form-control" name="rec_qtde" id="rec_qtde"
							onkeypress="return validaNumero(event)">
					</div>

					<div class="form-group col-md-3">
						<label>Valor Total</label> 
						<input type="text" class="form-control" name="rec_total" id="rec_total"
							onblur="calcular()">
					</div>

					<div class="form-group col-md-3">
						<input type="hidden" class="form-control" name="rec_unit" id="rec_unit">
					</div>

					<div class="form-group col-md-3">
						<input type="hidden" class="form-control" name="rec_id" id="rec_id">
					</div>
				</div>

				<button type="submit" name="rec_submit" class="btn btn-primary">Receber Item</button>
				<span style="margin-left:10px"></span>
				<a href="inicial" class="btn btn-warning">Cancelar</a>
			</form>
		</div>
	</div>
	
	</c:when>
	<c:otherwise>
		<script type="text/javascript">
			window.location.href='inicial';
		</script>
	</c:otherwise>
	</c:choose>
	
	<c:import url="../../template/footer.jsp" />
