create table usuario (
	cedula varchar(100) PRIMARY KEY,
	nombres varchar(100) not null,
	edad integer not null,
	direccion varchar(200) not null,
	sexo varchar(10) not null,
	contrasena varchar(100) not null,
	tipo_de_usuario varchar(30) not null
);
create table articulos(
	codigo_de_articulo varchar(100) not null PRIMARY KEY ,
	precio_unitario decimal(10, 2) not null,
	nombre varchar(100) not null,
	descripcion text not null,
	cantidad Integer not null,
	url_de_imagen text not null
);

create table orden_de_compra (
	codigo serial primary key,
	estado boolean not null default false,
	metodo_de_pago varchar(200),
	descuento decimal(10, 2),
	precio_total decimal(10, 2),
	numero_de_articulos integer,
	direccion_a_facturar varchar(200),
	tarjeta varchar(20),
	realizo_encuesta boolean not null default false,
	usuario_que_pertenece varchar(100),
	constraint fk_orden_compra_usuario foreign key(usuario_que_pertenece) references usuario(cedula)
);
create table articulo_elegido (
	codigo serial primary key,
	numero_de_orden integer not null,
	usuario_que_elije varchar(100) not null,
	articulo_que_pertenece varchar(100) not null,
	numero_de_articulos integer not null,
	valor_total decimal(10, 2) not null,
	constraint fk_articulo_elegido_orden_de_compra foreign key(numero_de_orden) references orden_de_compra(codigo),
	constraint fk_articulo_elegido_usuario foreign key(usuario_que_elije) references usuario(cedula),
	constraint fk_articulo_elegido_articulos foreign key(articulo_que_pertenece) references articulos(codigo_de_articulo)
);
create table encuesta (
	id_respuesta serial primary key,
	id_orden Integer,
	pregunta varchar(10) not null,
	respuesta_dada text,
	constraint fk_enc_orden foreign key(id_orden) references orden_de_compra(codigo)
);
insert into usuario values ('0000000000', 'Administrador 1', 21, 'Direccion ficticia 1', 'M', 'contra', 'ADMIN');

insert into articulos values('26020',64.6,'Licuadora Haceb','600 Watts 3 Velocidades Negro 4655B',420,'https://crecos.vteximg.com.br/arquivos/ids/180474-398-398/Licuadora-Oster-600-Watts-3-Velocidades-Negro-4655B.jpg?v=637225890489500000');
insert into articulos values('72782',328.91,'Cocina a Gas Haceb','Cocina a Gas Haceb EM6060FX0 | 4 Quemadores 60 cm Acero Inoxidable',95,'https://crecos.vteximg.com.br/arquivos/ids/180529-1000-1000/Cocina-a-Gas-Mabe-EM6060FX0-4-Quemadores-60-cm-Acero-Inoxidable.jpg?v=637227507632730000');
insert into articulos values('66664',361.54,'TV LED Smart Haceb 32 Pulgadas','Televisor HD con Netflix y Youtube',200,'https://www.ecuabuy.com.ec/190-home_default/televisor-led-32-innova-smart-tv-android-60-in32d6s.jpg');
insert into articulos values('42796',824.62,'Refrigeradora Haceb 20 pulgadas 568 Litros','Refrigeradora inteligente y compacta, indeal para tu hogar',33,'https://crecos.vteximg.com.br/arquivos/ids/175902-1000-1000/Refrigeradora-SMC-SMCRF20SSP-20-489-Litros.jpg?v=637105771552670000');
insert into articulos values('55244',129.27,'Silla de Comedor Marriott P90','Silla elegante, para cualquier tipo de evento',1240,'https://crecos.vteximg.com.br/arquivos/ids/178255-1000-1000/Silla-de-Comedor-Marriot-J10575-W.jpg?v=637161029152270000');
insert into articulos values('13497',891.43,'Split Inverter Haceb 12000 BTU','Sin descripción',243,'https://crecos.vteximg.com.br/arquivos/ids/180791-1000-1000/Split-Inverter-Panasonic-CS-S12TKV-12000-BTU-Croma.jpg?v=637232580404400000');
insert into articulos values('11984',114.07,'Microonda Haceb Negro 1.1 32 Lt','Microonda elegante, para mantener todas tus comidas calientes',890,'https://crecos.vteximg.com.br/arquivos/ids/159058-1000-1000/FRep3jsARWy0SzU4nqvT_1483473695.jpg?v=636441048381100000');
insert into articulos values('34077',624.44,'Lavadora Automática Haceb 17KG','Sin descripción',56,'https://crecos.vteximg.com.br/arquivos/ids/182770-1000-1000/lavadora-whirlpool-7MWTW1700EM.jpg?v=637293239987170000');

