<%@page import="modelos.UsuarioModelo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrarse</title>
        <link rel="stylesheet" href="estilos.css"/>
        <%
            UsuarioModelo usuario = (UsuarioModelo) session.getAttribute("datos");
            if (usuario != null) {
                response.sendRedirect("/productos");
            }
        %>
    </head>
    <body>
        <jsp:include page="PaginasParciales/cabecera.jsp"/>
        <div class="centrar">
            <h1>Registre un usuario</h1>
            <form method="POST" action="RegistrarUsuario">
                <fieldset style="width: 210px">
                    <br/>
                    <label for="cedula">Cédula:</label>
                    <input type="text" required id="cedula" name="cedula" minlength="10" maxlength="10" pattern="[0-9]+" title="Solo se permiten números" /> <br/><br/>
                    <label for="nombres">Nombres:</label>
                    <input type="text" required id="nombres" name="nombres" /> <br/><br/>
                    <label for="edad">Edad:</label>
                    <input type="text" required id="edad" name="edad" minlength="2" maxlength="2" pattern="[0-9]+" title="Solo se permiten números" /> <br/><br/>
                    <label for="direccion">Dirección:</label>
                    <input type="text" required id="direccion" name="direccion" /> <br/><br/>
                    <label for="contrasena">Contraseña:</label>
                    <input type="password" required id="contrasena" name="contrasena" /> <br/><br/>
                    <label for="sexo">Género:</label>
                    <select name="sexo" id="sexo">
                        <option value="M">Masculino</option>
                        <option value="F">Femenino</option>
                    </select> <br/><br/>
                    <div class="centrar">
                        <button type="submit">Guardar</button><br/>
                    </div>
                </fieldset>

            </form>

        </div>

    </body>
</html>
