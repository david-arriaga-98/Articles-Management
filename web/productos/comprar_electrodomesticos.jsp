<%-- 
    Document   : comprar_electrodomesticos
    Created on : 11/08/2020, 1:46:29
    Author     : hugo
--%>

<%@page import="modelos.ArticulosEnFactura"%>
<%@page import="modelos.OrdenDeCompra"%>
<%@page import="entidades.Articulos"%>
<%@page import="entidades.Usuario"%>
<%@page import="java.util.List"%>
<%@page import="modelos.UsuarioModelo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comprar Articulos</title>
        <link rel="stylesheet" href="../estilos.css"/>

        <%
            String cedula = "";
            String rol = "";
            UsuarioModelo usuario = (UsuarioModelo) session.getAttribute("datos");
            if (usuario != null) {
                cedula = usuario.cedula;
                rol = usuario.tipoDeUsuario;
            } else {
                response.sendRedirect("/iniciar.jsp");
            }

            Articulos articulo = new Articulos();

            double precioTotal = 0;
            boolean error = false;

            List<OrdenDeCompra> ordenDeCompra = articulo.obtenerOrdenesDeCompra(cedula);
            List<ArticulosEnFactura> articulosEnFactura = null;
            if (!ordenDeCompra.isEmpty()) {
                articulosEnFactura = articulo.obtenerArticulosDeFactura(ordenDeCompra.get(0).codigo);
                for (ArticulosEnFactura arti : articulosEnFactura) {
                    precioTotal += arti.valor;
                }
            } else {
                error = true;
            }
        %>

    </head>
    <body>
        <jsp:include page="../PaginasParciales/cabecera.jsp"/>

        <% if (rol.equals("ADMIN")) { %>
        <h1 style="text-align: center; color: #c62828;">Tu Rol no te permite ingresar a esta página</h1>
        <% } else {%>

        <div class="centrar">
            <h1>Realice sus compras aquí</h1>
            <a href="/productos/ver_articulos.jsp?accion=escoger" style="text-decoration: none; color: #0D47A1">+ Agregar un artículo</a><br/><br/>

            <%if (error || articulosEnFactura.isEmpty()) {%>
            <p class="error">No hay artículos</p>
            <%} else {%>

            <%if (ordenDeCompra.get(0).estado) {%>
            <p class="error">No hay artículos</p>
            <%} else {%>
            <table border cellpadding="10" cellspacing="0">
                <thead>
                    <tr>
                        <td><b>Nombre</b></td>
                        <td><b>Imagen</b></td>
                        <td><b>Cantidad</b></td>
                        <td><b>Precio Unitario</b></td>
                        <td><b>Precio Total</b></td>
                    </tr>
                </thead>
                <tbody>
                    <%for (ArticulosEnFactura arti : articulosEnFactura) {%>
                    <tr>
                        <td><%=arti.nombre%></td>
                        <td><img src="<%=arti.url%>" width="75px" /></td>
                        <td><%=arti.total%></td>
                        <td>$ <%=arti.precio%></td>
                        <td>$ <%=arti.valor%></td>
                    </tr>
                    <%}%>
                    <tr>
                        <td colspan="5" style="color: #0D47A1">Total a pagar es: $ <%=precioTotal%></td>
                    </tr>
                </tbody>
            </table>
            <p style="color: #0D47A1">Si desea terminar de comprar llene estos campos adicionales:</p>
            <form method="post" action="/GenerarFactura">
                <p>Método de pago:</p>
                <select id="metodo_pago" name="metodo_pago" id="metodo_pago">
                    <option value="Efectivo">Efectivo (10% descuento)</option>
                    <option value="Tarjeta">Tarjeta (Pago corriente)</option>
                </select> <br/>
                <p>Número de su tarjeta:</p>
                <input type="text" required name="tarjeta" id="tarjeta" minlength="16" maxlength="16" pattern="[0-9]+" title="Solo se permiten números" disabled /> <br/><br/>
                <input type="hidden" name="orden" value="<%=ordenDeCompra.get(0).codigo%>"/>
                <input type="hidden" name="cedula" value="<%=ordenDeCompra.get(0).usuario_que_pertenece%>"/>
                <button type="submit" style="margin-bottom: 20px">Generar Factura</button>
            </form> 
            <%}%>

            <%}%>

        </div>
        <script type="text/javascript">
            let metodoDePago = document.getElementById('metodo_pago');
            let tarjeta = document.getElementById('tarjeta');
            metodoDePago.addEventListener('change', (e) => {
                if (e.target.value === 'Efectivo') {
                    tarjeta.setAttribute('disabled', true);
                } else if (e.target.value === 'Tarjeta') {
                    tarjeta.removeAttribute('disabled');
                }
            });
        </script>

        <% }%>


    </body>
</html>
