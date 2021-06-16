package com.estoque.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.estoque.dao.OperacoesEstoqueDao;
import com.estoque.dominio.EntradaEstoque;

@SuppressWarnings("serial")
@WebServlet("/recebimentos")
public class ListaRecebimentosServlet extends HttpServlet {

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
			List<EntradaEstoque> lista = 
					dao.pesquisarEntrada(campo, pesquisar, (pagina - 1) * registrosPorPagina, registrosPorPagina);
			
			int registrosPesquisa = dao.getRegistros();
			// tem que multiplicar o número de registros para dar certo
			int paginas = (int) Math.ceil(registrosPesquisa * 1.0 / registrosPorPagina);
			String url = "recebimentos";
			String complemento = "pesquisar=" + pesquisar + "&campo=" + campo;
			request.setAttribute("listaRecebimentos", lista);
			request.setAttribute("paginas", paginas);
			request.setAttribute("paginaCorrente", pagina);
			request.setAttribute("totalRegistros", registrosPesquisa);
			request.setAttribute("recebimentos", url);
			request.setAttribute("complemento", complemento);
			System.out.println("Paginação: nº total de registros >>> " + registrosPesquisa);
			System.out.println("Paginação: nº total de páginas >>> " + paginas);
		} else {
			List<EntradaEstoque> lista = dao.listaRecebimentos((pagina - 1) * registrosPorPagina, registrosPorPagina);
			
			int registros = dao.getRegistros();
			// tem que multiplicar o número de registros para dar certo
			int paginas = (int) Math.ceil(registros * 1.0 / registrosPorPagina);
			String url = "recebimentos";
			String complemento = "";
			request.setAttribute("listaRecebimentos", lista);
			request.setAttribute("paginas", paginas);
			request.setAttribute("paginaCorrente", pagina);
			request.setAttribute("totalRegistros", registros);
			request.setAttribute("recebimentos", url);
			request.setAttribute("complemento", complemento);
			System.out.println("Paginação: nº total de registros >>> " + registros);
			System.out.println("Paginação: nº total de páginas >>> " + paginas);
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/materiais/recebimentos.jsp");
		dispatcher.forward(request, response);
	}
}
