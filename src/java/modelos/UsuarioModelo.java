/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelos;

/**
 *
 * @author hugo
 */
public class UsuarioModelo {

    public String cedula;
    public String nombres;
    public int edad;
    public String sexo;
    public String contrasena;
    public String direccion;
    public String tipoDeUsuario;

    public UsuarioModelo(String cedula, String nombres, int edad, String sexo, String contrasena, String direccion, String tipoDeUsuario) {
        this.cedula = cedula;
        this.nombres = nombres;
        this.edad = edad;
        this.sexo = sexo;
        this.contrasena = contrasena;
        this.direccion = direccion;
        this.tipoDeUsuario = tipoDeUsuario;
    }
}
