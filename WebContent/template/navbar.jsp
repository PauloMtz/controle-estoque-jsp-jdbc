<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
					data-target="#navbar" aria-expanded="false" aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> 
					<span class="icon-bar"></span> 
					<span class="icon-bar"></span> 
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="inicial"> 
					<img src="resources/img/logo.png"></a>
			</div>

			<div id="navbar" class="navbar-collapse collapse" style="margin-top: 10px">
				<ul class="nav navbar-nav">
					<li><a href="inicial">Início</a></li>
					
					<c:if test="${session_perfilUsuario == 'admin'}">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" 
							aria-haspopup="true" aria-expanded="false">Cadastros 
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li><a href="usuario?acao=novo">Novo Usuário</a></li>
							<li><a href="item">Cadastrar Item</a></li>
						</ul>
					</li>
					</c:if>

					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" 
							aria-haspopup="true" aria-expanded="false">Operações 
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<c:if test="${session_perfilUsuario == 'admin'}">
							<li><a href="receber">Recebimento de Materiais</a></li>
							</c:if>
							<li><a href="saida">Saída de Materiais</a></li>
						</ul>
					</li>

					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" 
							aria-haspopup="true" aria-expanded="false">Consultas 
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li><a href="recebimentos">Recebimentos</a></li>
							<li><a href="saidas">Saídas</a></li>
							<c:if test="${session_perfilUsuario == 'admin'}">
							<li><a href="usuario">Usuários</a></li>
							</c:if>
						</ul>
					</li>
				</ul>

				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
							aria-haspopup="true" aria-expanded="false"> ${sessionScope.session_nomeUsuario}
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li><a href="usuario?acao=altera_senha&id=<c:out value='${sessionScope.session_idUsuario}' />">Alterar Senha</a></li>
							<li><a href="logout">Sair</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
