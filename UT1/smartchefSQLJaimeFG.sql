create table notificacion(
	id serial primary key,
	tipo int,
	texto varchar(200)
);
create table receta(
	id serial primary key,
	raciones int,
	nombre varchar(150),
	tiempo float,
	calorias int,
	dificultad int,
	descripcion varchar(200)
	constraint chk_receta_tiempo check (tiempo > 0),
    constraint chk_receta_raciones check (raciones between 1 and 12)
);
create table ingrediente(
	id serial primary key,
	nombre varchar(150),
	vegetariano bool,
	sin_gluten bool,
	calorias int,
	tipo_cantidad int,
	precio float
);
create table usuario(
	id serial primary key,
	rol int,
	nombre varchar(150),
	contrasenya varchar(150)
);
create table preferencia(
	id serial primary key,
	tipo int
);
create table foto(
	id serial primary key,
	id_receta int,
	constraint fk_foto_receta
	foreign key (id_receta)
	references receta(id)
	on delete cascade
);
create table paso(
	id serial primary key,
	id_receta int,
	descripcion varchar(200),
	numero int,
	constraint fk_foto_receta
	foreign key (id_receta)
	references receta(id)
	on delete cascade
);
create table receta_usuario(
	id serial primary key,
	id_receta int,
	id_usuario int,
	tipo int,
	fecha timestamp,
	constraint fk_receta_usuario_receta
	foreign key (id_receta)
	references receta(id)
	on delete cascade,
	constraint fk_receta_usuario_usuario
	foreign key (id_usuario)
	references usuario(id)
	on delete cascade
);
create table coleccion(
	id serial primary key,
	id_usuario int,
	nombre varchar(150),
	constraint fk_coleccion_usuario
	foreign key (id_usuario)
	references usuario(id)
	on delete cascade
);
create table usuario_preferencia(
	id_usuario int,
	id_preferencia int,
	primary key (id_usuario,id_preferencia),
	constraint fk_usuario_preferencia_usuario
	foreign key (id_usuario)
	references usuario(id)
	on delete cascade,
	constraint fk_usuario_preferencia_preferencia
	foreign key (id_preferencia)
	references preferencia(id)
	on delete cascade
);
create table receta_ingrediente(
	id serial primary key,
	id_ingrediente int,
	id_receta int,
	cantidad int,
	constraint fk_receta_ingrediente_ingrediente
		foreign key (id_ingrediente)
		references ingrediente(id)
		on delete cascade,
	constraint fk_receta_ingrediente_receta
		foreign key (id_receta)
		references receta(id)
		on delete cascade,
	constraint chk_receta_ingrediente_cantidad check (cantidad > 0)
);
create table receta_coleccion(
	id_receta int,
	id_coleccion int,
	primary key (id_receta,id_coleccion),
	constraint fk_receta_coleccion_receta
	foreign key (id_receta)
	references receta(id)
	on delete cascade,
	constraint fk_receta_coleccion_coleccion
	foreign key (id_coleccion)
	references coleccion(id)
	on delete cascade
);
create table lista_compra(
	id_usuario int,
	id_ingrediente int,
	primary key (id_usuario,id_ingrediente),
	constraint fk_lista_compra_usuario
	foreign key (id_usuario)
	references usuario(id)
	on delete cascade,
	constraint fk_lista_compra_ingrediente
	foreign key (id_ingrediente)
	references ingrediente(id)
	on delete cascade
);
create table despensa(
	id serial primary key,
	id_ingrediente int,
	id_usuario int,
	cantidad int,
	caducidad timestamp,
	constraint fk_despensa_ingrediente
		foreign key (id_ingrediente)
		references ingrediente(id)
		on delete cascade,
	constraint fk_despensa_usuario
		foreign key (id_usuario)
		references usuario(id)
		on delete cascade
);




