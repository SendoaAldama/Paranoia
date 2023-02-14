-- Version de la Hoja 2.0

-- Borrar la base de datos si existe

DROP DATABASE IF EXISTS PRN20_20;

-- Creacion de la Base de datos llamada Paranoia si no existe

CREATE DATABASE IF NOT EXISTS PRN20_20;

-- Usamos el USE para seleccionar las Base de datos que vamos a usar

USE PRN20_20;

-- Crear la tabla Participante si no existe

CREATE TABLE IF NOT EXISTS Participante(
  CodParticipante TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Nombre VARCHAR(20) NOT NULL,
  Apellido VARCHAR(25) NOT NULL,
  Alias VARCHAR(30) NOT NULL UNIQUE,
  Foto BLOB,
  Telefono CHAR(9) NOT NULL UNIQUE,
  Email VARCHAR(50) NOT NULL UNIQUE,
  Tipo ENUM("Jugador", "Master") NOT NULL
  );

-- 			Jugador

-- Crear la tabla Jugador si no existe

CREATE TABLE IF NOT EXISTS Jugador(
  CodJugador TINYINT UNSIGNED NOT NULL,
  Puntuacion INT UNSIGNED NOT NULL DEFAULT "0",
  PRIMARY KEY (CodJugador)
);

-- 		MASTER

-- Crear tabla Master si no existe

CREATE TABLE IF NOT EXISTS Master(
  CodMaster TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (CodMaster)
  );

-- 		PERSONAJE

-- Crear tabla Personaje si no existe

CREATE TABLE IF NOT EXISTS Personaje(
  CodPersonaje TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  NombreP VARCHAR(30) UNIQUE NOT NULL DEFAULT "Jugador1",
  CodSeguridad CHAR(1) NOT NULL DEFAULT 'R',
  Servicio CHAR(3) NOT NULL,
  Fuerza TINYINT UNSIGNED NOT NULL,
  Resistencia TINYINT UNSIGNED NOT NULL,
  Agilidad TINYINT UNSIGNED NOT NULL,
  Destreza TINYINT UNSIGNED NOT NULL,
  Percepcion TINYINT UNSIGNED NOT NULL,
  Cinismo TINYINT UNSIGNED NOT NULL,
  Talento TINYINT UNSIGNED NOT NULL,
  PoderMutanteNum TINYINT UNSIGNED NOT NULL,
  AcarreoBonusDanho TINYINT UNSIGNED NOT NULL,
  Aguante TINYINT UNSIGNED NOT NULL,
  HabilidadAgilidad TINYINT UNSIGNED NOT NULL,
  HabilidadDestreza TINYINT UNSIGNED NOT NULL,
  HabilidadPercepcion TINYINT UNSIGNED NOT NULL,
  Tipo ENUM("PJ", "PNJ") NOT NULL
  );
  
-- 		PJ

-- Crear la tabla PJ si no existe

CREATE TABLE IF NOT EXISTS PJ(
  CodPersonaje TINYINT UNSIGNED NOT NULL PRIMARY KEY,
  CodJugador TINYINT UNSIGNED NOT NULL,
  NumVidas TINYINT UNSIGNED NOT NULL DEFAULT "1",
  Nivel TINYINT UNSIGNED NOT NULL DEFAULT "1",
  PoderMutanteNombre VARCHAR(25) NOT NULL,
  SociedadSecreta VARCHAR(30) NOT NULL,
  HabilidadCinismo TINYINT UNSIGNED NOT NULL,
  HabilidadTalentoMecanico TINYINT UNSIGNED NOT NULL,
  Puntos_Traicion TINYINT UNSIGNED NOT NULL,
  Puntos_Recomendacion TINYINT UNSIGNED NOT NULL,
  Creditos INT UNSIGNED NOT NULL DEFAULT 100,
  Arma1 VARCHAR(20) NOT NULL DEFAULT 'Pistola laser(20)',
  Arma2 VARCHAR(20) NULL,
  Armadura VARCHAR(25) NOT NULL DEFAULT 'Reflec roja (L4)',
  Equipo VARCHAR(45) NOT NULL DEFAULT "Jugo de manzana"
);
 
-- 		PNJ

-- Crear tabla PNJ si no existe

