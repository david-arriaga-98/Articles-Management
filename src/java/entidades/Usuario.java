package entidades;

import db.*;
import java.sql.*;
import java.util.*;
import modelos.UsuarioModelo;

public class Usuario {

    private final String tabla = "usuario";
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
    

    public List<UsuarioModelo> obtenerTodosLosUsuarios() throws SQLException {
        List<UsuarioModelo> datos = new ArrayList();
        String cadena = "SELECT * FROM " + this.tabla;

        try {
            Connection conexion;
            conexion = conn.obtenerConexion();
            PreparedStatement p = conexion.prepareStatement(cadena);
            ResultSet rS = p.executeQuery();

            while (rS.next()) {
                datos.add(new UsuarioModelo(rS.getString("cedula"), rS.getString("nombres"), Integer.parseInt(rS.getString("edad")), rS.getString("sexo"), "", rS.getString("direccion"), rS.getString("tipo_de_usuario")));
            }
            conexion.close();
        } catch (SQLException e) {
            throw e;
        }
        return datos;
    }

    public List<UsuarioModelo> obtenerUsuario(String cedula) throws SQLException {
        List<UsuarioModelo> datos = new ArrayList(1);
        String cadena = "SELECT * FROM " + this.tabla + " WHERE cedula='" + cedula + "'";

        try {
            // 1. Obtenemos la conexion 
            Connection conexion;
            conexion = conn.obtenerConexion();
            PreparedStatement p = conexion.prepareStatement(cadena);
            ResultSet rS = p.executeQuery();
            if (rS.next()) {
                datos.add(new UsuarioModelo(rS.getString("cedula"), rS.getString("nombres"), Integer.parseInt(rS.getString("edad")),
                        rS.getString("sexo"), rS.getString("contrasena"), rS.getString("direccion"), rS.getString("tipo_de_usuario")));
            }
            conexion.close();
        } catch (SQLException e) {
            throw e;
        }

        return datos;
    }

    public int ingresarUsuario(UsuarioModelo usuario) throws SQLException {
        try {
            int estado;
            try (Connection conexion = conn.obtenerConexion()) {
                String s = "insert into " + this.tabla + " values ('" + usuario.cedula + "', '" + usuario.nombres + "', " + usuario.edad + ",'" + usuario.direccion + "', '" + usuario.sexo + "' ,'" + usuario.contrasena + "', 'USER');";
                PreparedStatement p = conexion.prepareStatement(s);
                estado = p.executeUpdate();
                conexion.close();
            }
            return estado;
        } catch (SQLException e) {
            throw e;
        }

    }

}
