package com.estoque.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.estoque.dao.MaterialDao;
import com.estoque.dominio.Maquina;
import com.estoque.dominio.Material;

@SuppressWarnings("serial")
@WebServlet("/item")
public class ItemServlet extends HttpServlet {
	
	// ver como salvar imagem
	// https://www.codejava.net/coding/how-to-display-images-from-database-in-jsp-page-with-java-servlet
	// https://www.codejava.net/coding/how-to-implement-forgot-password-feature-for-java-web-application
	
	private MaterialDao dao;
	
	@Override
	public void init() {
		dao = new MaterialDao();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		// estes atributos vêm da lista quando clica em 'atualizar'
		String opcao = (request.getParameter("opcao") != null) ? request.getParameter("opcao") : "";
		int id = (request.getParameter("id") != null) ? Integer.parseInt(request.getParameter("id")) : 0;
		
		if (opcao.equalsIgnoreCase("editar")) {
			Material m = dao.buscarPorId(id);
			request.setAttribute("dadosItem", m);
		}
		
		// preenche o combo-box de máquinas
		List<Maquina> maquinas = new ArrayList<Maquina>(Arrays.asList(Maquina.values()));
		request.setAttribute("listaMaquinas", maquinas);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/materiais/novo-item.jsp");
		dispatcher.forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		// esse id vem do formulário quando da edição
		int id = (Integer.parseInt(request.getParameter("id")) != 0) ? Integer.parseInt(request.getParameter("id")) : 0;
				
		Material m = new Material();
		
		m.setDescricao(request.getParameter("descricao").toUpperCase());
		m.setPartNumber(request.getParameter("part-number").toUpperCase());
		m.setCodigoERP(request.getParameter("cod-erp").toUpperCase());
		m.setDimensoes(request.getParameter("dimensoes").toLowerCase());
		m.setPosicaoAlmox(request.getParameter("posicao").toUpperCase());
		m.setMaquina(request.getParameter("maquina"));
		m.setFabricante(request.getParameter("fabricante").toUpperCase());
		m.setId(id);
		
		try {
			if (id != 0) {
				dao.atualizar(m);
				request.setAttribute("mensagemSucesso", "Registro atualizado com sucesso!");
			} else {
				dao.inserir(m);
				request.setAttribute("mensagemSucesso", "Registro cadastrado com sucesso!");
			}
		} catch (Exception e) {
			request.setAttribute("mensagemErro", "N�o foi poss�vel efetuar cadastro.");
			e.printStackTrace();
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/materiais/novo-item.jsp");
		dispatcher.forward(request, response);
	}
}