CREATE TABLE IF NOT EXISTS PNJ(
  CodPersonaje TINYINT UNSIGNED NOT null,
  CodMaster TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (CodPersonaje, CodMaster)
);

-- 			Partida

-- Crear la tabla si no existe

CREATE TABLE IF NOT EXISTS Partida(
  CodPartida TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  FechaPartida DATE NOT NULL,
  Titulo VARCHAR(50) NOT NULL,
  AcontecimientosSucedidos TEXT,	
  CodMasterCreador TINYINT UNSIGNED NULL,
  CodMasterDirector TINYINT UNSIGNED NULL,
  PRIMARY KEY (CodPartida)
);

-- 			PJ_Partida

-- Crear la tabla Jugador_Partida si no existe

CREATE TABLE IF NOT EXISTS PJ_Partida(
	CodPersonaje TINYINT UNSIGNED NOT NULL,
    CodPartida TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (CodPersonaje, CodPartida) 
);

-- 		PNJ_Partida

-- Crear la tabla PNJ_Partida si no existe

CREATE TABLE IF NOT EXISTS PNJ_Partida(
	CodPersonaje TINYINT UNSIGNED NOT NULL,
    CodPartida TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (CodPersonaje, CodPartida) 
);

-- Creacion de las FOREING KEY

-- Poner las FK de jugador a paritipante (CodParticipante)

ALTER TABLE Jugador ADD FOREIGN KEY (CodJugador) REFERENCES Participante(CodParticipante) on update cascade on delete cascade;

-- Poner las FK de Master a Paritipante (CodParticipante)

ALTER TABLE Master ADD FOREIGN KEY (CodMaster) REFERENCES Participante(CodParticipante) on update cascade on delete cascade;

-- Poner la FK de PJ a CodPersonaje de Personaje y CodJugador a Jugador

ALTER TABLE PJ ADD FOREIGN KEY (CodPersonaje) REFERENCES Personaje(CodPersonaje) on update cascade on delete cascade;
ALTER TABLE PJ ADD FOREIGN KEY (CodJugador) REFERENCES Jugador(CodJugador) on update cascade on delete restrict;

-- Poner la FK de PNJ a CodPersonaje de Personaje y CodMaster a Master

ALTER TABLE PNJ ADD FOREIGN KEY (CodPersonaje) REFERENCES Personaje(CodPersonaje) on update cascade on delete cascade;
ALTER TABLE PNJ ADD FOREIGN KEY (CodMaster) REFERENCES Master(CodMaster) on update cascade on delete restrict;

-- FK de CodPersonaje a Personaje y CodPartida a Partida

ALTER TABLE PJ_Partida ADD FOREIGN KEY (CodPersonaje) REFERENCES PJ(CodPersonaje) on update cascade on delete cascade;
ALTER TABLE PJ_Partida ADD FOREIGN KEY (CodPartida) REFERENCES Partida(CodPartida) on update cascade on delete restrict;

-- FK de CodPersonaje a Personaje y CodPartida a Partida

ALTER TABLE PNJ_Partida ADD FOREIGN KEY (CodPersonaje) REFERENCES PNJ(CodPersonaje) on update cascade on delete cascade;
ALTER TABLE PNJ_Partida ADD FOREIGN KEY (CodPartida) REFERENCES Partida(CodPartida) on update cascade on delete restrict;

-- FK de Partida master a master

ALTER TABLE Partida add FOREIGN KEY (CodMasterCreador) REFERENCES master (CodMaster) on update cascade on delete cascade;


-- 					Tablas maestras 

-- Crear tabla Servicio

CREATE TABLE Servicio(
Cod TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
Servicio CHAR(3) NOT NULL
);

-- Introcudodir datos en Servicio

INSERT INTO Servicio(Servicio) VALUES("SSI"),
("SSI"),
("STC"),
("SCT"),
("SBD"),
("SBD"),
("SBD"),
("SBD"),
("SDF"),
("SDF"),
("SDF"),
("SPL"),
("SPL"),
("SPL"),
("SEG"),
("SID"),
("SID"),
("SCP"),
("SCP");

-- Crear tabla PoderMutante

CREATE TABLE PoderMutante(
Cod TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
PoderMutante VARCHAR(25) NOT NULL
);

