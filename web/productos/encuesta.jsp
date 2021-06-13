<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelos.ArticulosEnFactura"%>
<%@page import="modelos.OrdenDeCompra"%>
<%@page import="entidades.Articulos"%>
<%@page import="modelos.UsuarioModelo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Encuesta</title>
        <link rel="stylesheet" href="../estilos.css"/>
        <style>
            label {
                font-size: inherit;
            }
        </style>

        <%
            boolean mostrarError = false;
            String mensajeDeError = "Ha ocurrido un error";
            String id = request.getParameter("fac");
            OrdenDeCompra orden = null;

            UsuarioModelo usuario = (UsuarioModelo) session.getAttribute("datos");
            if (usuario == null) {
                response.sendRedirect("/iniciar.jsp");
                return;
            } else {
                if (id != null) {
                    Articulos articu = new Articulos();
                    List<OrdenDeCompra> ordenes = articu.obtenerOrdenDeCompra(Integer.parseInt(id), usuario.cedula);
                    if (ordenes.isEmpty()) {
                        mostrarError = true;
                        mensajeDeError = "No existe esta orden";
                    } else {
                        orden = ordenes.get(0);
                        if (orden.realizo_encuesta) {
                            mostrarError = true;
                            mensajeDeError = "Ya se ha realizado la encuesta";
                        }
                    }
                } else {
                    mostrarError = true;
                    mensajeDeError = "No se ha dado un identificador";
                }
            }

        %>


    </head>
    <body>
        <jsp:include page="../PaginasParciales/cabecera.jsp"/>

        <% if (mostrarError) {%>
        <div class="centrar">
            <h1 style="color: #c62828"><%=mensajeDeError%></h1>
        </div>
        <% } else { %>

        <div class="centrar">
            <h1>Encuesta</h1>
            <div style="width: 90%; margin: 0 auto">
                <form method="POST" action="/Encuesta">

                    <p style="font-weight: bold">¿Cómo calificarías tu experiencia general con nuestros productos?</p>
                    <input required type="radio" id="0" name="001" value="0">
                    <label for="0">Totalmente insatisfactorio</label><br>
                    <input required type="radio" id="1" name="001" value="1">
                    <label for="1">Insatisfactorio</label><br>
                    <input required type="radio" id="2" name="001" value="2">
                    <label for="2">Neutra</label><br>
                    <input required type="radio" id="3" name="001" value="3">
                    <label for="3">Satisfactoria</label><br>
                    <input required type="radio" id="4" name="001" value="4">
                    <label for="4">Totalmente satisfactoria</label><br>

                    <p style="font-weight: bold">Considerando tu experiencia con nuestros productos y servicios, ¿Cuál es la probablidad de que recomiendes nuestra marca a un amigo o familiar?</p>

                    <input required name="002" id="rango" style="width: 50%;" min="0" max="10" type="range" list="tickmarks">
                    <datalist id="tickmarks">
                        <option value="0" label="0%">
                        <option value="5">
                        <option value="10">
                    </datalist>

                    <p style="color: #0D47A1; font-size: 12px">Valor: <span id="valor">5</span></p>

                    <p style="font-weight: bold">¿Cómo calificarías nuestros productos en las siguientes áreas?</p>

                    <table CELLSPACING="20">
                        <tr>
                            <th></th>
                            <th>Muy insatisfecho</th>
                            <th>Insatisfecho</th>
                            <th>Neutro</th>
                            <th>Satisfecho</th>
                        </tr>
                        <tr>
                            <td>Calidad</td>
                            <td><input required type="radio" name="003" value="0"></td>
                            <td><input required type="radio" name="003" value="1"></td>
                            <td><input required type="radio" name="003" value="2"></td>
                            <td><input required type="radio" name="003" value="3"></td>
                        </tr>
                        <tr>
                            <td>Precio</td>
                            <td><input required type="radio" name="004" value="0"></td>
                            <td><input required type="radio" name="004" value="1"></td>
                            <td><input required type="radio" name="004" value="2"></td>
                            <td><input required type="radio" name="004" value="3"></td>
                        </tr>
                        <tr>
                            <td>Atractivo visual</td>
                            <td><input required type="radio" name="005" value="0"></td>
                            <td><input required type="radio" name="005" value="1"></td>
                            <td><input required type="radio" name="005" value="2"></td>
                            <td><input required type="radio" name="005" value="3"></td>
                        </tr>
                        <tr>
                            <td>Experiencia de compra</td>
                            <td><input required type="radio" name="006" value="0"></td>
                            <td><input required type="radio" name="006" value="1"></td>
                            <td><input required type="radio" name="006" value="2"></td>
                            <td><input required type="radio" name="006" value="3"></td>
                        </tr>
                        <tr>
                            <td>Instrucciones de uso</td>
                            <td><input required type="radio" name="007" value="0"></td>
                            <td><input required type="radio" name="007" value="1"></td>
                            <td><input required type="radio" name="007" value="2"></td>
                            <td><input required type="radio" name="007" value="3"></td>
                        </tr>
                        <tr>
                            <td>Soporte al cliente</td>
                            <td><input required type="radio" name="008" value="0"></td>
                            <td><input required type="radio" name="008" value="1"></td>
                            <td><input required type="radio" name="008" value="2"></td>
                            <td><input required type="radio" name="008" value="3"></td>
                        </tr>
                        <tr>
                            <td>Sitio web</td>
                            <td><input required type="radio" name="009" value="0"></td>
                            <td><input required type="radio" name="009" value="1"></td>
                            <td><input required type="radio" name="009" value="2"></td>
                            <td><input required type="radio" name="009" value="3"></td>
                        </tr>
                    </table>

                    <p style="font-weight: bold">Por favor, marca del 1 al 3 cuál de estas tres áreas te gustaría mejorar</p>

                    <table CELLSPACING="20">
                        <tr>
                            <td>Método de pago</td>
                            <td>
                                <select name="0010">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Aspecto de la página</td>
                            <td>
                                <select name="0011">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Variedad de productos</td>
                            <td>
                                <select name="0012">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                </select>
                            </td>
                        </tr>
                    </table>

                    <p style="font-weight: bold">¿Tienes algún comentario o sugerencia para nosotros?</p>
                    <textarea name="0013" rows="5" cols="50" style="width: 50%" placeholder="Escriba su comentario" ></textarea>
                    <br/>
                    <input type="hidden" name="factura" value="<%=id%>" />
                    <button style="margin-bottom: 20px; margin-top: 10px;" type="submit">Enviar</button>
                </form>
            </div>

        </div>

        <% }%>

        <script>
            let valor = document.getElementById("valor");
            document.getElementById("rango").addEventListener("change", (e) => {
                valor.innerHTML = e.target.value;
            });
        </script>
    </body>
</html>
