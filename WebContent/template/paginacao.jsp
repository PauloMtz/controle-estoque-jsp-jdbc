<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<!-- Fonte: https://ibytecode.com/blog/pagination-in-servlet-and-jsp/ -->

	<ul class="pagination pagination-sm" style="float: right">
		<c:choose>
			<c:when test="${paginas == 1}">
				<li>Página 1 de 1</li>
			</c:when>
			<c:otherwise>
				<c:if test="${paginaCorrente > 1}">
					<li class="page-item">
						<a  class="page-link" href="${url}?pagina=${paginaCorrente - 1}&${complemento}">Ant</a>
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
				
				<c:if test="${paginaCorrente lt paginas}">
					<li class="page-item">
						<a  class="page-link" href="${url}?pagina=${paginaCorrente + 1}&${complemento}">Prox</a>
					</li>
				</c:if>
			</c:otherwise>
		</c:choose>
	</ul>
