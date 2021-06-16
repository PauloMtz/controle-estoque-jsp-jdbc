package com.estoque.db;

public class ConexaoTeste {

	@SuppressWarnings("static-access")
	public static void main(String[] args) {
		
		MysqlConexao con = new MysqlConexao();
		con.getConexao();
	}

}
