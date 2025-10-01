package com.estoque.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.estoque.dao.OperacoesEstoqueDao;
import com.estoque.dominio.Finalidade;
import com.estoque.dominio.SaidaEstoque;

@SuppressWarnings("serial")
@WebServlet("/saida")
public class EstoqueSaidaServlet extends HttpServlet {
	
	private OperacoesEstoqueDao dao;
	
	@Override
	public void init() {
		dao = new OperacoesEstoqueDao();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		// preenche o combo-box de finalidade
		List<Finalidade> finalidade = new ArrayList<Finalidade>(Arrays.asList(Finalidade.values()));
		request.setAttribute("listaFinalidade", finalidade);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/materiais/saida-material.jsp");
		dispatcher.forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		SaidaEstoque saida = new SaidaEstoque();
		int id = request.getParameter("sai_id") != null ? Integer.parseInt(request.getParameter("sai_id")) : 0;
		int qtdePedida = Integer.parseInt(request.getParameter("sai_qtde"));
		
		saida.setItem(Integer.parseInt(request.getParameter("sai_id")));
		saida.setSolicitante(request.getParameter("sai_solic").toUpperCase());
		saida.setQuantidade(Integer.parseInt(request.getParameter("sai_qtde")));
		saida.setFinalidade(request.getParameter("sai_fin"));
		saida.setValorTotal(Double.parseDouble(request.getParameter("sai_total")));
		saida.setCustoUnitario(Double.parseDouble(request.getParameter("sai_unit")));
		saida.setObservacao(request.getParameter("sai_obs").toUpperCase());
		
		try {
			int qtdeEstoque = dao.buscarQuantidadeItem(id);
			
			if (qtdePedida > qtdeEstoque) {
				request.setAttribute("mensagemErro", "Quantidade solicitada indisponível.");
			} else {
				try {
					dao.cadastrarSaida(saida);
					request.setAttribute("mensagemSucesso", "Retirada registrada com sucesso!");
				} catch (Exception e) {
					request.setAttribute("mensagemErro", "Não foi possível efetuar operação.");
					e.printStackTrace();
				}
			}
		} catch (SQLException e1) {
			request.setAttribute("mensagemErro", "Não foi possível efetuar operação.");
			e1.printStackTrace();
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/materiais/saida-material.jsp");
		dispatcher.forward(request, response);
	}
}