-- Introducir datos en PoderMurtante

INSERT INTO PoderMutante(PoderMutante) VALUES
("Control de Adrenalina"),
("Carisma"),
("Lectura mental"),
("Electroshock"),
("Empatía"),
("Campo de Energía"),
("Hipersentido"),
("Levitacion"),
("Empatía Mecánica"),
("Adaptación metabólica"),
("Intuición Mecánica"),
("Rayo mental"),
("Polimorfismo"),
("Precognición"),
("Pirokinesis"),
("Regeneración"),
("Telekinesis"),
("Telepatía"),
("Teleportación"),
("Vista cin Rayos X");

-- Crear Tabla Sociedad Secreta

CREATE TABLE SociedadSecreta(
Cod TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
SociedadSecreta VARCHAR(30) NOT NULL
);

-- Introcudodir datos en SociedadSecretra

INSERT INTO SociedadSecreta(SociedadSecreta) VALUES
("Antimutantes"),
("Piratas Informaticos"),
("Comunistas"),
("Corpore Metal"),
("Leopardo de la Muerte"),
("Leopardo de la Muerte"),
("Iglesia Primiriva"),
("Iglesia Primitiva"),
("Antifrankenstein"),
("Libre Empresa"),
("Humanistas"),
("Iluminados"),
("Misticos"),
("Protectos"),
("Purgadores Cristo Programador"),
("Romanticos"),
("Romanticos"),
("Club Sierra"),
("Club Sierra"),
("MySQL Lovers");

-- Crear tabla de HabilidadesBasicas

CREATE TABLE HabilidadesBasicas(
Cod TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
HabilidadesBasicas CHAR(3) NOT NULL
);

-- Insert Habilidades_Basicas

INSERT INTO HabilidadesBasicas(HabilidadesBasicas) VALUES
(0),
(0),
(0),
(1),
(1),
(1),
(2),
(2),
(2),
(2),
(3),
(3),
(3),
(3),
(4),
(4),
(4),
(5),
(5),
(5);

-- 					Rutinas
-- Procedure para dar de alta los Participantes

DROP PROCEDURE IF EXISTS alta;

DELIMITER $$

CREATE PROCEDURE alta(
IN jNombre VARCHAR(20),
IN jApellido VARCHAR(25),
IN jAlias VARCHAR(30),
IN jTelefono CHAR(9),
IN jEmail VARCHAR(50),
IN jTipo ENUM("Jugador","Master")
)
BEGIN

	IF jTipo = "Jugador" THEN
	INSERT INTO Participante(CodParticipante,Nombre,Apellido,Alias,Telefono,Email,Tipo)
    Values(
    DEFAULT,jNombre,jApellido,jAlias,jTelefono,jEmail,JTipo); 
    INSERT INTO Jugador VALUES((SELECT CodParticipante FROM Participante WHERE Tipo = "Jugador" ORDER BY CodParticipante DESC LIMIT 1),DEFAULT);
    
    ELSE
    INSERT INTO Participante(CodParticipante,Nombre,Apellido,Alias,Telefono,Email,Tipo)
    Values(
    DEFAULT,jNombre,jApellido,jAlias,jTelefono,jEmail,JTipo);
    INSERT INTO Master VALUES((SELECT CodParticipante FROM Participante WHERE Tipo = "Master"));
    
    END IF;
END $$
DELIMITER ;
   
-- Crear JugadorPartida

DROP PROCEDURE IF EXISTS JugadorPartida;

DELIMITER $$

CREATE PROCEDURE JugadorPartida(
IN jNombrep VARCHAR(30), 
IN jAlias VARCHAR(30), 
IN jSector CHAR(3),
IN jTipo ENUM('PJ','PNJ')
)
BEGIN

-- Variables
DECLARE Letra1 TINYINT;
DECLARE Letra2 TINYINT;
DECLARE Letra3 TINYINT;
DECLARE Aleatorio TINYINT;
DECLARE JMaster TINYINT;
DECLARE Nombre VARCHAR(30); 

