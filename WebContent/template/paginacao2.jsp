<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<ul class="pagination pagination-sm" style="float: right">
	<c:choose>
		<c:when test="${paginas == 1}">
			<li>Página 1 de 1</li>
		</c:when>
		
		<c:when test="${paginas > 1 && paginas <= 10}">
			<c:if test="${paginaCorrente > 1}">
				<li class="page-item">
					<a  class="page-link" href="${url}?pagina=${paginaCorrente - 1}&${complemento}">
						<img src="resources/img/previous3.png">
					</a>
				</li>
			</c:if>
			<c:forEach begin="1" end="${paginas}" var="i">
				<c:choose>
					<c:when test="${paginaCorrente eq i}">
						<li class="page-item active"><a  class="page-link">${i}</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a  class="page-link" href="${url}?pagina=${i}&${complemento}">${i}</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${paginaCorrente < paginas}">
				<li class="page-item">
					<a  class="page-link" href="${url}?pagina=${paginaCorrente + 1}&${complemento}">
						<img src="resources/img/next3.png">
					</a>
				</li>
			</c:if>
		</c:when>
		
		<c:when test="${paginas > 10}">
			<c:choose>
				<c:when test="${paginaCorrente <= 4}">
					<c:if test="${paginaCorrente > 1}">
						<li class="page-item">
							<a  class="page-link" href="${url}?pagina=${paginaCorrente - 1}&${complemento}">
								<img src="resources/img/previous3.png">
							</a>
						</li>
					</c:if>
					<c:forEach begin="1" end="4" var="i">
						<c:choose>
							<c:when test="${paginaCorrente eq i}">
								<li class="page-item active"><a  class="page-link">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item">
									<a  class="page-link" href="${url}?pagina=${i}&${complemento}">${i}</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<li class="page-item">
						<a  class="page-link">...</a>
					</li>
					<li class="page-item">
						<a  class="page-link" href="${url}?pagina=${paginas-1}&${complemento}">${paginas-1}</a>
					</li>
					<li class="page-item">
						<a  class="page-link" href="${url}?pagina=${paginas}&${complemento}">${paginas}</a>
					</li>
					
					<c:if test="${paginaCorrente < paginas}">
						<li class="page-item">
							<a  class="page-link" href="${url}?pagina=${paginaCorrente + 1}&${complemento}">
								<img src="resources/img/next3.png">
							</a>
						</li>
					</c:if>
				</c:when>
				
				<c:when test="${paginaCorrente > 4 && paginaCorrente < (paginas - 4)}">
					<c:if test="${paginaCorrente > 1}">
						<li class="page-item">
							<a  class="page-link" href="${url}?pagina=${paginaCorrente - 1}&${complemento}">
								<img src="resources/img/previous3.png">
							</a>
						</li>
					</c:if>
					<li class="page-item">
						<a  class="page-link" href="${url}?pagina=1&${complemento}">1</a>
					</li>
					<li class="page-item">
						<a  class="page-link" href="${url}?pagina=2&${complemento}">2</a>
					</li>
					<li class="page-item">
						<a  class="page-link">...</a>
					</li>
					
					<c:forEach begin="${paginaCorrente - adjacentes}" end="${paginaCorrente + adjacentes}" var="i">
						<c:choose>
							<c:when test="${paginaCorrente eq i}">
								<li class="page-item active"><a  class="page-link">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item">
									<a  class="page-link" href="${url}?pagina=${i}&${complemento}">${i}</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<li class="page-item">
						<a  class="page-link">...</a>
					</li>
					<li class="page-item">
						<a  class="page-link" href="${url}?pagina=${paginas-1}&${complemento}">${paginas-1}</a>
					</li>
					<li class="page-item">
						<a  class="page-link" href="${url}?pagina=${paginas}&${complemento}">${paginas}</a>
					</li>
					<c:if test="${paginaCorrente < paginas}">
						<li class="page-item">
							<a  class="page-link" href="${url}?pagina=${paginaCorrente + 1}&${complemento}">
								<img src="resources/img/next3.png">
							</a>
						</li>
					</c:if>
				</c:when>
				
				<c:otherwise>
					<c:if test="${paginaCorrente > 1}">
						<li class="page-item">
							<a  class="page-link" href="${url}?pagina=${paginaCorrente - 1}&${complemento}">
								<img src="resources/img/previous3.png">
							</a>
						</li>
					</c:if>
					<li class="page-item">
						<a  class="page-link" href="${url}?pagina=1&${complemento}">1</a>
					</li>
					<li class="page-item">
						<a  class="page-link" href="${url}?pagina=2&${complemento}">2</a>
					</li>
					<li class="page-item">
						<a  class="page-link">...</a>
					</li>
					
					<c:forEach begin="${paginas - 5}" end="${paginas}" var="i">
						<c:choose>
							<c:when test="${paginaCorrente eq i}">
								<li class="page-item active"><a  class="page-link">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item">
									<a  class="page-link" href="${url}?pagina=${i}&${complemento}">${i}</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<c:if test="${paginaCorrente < paginas}">
						<li class="page-item">
							<a  class="page-link" href="${url}?pagina=${paginaCorrente + 1}&${complemento}">
								<img src="resources/img/next3.png">
							</a>
						</li>
					</c:if>
				</c:otherwise>
			</c:choose>
		</c:when>
	</c:choose>
</ul>
