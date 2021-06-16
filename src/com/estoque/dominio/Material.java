package com.estoque.dominio;

public class Material {

	private int id;
	private String descricao;
	private String codigoERP;
	private String partNumber;
	private String fabricante;
	private String maquina;
	private String dimensoes;
	private String posicaoAlmox;
	private Estoque estoque;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getCodigoERP() {
		return codigoERP;
	}

	public void setCodigoERP(String codigoERP) {
		this.codigoERP = codigoERP;
	}

	public String getPartNumber() {
		return partNumber;
	}

	public void setPartNumber(String partNumber) {
		this.partNumber = partNumber;
	}

	public String getFabricante() {
		return fabricante;
	}

	public void setFabricante(String fabricante) {
		this.fabricante = fabricante;
	}

	public String getMaquina() {
		return maquina;
	}

	public void setMaquina(String maquina) {
		this.maquina = maquina;
	}

	public String getDimensoes() {
		return dimensoes;
	}

	public void setDimensoes(String dimensoes) {
		this.dimensoes = dimensoes;
	}

	public String getPosicaoAlmox() {
		return posicaoAlmox;
	}

	public void setPosicaoAlmox(String posicaoAlmox) {
		this.posicaoAlmox = posicaoAlmox;
	}
	
	public Estoque getEstoque() {
		return estoque;
	}
	
	public void setEstoque(Estoque estoque) {
		this.estoque = estoque;
	}

	@Override
	public String toString() {
		return "Material [descricao=" + descricao + ", codigoERP=" + codigoERP + ", partNumber=" + partNumber
				+ ", fabricante=" + fabricante + ", maquina=" + maquina + ", dimensoes=" + dimensoes + ", posicaoAlmox="
				+ posicaoAlmox + "]";
	}
}
