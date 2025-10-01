package com.estoque.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.estoque.dao.MaterialDao;
import com.estoque.dominio.Material;
import com.google.gson.Gson;

@SuppressWarnings("serial")
@WebServlet("/listar")
public class ListaModalServlet extends HttpServlet {
	
	private MaterialDao dao;
	
	@Override
	public void init() {
		dao = new MaterialDao();
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		String pesquisar = request.getParameter("pesquisar");
		List<Material> lista = dao.buscarItem(pesquisar);
		
		System.out.println("Item pesquisado: " + pesquisar);
		System.out.println("Lista: " + lista);
		
		Gson json = new Gson();
		String listaItens = json.toJson(lista);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		out.print(listaItens);
		out.flush();
	}
}
