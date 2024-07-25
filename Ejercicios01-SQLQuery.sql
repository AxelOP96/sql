--Obtener las Películas estrenadas en la Década de los '80.
Select * From Peliculas
WHERE YEAR(FechaEstreno) BETWEEN 1980 AND 1989;

--Obtener los Actores nacidos en la Década de los '70.
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
--Obtener la Cantidad de Películas con Clasificación R. (Considerar usar el Comando LIKE)
--Select * FROM [Peliculas.Clasificaciones]
--SELECT * FROM Clasificaciones

Select COUNT(Descripcion) as 'Cantidad de Peliculas' from Peliculas p
INNER JOIN [Peliculas.Clasificaciones] pc ON pc.IdPelicula = p.Id
INNER JOIN Clasificaciones c ON c.Id = pc.IdClasificacion
WHERE Descripcion LIKE 'R%'

--Obtener la Película que mayor duración tiene.
SELECT top 1  MinutosDuracion as DURACION,Titulo as PELICULA FROM Peliculas

--Obtener las Películas de Categoría 'Superhéroes'.
--Select * FROM Categorias
--SELECT *FROM [Peliculas.Categorias]

SELECT p.Titulo as Pelicula FROM Peliculas p
INNER JOIN [Peliculas.Categorias] pcat ON p.Id = pcat.IdPelicula
INNER JOIN Categorias cat ON cat.Id = pcat.IdCategoria
WHERE cat.Descripcion LIKE 'Super%'

--Obtener la Cantidad de Actores que trabajaron en la Película 'Los Intocables'.
--SELECT * FROM Paises
--Select * FROM Reparto
Select COUNT(Nombre) as 'Total de Actores' FROM Peliculas p
INNER JOIN [Peliculas.Reparto] prep ON prep.IdPelicula = p.Id
INNER JOIN Reparto rep ON rep.Id = prep.IdReparto
Where p.id = 7

--Obtener los Actores que trabajaron en la Películas 'Los Intocables'.
Select rep.Nombre, pai.Nombre AS Nacionalidad, rep.FechaNacimiento as 'F.Nacimiento' FROM Peliculas p
INNER JOIN [Peliculas.Reparto] prep ON prep.IdPelicula = p.Id
INNER JOIN Reparto rep ON rep.Id = prep.IdReparto
INNER JOIN Paises pai ON pai.Id = rep.IdNacionalidad
Where p.id = 7

--Obtener el Total de Películas del Catálogo
Select Count(Id) as 'CANT DE PELICULAS' From Peliculas

--Obtener la Lista de Usuarios Inactivos.
SELECT * FROM Usuarios
WHERE Activo =0
/*
Ingresar el siguiente Film.
Película: "The Good, the Bad and the Ugly"
Biografía: "Tres hombres violentos pelean por una caja que alberga 200 000 dólares, la cual fue escondida durante la Guerra Civil. Dado que ninguno puede encontrar la tumba donde está el botín sin la ayuda de los otros dos, deben colaborar, pese a odiarse."
Duración: 162 minutos
Fecha de Estreno: 11 de enero de 1968*/
INSERT INTO Peliculas(Titulo, Bio, MinutosDuracion, FechaEstreno) VALUES (
'The Good, the Bad and the Ugly', 
'Tres hombres violentos pelean por una caja que alberga 200 000 dólares, la cual fue escondida durante la Guerra Civil. Dado que ninguno puede encontrar la tumba donde está el botín sin la ayuda de los otros dos, deben colaborar, pese a odiarse.', 
162, 
'1968-01-11 00:00:00'
)
-- En base al Film recientemente agregado al Catálogo, agregárselo como Favorito a Severus Snape.
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

--14  ¿Cuál es la "relación" que tienen estas consultas al Ejecutarse? ¿Cuál es el motivo?
-- La relacion es 1 a N, una pelicula esta en una plataforma y a la vez una plataforma tiene muchas peliculas

--15 La Película de Rocky dejó de estar disponible en la Plataforma de Paramount+ el 16 de enero del 2024
--Select * From Peliculas
--WHERE titulo LIKE 'Rocky' --3
--Select * from Plataformas --9
--SELECT * FROM [Peliculas.Plataformas]
Update [Peliculas.Plataformas] SET FechaBaja = '2024-01-16 00:00:00'
WHERE Id = 5
--16 Hubo un error al momento de registrar la película de Iron Man. El Protagonista no fue Robert Downey Jr., quién interpretó el papel fue Diego Peretti.
--SELECT * FROM Reparto
--SELECT * FROM [Peliculas.Reparto]
--SELECT * FROM Peliculas
--WHERE Titulo LIKE 'Iron Man' -- id 2
UPDATE Reparto SET Nombre = 'Diego', Apellido = 'Peretti'
Where Id = 1
--17  La Plataforma Tubi TV cambia de firma, dado que cambiará su nombre a MaxiPrograma TV
SELECT * FROM Plataformas
UPDATE Plataformas SET Nombre = 'Maxiprograma TV'
Where id =10
--18 La Película de Spiderman cambia su Clasificación de PG-13 a 'Apta para todos los Públicos'.
--SELECT * FROM Clasificaciones --3 - G 1
--SELECT * FROM [Peliculas.Clasificaciones] 
UPDATE [Peliculas.Clasificaciones] SET IdClasificacion = 1
WHERE IdPelicula = 12
--SELECT * FROM Peliculas -- 12
--19 El Usuario Homero Simpson hace mucho tiempo que está inactivo. Hay que eliminarlo de la Base de manera física.
DELETE FROM Usuarios
where Activo = 0 AND id = 3

--20 Realizar una limpieza de las Puntuaciones de las Películas. Eliminar todas las Puntuaciones desde el 2020 hasta el 2023 (inclusive). ¿Se podrá realizar la Consulta?
DELETE FROM [Peliculas.Puntuacion]
WHERE YEAR(FechaPuntuacion) BETWEEN 2020 AND 2023
--21  Se debe realizar una limpieza de Películas. Hay que eliminar las Películas que se hayan estrenado desde 1980 hasta 1989 (inclusive). ¿Se podrá realizar la Consulta?
DELETE FROM Peliculas
WHERE YEAR(FechaEstreno) BETWEEN 1980 AND 1989