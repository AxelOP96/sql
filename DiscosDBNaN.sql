USE [master]
GO

/****** Object:  Database [DiscosDB]    Script Date: 29/7/2024 15:00:55 ******/
CREATE DATABASE [DiscosDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DiscosDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\DiscosDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DiscosDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\DiscosDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DiscosDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [DiscosDB] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [DiscosDB] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [DiscosDB] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [DiscosDB] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [DiscosDB] SET ARITHABORT OFF 
GO

ALTER DATABASE [DiscosDB] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [DiscosDB] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [DiscosDB] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [DiscosDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [DiscosDB] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [DiscosDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [DiscosDB] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [DiscosDB] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [DiscosDB] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [DiscosDB] SET  DISABLE_BROKER 
GO

ALTER DATABASE [DiscosDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [DiscosDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [DiscosDB] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [DiscosDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [DiscosDB] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [DiscosDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [DiscosDB] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [DiscosDB] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [DiscosDB] SET  MULTI_USER 
GO

ALTER DATABASE [DiscosDB] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [DiscosDB] SET DB_CHAINING OFF 
GO

ALTER DATABASE [DiscosDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [DiscosDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [DiscosDB] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [DiscosDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [DiscosDB] SET QUERY_STORE = ON
GO

ALTER DATABASE [DiscosDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO

ALTER DATABASE [DiscosDB] SET  READ_WRITE 
GO


CREATE TABLE Discos(
	Id int NOT NULL PRIMARY KEY,
	Titulo Varchar(50),
	FechaLanzamiento Date,
	CantidadCanciones int,
	UrlImagenTapa varchar(50),
	IdEstilo int,
	IdTipoEdicion int,
	CONSTRAINT FK_Discos_Estilos FOREIGN KEY (IdEstilo) REFERENCES ESTILOS (Id),
	CONSTRAINT FK_Discos_Tipos FOREIGN KEY (IdTipoEdicion) REFERENCES TIPOSEDICION (Id)
)
Create TABLE TIPOSEDICION(
	Id int PRIMARY KEY,
	Descripcion varchar(50)
)
CREATE TABLE ESTILOS(
	Id int PRIMARY KEY,
	Descripcion varchar(50)
)
CREATE TABLE ESTILOS_DISCOS(
	IdDiscos int,
	IdEstilos int,
	CONSTRAINT FK_Discos  FOREIGN KEY (IdDiscos) REFERENCES Discos(Id),
	CONSTRAINT FK_Estilos FOREIGN KEY (IdEstilos) REFERENCES ESTILOS(Id)
)