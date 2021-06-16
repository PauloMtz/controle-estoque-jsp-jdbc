package com.estoque.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.estoque.db.MysqlConexao;
import com.estoque.dominio.EntradaEstoque;
import com.estoque.dominio.Estoque;
import com.estoque.dominio.Material;
import com.estoque.dominio.SaidaEstoque;

public class OperacoesEstoqueDao {

	private Connection conn;
	private PreparedStatement pstm;
	private ResultSet rs;
	
	// utilizado na paginação
	private int registros;

	public OperacoesEstoqueDao() {
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
	
	public List<EntradaEstoque> listaRecebimentos(int inicio, int registros) {
		
		List<EntradaEstoque> lista = new ArrayList<>();
		
		String sql = "select SQL_CALC_FOUND_ROWS * from entrada_item left join itens"
				+ " on entrada_item.item_id = itens.id_item"
				+ " order by data_recebimento desc limit ?, ?";
		
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, inicio);
			pstm.setInt(2, registros);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				EntradaEstoque e = new EntradaEstoque();
				Material m = new Material();
				
				// entrada estoque
				e.setId(rs.getInt("id_entrada"));
				e.setItem(rs.getInt("item_id"));
				e.setFornecedor(rs.getString("fornecedor"));
				e.setContrato(rs.getString("contrato"));
				e.setQuantidade(rs.getInt("quantidade"));
				e.setValorTotal(rs.getDouble("valor_total"));
				e.setCustoUnitario(rs.getDouble("custo_unitario"));
				e.setDataEntrada(rs.getDate("data_recebimento"));
				
				// material
				m.setId(rs.getInt("id_item"));
				m.setDescricao(rs.getString("descricao"));
				m.setCodigoERP(rs.getString("codigo_erp"));
				m.setPartNumber(rs.getString("part_number"));
				m.setFabricante(rs.getString("fabricante"));
				m.setMaquina(rs.getString("maquina"));
				m.setDimensoes(rs.getString("dimensoes"));
				m.setPosicaoAlmox(rs.getString("posicao_almox"));
				
				e.setMaterial(m);
				lista.add(e);
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
	
	public List<EntradaEstoque> pesquisarEntrada(String campo, String pesquisa, int inicio, int registros) {
		
		List<EntradaEstoque> lista = new ArrayList<>();
		
		String sql = "select SQL_CALC_FOUND_ROWS * from entrada_item left join itens"
				+ " on entrada_item.item_id = itens.id_item"
				+ " where " + campo + " like '%" + pesquisa + "%'"
				+ " order by data_recebimento desc limit ?, ?";
		
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, inicio);
			pstm.setInt(2, registros);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				EntradaEstoque e = new EntradaEstoque();
				Material m = new Material();
				
				// entrada estoque
				e.setId(rs.getInt("id_entrada"));
				e.setItem(rs.getInt("item_id"));
				e.setFornecedor(rs.getString("fornecedor"));
				e.setContrato(rs.getString("contrato"));
				e.setQuantidade(rs.getInt("quantidade"));
				e.setValorTotal(rs.getDouble("valor_total"));
				e.setCustoUnitario(rs.getDouble("custo_unitario"));
				e.setDataEntrada(rs.getDate("data_recebimento"));
				
				// material
				m.setId(rs.getInt("id_item"));
				m.setDescricao(rs.getString("descricao"));
				m.setCodigoERP(rs.getString("codigo_erp"));
				m.setPartNumber(rs.getString("part_number"));
				m.setFabricante(rs.getString("fabricante"));
				m.setMaquina(rs.getString("maquina"));
				m.setDimensoes(rs.getString("dimensoes"));
				m.setPosicaoAlmox(rs.getString("posicao_almox"));
				
				e.setMaterial(m);
				lista.add(e);
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
	
	public List<SaidaEstoque> listaSaidas(int inicio, int registros) {
		
		List<SaidaEstoque> lista = new ArrayList<>();
		
		String sql = "select SQL_CALC_FOUND_ROWS * from saida_item left join itens"
				+ " on saida_item.item_id = itens.id_item"
				+ " order by data_saida desc limit ?, ?";
		
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, inicio);
			pstm.setInt(2, registros);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				SaidaEstoque s = new SaidaEstoque();
				Material m = new Material();
				
				// saida estoque
				s.setId(rs.getInt("id_saida"));
				s.setItem(rs.getInt("item_id"));
				s.setSolicitante(rs.getString("solicitante"));
				s.setQuantidade(rs.getInt("quantidade"));
				s.setFinalidade(rs.getString("finalidade"));
				s.setValorTotal(rs.getDouble("valor_total"));
				s.setCustoUnitario(rs.getDouble("custo_unitario"));
				s.setObservacao(rs.getString("observacao"));
				s.setDataSaida(rs.getDate("data_saida"));
				
				// material
				m.setId(rs.getInt("id_item"));
				m.setDescricao(rs.getString("descricao"));
				m.setCodigoERP(rs.getString("codigo_erp"));
				m.setPartNumber(rs.getString("part_number"));
				m.setFabricante(rs.getString("fabricante"));
				m.setMaquina(rs.getString("maquina"));
				m.setDimensoes(rs.getString("dimensoes"));
				m.setPosicaoAlmox(rs.getString("posicao_almox"));
				
				s.setMaterial(m);
				lista.add(s);
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

	public List<SaidaEstoque> pesquisarSaida(String campo, String pesquisar, int inicio, int registros) {
		
		List<SaidaEstoque> lista = new ArrayList<>();
		
		String sql = "select SQL_CALC_FOUND_ROWS * from saida_item left join itens"
				+ " on saida_item.item_id = itens.id_item"
				+ " where " + campo + " like '%" + pesquisar + "%'"
				+ " order by data_saida desc limit ?, ?";
		
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, inicio);
			pstm.setInt(2, registros);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				SaidaEstoque s = new SaidaEstoque();
				Material m = new Material();
				
				// saida estoque
				s.setId(rs.getInt("id_saida"));
				s.setItem(rs.getInt("item_id"));
				s.setSolicitante(rs.getString("solicitante"));
				s.setQuantidade(rs.getInt("quantidade"));
				s.setFinalidade(rs.getString("finalidade"));
				s.setValorTotal(rs.getDouble("valor_total"));
				s.setCustoUnitario(rs.getDouble("custo_unitario"));
				s.setObservacao(rs.getString("observacao"));
				s.setDataSaida(rs.getDate("data_saida"));
				
				// material
				m.setId(rs.getInt("id_item"));
				m.setDescricao(rs.getString("descricao"));
				m.setCodigoERP(rs.getString("codigo_erp"));
				m.setPartNumber(rs.getString("part_number"));
				m.setFabricante(rs.getString("fabricante"));
				m.setMaquina(rs.getString("maquina"));
				m.setDimensoes(rs.getString("dimensoes"));
				m.setPosicaoAlmox(rs.getString("posicao_almox"));
				
				s.setMaterial(m);
				lista.add(s);
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
	
	public void cadastrarEntrada(EntradaEstoque entrada) {
		
		try {
			String sql = "insert into entrada_item (fornecedor, contrato, quantidade, valor_total,"
					+ " custo_unitario, item_id) values (?, ?, ?, ?, ?, ?)";
			
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, entrada.getFornecedor());
			pstm.setString(2, entrada.getContrato());
			pstm.setInt(3, entrada.getQuantidade());
			pstm.setDouble(4, entrada.getValorTotal());
			pstm.setDouble(5, entrada.getCustoUnitario());
			pstm.setInt(6, entrada.getItem());
			
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
	
	public void cadastrarSaida(SaidaEstoque saida) {
		
		try {
			String sql = "insert into saida_item (solicitante, quantidade, finalidade,"
					+ " valor_total, custo_unitario, observacao, item_id) values (?, ?, ?, ?, ?, ?, ?)";
			
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, saida.getSolicitante());
			pstm.setInt(2, saida.getQuantidade());
			pstm.setString(3, saida.getFinalidade());
			pstm.setDouble(4, saida.getValorTotal());
			pstm.setDouble(5, saida.getCustoUnitario());
			pstm.setString(6, saida.getObservacao());
			pstm.setInt(7, saida.getItem());
			
			pstm.execute();
			conn.commit();
		} catch (Exception e) {
			
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
			e.printStackTrace();
		}
	}
	
	public int buscarQuantidadeItem(int id) throws SQLException {
		
		Estoque e = new Estoque();
		
		String sql = "select quantidade from estoque where item_id = " + id;		
		pstm = conn.prepareStatement(sql);
		rs = pstm.executeQuery();
		
		while(rs.next()) {
			e.setQuantidade(rs.getInt("quantidade"));
		}
		
		return e.getQuantidade();
	}
}