SET Nombre = concat_ws("-",jNombrep,"R",jSector,1);
SELECT FLOOR(1+RAND()*19) INTO Letra1;
SELECT FLOOR(1+RAND()*19) INTO Letra2;
SELECT FLOOR(1+RAND()*19) INTO Letra3;
SELECT FLOOR(1+RAND()*19) INTO Aleatorio;
SET JMaster = (SELECT CodParticipante FROM Participante WHERE Alias = jAlias);

-- Codigo
  
IF jTipo = "PJ" THEN

INSERT INTO Personaje VALUES
(DEFAULT,
Nombre,
DEFAULT, 
(SELECT Servicio FROM Servicio WHERE Cod = Aleatorio), 
FLOOR(1+RAND()*19),
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19),
(SELECT HabilidadesBasicas FROM HabilidadesBasicas WHERE Cod = Aleatorio), 
(SELECT HabilidadesBasicas FROM HabilidadesBasicas WHERE Cod = Aleatorio), 
(SELECT HabilidadesBasicas FROM HabilidadesBasicas WHERE Cod = Aleatorio), 
"PJ"
);
    
INSERT INTO PJ VALUES
((SELECT CodPersonaje FROM Personaje ORDER BY CodPersonaje DESC LIMIT 1),
(SELECT CodParticipante FROM Participante WHERE Alias = jAlias),
DEFAULT, 
DEFAULT,
(SELECT PoderMutante FROM PoderMutante WHERE Cod = Aleatorio),
(SELECT SociedadSecreta FROM SociedadSecreta WHERE Cod = Aleatorio),
(SELECT HabilidadesBasicas FROM HabilidadesBasicas WHERE Cod = Aleatorio),
(SELECT HabilidadesBasicas FROM HabilidadesBasicas WHERE Cod = Aleatorio),
FLOOR(1+RAND()*19),
FLOOR(1+RAND()*19),
DEFAULT, 
DEFAULT, 
DEFAULT,
DEFAULT,
DEFAULT
);

ELSE
INSERT INTO Personaje VALUES 
(DEFAULT, 
jNombrep, 
DEFAULT, 
(SELECT Servicio FROM Servicio WHERE Cod = Aleatorio),
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19), 
FLOOR(1+RAND()*19),
FLOOR(1+RAND()*19), 
"PNJ"
 );
INSERT INTO PNJ VALUES ((SELECT CodPersonaje  FROM Personaje ORDER BY CodPersonaje DESC LIMIT 1), JMaster);
	
END IF;
END $$
DELIMITER ;

-- Introducir una partida sin el texto que se incluiría tras jugarla
-- Hay que meter la fecha, el título y el máster.
 
DROP PROCEDURE IF EXISTS CrearPartida;

DELIMITER $$

CREATE PROCEDURE CrearPartida(
IN jTitulo VARCHAR(50),
IN jFecha DATE,  
IN jAliasMasterDirige VARCHAR(30), 
IN jAliasMasterCrea VARCHAR(30)
)
BEGIN

-- Codigo

	INSERT INTO Partida VALUES (DEFAULT,jFecha,jTitulo,"",DEFAULT, DEFAULT);
	
	UPDATE Partida SET CodMasterDirector = (SELECT CodParticipante FROM Participante WHERE Alias = jAliasMasterDirige)
	WHERE CodPartida = (SELECT CodPartida ORDER BY CodPartida DESC LIMIT 1);
	
	UPDATE Partida SET CodMasterCreador = (SELECT CodParticipante FROM Participante WHERE Alias = jAliasMasterCrea)
	WHERE CodPartida = (SELECT CodPartida ORDER BY CodPartida DESC LIMIT 1);
    
END $$

DELIMITER ;

-- Listar los PJ y Jugadores de una partida dada o de la plataforma.

DROP PROCEDURE IF EXISTS ListarJugadores;

DELIMITER $$

CREATE PROCEDURE ListarJugadores(
IN jNombreP VARCHAR(50), 
IN jNumPartida TINYINT
)
BEGIN

-- Variables

DECLARE JCOD TINYINT;

-- Handler

DECLARE EXIT HANDLER FOR NOT FOUND
		SELECT "El nombre no coincide con ninguno que contiene la base de datos" AS ERROR;
		
       
		SELECT CodPersonaje INTO JCOD FROM Personaje WHERE NombreP = jNombreP;
        
-- Codigo

