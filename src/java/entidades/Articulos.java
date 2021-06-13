package entidades;

import db.Conexion;
import java.sql.*;
import java.util.*;
import modelos.*;

public class Articulos {

    private final String tabla = "articulos";
    private final Conexion conn = new Conexion();

    public int ejecutarActualizacion(String secuencia) throws SQLException {
        try {
            try (Connection conexion = conn.obtenerConexion()) {
                int estado;
                PreparedStatement p = conexion.prepareStatement(secuencia);
                estado = p.executeUpdate();
                return estado;
            }
        } catch (SQLException e) {
            throw e;
        }
    }

    public List<ArticuloModelo> obtenerArticulos() throws SQLException {
        List<ArticuloModelo> datos = new ArrayList();
        String cadena = "SELECT * FROM " + this.tabla + " order by codigo_de_articulo desc";

        try {
            // 1. Obtenemos la conexion 
            Connection conexion;
            conexion = conn.obtenerConexion();
            PreparedStatement p = conexion.prepareStatement(cadena);
            ResultSet rS = p.executeQuery();

            while (rS.next()) {
                datos.add(new ArticuloModelo(rS.getString("codigo_de_articulo"), Double.parseDouble(rS.getString("precio_unitario")), rS.getString("nombre"), rS.getString("descripcion"), Integer.parseInt(rS.getString("cantidad")), rS.getString("url_de_imagen")));
            }
            conexion.close();
        } catch (SQLException e) {
            throw e;
        }
        return datos;
    }

    public List<ArticuloModelo> obtenerArticulo(String codigo) throws SQLException {
        List<ArticuloModelo> datos = new ArrayList(1);
        String cadena = "SELECT * FROM " + this.tabla + " WHERE codigo_de_articulo='" + codigo + "'";
        try {
            // 1. Obtenemos la conexion 
            Connection conexion;
            conexion = conn.obtenerConexion();
            PreparedStatement p = conexion.prepareStatement(cadena);
            ResultSet rS = p.executeQuery();

            if (rS.next()) {
                datos.add(new ArticuloModelo(rS.getString("codigo_de_articulo"), Double.parseDouble(rS.getString("precio_unitario")), rS.getString("nombre"), rS.getString("descripcion"), Integer.parseInt(rS.getString("cantidad")), rS.getString("url_de_imagen")));
            }
            conexion.close();
        } catch (SQLException e) {
            throw e;
        }
        return datos;
    }

    public List<OrdenDeCompra> obtenerOrdenesDeCompra(String cedula) throws SQLException {
        List<OrdenDeCompra> datos = new ArrayList();
        String cadena = "select * from orden_de_compra where usuario_que_pertenece='" + cedula + "' order by codigo desc ";

        try {
            // 1. Obtenemos la conexion 
            Connection conexion;
            conexion = conn.obtenerConexion();
            PreparedStatement p = conexion.prepareStatement(cadena);
            ResultSet rS = p.executeQuery();
            // Siempre tomará el ultimo dato agregado
            while (rS.next()) {
                // Ahora asignamos
                OrdenDeCompra ordenDeCompra = new OrdenDeCompra(Integer.parseInt(rS.getString("codigo")), rS.getString("estado").equals("t"), rS.getString("metodo_de_pago") == null ? "" : rS.getString("metodo_de_pago"),
                        rS.getString("descuento") == null ? 0 : Double.parseDouble(rS.getString("descuento")), rS.getString("precio_total") == null ? 0 : Double.parseDouble(rS.getString("precio_total")),
                        rS.getString("numero_de_articulos") == null ? 0 : Integer.parseInt(rS.getString("numero_de_articulos")), rS.getString("usuario_que_pertenece") == null ? "" : rS.getString("usuario_que_pertenece"), rS.getString("direccion_a_facturar") == null ? "" : rS.getString("direccion_a_facturar"), rS.getString("tarjeta") == null ? "" : rS.getString("tarjeta"), rS.getString("realizo_encuesta").equals("t"));
                datos.add(ordenDeCompra);
            }
            conexion.close();
        } catch (SQLException e) {
            throw e;
        }
        return datos;
    }

    public ArrayList<ArticulosEnFactura> obtenerArticulosDeFactura(int numero_de_orden) throws SQLException {

        ArrayList<ArticulosEnFactura> datos = new ArrayList();
        String s = "select numero_de_articulos as total, valor_total as valor, nombre, url_de_imagen as url, precio_unitario as precio from articulo_elegido as artEle join articulos as art on articulo_que_pertenece = art.codigo_de_articulo where numero_de_orden=" + numero_de_orden + ";";

        try {
            // 1. Obtenemos la conexion 
            Connection conexion;
            conexion = conn.obtenerConexion();
            PreparedStatement p = conexion.prepareStatement(s);
            ResultSet rS = p.executeQuery();
            // Siempre tomará el ultimo dato agregado
            while (rS.next()) {
                datos.add(new ArticulosEnFactura(Integer.parseInt(rS.getString("total")), Double.parseDouble(rS.getString("valor")), rS.getString("nombre"), rS.getString("url"), Double.parseDouble(rS.getString("precio"))));
            }
            conexion.close();
        } catch (SQLException e) {
            throw e;
        }
        return datos;
    }

