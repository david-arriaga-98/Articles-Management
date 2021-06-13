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
public class ArticuloModelo {

    public String codigo_de_articulo;
    public double precio_unitario;
    public String nombre;
    public String descripcion;
    public int cantidad;
    public String url_de_imagen;

    public ArticuloModelo(String codigo_de_articulo, double precio_unitario, String nombre, String descripcion, int cantidad, String url_de_imagen) {
        this.codigo_de_articulo = codigo_de_articulo;
        this.precio_unitario = precio_unitario;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.cantidad = cantidad;
        this.url_de_imagen = url_de_imagen;
    }
}
