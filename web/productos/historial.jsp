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
        <title>Historial</title>
        <link rel="stylesheet" href="../estilos.css"/>
        <%

            String cedula = "";
            String rol = "";

            UsuarioModelo usuario = (UsuarioModelo) session.getAttribute("datos");
            if (usuario == null) {
                response.sendRedirect("/iniciar.jsp");
            } else {
                cedula = usuario.cedula;
                rol = usuario.tipoDeUsuario;
            }

            Articulos objArticulo = new Articulos();
            List<OrdenDeCompra> ordenes = objArticulo.obtenerOrdenesDeCompra(cedula);
            int numero = 1;

            double totalEfectivo = 0;
            double descuentos = 0;
            int articulosC = 0;

            if (!ordenes.isEmpty()) {
                // Para tarjeta
                for (int i = 0; i < ordenes.size(); i++) {
                    descuentos += ordenes.get(i).descuento;
                    articulosC += ordenes.get(i).numero_de_articulos;
                    if (ordenes.get(i).metodo_de_pago.equals("Tarjeta")) {
                        totalEfectivo += ordenes.get(i).precio_total;
                    }

                }

            }

        %>
    </head>
    <body>
        <jsp:include page="../PaginasParciales/cabecera.jsp"/>

        <% if (rol.equals("ADMIN")) { %>
        <h1 style="text-align: center; color: #c62828;">Tu Rol no te permite ingresar a esta página</h1>
        <% } else {%>
        <div class="centrar">
            <h1>Historial de compras</h1>
            <% if (usuario == null) { %> 
            <p class="error">Ha  ocurrido un error</>
                <% } else { %>
                <%if (ordenes.isEmpty()) {%>
            <p class="error">No hay registros que mostrar</p>
            <%} else {%>
            <table border cellpadding="10" cellspacing="0">
                <thead>
                    <tr>
                        <td><b>#</b></td>
                        <td><b>Tipo de pago</b></td>
                        <td><b>Subtotal</b></td>
                        <td><b>Descuento</b></td>
                        <td><b>Total a pagar</b></td>
                        <td><b>Informacion</b></td>
                    </tr>
                </thead>
                <tbody>
                    <%for (OrdenDeCompra orden : ordenes) {
                            if (orden.estado) {
                    %>
                    <tr>
                        <td><%=numero%></td>
                        <td><%=orden.metodo_de_pago%></td>
                        <td>$ <%=String.format("%.2f", (orden.descuento + orden.precio_total)).replace(",", ".")%></td>
                        <td>$ <%=orden.descuento%></td>
                        <td>$ <%=orden.precio_total%></td>
                        <td><a href="/productos/ver_factura.jsp?id=<%=orden.codigo%>">Ver Factura</a></td>
                    </tr>
                    <%numero++;
                            }
                        }%>

                </tbody>
            </table>
            <%}%>
            <%}%>

            <h2 style="margin-bottom: 0">Total en pagos con tarjeta:</h2>
            <p>$ <%=String.format("%.2f", totalEfectivo)%></p>
            <h2 style="margin-bottom: 0">Total en Descuentos:</h2>
            <p>$ <%=String.format("%.2f", descuentos)%></p>
            <h2 style="margin-bottom: 0">Artículos comprados:</h2>
            <p><%= articulosC%> artículos en total</p>
        </div>
        <% }%>


    </body>
</html>