IF jNumPartida IS NOT NULL THEN

SELECT pa.Nombre, pa.Apellido, pa.Alias, pa.Telefono, pa.Email, pa.Foto, j.Puntuacion,
per.NombreP, per.CodSeguridad, per.Servicio, per.Fuerza, per.Resistencia, per.Agilidad, per.Destreza, per.Percepcion, per.Cinismo, per.Talento, per.PoderMutanteNum, per.AcarreoBonusDanho, per.Aguante, per.HabilidadAgilidad, per.HabilidadDestreza, per.HabilidadPercepcion, per.Tipo,
pj.Puntos_Recomendacion, pj.Puntos_Traicion, pj.SociedadSecreta, pj.Nivel, pj.PoderMutanteNombre, pj.Creditos, pj.Arma1, pj.Arma2, pj.Armadura, pj.HabilidadCinismo, pj.HabilidadTalentoMecanico, pj.NumVidas, p.Titulo, p.FechaPartida
FROM Participante pa , Jugador j, Personaje per , PJ AS pj, Partida p, PJ_Partida ptp
WHERE pa.CodParticipante = (SELECT CodJugador FROM PJ WHERE CodJugador = JCOD) AND p.CodPartida = jNumPartida
AND pa.CodParticipante = j.CodJugador AND pj.CodJugador = j.CodJugador AND pj.CodPersonaje = per.CodPersonaje AND p.CodPartida = ptp.CodPartida AND ptp.CodPersonaje = pj.CodPersonaje;

ELSE

SELECT pa.Nombre, pa.Apellido, pa.Alias, pa.Telefono, pa.Email, pa.Foto, j.Puntuacion,
per.NombreP, per.CodSeguridad, per.Servicio, per.Fuerza, per.Resistencia, per.Agilidad, per.Destreza, per.Percepcion, per.Cinismo, per.Talento, per.PoderMutanteNum, per.AcarreoBonusDanho, per.Aguante, per.HabilidadAgilidad, per.HabilidadDestreza, per.HabilidadPercepcion, per.Tipo,
pj.Puntos_Recomendacion, pj.Puntos_Traicion, pj.SociedadSecreta, pj.Nivel, pj.PoderMutanteNombre, pj.Creditos, pj.Arma1, pj.Arma2, pj.Armadura, pj.HabilidadCinismo, pj.HabilidadTalentoMecanico, pj.NumVidas
FROM Participante pa , Jugador j, Personaje per , PJ AS pj
WHERE pa.CodParticipante = (SELECT CodJugador FROM PJ WHERE CodJugador = JCOD)
AND pa.CodParticipante = j.CodJugador AND pj.CodJugador = j.CodJugador AND pj.CodPersonaje = per.CodPersonaje;

END IF;

END $$

DELIMITER ;

-- Cuando muere uno de los clones, actualizar los datos del PJ afectados y si llega a 0 vidas se da por eliminado al Jugador.

DROP PROCEDURE IF EXISTS DatosClon;

DELIMITER $$

CREATE PROCEDURE DatosClon(
IN jNombre VARCHAR(30),
IN jNumeroClon TINYINT
)
BEGIN

-- Variables

DECLARE jCod TINYINT;
DECLARE jVidaAc TINYINT;
DECLARE PP TINYINT;

-- Handler

DECLARE EXIT HANDLER FOR NOT FOUND 
	SELECT "El nombre indicado no coincide con ninguno de esta base de datos" AS ERROR;

	SELECT CodPersonaje INTO jCod FROM Personaje WHERE NombreP = jNombre;
	SELECT NumVidas INTO jVidaAc FROM PJ WHERE CodPersonaje = (SELECT CodPersonaje FROM Personaje WHERE NombreP = jNombre); 
	
      
-- Codigo
IF jVidaAc = 6 THEN

UPDATE PJ SET NumVidas = 0 where CodPersonaje = (SELECT CodPersonaje FROM Personaje WHERE NombreP = jNombre);
UPDATE Personaje SET NombreP = replace(NombreP, jVidaAc, 0) WHERE jCod;

ELSE

