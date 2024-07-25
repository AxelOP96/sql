--Obtener las Pel�culas estrenadas en la D�cada de los '80.
Select * From Peliculas
WHERE YEAR(FechaEstreno) BETWEEN 1980 AND 1989;

--Obtener los Actores nacidos en la D�cada de los '70.
Select * from Reparto
Where YEAR(FechaNacimiento) BETWEEN 1970 AND 1979

--Obtener las Peliculas que se encuentran en la Plataforma de Disney+.
SELECT p.Titulo
FROM Peliculas as p
INNER JOIN [Peliculas.Plataformas] pl ON pl.IdPelicula = p.Id
INNER JOIN Plataformas plat ON plat.Id = pl.IdPlataforma
WHERE plat.Nombre LIKE 'Disney+'

--SELECT * FROM Plataformas plat
--WHERE plat.Nombre LIKE '%Disney+%'
--SELECT * FROM [Peliculas.Plataformas]
--Obtener la Cantidad de Pel�culas con Clasificaci�n R. (Considerar usar el Comando LIKE)
--Select * FROM [Peliculas.Clasificaciones]
--SELECT * FROM Clasificaciones

Select COUNT(Descripcion) as 'Cantidad de Peliculas' from Peliculas p
INNER JOIN [Peliculas.Clasificaciones] pc ON pc.IdPelicula = p.Id
INNER JOIN Clasificaciones c ON c.Id = pc.IdClasificacion
WHERE Descripcion LIKE 'R%'

--Obtener la Pel�cula que mayor duraci�n tiene.
SELECT top 1  MinutosDuracion as DURACION,Titulo as PELICULA FROM Peliculas

--Obtener las Pel�culas de Categor�a 'Superh�roes'.
--Select * FROM Categorias
--SELECT *FROM [Peliculas.Categorias]

SELECT p.Titulo as Pelicula FROM Peliculas p
INNER JOIN [Peliculas.Categorias] pcat ON p.Id = pcat.IdPelicula
INNER JOIN Categorias cat ON cat.Id = pcat.IdCategoria
WHERE cat.Descripcion LIKE 'Super%'

--Obtener la Cantidad de Actores que trabajaron en la Pel�cula 'Los Intocables'.
--SELECT * FROM Paises
--Select * FROM Reparto
Select COUNT(Nombre) as 'Total de Actores' FROM Peliculas p
INNER JOIN [Peliculas.Reparto] prep ON prep.IdPelicula = p.Id
INNER JOIN Reparto rep ON rep.Id = prep.IdReparto
Where p.id = 7

--Obtener los Actores que trabajaron en la Pel�culas 'Los Intocables'.
Select rep.Nombre, pai.Nombre AS Nacionalidad, rep.FechaNacimiento as 'F.Nacimiento' FROM Peliculas p
INNER JOIN [Peliculas.Reparto] prep ON prep.IdPelicula = p.Id
INNER JOIN Reparto rep ON rep.Id = prep.IdReparto
INNER JOIN Paises pai ON pai.Id = rep.IdNacionalidad
Where p.id = 7

--Obtener el Total de Pel�culas del Cat�logo
Select Count(Id) as 'CANT DE PELICULAS' From Peliculas

