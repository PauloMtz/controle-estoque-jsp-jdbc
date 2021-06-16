package com.estoque.dominio;

public enum Maquina {

	Crisplant("Crisplant"),
	Crossbelt("Crossbelt"),
	DBCS("DBCS"),
	OVIS("OVIS");
	
	private String descricao;
	
	private Maquina(String descricao) {
		this.descricao = descricao;
	}
	
	public String getDescricao() {
		return descricao;
	}
}