UPDATE PJ SET NumVidas = (jNumeroClon + 1) WHERE CodPersonaje = (SELECT CodPersonaje FROM Personaje WHERE NombreP = jNombre);
UPDATE Personaje SET NombreP = replace(NombreP, jVidaAc, (jNumeroClon + 1)) WHERE jCod;

END IF;

END $$

DELIMITER ;

-- Crear una rutina que según reciba como parámetro el número de clon y un caracter; y proporcione un listado donde:
--  - Si el caracter vale "S" se listará el número de PJs que tienen gastada esa vida y desde esa hasta la última.
--  - Si el caracter vale "N" se listará el número de PJs que tienen gastada esa cantidad de vidas.
-- Ejemplo: (4,"S") listaría cuántos clones están en la vida 4, cuántos en la 5 y cuántos en la 6; y (4,"N") listaría cuántos
-- clones están en la vida 4.

DROP PROCEDURE IF EXISTS VidasPJ;

DELIMITER $$

CREATE PROCEDURE VidasPJ(
jNumClon TINYINT, 
jEleccion ENUM("S","N")
)
BEGIN

-- Codigo

IF jEleccion = "S" THEN

SELECT per.NombreP, per.CodSeguridad, per.Servicio, per.Fuerza, per.Resistencia, per.Agilidad, per.Destreza, per.Percepcion, per.Cinismo, per.Talento, per.PoderMutanteNum, per.AcarreoBonusDanho, per.Aguante, per.HabilidadAgilidad, per.HabilidadDestreza, per.HabilidadPercepcion, per.tipo,
pj.Puntos_Recomendacion, pj.Puntos_Traicion, pj.SociedadSecreta, pj.Nivel, pj.PoderMutanteNombre, pj.Creditos, pj.Arma1, pj.Arma2, pj.Armadura, pj.HabilidadCinismo, pj.HabilidadTalentoMecanico, pj.NumVidas
	FROM Personaje per, PJ AS pj
	WHERE pj.NumVidas >= jNumClon
	ORDER BY pj.NumVidas ASC;
    
ELSE

		IF Eleccion = "N"  then

SELECT per.NombreP, per.CodSeguridad, per.Servicio, per.Fuerza, per.Resistencia, per.Agilidad, per.Destreza, per.Percepcion, per.Cinismo, per.Talento, per.PoderMutanteNum, per.AcarreoBonusDanho, per.Aguante, per.HabilidadAgilidad, per.HabilidadDestreza, per.HabilidadPercepcion, per.tipo,
pj.Puntos_Recomendacion, pj.Puntos_Traicion, pj.SociedadSecreta, pj.Nivel, pj.PoderMutanteNombre, pj.Creditos, pj.Arma1, pj.Arma2, pj.Armadura, pj.HabilidadCinismo, pj.HabilidadTalentoMecanico, pj.NumVidas
	FROM Personaje per, PJ AS pj
	WHERE pj.NumVidas = jNumClon
    AND per.Tipo = "PJ";

	ELSE
		
	SELECT "La letra introducida no conincide con ninguna de las elecciones posibles";
	SELECT "Escoge entre S o N";

	END IF;

END IF;

END $$

DELIMITER ;

-- Crear una rutina que según reciba como parámetro un alias de participante, o nada, proporcione un listado de los
-- personajes asociados a ese participante donde se den sus datos y características principales y en qué partidas ha tomado
-- parte, sea PJ o PNJ.
-- Nota: Ya he realizado el diseño para que en lugar de nada, tengan que escribir ninguno como valor del partámetro, 
-- de manera que ese dato no puede ser un valor permitido para alias.

DROP PROCEDURE IF EXISTS InformacionAlias;

DELIMITER $$

CREATE PROCEDURE InformacionAlias(
jAlias VARCHAR(30)
)
BEGIN

-- VARIABLES

DECLARE jCodP TINYINT;

-- Handlers

DECLARE EXIT HANDLER FOR NOT FOUND
	SELECT "El alias de este jugador no esta en esta base de datos" AS ERROR;
	
-- Codigo

