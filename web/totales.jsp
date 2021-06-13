<%-- 
    Document   : totales
    Created on : 18/08/2020, 19:37:37
    Author     : hugo
--%>

<%@page import="modelos.OrdenDeCompra"%>
<%@page import="java.util.List"%>
<%@page import="entidades.Articulos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Obtener valores</title>
        <%
            double totalTarjeta = 0;
            double totalEfectivo = 0;
            Articulos objA = new Articulos();
            List<OrdenDeCompra> tarjeta = objA.obtenerOrdenDeCompraPor("metodo_de_pago", "Tarjeta");
            List<OrdenDeCompra> efectivo = objA.obtenerOrdenDeCompraPor("metodo_de_pago", "Efectivo");
            System.out.println(tarjeta.size());
            System.out.println(efectivo.size());
            if (!tarjeta.isEmpty() && !efectivo.isEmpty()) {
                // Para tarjeta
                for (int i = 0; i < tarjeta.size(); i++) {
                    totalTarjeta += tarjeta.get(i).precio_total;
                }

                for (int i = 0; i < efectivo.size(); i++) {
                    totalEfectivo += efectivo.get(i).precio_total;
                }
            }

        %>

    </head>
    <body>
    <center>
        <h1>Total en efectivo:</h1>
        <p><%=totalEfectivo%></p>
        <h1>Total en tarjeta:</h1>
        <p><%=totalTarjeta%></p>
    </center>
</body>
</html>
