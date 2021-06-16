package com.estoque.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.estoque.db.MysqlConexao;
import com.estoque.dominio.Estoque;
import com.estoque.dominio.Material;

public class MaterialDao {
	
	private Connection conn;
	private PreparedStatement pstm;
	private ResultSet rs;
	
	// utilizado na paginação
	private int registros;

	public MaterialDao() {
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
	
	public List<Material> listar(int inicio, int registros) {
		
		List<Material> lista = new ArrayList<>();
		
		String sql = "select SQL_CALC_FOUND_ROWS * from itens left join estoque on itens.id_item = estoque.item_id"
				+ " order by descricao limit ?, ?";
		
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, inicio);
			pstm.setInt(2, registros);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				Material m = new Material();
				Estoque e = new Estoque();
				
				m.setId(rs.getInt("id_item"));
				m.setDescricao(rs.getString("descricao"));
				m.setCodigoERP(rs.getString("codigo_erp"));
				m.setPartNumber(rs.getString("part_number"));
				m.setFabricante(rs.getString("fabricante"));
				m.setMaquina(rs.getString("maquina"));
				m.setDimensoes(rs.getString("dimensoes"));
				m.setPosicaoAlmox(rs.getString("posicao_almox"));
				
				e.setQuantidade(rs.getInt("quantidade"));
				e.setCustoUnitario(rs.getDouble("custo_unitario"));
				m.setEstoque(e);
				
				lista.add(m);
			}
			
			rs.close();
			rs = pstm.executeQuery("select FOUND_ROWS()");
			
			if (rs.next()) {
				this.registros = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return lista;
	}
	
	public List<Material> pesquisar(String campo, String pesquisa, int inicio, int registros) {
		
		List<Material> lista = new ArrayList<>();
		
		String sql = "select SQL_CALC_FOUND_ROWS * from itens left join estoque"
				+ " on itens.id_item = estoque.item_id"
				+ " where " + campo + " like '%" + pesquisa + "%'"
				+ " order by descricao limit ?, ?";
		
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, inicio);
			pstm.setInt(2, registros);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				Material m = new Material();
				Estoque e = new Estoque();
				
				// material
				m.setId(rs.getInt("id_item"));
				m.setDescricao(rs.getString("descricao"));
				m.setCodigoERP(rs.getString("codigo_erp"));
				m.setPartNumber(rs.getString("part_number"));
				m.setFabricante(rs.getString("fabricante"));
				m.setMaquina(rs.getString("maquina"));
				m.setDimensoes(rs.getString("dimensoes"));
				m.setPosicaoAlmox(rs.getString("posicao_almox"));
				
				// estoque
				e.setQuantidade(rs.getInt("quantidade"));
				e.setCustoUnitario(rs.getDouble("custo_unitario"));
				m.setEstoque(e);
				
				lista.add(m);
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
	
	public List<Material> buscarItem(String pesquisa) {
		
		List<Material> lista = new ArrayList<>();
		
		String sql = "select * from itens left join estoque"
				+ " on itens.id_item = estoque.item_id"
				+ " where itens.descricao like '%" + pesquisa + "%'"
				+ " order by descricao";
		
		try {
			pstm = conn.prepareStatement(sql);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				Material m = new Material();
				Estoque e = new Estoque();
				
				// material
				m.setId(rs.getInt("id_item"));
				m.setDescricao(rs.getString("descricao"));
				m.setCodigoERP(rs.getString("codigo_erp"));
				m.setPartNumber(rs.getString("part_number"));
				m.setFabricante(rs.getString("fabricante"));
				m.setMaquina(rs.getString("maquina"));
				m.setDimensoes(rs.getString("dimensoes"));
				m.setPosicaoAlmox(rs.getString("posicao_almox"));
				
				// estoque
				e.setQuantidade(rs.getInt("quantidade"));
				e.setCustoUnitario(rs.getDouble("custo_unitario"));
				m.setEstoque(e);
				
				lista.add(m);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lista;
	}
	
	public void inserir(Material m) {
		
		try {
			String sql = "insert into itens (descricao, codigo_erp, part_number, fabricante, maquina,"
					+ " dimensoes, posicao_almox) values (?, ?, ?, ?, ?, ?, ?)";
			
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, m.getDescricao());
			pstm.setString(2, m.getCodigoERP());
			pstm.setString(3, m.getPartNumber());
			pstm.setString(4, m.getFabricante());
			pstm.setString(5, m.getMaquina());
			pstm.setString(6, m.getDimensoes());
			pstm.setString(7, m.getPosicaoAlmox());
			
			pstm.execute();
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
	
	public void atualizar(Material m) {
		
		try {
			String sql = "update itens set descricao = ?, codigo_erp = ?, part_number = ?,"
					+ " fabricante = ?, maquina = ?, dimensoes = ?, posicao_almox = ?"
					+ " where id_item = ?";
			
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, m.getDescricao());
			pstm.setString(2, m.getCodigoERP());
			pstm.setString(3, m.getPartNumber());
			pstm.setString(4, m.getFabricante());
			pstm.setString(5, m.getMaquina());
			pstm.setString(6, m.getDimensoes());
			pstm.setString(7, m.getPosicaoAlmox());
			pstm.setInt(8, m.getId());
			
			pstm.execute();
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
	
	public Material buscarPorId(int id) {
		
		Material m = new Material();
		
		String sql = "select * from itens where id_item = ?";
		
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, id);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				m.setId(rs.getInt("id_item"));
				m.setDescricao(rs.getString("descricao"));
				m.setCodigoERP(rs.getString("codigo_erp"));
				m.setPartNumber(rs.getString("part_number"));
				m.setFabricante(rs.getString("fabricante"));
				m.setMaquina(rs.getString("maquina"));
				m.setDimensoes(rs.getString("dimensoes"));
				m.setPosicaoAlmox(rs.getString("posicao_almox"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return m;
	}
}
