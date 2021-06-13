<%@page import="modelos.UsuarioModelo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Iniciar Sesión</title>
        <link rel="stylesheet" href="estilos.css"/>
        <%
            UsuarioModelo usuario = (UsuarioModelo) session.getAttribute("datos");
            if(usuario != null){
                response.sendRedirect("/productos");
            }   
        %>
    </head>
    <body>
        <jsp:include page="PaginasParciales/cabecera.jsp"/>
        <div class="centrar">
            <h1>Ingrese a su cuenta</h1>
            <form method="POST" action="IniciarSesion" >
                <fieldset style="width: 210px" style="margin-top: 14px">
                    <br/>
                    <label for="cedula">Cédula:</label>
                    <input type="text" required id="cedula" name="cedula" /> <br/><br/>
                    <label for="contrasena">Contraseña:</label>
                    <input type="password" required id="contrasena" name="contrasena" /> <br/><br/>
                    <div class="centrar">
                        <button type="submit">Ingresar</button><br/>
                    </div>
                </fieldset>
            </form>
        </div>
    </body>
</html>

