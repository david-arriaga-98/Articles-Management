<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css"
              integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A=="
              crossorigin=""/>
        <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"
                integrity="sha512-XQoYMqMTK8LvdxXYG3nZ448hOEQiglfqkJs1NOQV44cWnUrBc8PkAOcXy20w0vlaXaVUearIOBhiXZ5V3ynxwA=="
        crossorigin=""></script>
        <style>
            #map {
                margin: 0 auto;
                margin-top: 20px;
                height: 500px;
                width: 50%;
                border-radius: 10px;
            }
        </style>
        <link rel="stylesheet" href="estilos.css"/>
    </head>
    <body>
        <jsp:include page="PaginasParciales/cabecera.jsp"/>
        <div id="map"></div>

        <script>
            
            let coordenadas = [-2.19616, -79.88621];
            var Icono = L.icon({
                iconUrl: "https://www.flaticon.es/svg/static/icons/svg/1008/1008286.svg",
                iconSize: [30, 40],
                iconAnchor: [15, 40],
                popupAnchor: [0, -40]
            });
            var map = L.map('map').setView(coordenadas, 13);
            L.tileLayer('https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png').addTo(map);
            L.marker([-2.19616, -79.88621], {
                icon: Icono,
                opacity: 0.75
            }).addTo(map)
                    .bindPopup('<i>Tienda 1</i><br/><i>Entre Noguchi y Cristobal Colón</i>');
            
            L.marker([-2.18, -79.84], {
                icon: Icono,
                opacity: 0.75
            }).addTo(map)
                    .bindPopup('<i>Tienda 2</i><br/><i>Los Rios y Clemente Ballén</i>');
            
            L.marker([-2.192, -79.895], {
                icon: Icono,
                opacity: 0.75
            }).addTo(map)
                    .bindPopup('<i>Tienda 3</i><br/><i>Leon Febres Cordero y Avenida Central</i>');
            
        </script>
    </body>
</html>
