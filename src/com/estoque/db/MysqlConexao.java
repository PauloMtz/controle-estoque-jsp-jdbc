package com.estoque.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MysqlConexao {

	private static Connection conexao = null;
	private static String user = "root";
	private static String password = "";
	private static String url = 
			"jdbc:mysql://localhost:3306/almox?useTimezone=true&serverTimezone=America/Sao_Paulo&useSSL=false";
			//private static String url = "jdbc:postgresql://localhost:5432/database";
	
	static {
		try {
			conectar();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public MysqlConexao() {
		try {
			conectar();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private static void conectar() throws SQLException {
		
		try {
			if (conexao == null) {
				//Class.forName("org.postgresql.Driver");
				Class.forName("com.mysql.jdbc.Driver");
				conexao = DriverManager.getConnection(url, user, password);
				conexao.setAutoCommit(false);
				//System.out.println("MYSQL: Conectado com sucesso!");
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getConexao() {
		return conexao;
	}
}
