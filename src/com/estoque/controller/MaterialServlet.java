package com.estoque.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.estoque.dao.MaterialDao;
import com.estoque.dominio.Material;

@SuppressWarnings("serial")
@WebServlet("/inicial")
public class MaterialServlet extends HttpServlet {
	
	// ver como salvar imagem
	// https://www.codejava.net/coding/how-to-display-images-from-database-in-jsp-page-with-java-servlet

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		MaterialDao dao = new MaterialDao();
		
		String campo = request.getParameter("campo");
		String pesquisar = request.getParameter("pesquisar");
		
		// lista os registros... com paginação
		int pagina = 1;
		int registrosPorPagina = 5;
		
		if (request.getParameter("pagina") != null) {
			pagina = Integer.parseInt(request.getParameter("pagina"));
		}
		
		if (pesquisar != null) {
			List<Material> lista = 
					dao.pesquisar(campo, pesquisar, (pagina - 1) * registrosPorPagina, registrosPorPagina);
			
			int registrosPesquisa = dao.getRegistros();
			// tem que multiplicar o número de registros para dar certo
			int paginas = (int) Math.ceil(registrosPesquisa * 1.0 / registrosPorPagina);
			String url = "inicial";
			String complemento = "pesquisar=" + pesquisar + "&campo=" + campo;
			request.setAttribute("listaItens", lista);
			request.setAttribute("paginas", paginas);
			request.setAttribute("paginaCorrente", pagina);
			request.setAttribute("totalRegistros", registrosPesquisa);
			request.setAttribute("inicial", url);
			request.setAttribute("complemento", complemento);
			System.out.println("Paginação: nº total de registros >>> " + registrosPesquisa);
			System.out.println("Paginação: nº total de páginas >>> " + paginas);
		} else {
			List<Material> lista = dao.listar((pagina - 1) * registrosPorPagina, registrosPorPagina);
			
			int registros = dao.getRegistros();
			// tem que multiplicar o número de registros para dar certo
			int paginas = (int) Math.ceil(registros * 1.0 / registrosPorPagina);
			String url = "inicial";
			String complemento = "";
			request.setAttribute("listaItens", lista);
			request.setAttribute("paginas", paginas);
			request.setAttribute("paginaCorrente", pagina);
			request.setAttribute("totalRegistros", registros);
			request.setAttribute("inicial", url);
			request.setAttribute("complemento", complemento);
			System.out.println("Paginação: nº total de registros >>> " + registros);
			System.out.println("Paginação: nº total de páginas >>> " + paginas);
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
		dispatcher.forward(request, response);
	}
}
