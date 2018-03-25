
DROP DATABASE IF EXISTS catalog;

CREATE DATABASE catalog;

USE catalog;


DROP TABLE IF EXISTS `catalog`.`tbl_user`;
DROP TABLE IF EXISTS `catalog`.`elevi`;
DROP TABLE IF EXISTS `catalog`.`note`;
DROP TABLE IF EXISTS `catalog`.`materii`;
DROP TABLE IF EXISTS `catalog`.`profesori`;


CREATE TABLE `catalog`.`elevi`(
    `id` BIGINT NULL AUTO_INCREMENT,
    `user_username` VARCHAR(45) NOT NULL UNIQUE,
    `user_password` VARCHAR(100) NULL,
    `user_name` VARCHAR (45) NULL,
    `prenume` VARCHAR(30) NULL,
    `data_nasterii` DATE NULL,
    `clasa` VARCHAR(10) NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `catalog`.`materii`(
    `id_materie` BIGINT NULL AUTO_INCREMENT,
    `nume_materie` VARCHAR(30)NULL,

    `nr_abstente` INT NULL,

    PRIMARY KEY(`id_materie`)
);

CREATE TABLE  `catalog`.`note`(
    `id_nota` BIGINT NULL AUTO_INCREMENT primary key,
    `id_materie` BIGINT,
    `id_elev` BIGINT,
    `nota` FLOAT NULL,
    FOREIGN KEY (`id_materie`) REFERENCES materii(id_materie),
    FOREIGN KEY (`id_elev`) REFERENCES elevi(id)
);

CREATE TABLE `catalog`.`profesori`(
    `nume` VARCHAR(50) NULL,
    `nivel_educatie` VARCHAR (15)NULL,
    `parola` VARCHAR (100) NULL
  
);

INSERT INTO elevi (user_username, user_password, user_name, prenume, data_nasterii, clasa)  VALUES ('gigel','anton', 'gigel2', 'anton2', STR_TO_DATE('1-01-2012', '%d-%m-%Y'), '1000');
INSERT INTO elevi (user_username, user_password, user_name, prenume, data_nasterii, clasa)  VALUES ('ioan','irimia', 'ioan2', 'irimia2', STR_TO_DATE('1-01-2012', '%d-%m-%Y'), '1000');
INSERT INTO elevi (user_username, user_password, user_name, prenume, data_nasterii, clasa)  VALUES ('ioan2','irimia2', 'ioan2', 'irimia2', STR_TO_DATE('1-01-2012', '%d-%m-%Y'), '1000');
INSERT INTO elevi (user_username, user_password, user_name, prenume, data_nasterii, clasa)  VALUES ('ioan3','irimia', 'ioan2', 'irimia2', STR_TO_DATE('1-01-2012', '%d-%m-%Y'), '1000');

INSERT INTO profesori(nume, nivel_educatie, parola) VALUES ('Popescu','Univeristar','popescu1');
INSERT INTO profesori(nume, nivel_educatie, parola) VALUES ('Popescu','Univeristar','12345');
INSERT INTO profesori(nume, nivel_educatie, parola) VALUES ('Ionescu','Univeristar','random1');

INSERT INTO materii (id_materie, nume_materie,  nr_abstente) VALUES('1','Matematica','0');
INSERT INTO materii (id_materie, nume_materie,  nr_abstente) VALUES('2','Limba Romana','1');
INSERT INTO materii (id_materie, nume_materie,  nr_abstente) VALUES('3','Informatica','1');

INSERT INTO note(id_nota, id_materie, id_elev, nota) VALUES('10','1','1','10');
INSERT INTO note(id_nota, id_materie, id_elev, nota) VALUES('11','2','2','8');
INSERT INTO note(id_nota, id_materie, id_elev, nota) VALUES('12','3','3','9');
INSERT INTO note(id_nota, id_materie, id_elev, nota) VALUES('13','1','3','10');

/*se creeaza o functie in baza de date care primeste ca parametru un nume (name) etc...OUT(parametru de iesire)  */

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createUser`(  
    IN p_name VARCHAR(20),
    IN p_username VARCHAR(20),
    IN p_password VARCHAR(20),
    IN p_prenume VARCHAR(20),
    IN p_datanasterii VARCHAR(20),
    IN p_clasa VARCHAR(20)
)
BEGIN
    if ( select exists (select 1 from elevi where user_username = p_username) ) THEN
     
        select 'Username Exists !!';
     
    ELSE
     
        insert into elevi
        (
            user_name,
            user_username,
            user_password,
            prenume,
            data_nasterii,
            clasa
        )
        values
        (
            p_name,
            p_username,
            p_password,
            p_prenume,
            STR_TO_DATE(p_datanasterii, '%d-%m-%Y'),
            p_clasa
        );
     
    END IF;
END$$
DELIMITER ;


/*p_name is name
username is email*/

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_check_login`(  
    IN p_name VARCHAR(20),
    IN p_password VARCHAR(20)
)


BEGIN
    if ( select exists (select 1 from elevi where user_name = p_name and user_password = p_password) ) THEN
        select 'Login success';
    ELSE
        select 'Login fail';
     
    END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getNote`(  
    IN p_user_username VARCHAR(45)
)
BEGIN
    /*select nume_materie, nota, nr_abstente from note inner join materii on note.id_materie = materii.id_materie where note.id_elev=p_id_elev;*/
    select user_name,prenume,nume_materie, nota, nr_abstente from note inner join materii on note.id_materie = materii.id_materie inner join elevi on note.id_elev = elevi.id where elevi.user_username= p_user_username;
END$$
DELIMITER ;