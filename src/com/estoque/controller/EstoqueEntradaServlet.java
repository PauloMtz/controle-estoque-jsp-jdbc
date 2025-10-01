package com.estoque.controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.estoque.dao.OperacoesEstoqueDao;
import com.estoque.dominio.EntradaEstoque;

@SuppressWarnings("serial")
@WebServlet("/receber")
public class EstoqueEntradaServlet extends jakarta.servlet.http.HttpServlet {

	private OperacoesEstoqueDao dao;
	
	@Override
	public void init() {
		dao = new OperacoesEstoqueDao();
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/materiais/receber-material.jsp");
		dispatcher.forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		EntradaEstoque entrada = new EntradaEstoque();
		entrada.setItem(Integer.parseInt(request.getParameter("rec_id")));
		entrada.setFornecedor(request.getParameter("rec_fornecedor").toUpperCase());
		entrada.setContrato(request.getParameter("rec_contrato").toUpperCase());
		entrada.setQuantidade(Integer.parseInt(request.getParameter("rec_qtde")));
		entrada.setValorTotal(Double.parseDouble(request.getParameter("rec_total")));
		entrada.setCustoUnitario(Double.parseDouble(request.getParameter("rec_unit")));
			
		try {			
			dao.cadastrarEntrada(entrada);
			request.setAttribute("mensagemSucesso", "Recebimento registrado com sucesso!");
		} catch (Exception e) {
			request.setAttribute("mensagemErro", "Não foi possível efetuar operação.");
			e.printStackTrace();
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/materiais/receber-material.jsp");
		dispatcher.forward(request, response);
	}
}
