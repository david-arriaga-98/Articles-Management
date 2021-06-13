<%@page import="modelos.UsuarioModelo"%>
<%@page import="modelos.ArticuloModelo"%>
<%@page import="java.util.List"%>
<%@page import="entidades.Articulos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Artículos</title>
        <link rel="stylesheet" href="../estilos.css"/>
        <%
            boolean debeEscoger = false;
            String usuario = "";
            String accion = request.getParameter("accion") == null ? "" : request.getParameter("accion");

            if (accion.equals("escoger")) {

                // Traemos la sesion
                UsuarioModelo datosDeUsuario = (UsuarioModelo) session.getAttribute("datos");
                if (datosDeUsuario != null) {
                    debeEscoger = true;
                    usuario = datosDeUsuario.cedula;
                } else {
                    debeEscoger = false;
                }
            } else {
                debeEscoger = false;
            }

            List<ArticuloModelo> articulos = new Articulos().obtenerArticulos();

        %>

    </head>
    <body>
        <jsp:include page="../PaginasParciales/cabecera.jsp"/>
        <div class="centrar">
            <h1><%=debeEscoger ? "Escoja su artículo favorito" : "Articulos disponibles"%></h1>

            <% if (articulos.isEmpty()) { %>
            <p style="color: #c62828" >No hay artículos disponibles</p>
            <% } else { %>

            <%            for (ArticuloModelo articulo : articulos) {
            %>
            <fieldset style="width: 430px; margin-bottom: 14px" >
                <div class="centrar">
                    <h2 style="color: darkblue; text-align: center"><%=articulo.nombre%></h2>
                    <img src="<%=articulo.url_de_imagen%>" width="120px" />
                    <p style="color: lightslategray">$ <%=articulo.precio_unitario%></p>
                    <p style="font-size: 11px"><%=articulo.descripcion%></p>
                    <p style="font-size: 11px">Unidades disponibles: <%=articulo.cantidad%></p>
                    <%
                        if (debeEscoger) {
                    %>
                    <form method="POST" action="/ElegirArticulo">
                        <span style="font-size: 11px">Unidades a escoger:</span>
                        <input type="number" value="1" max="<%=articulo.cantidad%>" min="1" name="cantidad" />
                        <input type="hidden" value="<%=articulo.codigo_de_articulo%>" required name="articulo" />
                        <input type="hidden" value="<%=usuario%>" required name="usuario" />
                        <button type="submit">Escoger</button>
                    </form>
                    <%
                        }
                    %>
                </div>
            </fieldset>

            <%
                }
            %>

            <% }%>

        </div>

    </body>
</html>
