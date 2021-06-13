<%@page import="modelos.Encuesta"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidades.Articulos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reporte de aceptación del usuario</title>
        <link rel="stylesheet" href="../estilos.css"/>
        <%

            int[][] resp = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0},
                {0, 0, 0, 0},
                {0, 0, 0, 0},
                {0, 0, 0, 0},
                {0, 0, 0, 0},
                {0, 0, 0, 0},
                {0, 0, 0, 0},
                {0, 0, 0},
                {0, 0, 0},
                {0, 0, 0}};

            Articulos art = new Articulos();
            ArrayList<Encuesta> encuestas = art.obtenerEncuestas();

            for (int x = 0; x < encuestas.size(); x++) {

                int resp_dada = Integer.parseInt(encuestas.get(x).respuesta_dada);

                if (encuestas.get(x).pregunta.equals("001")) {
                    resp[0][resp_dada]++;
                } else if (encuestas.get(x).pregunta.equals("002")) {
                    resp[1][resp_dada]++;
                } else if (encuestas.get(x).pregunta.equals("003")) {
                    resp[2][resp_dada]++;
                } else if (encuestas.get(x).pregunta.equals("004")) {
                    resp[3][resp_dada]++;
                } else if (encuestas.get(x).pregunta.equals("005")) {
                    resp[4][resp_dada]++;
                } else if (encuestas.get(x).pregunta.equals("006")) {
                    resp[5][resp_dada]++;
                } else if (encuestas.get(x).pregunta.equals("007")) {
                    resp[6][resp_dada]++;
                } else if (encuestas.get(x).pregunta.equals("008")) {
                    resp[7][resp_dada]++;
                } else if (encuestas.get(x).pregunta.equals("009")) {
                    resp[8][resp_dada]++;
                } else if (encuestas.get(x).pregunta.equals("0010")) {
                    resp[9][resp_dada - 1]++;
                } else if (encuestas.get(x).pregunta.equals("0011")) {
                    resp[10][resp_dada - 1]++;
                } else if (encuestas.get(x).pregunta.equals("0012")) {
                    resp[11][resp_dada - 1]++;
                }
            }

            /*/ Llenamos la matriz
            for (int i = 0 ; i < resp.length ; i ++ ) {
                for(int j = 0 ; j < resp[i].length ; j++) {
                    
                }
            }*/

        %>
    </head>
    <body>
        <jsp:include page="../PaginasParciales/cabecera.jsp"/>
        <div class="centrar">
            <h1>Resultado general de las encuesta</h1>
            <div style="width: 90%; margin: 0 auto">
                <p style="font-weight: bold">1. Encuestas realizadas:</p>
                <p style="color: #0D47A1; margin-left: 25px"><%=encuestas.size() / 12%></p>
                <p style="font-weight: bold">2. ¿Cómo calificarías tu experiencia general con nuestros productos?</p>
                <i style="color: #0D47A1; margin-left: 25px">Totalmente insatisfactorio: <b><%=resp[0][0]%></b></i><br>
                <i style="color: #0D47A1; margin-left: 25px">Insatisfactorio: <b><%=resp[0][1]%></b></i><br>
                <i style="color: #0D47A1; margin-left: 25px">Neutra: <b><%=resp[0][2]%></b></i><br>
                <i style="color: #0D47A1; margin-left: 25px">Satisfactoria: <b><%=resp[0][3]%></b></i><br>
                <i style="color: #0D47A1; margin-left: 25px">Totalmente satisfactoria: <b><%=resp[0][4]%></b></i>
                <p style="font-weight: bold">3. Considerando tu experiencia con nuestros productos y servicios, ¿Cuál es la probablidad de que recomiendes nuestra marca a un amigo o familiar?</p>

                <table CELLSPACING="20">
                    <tr>
                        <th>0</th>
                        <th>1</th>
                        <th>2</th>
                        <th>3</th>
                        <th>4</th>
                        <th>5</th>
                        <th>6</th>
                        <th>7</th>
                        <th>8</th>
                        <th>9</th>
                        <th>10</th>
                    </tr>
                    <tr>
                        <th>
                            <b style="color: #0D47A1;"><%=resp[1][0]%></b>
                        </th>
                        <th>
                            <b style="color: #0D47A1;"><%=resp[1][1]%></b>
                        </th>
                        <th>
                            <b style="color: #0D47A1;"><%=resp[1][2]%></b>
                        </th>
                        <th>
                            <b style="color: #0D47A1;"><%=resp[1][3]%></b>
                        </th>
                        <th>
                            <b style="color: #0D47A1;"><%=resp[1][4]%></b>
                        </th>
                        <th>
                            <b style="color: #0D47A1;"><%=resp[1][5]%></b>
                        </th>
                        <th>
                            <b style="color: #0D47A1;"><%=resp[1][6]%></b>
                        </th>
                        <th>
                            <b style="color: #0D47A1;"><%=resp[1][7]%></b>
                        </th>
                        <th>
                            <b style="color: #0D47A1;"><%=resp[1][8]%></b>
                        </th>
                        <th>
                            <b style="color: #0D47A1;"><%=resp[1][9]%></b>
                        </th>
                        <th>
                            <b style="color: #0D47A1;"><%=resp[1][10]%></b>
                        </th>
                    </tr>
                </table>

                <p style="font-weight: bold">4. ¿Cómo calificarías nuestros productos en las siguientes áreas?</p>

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
                        <td><b style="color: #0D47A1;"><%=resp[2][0]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[2][1]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[2][2]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[2][3]%></b></td>
                    </tr>
                    <tr>
                        <td>Precio</td>
                        <td><b style="color: #0D47A1;"><%=resp[3][0]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[3][1]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[3][2]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[3][3]%></b></td>
                    </tr>
                    <tr>
                        <td>Atractivo visual</td>
                        <td><b style="color: #0D47A1;"><%=resp[4][0]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[4][1]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[4][2]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[4][3]%></b></td>
                    </tr>
                    <tr>
                        <td>Experiencia de compra</td>
                        <td><b style="color: #0D47A1;"><%=resp[5][0]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[5][1]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[5][2]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[5][3]%></b></td>
                    </tr>
                    <tr>
                        <td>Instrucciones de uso</td>
                        <td><b style="color: #0D47A1;"><%=resp[6][0]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[6][1]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[6][2]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[6][3]%></b></td>
                    </tr>
                    <tr>
                        <td>Soporte al cliente</td>
                        <td><b style="color: #0D47A1;"><%=resp[7][0]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[7][1]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[7][2]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[7][3]%></b></td>
                    </tr>
                    <tr>
                        <td>Sitio web</td>
                        <td><b style="color: #0D47A1;"><%=resp[8][0]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[8][1]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[8][2]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[8][3]%></b></td>
                    </tr>
                </table>

                <p style="font-weight: bold">5. Por favor, marca del 1 al 3 cuál de estas tres áreas te gustaría mejorar</p>

                <table CELLSPACING="20">
                    <tr>
                        <th></th>
                        <th>1</th>
                        <th>2</th>
                        <th>3</th>
                    </tr>
                    <tr>
                        <td>Método de pago</td>
                        <td><b style="color: #0D47A1;"><%=resp[9][0]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[9][1]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[9][2]%></b></td>
                    </tr>
                    <tr>
                        <td>Aspecto de la página</td>
                        <td><b style="color: #0D47A1;"><%=resp[10][0]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[10][1]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[10][2]%></b></td>
                    </tr>
                    <tr>
                        <td>Variedad de productos</td>
                        <td><b style="color: #0D47A1;"><%=resp[11][0]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[11][1]%></b></td>
                        <td><b style="color: #0D47A1;"><%=resp[11][2]%></b></td>
                    </tr>
                </table>

            </div>
        </div>
    </body>
</html>
