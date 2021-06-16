package com.estoque.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.estoque.db.MysqlConexao;
import com.estoque.dominio.Usuario;

public class UsuarioDao {

	private Connection conn;
	private PreparedStatement pstm;
	private ResultSet rs;
	
	// utilizado na paginação
	private int registros;

	public UsuarioDao() {
		conn = MysqlConexao.getConexao();
	}
	
	// utilizado na paginação
	public int getRegistros() {
		return registros;
	}
	
	/*
	
	execute -> Executa qualquer tipo de instrução SQL, seja um SELECT, UPDATE, INSERT, DELETE;

	executeQuery -> Executa uma instrução sql SELECT, no entanto diferente da execute onde era 
					necessário executar o comando statement.getResultSet() ou 
					preparedStatement.getResultSet() a mesma já retorna o ResultSet;

	executeUpdate -> Executa operações como INSERT, UPDATE, DELETE, no entanto nesta operação 
					temos como retorno o numero de linhas afetadas, não sendo necessário executar 
					o comando statement.getUpdateCount();
	
	Fonte: https://cursos.alura.com.br/forum/topico-execute-vs-executequery-vs-executeupdate-45673
	
	*/
	
	public List<Usuario> listarTodos(int inicio, int registros) {
		
		List<Usuario> lista = new ArrayList<>();
		
		String sql = "select SQL_CALC_FOUND_ROWS * from usuarios_java order by ativo desc, nome limit ?, ?";
		
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, inicio);
			pstm.setInt(2, registros);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				Usuario u = new Usuario();
				u.setId(rs.getInt("id"));
				u.setNome(rs.getString("nome"));
				u.setMatricula(rs.getString("matricula"));
				u.setEmail(rs.getString("email"));
				u.setAtivo(rs.getBoolean("ativo"));
				
				lista.add(u);
			}
			
			rs.close();
			rs = pstm.executeQuery("select FOUND_ROWS()");
			
			if (rs.next()) {
				this.registros = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lista;
	}
	
	public boolean inserir(Usuario u) throws Exception {
		
		String sql = "insert into usuarios_java (nome, matricula, email, senha,"
					+ " perfil, ativo) values (?, ?, ?, ?, ?, ?)";
		
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, u.getNome());
			pstm.setString(2, u.getMatricula());
			pstm.setString(3, u.getEmail());
			pstm.setString(4, u.getSenha());
			pstm.setString(5, u.getPerfil());
			pstm.setBoolean(6, u.getAtivo());
			
			pstm.execute();
			conn.commit();
			
			return true;
		} catch (SQLException e) {
			conn.rollback();
			e.printStackTrace();
		}
		
		return false;
	}
	
	public Usuario buscarPorId(int id) {
		
		Usuario u = new Usuario();
		String sql = "select * from usuarios_java where id = ?";
		
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, id);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				u.setId(rs.getInt("id"));
				u.setNome(rs.getString("nome"));
				u.setEmail(rs.getString("email"));
				u.setSenha(rs.getString("senha"));
				u.setMatricula(rs.getString("matricula"));
				u.setPerfil(rs.getString("perfil"));
				u.setAtivo(rs.getBoolean("ativo"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return u;
	}
	
	public Usuario buscarUsuario(String matricula, String senha) {
		
		Usuario u = new Usuario();
		
		String sql = "select * from usuarios_java where matricula = ? and senha = ?";
		
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, matricula);
			pstm.setString(2, senha);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				u.setId(rs.getInt("id"));
				u.setNome(rs.getString("nome"));
				u.setMatricula(rs.getString("matricula"));
				u.setEmail(rs.getString("email"));
				u.setSenha(rs.getString("senha"));
				u.setPerfil(rs.getString("perfil"));
				u.setAtivo(rs.getBoolean("ativo"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return u;
	}
	
	public List<Usuario> pesquisarUsuario(String campo, String pesquisa, int inicio, int registros) {
		
		List<Usuario> lista = new ArrayList<>();
		
		String sql = "select SQL_CALC_FOUND_ROWS * from usuarios_java"
					+ " where " + campo + " like '%" + pesquisa + "%'"
					+ " limit ?, ?";
		
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, inicio);
			pstm.setInt(2, registros);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				Usuario u = new Usuario();
				u.setId(rs.getInt("id"));
				u.setNome(rs.getString("nome"));
				u.setMatricula(rs.getString("matricula"));
				u.setEmail(rs.getString("email"));
				u.setSenha(rs.getString("senha"));
				u.setPerfil(rs.getString("perfil"));
				u.setAtivo(rs.getBoolean("ativo"));
				
				lista.add(u);
			}
			
			rs.close();
			rs = pstm.executeQuery("select FOUND_ROWS()");
			
			if (rs.next()) {
				this.registros = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lista;
	}
	
	public void atualizar(Usuario u) throws Exception {
		
		String sql = "update usuarios_java set nome = ?, matricula = ?, email = ?,"
					+ " perfil = ?, ativo = ? where id = ?";
		
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, u.getNome());
			pstm.setString(2, u.getMatricula());
			pstm.setString(3, u.getEmail());
			pstm.setString(4, u.getPerfil());
			pstm.setBoolean(5, u.getAtivo());
			pstm.setInt(6, u.getId());
			
			pstm.execute();
			conn.commit();
		} catch (SQLException e) {
			conn.rollback();
			e.printStackTrace();
		}
	}
	
	public void alterarSenha(Usuario u) throws Exception {
		
		String sql = "update usuarios_java set senha = ? where id = ?";
		
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, u.getSenha());
			pstm.setInt(2, u.getId());
			
			pstm.execute();
			conn.commit();
		} catch (SQLException e) {
			conn.rollback();
			e.printStackTrace();
		}
	}
	
	public void excluir(int id) {
		
		String sql = "delete from usuarios_java where id = ?";
		
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, id);
			pstm.executeUpdate();
			conn.commit();
		} catch (SQLException e) {
			
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
			e.printStackTrace();
		}
	}
}
