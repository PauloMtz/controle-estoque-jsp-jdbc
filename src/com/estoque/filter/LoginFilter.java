package com.estoque.filter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.estoque.db.MysqlConexao;

//intercepta todas as requisições
//tem que declarar no web.xml
@WebFilter(urlPatterns = "/*")
public class LoginFilter implements Filter {
	
	// ver: https://www.codejava.net/java-ee/servlet/how-to-implement-authentication-filter-for-java-web-application
	
	private static Connection conexao;

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain filter)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession session = req.getSession();
		
		// pega data/hora atual
		LocalDateTime agora = LocalDateTime.now();
		
		// formatar a data
		DateTimeFormatter formatterData = DateTimeFormatter.ofPattern("dd/MM/uuuu HH:mm:ss");
		String horaAcesso = formatterData.format(agora);
		
		String usuario = (String) session.getAttribute("session_nomeUsuario");
		//Date data = (Date) session.getAttribute("dataLogin");
		
		if (usuario != null) {
			System.out.println(usuario + " acessou " + req.getRequestURI() + " em " + horaAcesso);
		}
		
		try {
			filter.doFilter(request, response);
			conexao.commit();
		} catch (SQLException e) {
			throw new ServletException();
		}
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
		// invoca a conexão
		conexao = MysqlConexao.getConexao();
	}
	
	@Override
	public void destroy() {
		// não precisa
	}
}