    public List<OrdenDeCompra> obtenerOrdenDeCompra(int orden, String cedula) throws SQLException {
        List<OrdenDeCompra> datos = new ArrayList();
        String cadena = "select * from orden_de_compra where codigo=" + orden + " and usuario_que_pertenece='" + cedula + "';";
        try {
            // 1. Obtenemos la conexion 
            Connection conexion;
            conexion = conn.obtenerConexion();
            PreparedStatement p = conexion.prepareStatement(cadena);
            ResultSet rS = p.executeQuery();
            // Siempre tomará el ultimo dato agregado
            if (rS.next()) {
                // Ahora asignamos
                OrdenDeCompra ordenDeCompra = new OrdenDeCompra(Integer.parseInt(rS.getString("codigo")), rS.getString("estado").equals("t"), rS.getString("metodo_de_pago") == null ? "" : rS.getString("metodo_de_pago"),
                        rS.getString("descuento") == null ? 0 : Double.parseDouble(rS.getString("descuento")), rS.getString("precio_total") == null ? 0 : Double.parseDouble(rS.getString("precio_total")),
                        rS.getString("numero_de_articulos") == null ? 0 : Integer.parseInt(rS.getString("numero_de_articulos")), rS.getString("usuario_que_pertenece") == null ? "" : rS.getString("usuario_que_pertenece"), rS.getString("direccion_a_facturar") == null ? "" : rS.getString("direccion_a_facturar"), rS.getString("tarjeta") == null ? "" : rS.getString("tarjeta"), rS.getString("realizo_encuesta").equals("t"));
                datos.add(ordenDeCompra);
            }
            conexion.close();
            return datos;

        } catch (SQLException e) {
            System.out.println("Valio gaver");
            throw e;
        }
    }

    public List<OrdenDeCompra> obtenerOrdenDeCompraPor(String propiedad, String valor) throws SQLException {
        List<OrdenDeCompra> datos = new ArrayList();
        String cadena = "select * from orden_de_compra where " + propiedad + " = '" + valor + "';";
        try {
            // 1. Obtenemos la conexion 
            Connection conexion;
            conexion = conn.obtenerConexion();
            PreparedStatement p = conexion.prepareStatement(cadena);
            ResultSet rS = p.executeQuery();
            // Siempre tomará el ultimo dato agregado
            if (rS.next()) {
                // Ahora asignamos
                OrdenDeCompra ordenDeCompra = new OrdenDeCompra(Integer.parseInt(rS.getString("codigo")), rS.getString("estado").equals("t"), rS.getString("metodo_de_pago") == null ? "" : rS.getString("metodo_de_pago"),
                        rS.getString("descuento") == null ? 0 : Double.parseDouble(rS.getString("descuento")), rS.getString("precio_total") == null ? 0 : Double.parseDouble(rS.getString("precio_total")),
                        rS.getString("numero_de_articulos") == null ? 0 : Integer.parseInt(rS.getString("numero_de_articulos")), rS.getString("usuario_que_pertenece") == null ? "" : rS.getString("usuario_que_pertenece"), rS.getString("direccion_a_facturar") == null ? "" : rS.getString("direccion_a_facturar"), rS.getString("tarjeta") == null ? "" : rS.getString("tarjeta"), rS.getString("realizo_encuesta").equals("t"));
                datos.add(ordenDeCompra);
            }
            conexion.close();
            return datos;

        } catch (SQLException e) {
            System.out.println("Valio gaver");
            throw e;
        }
    }
    
    
    public ArrayList<Encuesta> obtenerEncuestas() throws SQLException {

        ArrayList<Encuesta> datos = new ArrayList();
        String s = "SELECT * FROM encuesta WHERE pregunta <> '0013';";

        try {
            // 1. Obtenemos la conexion 
            Connection conexion;
            conexion = conn.obtenerConexion();
            PreparedStatement p = conexion.prepareStatement(s);
            ResultSet rS = p.executeQuery();
            // Siempre tomará el ultimo dato agregado
            while (rS.next()) {
                datos.add(new Encuesta(Integer.parseInt(rS.getString("id_respuesta")), Integer.parseInt(rS.getString("id_orden")), rS.getString("pregunta"), rS.getString("respuesta_dada")));
            }
            conexion.close();
        } catch (SQLException e) {
            throw e;
        }
        return datos;
    }
    
    

}
