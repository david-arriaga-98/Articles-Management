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
public class OrdenDeCompra {

    public int codigo;
    public boolean estado;
    public String metodo_de_pago;
    public double descuento;
    public double precio_total;
    public int numero_de_articulos;
    public String usuario_que_pertenece;
    public String direccion_a_facturar;
    public String tarjeta;
    public boolean realizo_encuesta;
    
    public OrdenDeCompra(int codigo, boolean estado, String metodo_de_pago, double descuento,
            double precio_total, int numero_de_articulos, String usuario_que_pertenece, String direccion_a_facturar, String tarjeta, boolean realizo_encuesta) {

        this.codigo = codigo;
        this.estado = estado;
        this.metodo_de_pago = metodo_de_pago;
        this.descuento = descuento;
        this.precio_total = precio_total;
        this.numero_de_articulos = numero_de_articulos;
        this.usuario_que_pertenece = usuario_que_pertenece;
        this.direccion_a_facturar = direccion_a_facturar;
        this.tarjeta = tarjeta;
        this.realizo_encuesta = realizo_encuesta;
    }

}
