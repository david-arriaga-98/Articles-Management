<%@page import="java.text.DecimalFormat"%>
<%@page import="entidades.Usuario"%>
<%@page import="modelos.UsuarioModelo"%>
<%@page import="java.util.List"%>
<%@page import="modelos.ArticulosEnFactura"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelos.OrdenDeCompra"%>
<%@page import="entidades.Articulos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Factura</title>
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

            boolean mostrarError = false;
            String mensajeDeError = "Ha ocurrido un error";
            String id = request.getParameter("id");
            Articulos articu = new Articulos();
            OrdenDeCompra orden = null;
            ArrayList<ArticulosEnFactura> articulos = null;
            if (id != null) {
                List<OrdenDeCompra> ordenes = articu.obtenerOrdenDeCompra(Integer.parseInt(id), cedula);
                if (ordenes.isEmpty()) {
                    mostrarError = true;
                    mensajeDeError = "No existe esta orden";
                } else {
                    orden = ordenes.get(0);
                    articulos = articu.obtenerArticulosDeFactura(Integer.parseInt(id));
                }

            }
            int numero = 1;

        %>
    </head>
    <body>
        <jsp:include page="../PaginasParciales/cabecera.jsp"/>
        <% if (rol.equals("ADMIN")) { %>
        <h1 style="text-align: center; color: #c62828;">Tu Rol no te permite ingresar a esta página</h1>
        <% } else {%>
        <div class="centrar">
            <h1>Detalle de factura</h1>
            <% if (id == null || mostrarError) {%> 
            <p class="error"><%=mensajeDeError%></p>
            <% } else {%>
            <button id="irEncuesta" type="submit" style="margin-bottom: 10px; display: <%=orden.realizo_encuesta ? "none": "null"%>">¿Desea llenar una pequeña encuesta?</button>
            <fieldset>
                <p>Número de la factura: <%=orden.codigo%></p>
                <p>Estado de la factura: <%=orden.metodo_de_pago.equals("Tarjeta") ? "Pagado" : "En Progreso"%></p>
                <p>Tipo de pago: <%=orden.metodo_de_pago%></p>
                <%if (orden.metodo_de_pago.equals("Tarjeta")) {%>
                <p>Número de tarjeta: <%=orden.tarjeta%></p>  
                <%}%>
                <p>Dirección: <%=orden.direccion_a_facturar%></p>
                <p>Subtotal: $<%=String.format("%.2f", (orden.descuento + orden.precio_total))%></p>
                <p>Descuento $<%=orden.descuento%></p>
                <p>Total a pagar: $<%=orden.precio_total%></p>
            </fieldset> <br/>

            <table border cellpadding="5" cellspacing="0" style="margin-bottom: 20px">
                <thead>
                    <tr>
                        <td><b>#</b></td>
                        <td><b>Nombre</b></td>
                        <td><b>Imagen</b></td>
                        <td><b>Cantidad</b></td>
                        <td><b>Precio Unitario</b></td>
                        <td><b>Precio Total</b></td>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (ArticulosEnFactura arti : articulos) {
                    %>
                    <tr>
                        <td><%=numero%></td>
                        <td><%=arti.nombre%></td>
                        <td><img src="<%=arti.url%>" width="75px" /></td>
                        <td><%=arti.total%></td>
                        <td>$ <%=arti.precio%></td>
                        <td>$ <%=arti.valor%></td>
                    </tr>

                    <%
                            numero++;
                        }
                    %>
                </tbody>
            </table>

            <%}%>
        </div>
        <% }%>
        
        <script>
            let irEncuesta = document.getElementById("irEncuesta");
            irEncuesta.addEventListener("click", () => {
               location.href = "/productos/encuesta.jsp?fac=<%=id%>"; 
            });
        </script>
        
    </body>
</html>
