// carrega os dados no modal de detalhes do item
$(document).on('click', '#detalhes', function(e) {
	var descricao = $(this).attr("data-descricao");
	var codigo_erp = $(this).attr("data-codigo");
	var part_number = $(this).attr("data-number");
	var fabricante = $(this).attr("data-fab");
	var maquina = $(this).attr("data-maquina");
	var dimensoes = $(this).attr("data-dimensoes");
	var posicao = $(this).attr("data-posicao");
	var qtde = $(this).attr("data-quantidade");
	var unit = $(this).attr("data-unit");
	$('#descricao').val(descricao);
	$('#codigo_erp').val(codigo_erp);
	$('#part_number').val(part_number);
	$('#fabricante').val(fabricante);
	$('#maquina').val(maquina);
	$('#dimensoes').val(dimensoes);
	$('#posicao_almox').val(posicao);
	$('#quantidade').val(qtde);
	$('#custo_unit').val(unit);
});

// carrega dados no campo de pesquisa [ saída e recebimento de itens ]
$('.pesquisar-item').on('keyup', function() {
	var item = $('.pesquisar-item').val();
	console.log('Teste');
	
	$.ajax({
		url: 'listar',
		type: 'get',
		data: {pesquisar: item},
		success: function(dados) {
			console.log(dados);
			
			if ($('.lista-itens').length == 0) {
				$('.pesquisar-item').after('<ul class="nav navbar-nav" style="max-height:0">'
						+ '<li class="dropdown lista-itens"></li></ul>');
			}
			
			var html = '';
			
			$.each(dados, function(i, obj){
				html += '<li><a class="selecionar"'
						+ ' data-id = "' + obj.id + '"'
						+ ' data-descricao = "' + obj.descricao + '"'
						+ ' data-codigo = "' + obj.codigoERP + '"'
						+ ' data-number = "' + obj.partNumber + '"'
						+ ' data-dimensoes = "' + obj.dimensoes + '"'
						+ ' data-unit = "' + obj.estoque.custoUnitario + '"'
						+ ' href="javascript:;" style="color:gray">'
						+ obj.descricao + ' - '
						+ obj.codigoERP + ' - '
						+ obj.dimensoes + '</a></li>';
			})
			
			$('.lista-itens').html(html).show();
		}
	});
});

// envia os dados para o formulário de recebimento
$(document).on('click', '.selecionar', function(e) {

	$('.lista-itens').hide();
	var id = $(this).attr("data-id");
	var descricao = $(this).attr("data-descricao");
	var codigo_erp = $(this).attr("data-codigo");
	var part_number = $(this).attr("data-number");
	var dimensoes = $(this).attr("data-dimensoes");
	$('#rec_id').val(id);
	$('#rec_descricao').val(descricao);
	$('#rec_codigo').val(codigo_erp);
	$('#rec_number').val(part_number);
	$('#rec_dimensoes').val(dimensoes);

	$.ajax({
		type: 'post',
		url: 'receber',
		success: function(data) {
			$('#form-receber').html(data);
		}
	});
});

// envia os dados para o formulário de saída
$(document).on('click', '.selecionar', function(e) {
	
	$('.lista-itens').hide();
	var id = $(this).attr("data-id");
	var descricao = $(this).attr("data-descricao");
	var codigo_erp = $(this).attr("data-codigo");
	var part_number = $(this).attr("data-number");
	var dimensoes = $(this).attr("data-dimensoes");
	var unitario = $(this).attr("data-unit");
	$('#sai_id').val(id);
	$('#sai_descricao').val(descricao);
	$('#sai_codigo').val(codigo_erp);
	$('#sai_number').val(part_number);
	$('#sai_dimensoes').val(dimensoes);
	$('#sai_unit').val(unitario);

	$.ajax({
		type: 'post',
		url: 'saida',
		success: function(data) {
			$('#form-saida').html(data);
		}
	});
});

// calcula valor unitário no recebimento do item
function calcular() {
	var qtde = $("#rec_qtde").val();
	var total = $("#rec_total").val();

	if (qtde == 0) {
		total = 0;
	}
	var unit = total / qtde;
	// carrega o valor no campo
	$("#rec_unit").val(unit);
}

// calcula total na saída do item
function calcula_saida() {
	var qtde = $("#sai_qtde").val();
	var unit = $("#sai_unit").val();
	var total = qtde * unit;
	// carrega o valor no campo
	$("#sai_total").val(total);
}

// valida se o que o usuário digita é número
function validaNumero(evt) {
	var charCode = (evt.which) ? evt.which : evt.keyCode;
	
	if ((charCode >= 48 && charCode <= 57) || charCode <= 31) {
		return true;
	}
	
	return false;
}
