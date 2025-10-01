package com.estoque.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.estoque.dao.OperacoesEstoqueDao;
import com.estoque.dominio.SaidaEstoque;

@SuppressWarnings("serial")
@WebServlet("/saidas")
public class ListaSaidasServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		OperacoesEstoqueDao dao = new OperacoesEstoqueDao();
		
		String campo = request.getParameter("campo");
		String pesquisar = request.getParameter("pesquisar");
		
		// lista os registros... com paginação
		int pagina = 1;
		int registrosPorPagina = 8;
		
		if (request.getParameter("pagina") != null) {
			pagina = Integer.parseInt(request.getParameter("pagina"));
		}
		
		if (pesquisar != null) {
			List<SaidaEstoque> lista = 
					dao.pesquisarSaida(campo, pesquisar, (pagina - 1) * registrosPorPagina, registrosPorPagina);
			
			int registrosPesquisa = dao.getRegistros();
			// tem que multiplicar o número de registros para dar certo
			int paginas = (int) Math.ceil(registrosPesquisa * 1.0 / registrosPorPagina);
			String url = "saidas";
			String complemento = "pesquisar=" + pesquisar + "&campo=" + campo;
			request.setAttribute("listaSaidas", lista);
			request.setAttribute("paginas", paginas);
			request.setAttribute("paginaCorrente", pagina);
			request.setAttribute("totalRegistros", registrosPesquisa);
			request.setAttribute("saidas", url);
			request.setAttribute("complemento", complemento);
			System.out.println("Paginação: nº total de registros >>> " + registrosPesquisa);
			System.out.println("Paginação: nº total de páginas >>> " + paginas);
		} else {
			List<SaidaEstoque> lista = dao.listaSaidas((pagina - 1) * registrosPorPagina, registrosPorPagina);
			
			int registros = dao.getRegistros();
			// tem que multiplicar o número de registros para dar certo
			int paginas = (int) Math.ceil(registros * 1.0 / registrosPorPagina);
			String url = "saidas";
			String complemento = "";
			request.setAttribute("listaSaidas", lista);
			request.setAttribute("paginas", paginas);
			request.setAttribute("paginaCorrente", pagina);
			request.setAttribute("totalRegistros", registros);
			request.setAttribute("saidas", url);
			request.setAttribute("complemento", complemento);
			System.out.println("Paginação: nº total de registros >>> " + registros);
			System.out.println("Paginação: nº total de páginas >>> " + paginas);
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/materiais/saidas.jsp");
		dispatcher.forward(request, response);
	}
}
