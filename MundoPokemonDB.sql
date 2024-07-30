USE [master]
GO

/****** Object:  Database [MundoPokemonDB]    Script Date: 29/7/2024 19:32:02 ******/
CREATE DATABASE [MundoPokemonDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MundoPokemonDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\MundoPokemonDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MundoPokemonDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\MundoPokemonDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MundoPokemonDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [MundoPokemonDB] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET ARITHABORT OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [MundoPokemonDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [MundoPokemonDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET  DISABLE_BROKER 
GO

ALTER DATABASE [MundoPokemonDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [MundoPokemonDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [MundoPokemonDB] SET  MULTI_USER 
GO

ALTER DATABASE [MundoPokemonDB] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [MundoPokemonDB] SET DB_CHAINING OFF 
GO

ALTER DATABASE [MundoPokemonDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [MundoPokemonDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [MundoPokemonDB] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [MundoPokemonDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [MundoPokemonDB] SET QUERY_STORE = ON
GO

ALTER DATABASE [MundoPokemonDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO

ALTER DATABASE [MundoPokemonDB] SET  READ_WRITE 
GO

CREATE TABLE Elementos(
	Id int PRIMARY KEY,
	Descripcion varchar(20)
	)
CREATE TABLE Medallas(
	Id int PRIMARY KEY,
	Nombre varchar(50),
	ImagenUrl varchar(100)
	)
CREATE TABLE Ciudades(
	Id int PRIMARY KEY,
	Nombre varchar(25)
	)
CREATE TABLE Entrenadores(
	Id int PRIMARY KEY,
	Nombre varchar(20),
	Apellido varchar(20),
	NickName varchar(30),
	Email varchar(50) UNIQUE,
	Clave varchar(50),
	FechaNacimiento date
	)
CREATE TABLE Gimnasios(
	Id int PRIMARY KEY,
	Nombre varchar(20),
	IdCiudad int,
	IdMedalla int,
	IdEntrenador int
	CONSTRAINT FK_Gimnasios_Ciudad FOREIGN KEY (IdCiudad) REFERENCES Ciudades (id),
	CONSTRAINT FK_Gimnasios_Medalla FOREIGN KEY (IdMedalla) REFERENCES Medallas(id),
	CONSTRAINT FK_Gimnasios_Entrenador FOREIGN KEY (IdEntrenador) REFERENCES Entrenadores(id)
	)
CREATE TABLE [Entrenadores.Medallas](
	Id int PRIMARY KEY,
	IdEntrenador int,
	IdMedalla int,
	FechaObtencion date,
	CONSTRAINT FK_EntrenadoresMedallas_Entrenador FOREIGN KEY (IdEntrenador) REFERENCES Entrenadores(Id),
	CONSTRAINT FK_EntrenadoresMedallas_Medalla FOREIGN KEY (IdMedalla) REFERENCES Medallas(Id)
	)
CREATE TABLE Pokemons(
	Id int PRIMARY KEY,
	Nombre varchar(20),
	Numero int,
	Bio varchar(50),
	Altura float,
	Peso float,
	ImagenUrl varchar(100),
	IdEvolucion int UNIQUE
	)
CREATE TABLE [Evoluciones.Variables](
	Id int PRIMARY KEY,
	IdEvolucion int,
	IdPokemon int,
	CONSTRAINT FK_EvoVariables_Pokemon FOREIGN KEY (IdPokemon) REFERENCES Pokemons(id),
	CONSTRAINT FK_EvoVariables_Evolucion FOREIGN KEY (IdEvolucion) REFERENCES Pokemons(IdEvolucion)
	)
CREATE TABLE [Pokemons.Tipos](
	Id int PRIMARY KEY,
	IdPokemon int, 
	IdElemento int,
	CONSTRAINT FK_PokeTipos_Pokemon FOREIGN KEY (IdPokemon) REFERENCES Pokemons(Id),
	CONSTRAINT FK_PokeTipos_Elementos FOREIGN KEY (IdElemento) REFERENCES Elementos(Id)
	)
CREATE TABLE [Pokemons.Debilidades](
	Id int PRIMARY KEY,
	IdPokemon int,
	IdElemento int,
	CONSTRAINT FK_PokeDebilidades_Pokemon FOREIGN KEY (IdPokemon) REFERENCES Pokemons(Id),
	CONSTRAINT FK_PokeDebilidades_Elementos FOREIGN KEY (IdElemento) REFERENCES Elementos(Id)
)
CREATE TABLE Habilidades(
	Id int PRIMARY KEY,
	Nombre Varchar(30),
	Descripcion varchar(30),
	IdTipo int,
	CONSTRAINT FK_Habilidades_Tipo FOREIGN KEY (IdTipo) REFERENCES [Pokemons.Tipos] (Id)
	)
CREATE TABLE [Pokemon.Habilidades](
	Id int PRIMARY KEY,
	IdPokemon int,
	IdHabilidad int,
	CONSTRAINT FK_PokeHabilidades_Pokemon FOREIGN KEY(IdPokemon) REFERENCES Pokemons(Id),
	CONSTRAINT FK_PokeHabilidades_Habilidad FOREIGN KEY(IdHabilidad) REFERENCES Habilidades(Id)
	)
CREATE TABLE [Entrenadores.Pokemons](
	Id int PRIMARY KEY,
	IdEntrenador int,
	IdPokemon int,
	Nombre varchar(30),
	CONSTRAINT FK_EntrenadorPokemon_Entrenador FOREIGN KEY (IdEntrenador) REFERENCES Entrenadores(Id),
	CONSTRAINT FK_EntrenadorPokemon_Pokemon FOREIGN KEY (IdPokemon) REFERENCES Pokemons(Id)
	)