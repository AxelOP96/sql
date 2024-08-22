/* Creación de base de datos*/
create database MuscuMax;
use MuscuMax;

/* Creación de tablas */
create table Usuario(
	usuarioId int primary key IDENTITY(1,1),
	nombre varchar(100) not null,
	apellido varchar(100) not null,
	email varchar(100) not null unique,
	password varchar(100) not null,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime,
	modificadoPor int,
	visible int default 1,
	habilitado int default 0
);

create table Perfil(
	perfilId int primary key IDENTITY(1,1),
	descripcion varchar(100)
);

create table Musculo(
	musculoId int primary key IDENTITY(1,1),
	descripcion varchar(100) unique
);

create table Ejercicio(
	ejercicioId int primary key IDENTITY(1,1),
	descripcion varchar(100),
	musculoId int,
	constraint fk_musculoid_ejercicio foreign key (musculoId) references Musculo(musculoId)
);


create table PerfilUsuario(
	usuarioId int,
	perfilId int,
	visible int default 1,
	constraint fk_idusuario_perfilusuario foreign key (usuarioId) references Usuario(usuarioId),
	constraint fk_idperfil_perfilusuario foreign key (perfilId) references Perfil(perfilId)
)

create table TipoRutina(
	idTipoRutina int not null primary key IDENTITY(1,1),
	descripcion varchar(100) unique
)

create table Rutina(
	rutinaId int primary key IDENTITY(1,1),
	ejercicioId int,
	serie int not null,
	repeticion int not null,
	peso int not null,
	idTipoRutina int,
	constraint fk_idTipoRutina foreign key (idTipoRutina) references TipoRutina(idTipoRutina)
);

create table RutinaUsuario(
	idRutinaUsuario int not null primary key IDENTITY(1,1),
	idUsuario int not null,
	idRutina int not null,
	visible int default 1,
	asignadoPor int not null,
	constraint fk_idUsuario_rutinausuario foreign key (idUsuario) references Usuario(usuarioId),
	constraint fk_idrutina_rutinausuario foreign key (idRutina) references Rutina(rutinaId),
	constraint fk_asignadoPor_rutingausuario foreign key (asignadoPor) references Usuario(usuarioId)
)


