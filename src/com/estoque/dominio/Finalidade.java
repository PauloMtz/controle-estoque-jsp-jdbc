package com.estoque.dominio;

public enum Finalidade {

	ORDEM_SERVICO("Ordem de Serviço"),
	TRANSFERENCIA("Transferência"),
	CONSERTO("Manutenção"),
	EMPRESTIMO("Empréstimo");
	
	private String descricao;
	
	private Finalidade(String descricao) {
		this.descricao = descricao;
	}
	
	public String getDescricao() {
		return descricao;
	}
}
