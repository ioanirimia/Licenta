/*CREATE DATABASE catalog;

CREATE TABLE `catalog`.`tbl_user`(
    
    `user_id` BIGINT NULL AUTO_INCREMENT,
    `user_name` VARCHAR (45) NULL,
    `user_username` VARCHAR(45) NULL,
    `user_password` VARCHAR(45) NULL,
    PRIMARY KEY (`user_id`)
);
*/

/*se creeaza o functie in baza de date care primeste ca parametru un nume (name) etc...OUT(parametru de iesire)  */
/*
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createUser`(  
    IN p_name VARCHAR(20),
    IN p_username VARCHAR(20),
    IN p_password VARCHAR(20)
)
BEGIN
    if ( select exists (select 1 from tbl_user where user_username = p_username) ) THEN
     
        select 'Username Exists !!';
     
    ELSE
     
        insert into tbl_user
        (
            user_name,
            user_username,
            user_password
        )
        values
        (
            p_name,
            p_username,
            p_password
        );
     
    END IF;
END$$
DELIMITER ;
*/

/*p_name is name
username is email*/
/*
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_check_login`(  
    IN p_name VARCHAR(20),
    IN p_password VARCHAR(20)
)
BEGIN
    if ( select exists (select 1 from tbl_user where user_name = p_name and user_password = p_password) ) THEN
        select 'Login success';
    ELSE
        select 'Login fail';
     
    END IF;
END$$
DELIMITER ;
*/

/*
CREATE TABLE `catalog`.`elevi`(
    `id` BIGINT NULL AUTO_INCREMENT,
    `nume` VARCHAR (30) NULL,
    `prenume` VARCHAR(30) NULL,
    `data_nasterii` DATE NULL,
    `clasa` VARCHAR(10) NULL,
    PRIMARY KEY(`id`)
);
*/
/*
CREATE TABLE  `catalog`.`note`(
    `id_nota` BIGINT NULL AUTO_INCREMENT primary key,
    `id_materie` BIGINT,
    `id_elev` BIGINT,
    `nota` FLOAT NULL,
    FOREIGN KEY (`id_materie`) REFERENCES materii(id_materie),
    FOREIGN KEY (`id_elev`) REFERENCES elevi(id)
);
*/
/*
CREATE TABLE `catalog`.`materii`(
    `id_materie` BIGINT NULL AUTO_INCREMENT,
    `note` FLOAT NULL,
    `nr_abstente` INT NULL,
    `medie` FLOAT NULL,
    PRIMARY KEY(`id_materie`)
);
*/


/*
CREATE TABLE `catalog`.`profesori`(
    `nume` VARCHAR(50) NULL,
    `nivel educatie` VARCHAR (15)NULL
);
*/
