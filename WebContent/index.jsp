<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="pt-br">
<head>
	<c:import url="template/header.jsp" />
</head>
<body>
	<c:import url="template/navbar.jsp" />

	<div class="container" style="min-height:630px;margin-top:60px">
		<h3 style="margin-top:50px">Materiais</h3><hr>
		
		<div class="row">
			<form action="inicial" class="form-inline" style="float:right;margin-bottom:30px">
				<div class="form-group">
					<input type="text" name="pesquisar" class="form-control" size="40"
						placeholder="Pesquisar..."> 
					<select class="form-control" name="campo">
						<option value="null">Selecione...</option>
						<option value="descricao">Descrição</option>
						<option value="codigo_erp">Código</option>
						<option value="part_number">Part Number</option>
						<option value="fabricante">Fabricante</option>
						<option value="maquina">Máquina</option>
						<option value="posicao_almox">Posição Almox</option>
					</select> 
					<input type="submit" value="Buscar" class="btn btn-primary">
				</div>
			</form>
		</div>
		
		<div class="row">
			<span style="float:right"><c:out value="${totalRegistros}"/> registros</span>
		</div><hr>

		<table class="table table-striped" style="border-bottom: 1px solid #ccc">
			<thead>
				<tr>
					<th scope="col">Descrição</th>
					<th scope="col">Código</th>
					<th scope="col">Pos. Almox.</th>
					<th scope="col">Máquina</th>
					<th scope="col">Qtde</th>
					<th scope="col">Valor unit.</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="item" items="${listaItens}">
				<tr>
					<td><c:out value="${item.descricao}" /></td>
					<td><c:out value="${item.codigoERP}" /></td>
					<td><c:out value="${item.posicaoAlmox}" /></td>
					<td><c:out value="${item.maquina}" /></td>
					<td><c:out value="${item.estoque.getQuantidade()}" /></td>
					<td><fmt:setLocale value="pt_BR" />
						<fmt:formatNumber type="currency" 
							value="${item.estoque.getCustoUnitario()}" /></td>
					<td>		
						<c:if test="${session_perfilUsuario == 'admin'}">
						<a href="item?opcao=editar&id=${item.id}"><span>Atualizar</span></a>
						</c:if>
						<span style="margin-left:10px;margin-right:10px"></span>
						<a href="#" data-toggle="modal" data-target="#modalDetalhes">
							<span id="detalhes"
								data-descricao="<c:out value="${item.descricao}" />" 
								data-codigo="<c:out value="${item.codigoERP}" />"
								data-number="<c:out value="${item.partNumber}" />" 
								data-fab="<c:out value="${item.fabricante}" />" 
								data-maquina="<c:out value="${item.maquina}" />"
								data-dimensoes="<c:out value="${item.dimensoes}" />" 
								data-posicao="<c:out value="${item.posicaoAlmox}" />"
								data-quantidade="<c:out value="${item.estoque.getQuantidade()}" />" 
								data-unit="<fmt:formatNumber type="currency" 
									value="${item.estoque.getCustoUnitario()}" />">Detalhes
							</span>
						</a>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>

		<!-- jsp: include page -->
		<jsp:include page="template/paginacao2.jsp" />
		
	</div>

	<!-- modal detalhes -->
	<div class="modal fade" id="modalDetalhes" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title">Mais Informações</h3>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" style="margin-top: -20px">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<table class="table table-bordered" id="tabela-modal" style="margin-top:20px">
						<tr>
							<th>Descrição:</th>
							<td><input id="descricao" disabled class="input-table" size="55"></td>
						</tr>
						<tr>
							<th>Código:</th>
							<td><input id="codigo_erp" disabled class="input-table" size="55"></td>
						</tr>
						<tr>
							<th>Part Number:</th>
							<td><input id="part_number" disabled class="input-table" size="55"></td>
						</tr>
						<tr>
							<th>Fabricante:</th>
							<td><input id="fabricante" disabled class="input-table" size="55"></td>
						</tr>
						<tr>
							<th>Máquina:</th>
							<td><input id="maquina" disabled class="input-table" size="55"></td>
						</tr>
						<tr>
							<th>Dimensões:</th>
							<td><input id="dimensoes" disabled class="input-table" size="55"></td>
						</tr>
						<tr>
							<th>Posição Almox:&nbsp;</th>
							<td><input id="posicao_almox" disabled class="input-table" size="55"></td>
						</tr>
						<tr>
							<th>Quantidade:</th>
							<td><input id="quantidade" disabled class="input-table" size="55"></td>
						</tr>
						<tr>
							<th>Custo Unitário:</th>
							<td><input id="custo_unit" disabled class="input-table" size="55"></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">

					<button type="button" class="btn btn-primary" data-dismiss="modal">Fechar</button>
				</div>
			</div>
		</div>
	</div>

	<c:import url="template/footer.jsp" />
