package com.estoque.controller;

import java.io.IOException;
import java.util.Date;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.estoque.dao.UsuarioDao;
import com.estoque.dominio.Usuario;
import com.estoque.utils.EncryptUtil;

@SuppressWarnings("serial")
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	
	// http://localhost:8080/estoque-controle/login
	
	private UsuarioDao dao;
	
	@Override
	public void init() {
		dao = new UsuarioDao();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
		dispatcher.forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		EncryptUtil app = new EncryptUtil();
		
		String matricula = request.getParameter("matricula");
		String senha = request.getParameter("senha");
		
		try {
			String hashSenha = app.encode(senha);
			
			Usuario u = dao.buscarUsuario(matricula, hashSenha);
			int id = u.getId();
			String nome = u.getNome();
			String mat = u.getMatricula();
			String pass = u.getSenha();
			String perfil = u.getPerfil();
			Boolean ativo = u.getAtivo();
			
			if (matricula.equals(mat) && hashSenha.equals(pass) && ativo == true) {
				HttpSession session = request.getSession();
				session.setAttribute("session_idUsuario", id);
				session.setAttribute("session_nomeUsuario", nome);
				session.setAttribute("session_perfilUsuario", perfil);
				session.setAttribute("session_dataLogin", new Date());
				response.sendRedirect(request.getContextPath() + "/inicial");
			} else {
				request.setAttribute("mensagemErro", "Dados inválidos e/ou acesso negado.");
				RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
				dispatcher.forward(request, response);
			}
		} catch (Exception e) {
			request.setAttribute("mensagemErro", e.getMessage());
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
		}
	}
}
