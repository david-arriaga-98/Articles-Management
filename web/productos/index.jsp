<%-- 
    Document   : cliente
    Created on : 10/08/2020, 2:15:24
    Author     : hugo
--%>

<%@page import="entidades.Usuario"%>
<%@page import="java.util.List"%>
<%@page import="modelos.UsuarioModelo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Productos</title>
        <link rel="stylesheet" href="../estilos.css"/>
        <%
            String nombre = "Usuario";
            String rol = "";
            UsuarioModelo usuario = (UsuarioModelo) session.getAttribute("datos");
            if (usuario == null) {
                response.sendRedirect("/iniciar.jsp");
            } else {
                nombre = usuario.nombres;
                rol = usuario.tipoDeUsuario;
            }
        %>

    </head>
    <body>
        <jsp:include page="../PaginasParciales/cabecera.jsp"/>
        <% if (rol.equals("ADMIN")) { %>
        <h1 style="text-align: center; color: #c62828;">Tu Rol no te permite ingresar a esta página</h1>
        <% } else {%>
        <div class="centrar">
            <h1>Bienvenido <%=nombre%>, ¿Que deseas realizar?</h1>
            <table>
                <tr>
                    <td class="centrar">
                        <img src="https://image.flaticon.com/icons/svg/2258/2258428.svg" width="150px" style="display: block;" />
                        <a href="/productos/comprar_electrodomesticos.jsp" style="text-decoration: none; color: #0D47A1">Comprar electrodomésticos</a><br/>
                    </td>
                    <td class="centrar">
                        <img src="https://image.flaticon.com/icons/svg/3286/3286295.svg" width="150px" style="display: block;" />
                        <a href="/productos/ver_articulos.jsp" style="text-decoration: none; color: #0D47A1">Ver artículos disponibles</a><br/>
                    </td>
                    <td class="centrar">
                        <img src="https://image.flaticon.com/icons/svg/743/743007.svg" width="150px" style="display: block;" />
                        <a href="/productos/historial.jsp" style="text-decoration: none; color: #0D47A1">Historial de compras</a>
                    </td
                </tr>

            </table>
        </div>
        <% }%>
    </body>
</html>
