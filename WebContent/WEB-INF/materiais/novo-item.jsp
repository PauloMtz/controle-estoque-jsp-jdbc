<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="pt-br">
<head>
	<c:import url="../../template/header.jsp" />
</head>
<body>
	<c:import url="../../template/navbar.jsp" />
	
	<c:choose>
	<c:when test="${session_perfilUsuario == 'admin'}">	
	<div class="container" style="min-height:630px;margin-top:60px">
		<h3 style="margin-top:50px">Cadastro Item</h3><hr>
		
		<c:if test="${mensagemSucesso != null}">
		<div class="alert alert-success" role="alert">${mensagemSucesso}</div>
		</c:if>
		
		<c:if test="${mensagemErro != null}">
		<div class="alert alert-danger" role="alert">${mensagemErro}</div>
		</c:if>
		
		<form action="item" method="post">
			<div class="row">
				<div class="form-group col-md-4">
					<label>Descrição</label>
					<input type="text" class="form-control" name="descricao" required
						value="<c:out value='${dadosItem.descricao}'/>" />
				</div>

				<div class="form-group col-md-4">
					<label>Part Number</label>
					<input type="text" class="form-control" name="part-number"
						value="<c:out value='${dadosItem.partNumber}'/>">
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-2">
					<label>Código ERP</label>
					<input type="text" class="form-control" name="cod-erp" required
						value="<c:out value='${dadosItem.codigoERP}'/>">
				</div>

				<div class="form-group col-md-3">
					<label>Dimensões</label>
					<input type="text" class="form-control" name="dimensoes"
						value="<c:out value='${dadosItem.dimensoes}'/>">
				</div>

				<div class="form-group col-md-3">
					<label>Posição Almox</label>
					<input type="text" class="form-control" name="posicao"
						value="<c:out value='${dadosItem.posicaoAlmox}'/>">
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-4">
					<label>Máquina</label>
					<select class="form-control" name="maquina">
						<option value="0">Selecione...</option>
						<c:forEach var="option" items="${listaMaquinas}">
							<option value="${option}" 
								<c:if test="${option == dadosItem.maquina}">selected="selected"</c:if> 
								>${option.descricao}</option>
						</c:forEach>
					</select>
				</div>

				<div class="form-group col-md-4">
					<label>Fabricante</label>
					<input type="text" class="form-control" name="fabricante"
						value="<c:out value='${dadosItem.fabricante}'/>">
				</div>
			</div>

			<input type="hidden" name="id" value="<c:out value='${dadosItem.id}'/>">
			<button type="submit" class="btn btn-primary" name="submit">Salvar</button>
			<a href="inicial" class="btn btn-warning">Cancelar</a>
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
