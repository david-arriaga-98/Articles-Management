<%@page import="modelos.UsuarioModelo"%>
<%@page import="java.io.OutputStream"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%
            UsuarioModelo usuario = (UsuarioModelo) session.getAttribute("datos");

            if (usuario == null) {
                response.sendRedirect("/iniciar.jsp");
                return;
            }
        %>
    </head>
    <body>
        <%
            try {
                Connection con;
                Conexion conexion = new Conexion();
                con = conexion.obtenerConexion();
                File file = new File(application.getRealPath("administracion/reporte.jasper"));
                Map<String, Object> parameter = new HashMap();
                byte[] bytes = JasperRunManager.runReportToPdf(file.getPath(), parameter, con);
                response.setContentType("application/pdf");
                response.setContentLength(bytes.length);
                OutputStream outs = response.getOutputStream();
                outs.write(bytes, 0, bytes.length);
                outs.flush();
                outs.close();
            } catch (IllegalStateException e) {
                System.out.println("ex");
            }

        %>
    </body>
</html>
