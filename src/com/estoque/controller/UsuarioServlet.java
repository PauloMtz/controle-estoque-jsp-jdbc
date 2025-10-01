package com.estoque.controller;

import java.io.IOException;
import java.util.List;

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
@WebServlet("/usuario")
public class UsuarioServlet extends HttpServlet {
	
	private UsuarioDao dao;
	
	@Override
	public void init() {
		dao = new UsuarioDao();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		// pega o usuário logado no sistema
		HttpSession session = request.getSession();
		int usuario = (int) session.getAttribute("session_idUsuario");
		
		// esse id vem da lista quando clica em editar ou excluir
		int id = request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : 0;
		String acao = (request.getParameter("acao") != null) ? request.getParameter("acao") : "";
		
		// variáveis para pesquisa
		String campo = request.getParameter("campo");
		String pesquisar = request.getParameter("pesquisar");
		
		if (acao.equalsIgnoreCase("novo")) {
			// carrega a página de cadastro de usuário
			RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/usuarios/form-usuario.jsp");
			dispatcher.forward(request, response);
		} else if (acao.equalsIgnoreCase("editar")) {
			// carrega a página para edição de registro
			request.setAttribute("dadosUsuario", dao.buscarPorId(id));
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/usuarios/form-usuario.jsp");
			dispatcher.forward(request, response);
		} else if (acao.equalsIgnoreCase("altera_senha")) {
			// carrega a página para edição de registro
			request.setAttribute("dadosUsuario", dao.buscarPorId(id));
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/usuarios/alterar-senha.jsp");
			dispatcher.forward(request, response);
		} else if (acao.equalsIgnoreCase("excluir")) {
			// verifica se é o mesmo usuário que está logado
			if (usuario == id) {
				request.setAttribute("mensagemErro", "Não é possível excluir o mesmo usuário que está logado no sistema.");
				request.setAttribute("dadosUsuario", dao.buscarPorId(id));
				RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/usuarios/form-usuario.jsp");
				dispatcher.forward(request, response);
			} else {
				// exclui registro
				dao.excluir(id);
				
				response.sendRedirect(request.getContextPath() + "/usuario");
			}
		} else {
			// lista os usuarios... com paginação
			int pagina = 1;
			int registrosPorPagina = 8;
			
			if (request.getParameter("pagina") != null) {
				pagina = Integer.parseInt(request.getParameter("pagina"));
			}
			
			if (pesquisar != null) {
				List<Usuario> listaUsuarios = 
						dao.pesquisarUsuario(campo, pesquisar, (pagina - 1) * registrosPorPagina, registrosPorPagina);
				int registrosPesquisa = dao.getRegistros();
				// tem que multiplicar o número de registros para dar certo
				int paginas = (int) Math.ceil(registrosPesquisa * 1.0 / registrosPorPagina);
				String url = "usuario";
				String complemento = "pesquisar=" + pesquisar + "&campo=" + campo;
				request.setAttribute("lista", listaUsuarios);
				request.setAttribute("paginas", paginas);
				request.setAttribute("paginaCorrente", pagina);
				request.setAttribute("totalRegistros", registrosPesquisa);
				request.setAttribute("usuario", url);
				request.setAttribute("complemento", complemento);
				System.out.println("Paginação: nº total de registros pesquisados >>> " + registrosPesquisa);
				System.out.println("Paginação: nº total de páginas >>> " + paginas);
			} else {
				List<Usuario> listaUsuarios = dao.listarTodos((pagina - 1) * registrosPorPagina, registrosPorPagina);
				int registros = dao.getRegistros();
				// tem que multiplicar o número de registros para dar certo
				int paginas = (int) Math.ceil(registros * 1.0 / registrosPorPagina);
				String url = "usuario";
				String complemento = "";
				request.setAttribute("lista", listaUsuarios);
				request.setAttribute("paginas", paginas);
				request.setAttribute("paginaCorrente", pagina);
				request.setAttribute("totalRegistros", registros);
				request.setAttribute("usuario", url);
				request.setAttribute("complemento", complemento);
				System.out.println("Paginação: nº total de registros >>> " + registros);
				System.out.println("Paginação: nº total de páginas >>> " + paginas);
			}
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/usuarios/usuarios.jsp");
			dispatcher.forward(request, response);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		EncryptUtil app = new EncryptUtil();
		
		// esse id vem do formulário de edição
		int id = request.getParameter("id") != "" ? Integer.parseInt(request.getParameter("id")) : 0;
		String acao = (request.getParameter("acao") != null) ? request.getParameter("acao") : "";
		
		try {
			//String senha = request.getParameter("senha");
			String hashSenha = app.encode("123");
			
			if (id != 0 && acao.equalsIgnoreCase("altera_senha")) {
				Usuario u = new Usuario();
				u.setSenha(hashSenha);
				u.setId(id);
				
				dao.alterarSenha(u);
				request.setAttribute("mensagemSucesso", "Registro atualizado com sucesso!");
			} else if (id != 0) {
				Usuario u = new Usuario();
				u.setNome(request.getParameter("nome").toUpperCase());
				u.setMatricula(request.getParameter("matricula"));
				u.setEmail(request.getParameter("email"));
				u.setSenha(hashSenha);
				u.setPerfil(request.getParameter("perfil"));
				u.setAtivo(Boolean.parseBoolean(request.getParameter("ativo")));
				u.setId(id);
				
				dao.atualizar(u);
				request.setAttribute("mensagemSucesso", "Registro atualizado com sucesso!");
			} else {
				Usuario u = new Usuario();
				String matricula = request.getParameter("matricula");
				u.setNome(request.getParameter("nome").toUpperCase());
				u.setMatricula(matricula);
				u.setEmail(request.getParameter("email"));
				u.setSenha(hashSenha);
				u.setPerfil(request.getParameter("perfil"));
				u.setAtivo(Boolean.parseBoolean(request.getParameter("ativo")));
				
				boolean resultado = dao.inserir(u);
				
				if (resultado) {
					request.setAttribute("mensagemSucesso", "Usuário cadastrado com sucesso!");
				} else {
					request.setAttribute("mensagemErro", "Já existe um usuário cadastrado com a matrícula " + matricula);
				}
			}
		} catch (Exception e) {
			request.setAttribute("mensagemErro", "Não foi possível efetuar operação.");
			e.printStackTrace();
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/usuarios/form-usuario.jsp");
		dispatcher.forward(request, response);
	}
}
