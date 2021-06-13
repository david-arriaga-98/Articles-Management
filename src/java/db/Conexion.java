package db;

import java.sql.*;

public class Conexion {

    String url = "jdbc:postgresql://localhost:5432/david_db";
    String usuario = "postgres";
    String clave = "david9812";

    public Connection obtenerConexion() {
        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection(url, usuario, clave);
            return connection;
        } catch (ClassNotFoundException e) {
            System.out.println("clase no encontrada");
        } catch (SQLException e) {
            System.out.println("Database Access Error.");
        }
        return null;

    }
}
