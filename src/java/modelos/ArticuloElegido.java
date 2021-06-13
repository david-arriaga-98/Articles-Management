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
public class ArticuloElegido {
        public int codigo;
        public int numero_de_orden;
        public String usuario_que_elije;
        public int numero_de_articulos;
        public double valor_total;

    public ArticuloElegido(int codigo, int numero_de_orden, String usuario_que_elije, int numero_de_articulos, double valor_total) {
        this.codigo = codigo;
        this.numero_de_orden = numero_de_orden;
        this.usuario_que_elije = usuario_que_elije;
        this.numero_de_articulos = numero_de_articulos;
        this.valor_total = valor_total;
    }
   
}