--Obtener la Lista de Usuarios Inactivos.
SELECT * FROM Usuarios
WHERE Activo =0
/*
Ingresar el siguiente Film.
Pel�cula: "The Good, the Bad and the Ugly"
Biograf�a: "Tres hombres violentos pelean por una caja que alberga 200 000 d�lares, la cual fue escondida durante la Guerra Civil. Dado que ninguno puede encontrar la tumba donde est� el bot�n sin la ayuda de los otros dos, deben colaborar, pese a odiarse."
Duraci�n: 162 minutos
Fecha de Estreno: 11 de enero de 1968*/
INSERT INTO Peliculas(Titulo, Bio, MinutosDuracion, FechaEstreno) VALUES (
'The Good, the Bad and the Ugly', 
'Tres hombres violentos pelean por una caja que alberga 200 000 d�lares, la cual fue escondida durante la Guerra Civil. Dado que ninguno puede encontrar la tumba donde est� el bot�n sin la ayuda de los otros dos, deben colaborar, pese a odiarse.', 
162, 
'1968-01-11 00:00:00'
)
-- En base al Film recientemente agregado al Cat�logo, agreg�rselo como Favorito a Severus Snape.
--SELECT * FROM [Usuarios.Favoritos]
--SELECT * FROM Peliculas
--SELECT * FROM Usuarios
INSERT INTO [Usuarios.Favoritos](IdPelicula, IdUsuario) 
VALUES(1002, 4)
--13 Ahora hagamos que esta pelicula se pueda ver en las Plataformas de Netflix y Amazon.
INSERT Into [Peliculas.Plataformas](IdPelicula, IdPlataforma, Id)
Values(1002, 1, 44)
INSERT Into [Peliculas.Plataformas](IdPelicula, IdPlataforma, Id)
Values(1002, 2, 45)
--Select * from Plataformas
--SELECT * FROM [Peliculas.Plataformas]

--14  �Cu�l es la "relaci�n" que tienen estas consultas al Ejecutarse? �Cu�l es el motivo?
-- La relacion es 1 a N, una pelicula esta en una plataforma y a la vez una plataforma tiene muchas peliculas

--15 La Pel�cula de Rocky dej� de estar disponible en la Plataforma de Paramount+ el 16 de enero del 2024
--Select * From Peliculas
--WHERE titulo LIKE 'Rocky' --3
--Select * from Plataformas --9
--SELECT * FROM [Peliculas.Plataformas]
Update [Peliculas.Plataformas] SET FechaBaja = '2024-01-16 00:00:00'
WHERE Id = 5
--16 Hubo un error al momento de registrar la pel�cula de Iron Man. El Protagonista no fue Robert Downey Jr., qui�n interpret� el papel fue Diego Peretti.
--SELECT * FROM Reparto
--SELECT * FROM [Peliculas.Reparto]
--SELECT * FROM Peliculas
--WHERE Titulo LIKE 'Iron Man' -- id 2
UPDATE Reparto SET Nombre = 'Diego', Apellido = 'Peretti'
Where Id = 1
--17  La Plataforma Tubi TV cambia de firma, dado que cambiar� su nombre a MaxiPrograma TV
SELECT * FROM Plataformas
UPDATE Plataformas SET Nombre = 'Maxiprograma TV'
Where id =10
--18 La Pel�cula de Spiderman cambia su Clasificaci�n de PG-13 a 'Apta para todos los P�blicos'.
--SELECT * FROM Clasificaciones --3 - G 1
--SELECT * FROM [Peliculas.Clasificaciones] 
UPDATE [Peliculas.Clasificaciones] SET IdClasificacion = 1
WHERE IdPelicula = 12
--SELECT * FROM Peliculas -- 12
--19 El Usuario Homero Simpson hace mucho tiempo que est� inactivo. Hay que eliminarlo de la Base de manera f�sica.
DELETE FROM Usuarios
where Activo = 0 AND id = 3

--20 Realizar una limpieza de las Puntuaciones de las Pel�culas. Eliminar todas las Puntuaciones desde el 2020 hasta el 2023 (inclusive). �Se podr� realizar la Consulta?
DELETE FROM [Peliculas.Puntuacion]
WHERE YEAR(FechaPuntuacion) BETWEEN 2020 AND 2023
--21  Se debe realizar una limpieza de Pel�culas. Hay que eliminar las Pel�culas que se hayan estrenado desde 1980 hasta 1989 (inclusive). �Se podr� realizar la Consulta?
DELETE FROM Peliculas
WHERE YEAR(FechaEstreno) BETWEEN 1980 AND 1989