<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<div class="modal fade" id="modal-material" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title">Selecionar Item</h3>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" style="margin-top: -20px">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">
					<div class="row">
						<form class="form-inline" style="float: right; margin-bottom: 30px">
							<div class="form-group">
								<input type="text" name="pesquisar" class="form-control pesquisar" size="40"
									placeholder="Pesquisar..."> 
								<select class="form-control" name="campo" id="campo">
									<option value="null">Selecione...</option>
									<option value="descricao">Descrição</option>
									<option value="codigo_erp">Código ERP</option>
									<option value="part_number">Part Number</option>
									<option value="fabricante">Fabricante</option>
									<option value="maquina">Máquina</option>
									<option value="posicao_almox">Posição Almox</option>
								</select> 
								<input type="submit" id="buscar" value="Buscar Item" class="btn btn-default">
							</div>
						</form>
					</div>
					
					<div class="row">
						<span style="float:right"><c:out value="${totalRegistros}"/> registros</span>
					</div>
					
					<table class="table table-striped" style="border-bottom:1px solid #ccc">
						<thead>
							<tr>
								<th scope="col">Descrição</th>
								<th scope="col">Cód. ERP</th>
								<th scope="col">Part Number</th>
								<th scope="col">Dimensões</th>
								<th scope="col">Máquina</th>
								<th scope="col"></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item" items="${listaItens}">
							<tr>
								<td><c:out value="${item.descricao}" /></td>
								<td><c:out value="${item.codigoERP}" /></td>
								<td><c:out value="${item.partNumber}" /></td>
								<td><c:out value="${item.dimensoes}" /></td>
								<td><c:out value="${item.maquina}" /></td>
								<td><a href="#modal-material" data-toggle="modal">
										<span class="selecionar" 
											data-id="<c:out value="${item.id}" />" 
											data-descricao="<c:out value="${item.descricao}" />" 
											data-codigo="<c:out value="${item.codigoERP}" />"
											data-number="<c:out value="${item.partNumber}" />" 
											data-fab="<c:out value="${item.fabricante}" />" 
											data-maquina="<c:out value="${item.maquina}" />"
											data-dimensoes="<c:out value="${item.dimensoes}" />" 
											data-posicao="<c:out value="${item.posicaoAlmox}" />"
											data-quantidade="<c:out value="${item.estoque.getQuantidade()}" />" 
											data-unit="<c:out value="${item.estoque.getCustoUnitario()}" />">
											Selecionar
										</span>
									</a>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
	
				<div class="modal-footer" style="margin-top: 50px">
					<button type="button" class="btn btn-primary" data-dismiss="modal">Fechar</button>
				</div>
			</div>
		</div>
	</div>