IF jAlias = "ninguno" THEN

	SELECT DISTINCT per.NombreP, par.Titulo, pj.Nivel, per.Fuerza, per.Resistencia, per.Agilidad, per.Destreza, per.Percepcion, per.Cinismo
	FROM  Personaje per, Partida par, PJ_Partida pjp, PNJ_Partida pnp, PJ pj, PNJ pnj
	WHERE (per.CodPersonaje = pj.CodPersonaje AND pj.CodPersonaje = pjp.CodPersonaje AND pjp.CodPartida = par.CodPartida)
    OR (per.CodPersonaje = pnj.CodPersonaje AND pnj.CodPersonaje = pnp.CodPersonaje AND pnp.CodPartida = par.CodPartida);

ELSE

	SELECT CodParticipante INTO jCodP
    FROM Participante WHERE Alias = jAlias;
    
    IF(SELECT Tipo FROM Participante WHERE CodParticipante = jCodP) = "Master" THEN
    SELECT per.NombreP, par.Titulo, per.Nivel, per.Fuerza, per.Resistencia, per.Agilidad, per.Destreza, per.Percepcion, per.Cinismo
    FROM Personaje per, Partida par, PNJ pnj
    WHERE per.CodPersonaje = pnj.CodPersonaje AND pnj.CodMaster = jCodP;
    
    ELSE
		SELECT per.NombreP, par.Titulo, per.Nivel, per.Fuerza, per.Resistencia, per.Agilidad, per.Destreza, per.Percepcion, per.Cinismo
        FROM Personaje per, Partida par, PJ pj
        WHERE per.CodPersonaje = pj.CodPersonaje AND pj.CodJugador = jCodP;

		END IF;
	END IF;

END $$

DELIMITER ;

-- Para que los jugadores puedan consultar los datos sobre personajes, se va a crear una vista que relacione Participantes,
-- con sus tablas hijas, con Personajes, con sus tablas hijas, y Partida.

DROP VIEW IF EXISTS InfomacionGeneralJugadores;

CREATE VIEW InfomacionGeneralJugadores AS

SELECT pa.Nombre, pa.Apellido, pa.Alias, pa.Telefono, pa.Email, pa.Foto, j.Puntuacion,
per.NombreP, per.CodSeguridad, per.Servicio, per.Fuerza, per.Resistencia, per.Agilidad, per.Destreza, per.Percepcion, per.Cinismo, per.Talento, per.PoderMutanteNum, per.AcarreoBonusDanho, per.Aguante, per.HabilidadAgilidad, per.HabilidadDestreza, per.HabilidadPercepcion, per.tipo,
pj.Puntos_Recomendacion, pj.Puntos_Traicion, pj.SociedadSecreta, pj.Nivel, pj.PoderMutanteNombre, pj.Creditos, pj.Arma1, pj.Arma2, pj.Armadura, pj.HabilidadCinismo, pj.HabilidadTalentoMecanico, pj.NumVidas, p.Titulo, p.FechaPartida
FROM Participante pa , Jugador j, Personaje per ,pj , Partida p, PJ_Partida ptp
WHERE pa.CodParticipante = j.CodJugador AND j.CodJugador = pj.CodJugador AND pj.CodPersonaje = per.CodPersonaje AND p.CodPartida = ptp.CodPartida AND ptp.CodPersonaje = pj.CodPersonaje;

-- CALL de los PROCEDURES

-- 	ALTA
CALL alta("Sendoa","Aldama","tete","678801485","SendoaAldama@gmail.com","Master");
CALL alta("Roberto","Nachos","fere","676193756","Roberto@gmail.com","Jugador");

-- Crear PJ y PNJ
CALL JugadorPartida("pep","tete","URK","PNJ");
CALL JugadorPartida("NENE","fere","URK","PJ");

-- Crear la partida
CALL CrearPartida("Pesos pesados",now(),"tete","tete");

-- Valores para las tablas intermedias para que funcionen algunas consultas
INSERT INTO PJ_Partida VALUES(2,1);
INSERT INTO PNJ_Partida VALUES(1,1);

-- CALL para listar los jugadores
CALL ListarJugadores("NENE-R-URK-1",1);

-- Cambiar el numero de vidas del clon
CALL DatosClon("NENE-R-URK-1",3);

-- Ordenar VidasPJ
CALL VidasPJ(4,"S");

-- Informacion del alias
CALL InformacionAlias ("ninguno");

-- Llamada a la VIEW
SELECT * FROM InfomacionGeneralJugadores;