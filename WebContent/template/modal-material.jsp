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
					<form class="form-inline" style="float: right; margin-bottom: 30px">
						<div class="form-group">
							<input type="text" name="pesquisar" class="form-control" size="40"
								placeholder="Pesquisar..." id="pesquisar"> <select
								class="form-control" name="campo" id="campo">
								<option value="null">Selecione...</option>
								<option value="descricao">Descrição</option>
								<option value="codigo_erp">Código ERP</option>
								<option value="part_number">Part Number</option>
								<option value="fabricante">Fabricante</option>
								<option value="maquina">Máquina</option>
								<option value="posicao_almox">Posição Almox</option>
							</select> <input type="submit" id="buscar" value="Buscar Item"
								class="btn btn-default">
						</div>
					</form>
				</div>
	
				<div class="modal-footer" style="margin-top: 50px">
					<button type="button" class="btn btn-primary" data-dismiss="modal">Fechar</button>
				</div>
			</div>
		</div>
	</div>
