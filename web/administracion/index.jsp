<%@page import="modelos.UsuarioModelo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Panel de administración</title>
        <link rel="stylesheet" href="../estilos.css"/>
        <%
            String rol = "";
            String nombre = "";
            UsuarioModelo usuario = (UsuarioModelo) session.getAttribute("datos");
            if (usuario != null) {
                rol = usuario.tipoDeUsuario;
                nombre = usuario.nombres;
            } else {
                response.sendRedirect("/iniciar.jsp");
            }
        %>
    </head>
    <body>
        <jsp:include page="../PaginasParciales/cabecera.jsp"/>
        <% if (rol.equals("ADMIN")) {%>

        <div class="centrar">
            <h1>Bienvenido <%=nombre%>, ¿Que deseas realizar?</h1>
            <table>
                <tr>
                    <td class="centrar">
                        <img src="https://www.flaticon.es/svg/static/icons/svg/448/448836.svg" width="150px" style="display: block;" />
                        <a href="/administracion/productos.jsp" style="text-decoration: none; color: #0D47A1">Administrar productos</a><br/>
                    </td>
                    <td class="centrar">
                        <img src="https://www.flaticon.es/svg/static/icons/svg/3003/3003214.svg" width="150px" style="display: block;" />
                        <a href="/administracion/usuarios.jsp" style="text-decoration: none; color: #0D47A1">Administrar usuarios</a><br/>
                    </td>
                    <td class="centrar">
                        <img src="https://www.flaticon.es/svg/static/icons/svg/2920/2920253.svg" width="150px" style="display: block;" />
                        <a href="/administracion/reporte_de_aceptacion.jsp" style="text-decoration: none; color: #0D47A1">Reporte</a><br/>
                    </td>
                </tr>
            </table>
        </div>


        <% } else { %>
        <h1 style="text-align: center; color: #c62828;">Tu Rol no te permite ingresar a esta página</h1>
        <% }%>
    </body>
</html>
