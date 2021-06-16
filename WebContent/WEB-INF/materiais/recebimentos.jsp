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

	<div class="container" style="min-height: 630px; margin-top: 60px">
		<h3 style="margin-top: 50px">Recebimentos</h3><hr>
		
		<div class="row">
			<form class="form-inline" style="float: right; margin-bottom: 30px">
				<div class="form-group">
					<input type="text" name="pesquisar" class="form-control" size="40"
						placeholder="Pesquisar..."> 
					<select class="form-control" name="campo">
						<option value="null">Selecione...</option>
						<option value="descricao">Item</option>
						<option value="codigo_erp">Código</option>
						<option value="part_number">Part Number</option>
						<option value="fornecedor">Fornecedor</option>
						<option value="maquina">Contrato</option>
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
					<th scope="col">Item</th>
					<th scope="col">Código</th>
					<th scope="col">Part Number</th>
					<th scope="col">Fornecedor</th>
					<th scope="col">Contrato</th>
					<th scope="col" style="text-align: center">Quantidade</th>
					<th scope="col">Valor Total</th>
					<th scope="col">Data</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="item" items="${listaRecebimentos}">
				<tr>
					<td><c:out value="${item.material.getDescricao()}" /></td>
					<td><c:out value="${item.material.getCodigoERP()}" /></td>
					<td><c:out value="${item.material.getPartNumber()}" /></td>
					<td><c:out value="${item.fornecedor}" /></td>
					<td><c:out value="${item.contrato}" /></td>
					<td align="center"><c:out value="${item.quantidade}" /></td>
					<td>
						<fmt:setLocale value="pt_BR" />
						<fmt:formatNumber type="currency" value="${item.valorTotal}" />
					</td>
					<td><fmt:formatDate value="${item.dataEntrada}" pattern="dd/MM/yyyy" /></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>

		<!-- jsp: include page -->
		<jsp:include page="../../template/paginacao2.jsp" />
		
	</div>

	<c:import url="../../template/footer.jsp" />
